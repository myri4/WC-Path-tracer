#pragma once

#include "VulkanContext.h"

namespace vk 
{
	struct CommandPool : public VkObject<VkCommandPool> 
	{
		using VkObject<VkCommandPool>::VkObject;

		VkResult Create(const VkCommandPoolCreateInfo& createInfo) 
		{ return vkCreateCommandPool(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle); }

		VkResult Create(uint32_t queueFamilyIndex, VkCommandPoolCreateFlags createFlags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT) 
		{
			VkCommandPoolCreateInfo createInfo = { VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO };

			createInfo.queueFamilyIndex = queueFamilyIndex;
			createInfo.flags = createFlags;

			return Create(createInfo);
		}

		VkResult Allocate(VkCommandBufferLevel level, VkCommandBuffer& commandBuffer) const 
		{
			VkCommandBufferAllocateInfo allocInfo = { VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO };

			allocInfo.commandPool = m_Handle;
			allocInfo.commandBufferCount = 1;
			allocInfo.level = level;

			return vkAllocateCommandBuffers(VulkanContext::GetLogicalDevice(), &allocInfo, &commandBuffer);
		}

		VkResult Reset(VkCommandPoolResetFlags flags = 0) { return vkResetCommandPool(VulkanContext::GetLogicalDevice(), m_Handle, flags); }

		void Free(VkCommandBuffer cmd) { vkFreeCommandBuffers(VulkanContext::GetLogicalDevice(), m_Handle, 1, &cmd); }

		void Destroy() 
		{ 
			vkDestroyCommandPool(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}
	};	
}