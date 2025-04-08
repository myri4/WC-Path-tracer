#pragma once

#include "Commands.h"
#include "Synchronization.h"

constexpr uint32_t FRAME_OVERLAP = 3;
constexpr uint64_t MAX_PASSES = 200;
inline uint8_t CURRENT_FRAME = 0;

namespace vk::SyncContext
{
	inline Semaphore PresentSemaphores[FRAME_OVERLAP], ImageAvaibleSemaphores[FRAME_OVERLAP];
	inline TimelineSemaphore m_TimelineSemaphore;
	inline uint64_t m_TimelineValue = 0;

	inline Fence RenderFences[FRAME_OVERLAP];
	inline Fence ImmediateFence;

	inline VkCommandBuffer MainCommandBuffers[FRAME_OVERLAP];
	inline VkCommandBuffer ComputeCommandBuffers[FRAME_OVERLAP];
	inline VkCommandBuffer UploadCommandBuffer;

	inline CommandPool GraphicsCommandPool;
	inline CommandPool ComputeCommandPool;
	inline CommandPool UploadCommandPool;

	Semaphore& GetPresentSemaphore();
	Semaphore& GetImageAvaibleSemaphore();

	Fence& GetRenderFence();

	VkCommandBuffer& GetMainCommandBuffer();
	VkCommandBuffer& GetComputeCommandBuffer();

	const Queue GetGraphicsQueue();
	const Queue GetComputeQueue();
	const Queue GetTransferQueue();
	const Queue GetPresentQueue();

	void Create();

	void UpdateFrame();

	void Submit(VkCommandBuffer cmd, const Queue& queue, VkPipelineStageFlags waitStage = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT, Fence fence = VK_NULL_HANDLE);

	void ImmediateSubmit(std::function<void(VkCommandBuffer)>&& function);

	void Destroy();
}