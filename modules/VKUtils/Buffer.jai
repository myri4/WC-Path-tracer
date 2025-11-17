Buffer :: struct
{
    allocation: VmaAllocation;
    handle: VkBuffer;
}

AllocateStagingBuffer :: (using buffer: *Buffer, size: VkDeviceSize, usage: VkBufferUsageFlags = .TRANSFER_SRC_BIT, call := #caller_code) -> VkResult #expand
{
	bufferInfo := VkBufferCreateInfo.{
	    size = size,
	    usage = usage,
    };

	vmaAllocInfo := VmaAllocationCreateInfo.{ usage = .VMA_MEMORY_USAGE_CPU_ONLY };

	result := vmaCreateBuffer(allocator, *bufferInfo, *vmaAllocInfo, *handle, *allocation, null);

	#if GRAPHICS_VALIDATION
    {
        if result != .SUCCESS return result;
        if validationLayersFound
        {
            name := #run -> string {
                nodes := compiler_get_nodes(call);

                procCall := cast(*Code_Procedure_Call) nodes;

                builder: String_Builder;
                print_expression(*builder, procCall.arguments_sorted[0]);
                result := builder_to_string(*builder);
                return result;
            }

            SetObjectName(handle, name);
        }
    }
    return result;
}

Map :: (using buffer: Buffer) -> VkResult, *void
{
	data: *void;
	result := vmaMapMemory(allocator, allocation, *data);
	return result, data;
}

Unmap :: (using buffer: Buffer) { vmaUnmapMemory(allocator, allocation); }

SetData :: (using buffer: Buffer, data: *void, size: s64) -> VkResult {
	result, ptr := Map(buffer);
	if result != .SUCCESS return result;

	memcpy(ptr, data, size);
	Unmap(buffer);
	
	return result;
}

Free :: (using buffer: *Buffer)
{
	vmaDestroyBuffer(allocator, handle, allocation);
	allocation = VK_NULL_HANDLE;
	handle = VK_NULL_HANDLE;
}

AllocateGPUBuffer :: (using buffer: *Buffer, size: VkDeviceSize, usage : VkBufferUsageFlags = .STORAGE_BUFFER_BIT, call := #caller_code) -> VkResult #expand
{
	bufferInfo := VkBufferCreateInfo.{
		size = size,
		usage = usage | .TRANSFER_DST_BIT,
	};

	allocInfo := VmaAllocationCreateInfo.{ usage = .GPU_ONLY };
	if usage & VkBufferUsageFlags.SHADER_DEVICE_ADDRESS_BIT
		allocInfo.flags = xx VmaAllocatorCreateFlagBits.BUFFER_DEVICE_ADDRESS_BIT;

    result := vmaCreateBuffer(allocator, *bufferInfo, *allocInfo, *handle, *allocation, null);

	#if GRAPHICS_VALIDATION
    {
        if result != .SUCCESS return result;
        if validationLayersFound
        {
            name := #run -> string {
                nodes := compiler_get_nodes(call);       

                procCall := cast(*Code_Procedure_Call) nodes;

                builder: String_Builder;
                print_expression(*builder, procCall.arguments_sorted[0]);
                result := builder_to_string(*builder);
                return result;
            }

            SetObjectName(handle, name);
        }
    }
    return result;
}

GetDeviceAddress :: (handle: VkBuffer) -> VkDeviceAddress
{
	pInfo := VkBufferDeviceAddressInfo.{ buffer = handle };
	return vkGetBufferDeviceAddress(logicalDevice, *pInfo);
}

GetDeviceAddress :: (using buffer: Buffer) -> VkDeviceAddress { return GetDeviceAddress(handle); }

GetBufferSize :: (using buffer: Buffer) -> VkDeviceSize
{
	if !allocation //|| !handle
        return 0; // @NOTE: Maybe add a success return value?

	inf: VmaAllocationInfo;
	vmaGetAllocationInfo(allocator, allocation, *inf);
	return inf.size;
}