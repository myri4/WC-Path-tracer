#include "Image.h"

namespace vk
{
	glm::ivec2 GetMipSize(uint32_t level, glm::ivec2 size) { return { size.x >> level, size.y >> level }; }

	uint32_t GetMipLevelCount(glm::vec2 size) { return (uint32_t)glm::floor(glm::log2(glm::min(size.x, size.y))); }

	VkImageMemoryBarrier GenerateImageMemoryBarier(
		VkImage image,
		VkImageLayout oldImageLayout,
		VkImageLayout newImageLayout,
		VkImageSubresourceRange subresourceRange)
	{
		VkImageMemoryBarrier barier = {
			.sType = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER,
			.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
			.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
			.oldLayout = oldImageLayout,
			.newLayout = newImageLayout,
			.image = image,
			.subresourceRange = subresourceRange,
		};

		// Source layouts (old)
		// Source access mask controls actions that have to be finished on the old layout
		// before it will be transitioned to the new layout
		switch (oldImageLayout)
		{
		case VK_IMAGE_LAYOUT_UNDEFINED:
			// Image layout is undefined (or does not matter)
			// Only valid as initial layout
			// No flags required, listed only for completeness
			barier.srcAccessMask = 0;
			break;

		case VK_IMAGE_LAYOUT_PREINITIALIZED:
			// Image is preinitialized
			// Only valid as initial layout for linear images, preserves memory contents
			// Make sure host writes have been finished
			barier.srcAccessMask = VK_ACCESS_HOST_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL:
			// Image is a color attachment
			// Make sure any writes to the color buffer have been finished
			barier.srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL:
			// Image is a depth/stencil attachment
			// Make sure any writes to the depth/stencil buffer have been finished
			barier.srcAccessMask = VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL:
			// Image is a transfer source 
			// Make sure any reads from the image have been finished
			barier.srcAccessMask = VK_ACCESS_TRANSFER_READ_BIT;
			break;

		case VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL:
			// Image is a transfer destination
			// Make sure any writes to the image have been finished
			barier.srcAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL:
			// Image is read by a shader
			// Make sure any shader reads from the image have been finished
			barier.srcAccessMask = VK_ACCESS_SHADER_READ_BIT;
			break;
		default:
			// Other source layouts aren't handled (yet)
			break;
		}

		// Target layouts (new)
		// Destination access mask controls the dependency for the new image layout
		switch (newImageLayout)
		{
		case VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL:
			// Image will be used as a transfer destination
			// Make sure any writes to the image have been finished
			barier.dstAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL:
			// Image will be used as a transfer source
			// Make sure any reads from the image have been finished
			barier.dstAccessMask = VK_ACCESS_TRANSFER_READ_BIT;
			break;

		case VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL:
			// Image will be used as a color attachment
			// Make sure any writes to the color buffer have been finished
			barier.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL:
			// Image layout will be used as a depth/stencil attachment
			// Make sure any writes to depth/stencil buffer have been finished
			barier.dstAccessMask |= VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
			break;

		case VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL:
			// Image will be read in a shader (sampler, input attachment)
			// Make sure any writes to the image have been finished
			if (barier.srcAccessMask == 0)
				barier.srcAccessMask = VK_ACCESS_HOST_WRITE_BIT | VK_ACCESS_TRANSFER_WRITE_BIT;

			barier.dstAccessMask = VK_ACCESS_SHADER_READ_BIT;
			break;
		default:
			// Other source layouts aren't handled (yet)
			break;
		}
		return barier;
	}

	bool ImageSpecification::operator==(const ImageSpecification& other) const
	{
		return format == other.format &&
			width == other.width &&
			height == other.height &&
			mipLevels == other.mipLevels &&
			usage == other.usage;
	}


