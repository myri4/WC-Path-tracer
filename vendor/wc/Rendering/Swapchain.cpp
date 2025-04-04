#include "Swapchain.h"
#include "vk/SyncContext.h"

namespace vk
{
	void Surface::Query()
	{
		vkGetPhysicalDeviceSurfaceCapabilitiesKHR(VulkanContext::GetPhysicalDevice(), m_Handle, &capabilities);

		vkGetPhysicalDeviceSurfaceFormatsKHR(VulkanContext::GetPhysicalDevice(), m_Handle, &formats.Count, nullptr); // @TODO: maybe check the return code
		formats.Allocate();
		vkGetPhysicalDeviceSurfaceFormatsKHR(VulkanContext::GetPhysicalDevice(), m_Handle, &formats.Count, formats.Data);

		vkGetPhysicalDeviceSurfacePresentModesKHR(VulkanContext::GetPhysicalDevice(), m_Handle, &presentModes.Count, nullptr);
		presentModes.Allocate();
		vkGetPhysicalDeviceSurfacePresentModesKHR(VulkanContext::GetPhysicalDevice(), m_Handle, &presentModes.Count, presentModes.Data);
	}

	bool Surface::Queried() { return formats && presentModes; }

	void Surface::Destroy()
	{
		vkDestroySurfaceKHR(VulkanContext::GetInstance(), m_Handle, VulkanContext::GetAllocator());
		m_Handle = VK_NULL_HANDLE;
		capabilities = {};
		formats.Free();
		presentModes.Free();
	}


	bool Swapchain::Create(const wc::Window& window)
	{
		if (glfwCreateWindowSurface(VulkanContext::GetInstance(), window, VulkanContext::GetAllocator(), &surface) != VK_SUCCESS)
		{
			WC_CORE_ERROR("Failed to create window surface!");
			return false;
		}
		surface.Query();
		return Create(window.GetFramebufferExtent(), window.VSync);
	}

	bool Swapchain::Create(VkExtent2D windowExtent, bool VSync, bool hasClear)
	{
		VkSurfaceFormatKHR surfaceFormat = surface.formats[0];
		for (const auto& availableFormat : surface.formats)
			if (availableFormat.format == VK_FORMAT_B8G8R8A8_UNORM && availableFormat.colorSpace == VK_COLOR_SPACE_SRGB_NONLINEAR_KHR)
			{
				surfaceFormat = availableFormat;
				break;
			}

		VkPresentModeKHR presentMode = VK_PRESENT_MODE_FIFO_KHR;
		if (!VSync)
			for (const auto& availablePresentMode : surface.presentModes)
				if (availablePresentMode == VK_PRESENT_MODE_MAILBOX_KHR)
				{
					presentMode = availablePresentMode;
					break;
				}

		if (surface.capabilities.currentExtent.width != std::numeric_limits<uint32_t>::max())
			extent = surface.capabilities.currentExtent;
		else
		{
			VkExtent2D actualExtent = windowExtent;

			extent.width = glm::clamp(actualExtent.width, surface.capabilities.minImageExtent.width, surface.capabilities.maxImageExtent.width);
			extent.height = glm::clamp(actualExtent.height, surface.capabilities.minImageExtent.height, surface.capabilities.maxImageExtent.height);
		}

		uint32_t imageCount = surface.capabilities.minImageCount + 1;
		if (surface.capabilities.maxImageCount > 0 && imageCount > surface.capabilities.maxImageCount)
			imageCount = surface.capabilities.maxImageCount;

		VkSwapchainCreateInfoKHR createInfo = {
			.sType = VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR,
			.surface = surface,

			.minImageCount = imageCount,
			.imageFormat = surfaceFormat.format,
			.imageColorSpace = surfaceFormat.colorSpace,
			.imageExtent = extent,
			.imageArrayLayers = 1,
			.imageUsage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT,

			.imageSharingMode = VK_SHARING_MODE_EXCLUSIVE,

			.preTransform = surface.capabilities.currentTransform,
			.compositeAlpha = VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR,
			.presentMode = presentMode,
			.clipped = true,
			.oldSwapchain = m_Handle,
		};

		//WC_CORE_INFO("Swapchain create info");
		//WC_CORE_INFO("Image count: {}", imageCount);
		//WC_CORE_INFO("Image format: {}", magic_enum::enum_name(surfaceFormat.format));
		//WC_CORE_INFO("Color-space: {}", magic_enum::enum_name(surfaceFormat.colorSpace));
		//WC_CORE_INFO("Extent: [{}, {}]", extent.width, extent.height);
		////WC_CORE_INFO("Transform: {}", magic_enum::enum_name(surfaceFormat.colorSpace));
		//WC_CORE_INFO("Present mode: {}", magic_enum::enum_name(presentMode));

		//QueueFamilyIndices indices = findQueueFamilies(physicalDevice/*, surface*/);
		//uint32_t queueFamilyIndices[] = { indices.graphicsFamily.value()/*, indices.presentFamily.value()*/ };

		//if (indices.graphicsFamily != indices.presentFamily) {
		//	createInfo.imageSharingMode = VK_SHARING_MODE_CONCURRENT;
		//	createInfo.queueFamilyIndexCount = 2;
		//	createInfo.pQueueFamilyIndices = queueFamilyIndices;
		//}
		//else 

		if (vkCreateSwapchainKHR(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle) != VK_SUCCESS)
			return false;

		if (createInfo.oldSwapchain != VK_NULL_HANDLE)
		{
			vkDestroySwapchainKHR(VulkanContext::GetLogicalDevice(), createInfo.oldSwapchain, VulkanContext::GetAllocator());
			images.Free();
		}

		vkGetSwapchainImagesKHR(VulkanContext::GetLogicalDevice(), m_Handle, &imageCount, nullptr);
		images.Allocate(imageCount);
		vkGetSwapchainImagesKHR(VulkanContext::GetLogicalDevice(), m_Handle, &imageCount, images.Data);

		imageViews.Allocate(images.Count);

		VkImageViewCreateInfo viewCreateInfo = {
			.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO,
			.viewType = VK_IMAGE_VIEW_TYPE_2D,
			.format = surfaceFormat.format,
			.subresourceRange = {
				.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
				.baseMipLevel = 0,
				.levelCount = 1,
				.baseArrayLayer = 0,
				.layerCount = 1,
			},
		};

		for (size_t i = 0; i < imageViews.Count; i++)
		{
			viewCreateInfo.image = images[i];

			if (imageViews[i].Create(viewCreateInfo) != VK_SUCCESS)
				return false;
			imageViews[i].SetName(std::format("Swapchain::ImageViews[{}]", i));
		}

		// Create Render pass
		if (RenderPass == VK_NULL_HANDLE)
		{
			VkAttachmentDescription color_attachment = {
				.format = surfaceFormat.format,
				.samples = VK_SAMPLE_COUNT_1_BIT,
				.loadOp = hasClear ? VK_ATTACHMENT_LOAD_OP_CLEAR : VK_ATTACHMENT_LOAD_OP_DONT_CARE,
				.storeOp = VK_ATTACHMENT_STORE_OP_STORE,
				.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE,
				.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
				.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED,
				.finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR,
			};

			VkAttachmentReference color_attachment_ref = { 0, VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL };

			VkSubpassDescription subpass = {
				.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
				.colorAttachmentCount = 1,
				.pColorAttachments = &color_attachment_ref,
			};

			VkSubpassDependency dependency = {
				.srcSubpass = VK_SUBPASS_EXTERNAL,
				.dstSubpass = 0,
				.srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
				.dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
				.srcAccessMask = 0,
				.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
			};

			VkRenderPassCreateInfo renderPassCreateInfo = {
				.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO,
				.attachmentCount = 1,
				.pAttachments = &color_attachment,
				.subpassCount = 1,
				.pSubpasses = &subpass,
				.dependencyCount = 1,
				.pDependencies = &dependency,
			};

			vkCreateRenderPass(VulkanContext::GetLogicalDevice(), &renderPassCreateInfo, VulkanContext::GetAllocator(), &RenderPass);
			VulkanContext::SetObjectName(RenderPass, "swapchain.RenderPass");
		}

		VkFramebufferCreateInfo fb_info = {
			.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO,
			.renderPass = RenderPass,
			.attachmentCount = 1,
			.width = extent.width,
			.height = extent.height,
			.layers = 1,
		};

		Framebuffers.Allocate(images.Count);

		for (uint32_t i = 0; i < Framebuffers.Count; i++)
		{
			fb_info.pAttachments = &imageViews[i];

			if (vkCreateFramebuffer(VulkanContext::GetLogicalDevice(), &fb_info, VulkanContext::GetAllocator(), &Framebuffers[i]) != VK_SUCCESS)
				return false;

			VulkanContext::SetObjectName(Framebuffers[i], std::format("swapchain.Framebuffers[{}]", i).c_str());
		}

		return true;
	}

