#pragma once

#include <filesystem>
#include "../imgui_backend/imgui_impl_vulkan.h"
#include "vk/Image.h"

namespace wc 
{
    struct TextureSpecification
    {
        // Image
		VkFormat                 format = VK_FORMAT_R8G8B8A8_UNORM;
		uint32_t                 width = 1;
		uint32_t                 height = 1;
        bool                     mipMapping = false;
		VkImageUsageFlags        usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_TRANSFER_DST_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT;

        // Sampler
		vk::Filter                magFilter = vk::Filter::NEAREST;
		vk::Filter                minFilter = vk::Filter::NEAREST;
		vk::SamplerMipmapMode     mipmapMode = vk::SamplerMipmapMode::NEAREST;
		vk::SamplerAddressMode    addressModeU = vk::SamplerAddressMode::REPEAT;
		vk::SamplerAddressMode    addressModeV = vk::SamplerAddressMode::REPEAT;
		vk::SamplerAddressMode    addressModeW = vk::SamplerAddressMode::REPEAT;
    };

    struct Texture 
    {
        vk::Image image;
        vk::ImageView view;
        vk::Sampler sampler;
        VkDescriptorSet imageID = VK_NULL_HANDLE;

        void Allocate(const TextureSpecification& specification);

        void Allocate(uint32_t width, uint32_t height, bool mipMapping = false);

        void Load(const void* data, uint32_t width, uint32_t height, bool mipMapping = false);

        void Load(const std::string& filepath, bool mipMapping = false);

        void SetData(const void* data, uint32_t width, uint32_t height, uint32_t offsetX = 0, uint32_t offsetY = 0, bool mipMapping = false);

        void MakeRenderable();

        void Destroy();

        glm::ivec2 GetSize() { return { image.width, image.height }; }

        void SetName(const std::string& name);

        operator ImTextureID () const { return (ImTextureID)imageID; }
    };
}