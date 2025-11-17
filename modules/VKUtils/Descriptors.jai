DescriptorAllocator: struct
{
	CurrentPool: VkDescriptorPool;
	UsedPools: [..]VkDescriptorPool;
	FreePools: [..]VkDescriptorPool;
};

CreateDescriptorAllocator :: ()
{
    using DescriptorAllocator;
	CurrentPool = GrabDescriptorPool();
	array_add(*UsedPools, CurrentPool);
}

DestroyDescriptorAllocator :: ()
{
    using DescriptorAllocator;
	for p : FreePools
		vkDestroyDescriptorPool(logicalDevice, p, null);

	for p : UsedPools
		vkDestroyDescriptorPool(logicalDevice, p, null);
}

ResetPools :: ()
{
    using DescriptorAllocator;
	for p : UsedPools
		vkResetDescriptorPool(logicalDevice, p, 0);

	FreePools = UsedPools;
    array_reset(*UsedPools);
	CurrentPool = VK_NULL_HANDLE;
}

AllocateDescriptorSet :: (set: *VkDescriptorSet, layout: VkDescriptorSetLayout, pNext: *void = null, descriptorCount: u32 = 1) -> bool
{
    using DescriptorAllocator;
	if CurrentPool == VK_NULL_HANDLE
	{
		CurrentPool = GrabDescriptorPool();
		array_add(*UsedPools, CurrentPool);
	}

	allocInfo := VkDescriptorSetAllocateInfo.{
		pNext = pNext,
		descriptorPool = CurrentPool,
		descriptorSetCount = descriptorCount,
		pSetLayouts = *layout,
	};

	if vkAllocateDescriptorSets(logicalDevice, *allocInfo, set) ==
	{
	case .SUCCESS; return true;
	case .ERROR_FRAGMENTED_POOL; #through;
	case .ERROR_OUT_OF_POOL_MEMORY;
		//allocate a new pool and retry
		CurrentPool = GrabDescriptorPool();
		array_add(*UsedPools, CurrentPool);

		//if it still fails then we have big issues
		if vkAllocateDescriptorSets(logicalDevice, *allocInfo, set) == .SUCCESS return true;
	}

	return false;
}

GrabDescriptorPool :: () -> VkDescriptorPool
{
    using DescriptorAllocator;
	if FreePools.count > 0
	{
		pool := FreePools[FreePools.count - 1];
        pop(*FreePools);
		return pool;
	}

	count : u32 = 500;

	sizes: [6]VkDescriptorPoolSize = .[
		.{ .SAMPLER,                cast(u32)(count * 0.5) },
		.{ .COMBINED_IMAGE_SAMPLER, cast(u32)(count * 2.0) },
		.{ .SAMPLED_IMAGE,          cast(u32)(count * 2.0) },
		.{ .STORAGE_IMAGE,          cast(u32)(count * 1.0) },
		.{ .UNIFORM_BUFFER,         cast(u32)(count * 0.5) },
		.{ .STORAGE_BUFFER,         cast(u32)(count * 1.0) },
	];

	pool_info := VkDescriptorPoolCreateInfo.{
		flags = .FREE_DESCRIPTOR_SET_BIT,
		maxSets = count,
		poolSizeCount = cast(u32)sizes.count,
		pPoolSizes = sizes.data,
	};

	descriptorPool: VkDescriptorPool;
	vkCreateDescriptorPool(logicalDevice, *pool_info, null, *descriptorPool);

	return descriptorPool;
}