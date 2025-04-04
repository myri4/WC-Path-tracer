#include "SyncContext.h"

#include <format>

namespace vk::SyncContext
{
	Semaphore& GetPresentSemaphore() { return PresentSemaphores[CURRENT_FRAME]; }
	Semaphore& GetImageAvaibleSemaphore() { return ImageAvaibleSemaphores[CURRENT_FRAME]; }

	Fence& GetRenderFence() { return RenderFences[CURRENT_FRAME]; }

	VkCommandBuffer& GetMainCommandBuffer() { return MainCommandBuffers[CURRENT_FRAME]; }
	VkCommandBuffer& GetComputeCommandBuffer() { return ComputeCommandBuffers[CURRENT_FRAME]; }

	const Queue GetGraphicsQueue() { return GraphicsQueue; }
	const Queue GetComputeQueue() { return ComputeQueue; }
	const Queue GetTransferQueue() { return GraphicsQueue; }
	const Queue GetPresentQueue() { return /*presentQueue*/GraphicsQueue; }

	void Create()
	{
		GraphicsCommandPool.Create(GetGraphicsQueue().queueFamily, VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT | VK_COMMAND_POOL_CREATE_TRANSIENT_BIT);
		ComputeCommandPool.Create(GetComputeQueue().queueFamily, VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT | VK_COMMAND_POOL_CREATE_TRANSIENT_BIT);
		UploadCommandPool.Create(GetTransferQueue().queueFamily, VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT | VK_COMMAND_POOL_CREATE_TRANSIENT_BIT);

		UploadCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, UploadCommandBuffer);
		ImmediateFence.Create();

		for (uint32_t i = 0; i < FRAME_OVERLAP; i++)
		{
			PresentSemaphores[i].Create(std::format("PresentSemaphore[{}]", i));
			ImageAvaibleSemaphores[i].Create(std::format("ImageAvaibleSemaphore[{}]", i));

			GraphicsCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, MainCommandBuffers[i]);
			ComputeCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, ComputeCommandBuffers[i]);

			VulkanContext::SetObjectName(MainCommandBuffers[i], std::format("MainCommandBuffer[{}]", i));
			VulkanContext::SetObjectName(ComputeCommandBuffers[i], std::format("ComputeCommandBuffer[{}]", i));

			RenderFences[i].Create(VK_FENCE_CREATE_SIGNALED_BIT);
		}

		m_TimelineSemaphore.Create("SyncContext::m_TimelineSemaphore");
	}

	void UpdateFrame()
	{
		CURRENT_FRAME = (CURRENT_FRAME + 1) % FRAME_OVERLAP;
		if (m_TimelineValue >= UINT64_MAX - MAX_PASSES)
		{
			m_TimelineSemaphore.Destroy();
			m_TimelineSemaphore.Create("SyncContext::m_TimelineSemaphore");
			m_TimelineValue = 0;
		}
	}

	void Submit(VkCommandBuffer cmd, const Queue& queue, VkPipelineStageFlags waitStage, Fence fence)
	{
		const uint64_t waitValue = m_TimelineValue;
		const uint64_t signalValue = ++m_TimelineValue;

		VkTimelineSemaphoreSubmitInfo timelineInfo = {
			.sType = VK_STRUCTURE_TYPE_TIMELINE_SEMAPHORE_SUBMIT_INFO,
			.waitSemaphoreValueCount = 1,
			.pWaitSemaphoreValues = &waitValue,
			.signalSemaphoreValueCount = 1,
			.pSignalSemaphoreValues = &signalValue,
		};

		queue.Submit({
			.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO,
			.pNext = &timelineInfo,
			.waitSemaphoreCount = 1,
			.pWaitSemaphores = &m_TimelineSemaphore,
			.pWaitDstStageMask = &waitStage,

			.commandBufferCount = 1,
			.pCommandBuffers = &cmd,
			.signalSemaphoreCount = 1,
			.pSignalSemaphores = &m_TimelineSemaphore,
			}, fence);
	}

	void ImmediateSubmit(std::function<void(VkCommandBuffer)>&& function) // @TODO: revisit if this is suitable for a inline
	{
		VkCommandBufferBeginInfo begInfo = {
			.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO,
			.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT
		};

		vkBeginCommandBuffer(UploadCommandBuffer, &begInfo);

		function(UploadCommandBuffer);

		vkEndCommandBuffer(UploadCommandBuffer);

		GetGraphicsQueue().Submit({
			.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO,
			.commandBufferCount = 1,
			.pCommandBuffers = &UploadCommandBuffer,
			}, ImmediateFence);

		ImmediateFence.Wait();
		ImmediateFence.Reset();

		vkResetCommandBuffer(UploadCommandBuffer, 0);
	}

	void Destroy()
	{
		GraphicsCommandPool.Destroy();
		ComputeCommandPool.Destroy();

		for (uint32_t i = 0; i < FRAME_OVERLAP; i++)
		{
			PresentSemaphores[i].Destroy();
			ImageAvaibleSemaphores[i].Destroy();

			RenderFences[i].Destroy();
		}

		m_TimelineSemaphore.Destroy();

		UploadCommandPool.Destroy();
		ImmediateFence.Destroy();
	}
}