	VkResult Image::Create(const VkImageCreateInfo& dimg_info, VmaMemoryUsage usage, VkMemoryPropertyFlags requiredFlags)
	{
		VmaAllocationCreateInfo dimg_allocinfo = {
			.usage = usage,
			.requiredFlags = requiredFlags,
		};

		width = dimg_info.extent.width;
		height = dimg_info.extent.height;
		mipLevels = dimg_info.mipLevels;
		layers = dimg_info.arrayLayers;
		format = dimg_info.format;

		return vmaCreateImage(VulkanContext::GetMemoryAllocator(), &dimg_info, &dimg_allocinfo, &m_Handle, &m_Allocation, nullptr);
	}

	VkResult Image::Create(const ImageSpecification& imageSpec, VmaMemoryUsage usage, VkMemoryPropertyFlags requiredFlags)
	{
		return Create({
			.sType = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO,

			.imageType = VK_IMAGE_TYPE_2D,

			.format = imageSpec.format,

			.extent = {
				.width = imageSpec.width,
				.height = imageSpec.height,
				.depth = 1,
			},

			.mipLevels = imageSpec.mipLevels,
			.arrayLayers = 1,
			.samples = VK_SAMPLE_COUNT_1_BIT,
			.tiling = VK_IMAGE_TILING_OPTIMAL,
			.usage = imageSpec.usage
			}, usage, requiredFlags);
	}

	void Image::Destroy()
	{
		vmaDestroyImage(VulkanContext::GetMemoryAllocator(), m_Handle, m_Allocation);
		m_Handle = VK_NULL_HANDLE;
		m_Allocation = VK_NULL_HANDLE;
	}

	void Image::InsertMemoryBarrier(
		VkCommandBuffer cmd,
		VkAccessFlags srcAccessMask,
		VkAccessFlags dstAccessMask,
		VkImageLayout oldImageLayout,
		VkImageLayout newImageLayout,
		VkPipelineStageFlags srcStageMask,
		VkPipelineStageFlags dstStageMask,
		VkImageSubresourceRange subresourceRange)
	{
		VkImageMemoryBarrier imageMemoryBarrier = {
			.sType = VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER,
			.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
			.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
			.srcAccessMask = srcAccessMask,
			.dstAccessMask = dstAccessMask,
			.oldLayout = oldImageLayout,
			.newLayout = newImageLayout,
			.image = m_Handle,
			.subresourceRange = subresourceRange,
		};

		vkCmdPipelineBarrier(cmd, srcStageMask, dstStageMask, 0, 0, nullptr, 0, nullptr, 1, &imageMemoryBarrier);
	}

	void Image::InsertMemoryBarrier(
		VkCommandBuffer cmd,
		VkImageAspectFlags aspectMask,
		VkAccessFlags srcAccessMask,
		VkAccessFlags dstAccessMask,
		VkImageLayout oldImageLayout,
		VkImageLayout newImageLayout,
		VkPipelineStageFlags srcStageMask,
		VkPipelineStageFlags dstStageMask)
	{
		InsertMemoryBarrier(cmd, srcAccessMask, dstAccessMask, oldImageLayout, newImageLayout, srcStageMask, dstStageMask, {
			.aspectMask = aspectMask,
			.levelCount = mipLevels,
			.layerCount = layers,
			});
	}

	void Image::SetLayout(
		VkCommandBuffer cmd,
		VkImageLayout oldImageLayout,
		VkImageLayout newImageLayout,
		VkImageSubresourceRange subresourceRange,
		VkPipelineStageFlags srcStageMask,
		VkPipelineStageFlags dstStageMask)
	{
		VkImageMemoryBarrier imageMemoryBarrier = GenerateImageMemoryBarier(m_Handle, oldImageLayout, newImageLayout, subresourceRange);

		vkCmdPipelineBarrier(cmd, srcStageMask, dstStageMask, 0, 0, nullptr, 0, nullptr, 1, &imageMemoryBarrier);
	}

