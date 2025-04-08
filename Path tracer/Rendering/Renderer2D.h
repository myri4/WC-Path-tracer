#pragma once

#include "Shader.h"

#include "RenderData.h"

#include "Font.h"

#include "CommandEncoder.h"

namespace blaze
{
	inline uint32_t m_ComputeWorkGroupSize = 4; // @TODO: REMOVE!!!?

	struct BloomPass
	{
		wc::Shader m_Shader;
		vk::Sampler m_Sampler;

		std::vector<VkDescriptorSet> m_DescriptorSets;

		uint32_t m_MipLevels = 1;

		struct
		{
			std::vector<vk::ImageView> imageViews;
			vk::Image image;
		} m_Buffers[3];

		auto GetOutput();

		void Init();

		void CreateImages(glm::vec2 renderSize, uint32_t mipLevelCount);

		void SetUp(const vk::ImageView& input);

		void Execute(wc::CommandEncoder& cmd, float Threshold = 1.f, float Knee = 0.6f);

		void DestroyImages();

		void Deinit();
	};

	struct CompositePass
	{
		wc::Shader m_Shader;
		VkDescriptorSet m_DescriptorSet;

		void Init();

		void SetUp(vk::Sampler sampler, vk::ImageView output, vk::ImageView input, vk::ImageView bloomInput);

		void Execute(wc::CommandEncoder& cmd, glm::ivec2 size);

		void Deinit();
	};

	struct CRTPass
	{
		wc::Shader m_Shader;
		VkDescriptorSet m_DescriptorSet;

		void Init();

		void SetUp(vk::Sampler sampler, vk::ImageView output, vk::ImageView input);

		void Execute(wc::CommandEncoder& cmd, glm::ivec2 size, float time);

		void Deinit();
	};

	struct Renderer2D
	{
		glm::vec2 m_RenderSize; // @NOTE: why is this a float vec2?

		// Rendering
		VkFramebuffer m_Framebuffer;
		VkRenderPass m_RenderPass;

		vk::Image m_OutputImage;
		vk::ImageView m_OutputImageView;

		vk::Image m_DepthImage;
		vk::ImageView m_DepthImageView;

		vk::Image m_EntityImage;
		vk::ImageView m_EntityImageView;


		wc::Shader m_Shader;
		VkDescriptorSet m_DescriptorSet;
		uint32_t TextureCapacity = 0;

		wc::Shader m_LineShader;


		// Post processing
		BloomPass bloom;
		CompositePass composite;
		CRTPass crt;

		vk::Image m_FinalImage[2];
		vk::ImageView m_FinalImageView[2];
		vk::Sampler m_ScreenSampler;

		VkCommandBuffer m_Cmd[FRAME_OVERLAP];
		VkCommandBuffer m_ComputeCmd[FRAME_OVERLAP];
		VkDescriptorSet ImguiImageID = VK_NULL_HANDLE;

		auto GetAspectRatio() { return m_RenderSize.x / m_RenderSize.y; }
		auto GetHalfSize(glm::vec2 size, float Zoom) const { return size * Zoom; }
		auto GetHalfSize(float Zoom) const { return GetHalfSize(m_RenderSize / 128.f, Zoom); }

		auto ScreenToWorld(glm::vec2 coords, float Zoom) const;

		auto WorldToScreen(glm::vec2 worldCoords, float Zoom) const;

		void Init();

		void AllocateNewDescriptor(uint32_t count);

		void UpdateTextures(const AssetManager& assetManager);

		void CreateScreen(glm::vec2 size);

		void Resize(glm::vec2 newSize);

		void DestroyScreen();

		void Deinit();

		void Flush(RenderData& renderData, const glm::mat4& viewProj);
	};
}
