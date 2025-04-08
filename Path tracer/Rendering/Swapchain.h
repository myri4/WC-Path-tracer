#pragma once

#include "vk/Image.h"
#include "../Utils/Window.h"
#include "../Memory/Buffer.h"

namespace vk
{
	struct Surface : public VkObject<VkSurfaceKHR>
	{
		using VkObject<VkSurfaceKHR>::VkObject;

		VkSurfaceCapabilitiesKHR capabilities = {};
		wc::FPtr<VkSurfaceFormatKHR> formats;
		wc::FPtr<VkPresentModeKHR> presentModes;

		void Query();

		bool Queried();

		void Destroy();
	};

	struct Swapchain : public VkObject<VkSwapchainKHR>
	{
		Surface surface;
		VkRenderPass RenderPass = VK_NULL_HANDLE;

		wc::FPtr<VkImage> images;
		wc::FPtr<vk::ImageView> imageViews;
		wc::FPtr<VkFramebuffer> Framebuffers;

		VkExtent2D extent;

		bool Create(const wc::Window& window);

		bool Create(VkExtent2D windowExtent, bool VSync, bool hasClear = true);

		VkResult AcquireNextImage(uint32_t& imageIndex, VkSemaphore semaphore = VK_NULL_HANDLE, VkFence fence = VK_NULL_HANDLE, uint64_t timeout = UINT64_MAX);

		void DestroyFramebuffers();

		void DestroySwapchain();

		void DestroyRenderPass();

		void Destroy();

		VkResult Present(uint32_t imageIndex, VkSemaphore waitSemaphore);
	};
}