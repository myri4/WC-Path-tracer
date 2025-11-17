DBufferManager :: struct (DataType: Type, usage: u32) { // D for dynamic
	buffer: vk.Buffer;
	stagingBuffer: vk.Buffer;
	data: [..]DataType;

	stagingPtr: *DataType;
}

Map :: (using buffer: *DBufferManager) -> *buffer.DataType {
    stagingPtr = Map(stagingBuffer).(buffer.DataType);
    return stagingPtr;
}

Unmap :: (using dbuffer: *DBufferManager) {
	stagingPtr = null;
	vk.Unmap(stagingBuffer);
}

Allocate :: (using dbuffer: *DBufferManager, elements: u32) -> VkResult {
	if buffer.handle || buffer.allocation || 
	   stagingBuffer.handle || stagingBuffer.allocation 
	   log_error("Error: buffer is already created!\n");

    bufferSize := elements * size_of(DataType);
	result := AllocateGPUBuffer(*buffer, bufferSize, xx usage);
	if result != .SUCCESS return result;

	result = AllocateStagingBuffer(*stagingBuffer, bufferSize);
	if result != .SUCCESS return result;

	result, stagingPtr = Map(stagingBuffer);

	return result;
}

Free :: (using dbuffer: *DBufferManager, reset := false) {
	if buffer.handle {
		Unmap(dbuffer);
		vk.Free(*buffer);
		vk.Free(*stagingBuffer);
	}
	
	if reset 
		array_reset(*data);
}

Resize :: (using dbuffer: *DBufferManager, elements: u32) {
	Free(dbuffer, false);
	Allocate(dbuffer, elements);
}

Update :: (using dbuffer: *DBufferManager, cmd: VkCommandBuffer, elems: u32 = 0) {
	if GetBufferSize(buffer) < xx (data.count * size_of(DataType))
		Resize(dbuffer, xx data.count);

	size := size_of(DataType) * (ifx elems == 0  data.count else elems);

	memcpy(stagingPtr, data.data, size);

	Unmap(stagingBuffer);
	bufferCopy := VkBufferCopy.{ size = xx size };
	vkCmdCopyBuffer(cmd, stagingBuffer.handle, buffer.handle, 1, *bufferCopy);
	Map(stagingBuffer);	
}