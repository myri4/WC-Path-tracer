CURRENT_FRAME_INDEX: u8 = 0;
MAX_PASSES :u64: 200;

Queue :: struct
{
	using #as handle: VkQueue;
	familyIndex: u32;
}

graphicsQueue: Queue;
computeQueue: Queue;
transferQueue: Queue;
//presentQueue: Queue;

TimelineSemaphore: VkSemaphore;
TimelineValue : u64 = 0;

ImmediateFence: VkFence;

UploadCommandBuffer: VkCommandBuffer;

GraphicsCommandPool: VkCommandPool;
ComputeCommandPool: VkCommandPool;
UploadCommandPool: VkCommandPool;

InitSyncContext :: ()
{
    cpCreateInfo := VkCommandPoolCreateInfo.{ flags = .RESET_COMMAND_BUFFER_BIT | .TRANSIENT_BIT };

    cpCreateInfo.queueFamilyIndex = graphicsQueue.familyIndex;
    Create(*GraphicsCommandPool, cpCreateInfo);
    Create(*ComputeCommandPool, cpCreateInfo);
    Create(*UploadCommandPool, cpCreateInfo);
    
    cmdAllocInfo := VkCommandBufferAllocateInfo.{ 
        commandPool = UploadCommandPool,
        commandBufferCount = 1,
        level = .PRIMARY,        
    };
    vkAllocateCommandBuffers(logicalDevice, *cmdAllocInfo, *UploadCommandBuffer);

    Create(*ImmediateFence, .{});
	{
		timelineCreateInfo := VkSemaphoreTypeCreateInfo.{ semaphoreType = .TIMELINE };

        Create(*TimelineSemaphore, .{ pNext = *timelineCreateInfo });
	}
}

UpdateFrameSyncs :: ()
{
	CURRENT_FRAME_INDEX = (CURRENT_FRAME_INDEX + 1) % FRAME_OVERLAP;
	if TimelineValue >= U64_MAX - MAX_PASSES
	{
		Destroy(*TimelineSemaphore);

		timelineCreateInfo := VkSemaphoreTypeCreateInfo.{ semaphoreType = .TIMELINE };

        Create(*TimelineSemaphore, .{ pNext = *timelineCreateInfo });
		TimelineValue = 0;
	}
}

Submit :: (cmd: VkCommandBuffer, queue: VkQueue, waitStage: VkPipelineStageFlags = .COLOR_ATTACHMENT_OUTPUT_BIT, fence: VkFence = VK_NULL_HANDLE)
{
	waitValue := TimelineValue;
    TimelineValue += 1;
	signalValue := TimelineValue;

	timelineInfo := VkTimelineSemaphoreSubmitInfo.{
		waitSemaphoreValueCount = 1,
		pWaitSemaphoreValues = *waitValue,
		signalSemaphoreValueCount = 1,
		pSignalSemaphoreValues = *signalValue,
	};

    submit_info := VkSubmitInfo.{
		pNext = *timelineInfo,
		waitSemaphoreCount = 1,
		pWaitSemaphores = *TimelineSemaphore,
		pWaitDstStageMask = *waitStage,

		commandBufferCount = 1,
		pCommandBuffers = *cmd,
		signalSemaphoreCount = 1,
		pSignalSemaphores = *TimelineSemaphore,
	};
    vkQueueSubmit(queue, 1, *submit_info, fence);
}

BeginImmediateSumbit :: (cmd: VkCommandBuffer)
{
	begInfo := VkCommandBufferBeginInfo.{ flags = .ONE_TIME_SUBMIT_BIT };

	vkBeginCommandBuffer(cmd, *begInfo);
}

EndImmediateSumbit :: (cmd: VkCommandBuffer)
{
	vkEndCommandBuffer(cmd);

	submitInfo := VkSubmitInfo.{
		commandBufferCount = 1,
		pCommandBuffers = *cmd,
	};
    vkQueueSubmit(graphicsQueue, 1, *submitInfo, ImmediateFence);

    vkWaitForFences(logicalDevice, 1, *ImmediateFence, VK_TRUE, U64_MAX);
    vkResetFences(logicalDevice, 1, *ImmediateFence);

	vkResetCommandBuffer(cmd, 0);
}

ImmediateSubmit :: (function: (VkCommandBuffer)) // @TODO: revisit if this is suitable for a inline or a #insert code macro
{
	inline BeginImmediateSumbit(UploadCommandBuffer);

	function(UploadCommandBuffer);

	EndImmediateSumbit(UploadCommandBuffer);
}

DestroySyncContext :: ()
{
	Destroy(*GraphicsCommandPool);
    Destroy(*ComputeCommandPool);

	Destroy(*TimelineSemaphore);

	Destroy(*UploadCommandPool);
	Destroy(*ImmediateFence);
}