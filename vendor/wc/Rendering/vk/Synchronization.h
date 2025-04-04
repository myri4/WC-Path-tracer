#pragma once

#include "VulkanContext.h"

namespace vk
{
	struct Fence : public VkObject<VkFence>
	{
		using VkObject<VkFence>::VkObject;

		void Create(const VkFenceCreateInfo& createInfo) { vkCreateFence(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle); }

		void Create(VkFenceCreateFlags flags = 0)
		{
			Create({
				.sType = VK_STRUCTURE_TYPE_FENCE_CREATE_INFO,
				.flags = flags,
			});
		}

		VkResult Wait(uint64_t timeout = UINT64_MAX) { return vkWaitForFences(VulkanContext::GetLogicalDevice(), 1, &m_Handle, true, timeout); }

		void Reset() { vkResetFences(VulkanContext::GetLogicalDevice(), 1, &m_Handle); }

		VkResult GetStatus() { return vkGetFenceStatus(VulkanContext::GetLogicalDevice(), m_Handle); }

		void Destroy()
		{
			vkDestroyFence(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}
	};

	struct Semaphore : public VkObject<VkSemaphore>
	{
		void Create(const VkSemaphoreCreateInfo& createInfo) { vkCreateSemaphore(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle); }

		void Create(VkSemaphoreCreateFlags flags = 0)
		{
			Create({
				.sType = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO,
				.flags = flags,
			});
		}

		void Create(const std::string& name, VkSemaphoreCreateFlags flags = 0)
		{
			Create(flags);
			SetName(name);
		}

		void Destroy()
		{
			vkDestroySemaphore(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}
	};

	struct TimelineSemaphore : public VkObject<VkSemaphore>
	{
		void Create(uint64_t initialValue = 0, VkSemaphoreCreateFlags flags = 0)
		{
			VkSemaphoreTypeCreateInfo timelineCreateInfo = { .sType = VK_STRUCTURE_TYPE_SEMAPHORE_TYPE_CREATE_INFO,
				.semaphoreType = VK_SEMAPHORE_TYPE_TIMELINE,
				.initialValue = initialValue,
			};

			VkSemaphoreCreateInfo semaphoreCreateInfo = { .sType = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO,
				.pNext = &timelineCreateInfo,
				.flags = flags,
			};

			vkCreateSemaphore(VulkanContext::GetLogicalDevice(), &semaphoreCreateInfo, VulkanContext::GetAllocator(), &m_Handle);
		}

		void Create(const std::string& name, uint64_t initialValue = 0)
		{
			Create(initialValue);
			SetName(name);
		}

		void Destroy()
		{
			vkDestroySemaphore(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}

		void Signal(uint64_t value)
		{
			VkSemaphoreSignalInfo signalInfo = { 
				.sType = VK_STRUCTURE_TYPE_SEMAPHORE_SIGNAL_INFO,
				.semaphore = m_Handle,
				.value = value,
			};

			vkSignalSemaphore(VulkanContext::GetLogicalDevice(), &signalInfo);
		}

		void Wait(uint64_t waitValue, uint64_t timeout = UINT64_MAX)
		{
			VkSemaphoreWaitInfo waitInfo = { 
				.sType = VK_STRUCTURE_TYPE_SEMAPHORE_WAIT_INFO,
				.flags = 0,
				.semaphoreCount = 1,
				.pSemaphores = &m_Handle,
				.pValues = &waitValue,
			};

			vkWaitSemaphores(VulkanContext::GetLogicalDevice(), &waitInfo, timeout);
		}

		auto GetCounterValue()
		{
			uint64_t value;
			vkGetSemaphoreCounterValue(VulkanContext::GetLogicalDevice(), m_Handle, &value);
			return value;
		}
	};

	struct Event : public VkObject<VkEvent>
	{
		void Create(const VkEventCreateInfo& createInfo) { vkCreateEvent(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle); }

		void Create(VkEventCreateFlags flags = 0)
		{
			Create({
				.sType = VK_STRUCTURE_TYPE_EVENT_CREATE_INFO,
				.flags = flags,
			});
		}

		VkResult GetStatus() { return vkGetEventStatus(VulkanContext::GetLogicalDevice(), m_Handle); }

		void Set() { vkSetEvent(VulkanContext::GetLogicalDevice(), m_Handle); }

		void Reset() { vkResetEvent(VulkanContext::GetLogicalDevice(), m_Handle); }

		void Destroy()
		{
			vkDestroyEvent(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}
	};
}