	// Fixed sub resource on first mip level and layer
	void Image::SetLayout(
		const VkCommandBuffer& cmd,
		const VkImageAspectFlags& aspectMask,
		const VkImageLayout& oldImageLayout,
		const VkImageLayout& newImageLayout,
		const VkPipelineStageFlags& srcStageMask,
		const VkPipelineStageFlags& dstStageMask)
	{
		VkImageSubresourceRange subresourceRange = {
			.aspectMask = aspectMask,
			.levelCount = mipLevels,
			.layerCount = layers,
		};
		SetLayout(cmd, oldImageLayout, newImageLayout, subresourceRange, srcStageMask, dstStageMask);
	}

	VkSubresourceLayout Image::SubresourceLayout(const VkImageAspectFlagBits& aspectMask)
	{
		VkImageSubresource subResource{};
		subResource.aspectMask = aspectMask;
		VkSubresourceLayout subResourceLayout;

		vkGetImageSubresourceLayout(VulkanContext::GetLogicalDevice(), m_Handle, &subResource, &subResourceLayout);
		return subResourceLayout;
	}

	bool Image::HasDepth() const
	{
		VkFormat formats[] =
		{
			VK_FORMAT_D16_UNORM,
			VK_FORMAT_X8_D24_UNORM_PACK32,
			VK_FORMAT_D32_SFLOAT,
			VK_FORMAT_D16_UNORM_S8_UINT,
			VK_FORMAT_D24_UNORM_S8_UINT,
			VK_FORMAT_D32_SFLOAT_S8_UINT
		};
		return std::find(std::begin(formats), std::end(formats), format) != std::end(formats);
	}

	bool Image::HasStencil() const
	{
		VkFormat formats[] =
		{
			VK_FORMAT_S8_UINT,
			VK_FORMAT_D16_UNORM_S8_UINT,
			VK_FORMAT_D24_UNORM_S8_UINT,
			VK_FORMAT_D32_SFLOAT_S8_UINT,
		};
		return std::find(std::begin(formats), std::end(formats), format) != std::end(formats);
	}


	VkResult ImageView::Create(const Image& image)
	{
		return Create({
			.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO,

			.image = image,
			.viewType = image.layers > 1 ? VK_IMAGE_VIEW_TYPE_2D_ARRAY : VK_IMAGE_VIEW_TYPE_2D,
			.format = image.format,
			.components = { VK_COMPONENT_SWIZZLE_R, VK_COMPONENT_SWIZZLE_G, VK_COMPONENT_SWIZZLE_B, VK_COMPONENT_SWIZZLE_A },
			.subresourceRange = {
				.aspectMask = VkImageAspectFlags(image.HasDepth() ? VK_IMAGE_ASPECT_DEPTH_BIT : VK_IMAGE_ASPECT_COLOR_BIT),
				.levelCount = image.mipLevels,
				.layerCount = image.layers,
			},
			});
	}

	VkResult Sampler::Create(const SamplerSpecification& spec)
	{
		return Create({
			.sType = VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO,

			.magFilter = (VkFilter)spec.magFilter,
			.minFilter = (VkFilter)spec.minFilter,
			.mipmapMode = (VkSamplerMipmapMode)spec.mipmapMode,
			.addressModeU = (VkSamplerAddressMode)spec.addressModeU,
			.addressModeV = (VkSamplerAddressMode)spec.addressModeV,
			.addressModeW = (VkSamplerAddressMode)spec.addressModeW,
			.mipLodBias = spec.mipLodBias,
			.anisotropyEnable = spec.anisotropyEnable,
			.maxAnisotropy = spec.maxAnisotropy,
			.compareEnable = false,
			.compareOp = VK_COMPARE_OP_NEVER,
			.minLod = spec.minLod,
			.maxLod = spec.maxLod,
			.borderColor = VK_BORDER_COLOR_FLOAT_OPAQUE_BLACK,
			.unnormalizedCoordinates = false
			});
	}
}