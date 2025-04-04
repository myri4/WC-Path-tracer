#pragma once

#include "Buffer.h"
#include <glm/glm.hpp>
#undef min

namespace vk 
{
    glm::ivec2 GetMipSize(uint32_t level, glm::ivec2 size);

    uint32_t GetMipLevelCount(glm::vec2 size);

    VkImageMemoryBarrier GenerateImageMemoryBarier(
        VkImage image,
        VkImageLayout oldImageLayout,
        VkImageLayout newImageLayout,
        VkImageSubresourceRange subresourceRange);

    struct ImageSpecification
    {
        VkFormat                 format = VK_FORMAT_UNDEFINED;
        uint32_t                 width = 1;
        uint32_t                 height = 1;
        uint32_t                 mipLevels = 1;
        VkImageUsageFlags        usage = 0;

        bool operator==(const ImageSpecification& other) const;
    };

    class Image : public VkObject<VkImage> 
    {
        VmaAllocation m_Allocation = VK_NULL_HANDLE;
    public:
        uint32_t width = 0, height = 0;
        uint32_t mipLevels = 1;
        uint32_t layers = 1;
        VkFormat format = VK_FORMAT_UNDEFINED;

        Image() = default;
        Image(VkImage img, VmaAllocation alloc = VK_NULL_HANDLE)
		{
			m_Handle = img;
			m_Allocation = alloc;
		}

        VkResult Create(const VkImageCreateInfo& dimg_info, VmaMemoryUsage usage = VMA_MEMORY_USAGE_GPU_ONLY, VkMemoryPropertyFlags requiredFlags = 0);

        VkResult Create(const ImageSpecification& imageSpec, VmaMemoryUsage usage = VMA_MEMORY_USAGE_GPU_ONLY, VkMemoryPropertyFlags requiredFlags = 0);

        void Destroy();

        glm::ivec2 GetMipSize(uint32_t level) const { return vk::GetMipSize(level, {width, height}); }

        glm::ivec2 GetSize() const { return { width, height }; }
        float GetAspectRatio() const { return (float)width / (float)height; }

        uint32_t GetMipLevelCount() { return vk::GetMipLevelCount({ width, height }); }

        void InsertMemoryBarrier(
            VkCommandBuffer cmd,
            VkAccessFlags srcAccessMask,
            VkAccessFlags dstAccessMask,
            VkImageLayout oldImageLayout,
            VkImageLayout newImageLayout,
            VkPipelineStageFlags srcStageMask,
            VkPipelineStageFlags dstStageMask,
            VkImageSubresourceRange subresourceRange);

        void InsertMemoryBarrier(
            VkCommandBuffer cmd,
            VkImageAspectFlags aspectMask,
            VkAccessFlags srcAccessMask,
            VkAccessFlags dstAccessMask,
            VkImageLayout oldImageLayout,
            VkImageLayout newImageLayout,
            VkPipelineStageFlags srcStageMask,
            VkPipelineStageFlags dstStageMask);

        void SetLayout(
            VkCommandBuffer cmd,
            VkImageLayout oldImageLayout,
            VkImageLayout newImageLayout,
            VkImageSubresourceRange subresourceRange,
            VkPipelineStageFlags srcStageMask = VK_PIPELINE_STAGE_ALL_COMMANDS_BIT,
            VkPipelineStageFlags dstStageMask = VK_PIPELINE_STAGE_ALL_COMMANDS_BIT);

        // Fixed sub resource on first mip level and layer
        void SetLayout(
            const VkCommandBuffer& cmd,
            const VkImageAspectFlags& aspectMask,
            const VkImageLayout& oldImageLayout,
            const VkImageLayout& newImageLayout,
            const VkPipelineStageFlags& srcStageMask = VK_PIPELINE_STAGE_ALL_COMMANDS_BIT,
            const VkPipelineStageFlags& dstStageMask = VK_PIPELINE_STAGE_ALL_COMMANDS_BIT);

        VkSubresourceLayout SubresourceLayout(const VkImageAspectFlagBits& aspectMask = VK_IMAGE_ASPECT_COLOR_BIT);

        bool HasDepth() const;

        bool HasStencil() const;

        bool IsDepthStencil() const { return(HasDepth() || HasStencil()); }
    };

    struct ImageView : public VkObject<VkImageView> 
    {
        ImageView() = default;
        ImageView(VkImageView view) { m_Handle = view; }
        VkResult Create(const VkImageViewCreateInfo& createInfo) { return vkCreateImageView(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle); }

        VkResult Create(const Image& image);

        void Destroy()
		{
			vkDestroyImageView(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}
    };


	struct TrackedImageView : public ImageView
	{
		VkImageLayout layout = VK_IMAGE_LAYOUT_UNDEFINED;

		uint32_t baseMipLevel = 0;
		uint32_t levelCount = 1;
		uint32_t baseArrayLayer = 0;
		uint32_t layerCount = 1;
	};

	struct TrackedImage : public Image
	{
		std::vector<TrackedImageView> views;
	};

    enum class Filter 
    {
        NEAREST = 0,
        LINEAR = 1,
    };

    enum class SamplerMipmapMode 
    {
        NEAREST = 0,
        LINEAR = 1,
    };

    enum SamplerAddressMode 
    {
        REPEAT = 0,
        MIRRORED_REPEAT = 1,
        CLAMP_TO_EDGE = 2,
        CLAMP_TO_BORDER = 3
    };

    struct SamplerSpecification
    {
        Filter                magFilter = Filter::NEAREST;
        Filter                minFilter = Filter::NEAREST;
        SamplerMipmapMode     mipmapMode = SamplerMipmapMode::NEAREST;
        SamplerAddressMode    addressModeU = SamplerAddressMode::REPEAT;
        SamplerAddressMode    addressModeV = SamplerAddressMode::REPEAT;
        SamplerAddressMode    addressModeW = SamplerAddressMode::REPEAT;
        float                 mipLodBias = 0.f;
        bool                  anisotropyEnable = false;
        float                 maxAnisotropy = 1.f;
        float                 minLod = 0.f;
        float                 maxLod = 1.f;
    };

    struct Sampler : public VkObject<VkSampler> 
    {
        Sampler() = default;
        Sampler(const VkSampler& sampler) { m_Handle = sampler; }

		VkResult Create(const VkSamplerCreateInfo& create_info) { return vkCreateSampler(VulkanContext::GetLogicalDevice(), &create_info, VulkanContext::GetAllocator(), &m_Handle); }

        VkResult Create(const SamplerSpecification& spec);

        void Destroy()
		{
			vkDestroySampler(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}
    };
}