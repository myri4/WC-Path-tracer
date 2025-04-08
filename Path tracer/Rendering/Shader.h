#pragma once

#pragma warning(push, 0)
#include <magic_enum.hpp>
#pragma warning(pop)

#include "vk/Buffer.h"
#include "vk/Pipeline.h"
#include "Descriptors.h"

#include <fstream>
#include <filesystem>

namespace wc
{
	void ReadBinary(const std::string& filename, std::vector<uint32_t>& buffer);
	VkPipelineColorBlendAttachmentState CreateBlendAttachment(bool enable = true);

	struct ShaderCreateInfo
	{
		std::vector<uint32_t> binaries[2];

		glm::vec2 renderSize = glm::vec2(0.f);
		VkRenderPass renderPass;

		std::vector<VkPipelineColorBlendAttachmentState> blendAttachments;
		bool depthTest = false;

		VkPrimitiveTopology topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST;
		VkFrontFace frontFace = VK_FRONT_FACE_CLOCKWISE;

		VkDescriptorBindingFlags* bindingFlags = nullptr;
		uint32_t bindingFlagCount = 0;
		bool dynamicDescriptorCount = false;

		VkDynamicState* dynamicState = nullptr;
		uint32_t dynamicStateCount = 0;
	};

	struct ComputeShaderCreateInfo
	{
		ComputeShaderCreateInfo() = default;
		ComputeShaderCreateInfo(const std::string& path);
		ComputeShaderCreateInfo(const char* path);

		std::vector<uint32_t> binary;

		VkDescriptorBindingFlags* bindingFlags = nullptr;
		uint32_t bindingFlagCount = 0;
		bool dynamicDescriptorCount = false;
	};

	struct Shader
	{	
		VkPipeline Pipeline = VK_NULL_HANDLE;
		VkPipelineLayout PipelineLayout = VK_NULL_HANDLE;
		VkDescriptorSetLayout DescriptorLayout = VK_NULL_HANDLE;

		VkDescriptorSet AllocateDescriptorSet();

		void Destroy();

		void Create(const ShaderCreateInfo& createInfo);

		void Create(const ComputeShaderCreateInfo& createInfo);
	};
}