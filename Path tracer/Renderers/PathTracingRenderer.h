#pragma once

#include "../Rendering/Shader.h"
#include "../Rendering/CommandEncoder.h"

#include "../imgui_backend/imgui_impl_vulkan.h"

using namespace wc;

constexpr uint32_t ComputeWorkGroupSize = 4;

struct PathTracingRenderer
{
	glm::vec2 renderSize;

	Shader shader;
	VkDescriptorSet descriptorSet;
	VkDescriptorSet ImguiImageID;

	vk::Image outputImage;
	vk::ImageView outputImageView;

	vk::Sampler screenSampler;

	VkCommandBuffer computeCmd[FRAME_OVERLAP];

	void Init()
	{
		for (uint32_t i = 0; i < FRAME_OVERLAP; i++)
		{
			//vk::SyncContext::GraphicsCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, Cmd[i]);
			vk::SyncContext::ComputeCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, computeCmd[i]);
		}

		shader.Create("assets/shaders/pathTracer.comp");
		vk::descriptorAllocator.Allocate(descriptorSet, shader.DescriptorLayout);

		screenSampler.Create({
			.magFilter = vk::Filter::LINEAR,
			.minFilter = vk::Filter::LINEAR,
			.mipmapMode = vk::SamplerMipmapMode::LINEAR,
			.addressModeU = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.addressModeV = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.addressModeW = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			});
	}

	void CreateScreen(glm::vec2 size)
	{
		renderSize = size;

		{
			outputImage.Create({
				.format = VK_FORMAT_R32G32B32A32_SFLOAT,
				.width = (uint32_t)renderSize.x,
				.height = (uint32_t)renderSize.y,
				.usage = VK_IMAGE_USAGE_STORAGE_BIT | VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT/*| VK_IMAGE_USAGE_STORAGE_BIT*/,
				});
			outputImage.SetName("Renderer2D::outputImage");

			outputImageView.Create(outputImage);
			outputImageView.SetName("Renderer2D::outputImageView");
		}

		vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
			outputImage.SetLayout(cmd, VK_IMAGE_ASPECT_COLOR_BIT, VK_IMAGE_LAYOUT_UNDEFINED, VK_IMAGE_LAYOUT_GENERAL);
			});

		vk::DescriptorWriter writer(descriptorSet);
		writer.BindImage(0, screenSampler, outputImageView, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE);

		ImguiImageID = MakeImGuiDescriptor(ImguiImageID, { screenSampler, outputImageView, VK_IMAGE_LAYOUT_GENERAL });
	}

	void DestroyScreen()
	{
		outputImage.Destroy();
		outputImageView.Destroy();
	}

	void Resize(glm::vec2 size)
	{
		DestroyScreen();
		CreateScreen(size);
	}

	void Render()
	{
		wc::CommandEncoder cmd;
		cmd.BindShader(shader);
		cmd.BindDescriptorSet(descriptorSet);

		cmd.Dispatch(glm::ceil((glm::vec2)renderSize / glm::vec2(ComputeWorkGroupSize)));
		cmd.ExecuteCompute(computeCmd[CURRENT_FRAME]);
	}

	void Deinit()
	{
		DestroyScreen();
		shader.Destroy();
		screenSampler.Destroy();
	}
};