	VkResult Swapchain::AcquireNextImage(uint32_t& imageIndex, VkSemaphore semaphore, VkFence fence, uint64_t timeout)
	{
		uint32_t realImageIndex = 0;
		auto result = vkAcquireNextImageKHR(VulkanContext::GetLogicalDevice(), m_Handle, timeout, semaphore, fence, &realImageIndex);

		if (result != VK_ERROR_OUT_OF_DATE_KHR)
			imageIndex = realImageIndex;

		return result;
	}

	void Swapchain::DestroyFramebuffers()
	{
		for (auto& framebuffer : Framebuffers)
		{
			vkDestroyFramebuffer(VulkanContext::GetLogicalDevice(), framebuffer, VulkanContext::GetAllocator());
			framebuffer = VK_NULL_HANDLE;
		}
		Framebuffers.Free();

		for (auto& view : imageViews)
			view.Destroy();
		imageViews.Free();
	}

	void Swapchain::DestroySwapchain()
	{
		vkDestroySwapchainKHR(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
		m_Handle = VK_NULL_HANDLE;
		images.Free();
	}

	void Swapchain::DestroyRenderPass()
	{
		vkDestroyRenderPass(VulkanContext::GetLogicalDevice(), RenderPass, VulkanContext::GetAllocator());
		RenderPass = VK_NULL_HANDLE;
	}

	void Swapchain::Destroy()
	{
		DestroyFramebuffers();
		DestroyRenderPass();
		DestroySwapchain();
		surface.Destroy();
	}

	VkResult Swapchain::Present(uint32_t imageIndex, VkSemaphore waitSemaphore)
	{
		VkPresentInfoKHR presentInfo = {
			.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR,
			.waitSemaphoreCount = 1,
			.pWaitSemaphores = &waitSemaphore,

			.swapchainCount = 1,
			.pSwapchains = &m_Handle,

			.pImageIndices = &imageIndex,
		};
		auto result = vkQueuePresentKHR(SyncContext::GetPresentQueue(), &presentInfo);
		return result;
	}
}