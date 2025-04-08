#include "Renderer2D.h"

#include "AssetManager.h"

#include "Descriptors.h"

#include "../imgui_backend/imgui_impl_vulkan.h"

namespace blaze
{
	auto BloomPass::GetOutput() { return m_Buffers[2].imageViews[0]; }

	void BloomPass::Init()
	{
		m_Shader.Create("assets/shaders/bloom.comp");
	}

	void BloomPass::CreateImages(glm::vec2 renderSize, uint32_t mipLevelCount)
	{
		glm::uvec2 bloomTexSize = renderSize * 0.5f;
		bloomTexSize += glm::uvec2(m_ComputeWorkGroupSize - bloomTexSize.x % m_ComputeWorkGroupSize, m_ComputeWorkGroupSize - bloomTexSize.y % m_ComputeWorkGroupSize);
		m_MipLevels = glm::max(mipLevelCount - 4, 1u);

		vk::SamplerSpecification samplerSpec = {
			.magFilter = vk::Filter::LINEAR,
			.minFilter = vk::Filter::LINEAR,
			.mipmapMode = vk::SamplerMipmapMode::LINEAR,
			.addressModeU = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.addressModeV = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.addressModeW = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.maxLod = float(m_MipLevels),
		};

		m_Sampler.Create(samplerSpec);
		m_Sampler.SetName("BloomSampler");

		for (int i = 0; i < 3; i++)
		{
			auto& buffer = m_Buffers[i];
			vk::ImageSpecification imgInfo = {
				.format = VK_FORMAT_R32G32B32A32_SFLOAT,

				.width = bloomTexSize.x,
				.height = bloomTexSize.y,

				.mipLevels = m_MipLevels,
				.usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_STORAGE_BIT,
			};

			buffer.image.Create(imgInfo);

			auto& views = buffer.imageViews;
			views.reserve(imgInfo.mipLevels);

			VkImageViewCreateInfo createInfo = {
				.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO,
				.viewType = VK_IMAGE_VIEW_TYPE_2D,
				.format = VK_FORMAT_R32G32B32A32_SFLOAT,
				.flags = 0,
				.image = buffer.image,
				.subresourceRange = {
					.layerCount = 1,
					.levelCount = imgInfo.mipLevels,
					.baseMipLevel = 0,
					.baseArrayLayer = 0,
					.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
				}
			};
			{ // Creating the first image view
				auto& imageView = views.emplace_back();
				imageView.Create(createInfo);
			}

			// Create The rest
			createInfo.subresourceRange.levelCount = 1;
			for (uint32_t mip = 1; mip < imgInfo.mipLevels; mip++)
			{
				createInfo.subresourceRange.baseMipLevel = mip;
				auto& imageView = views.emplace_back();
				imageView.Create(createInfo);
			}

			buffer.image.SetName(std::format("m_BloomBuffers[{}]", i));
		}

		vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd)
			{
				VkImageSubresourceRange range = {
					.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
					.baseArrayLayer = 0,
					.baseMipLevel = 0,
					.layerCount = 1,
					.levelCount = m_MipLevels,
				};
				for (int i = 0; i < 3; i++)
					m_Buffers[i].image.SetLayout(cmd, VK_IMAGE_LAYOUT_UNDEFINED, VK_IMAGE_LAYOUT_GENERAL, range);
			});
	}

	void BloomPass::SetUp(const vk::ImageView& input)
	{
		m_DescriptorSets.reserve(m_MipLevels * 3 - 1);

		uint32_t usingSets = 0;

		auto GenerateDescriptor = [&](const vk::ImageView& outputView, const vk::ImageView& inputView)
			{
				VkDescriptorSet* descriptor = nullptr;
				if (usingSets < m_DescriptorSets.size())
					descriptor = &m_DescriptorSets[usingSets];
				else
				{
					descriptor = &m_DescriptorSets.emplace_back();
					vk::descriptorAllocator.Allocate(*descriptor, m_Shader.DescriptorLayout);
				}
				usingSets++;

				vk::DescriptorWriter writer(*descriptor);
				writer.BindImage(0, m_Sampler, outputView, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE);
				writer.BindImage(1, m_Sampler, inputView, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER);
				writer.BindImage(2, m_Sampler, m_Buffers[2].imageViews[0], VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER);
			};

		GenerateDescriptor(m_Buffers[0].imageViews[0], input);

		for (uint32_t currentMip = 1; currentMip < m_MipLevels; currentMip++)
		{
			// Ping
			GenerateDescriptor(m_Buffers[1].imageViews[currentMip], m_Buffers[0].imageViews[0]);

			// Pong
			GenerateDescriptor(m_Buffers[0].imageViews[currentMip], m_Buffers[1].imageViews[0]);
		}


		// First Upsample
		GenerateDescriptor(m_Buffers[2].imageViews[m_MipLevels - 1], m_Buffers[0].imageViews[0]);

		for (int currentMip = m_MipLevels - 2; currentMip >= 0; currentMip--)
			GenerateDescriptor(m_Buffers[2].imageViews[currentMip], m_Buffers[0].imageViews[0]);
	}

	void BloomPass::Execute(wc::CommandEncoder& cmd, float Threshold, float Knee)
	{
		cmd.BindShader(m_Shader);
		uint32_t counter = 0;

		enum
		{
			Prefilter,
			Downsample,
			UpsampleFirst,
			Upsample
		};

		struct
		{
			glm::vec4 Params = glm::vec4(1.f); // (x) threshold, (y) threshold - knee, (z) knee * 2, (w) 0.25 / knee
			float LOD = 0.f;
			int Mode = Prefilter;
		} settings;

		settings.Params = glm::vec4(Threshold, Threshold - Knee, Knee * 2.f, 0.25f / Knee);
		cmd.PushConstants(settings);
		cmd.BindDescriptorSet(m_DescriptorSets[counter++]);
		cmd.Dispatch(glm::ceil(glm::vec2(m_Buffers[0].image.GetSize()) / glm::vec2(m_ComputeWorkGroupSize)));

		settings.Mode = Downsample;
		for (uint32_t currentMip = 1; currentMip < m_MipLevels; currentMip++)
		{
			glm::vec2 dispatchSize = glm::ceil((glm::vec2)m_Buffers[0].image.GetMipSize(currentMip) / glm::vec2(m_ComputeWorkGroupSize));

			// Ping
			settings.LOD = float(currentMip - 1);
			cmd.PushConstants(settings);

			cmd.BindDescriptorSet(m_DescriptorSets[counter++]);
			cmd.Dispatch(dispatchSize);

			// Pong
			settings.LOD = float(currentMip);
			cmd.PushConstants(settings);

			cmd.BindDescriptorSet(m_DescriptorSets[counter++]);
			cmd.Dispatch(dispatchSize);
		}

		// First Upsample
		settings.LOD = float(m_MipLevels - 2);
		settings.Mode = UpsampleFirst;
		cmd.PushConstants(settings);

		cmd.BindDescriptorSet(m_DescriptorSets[counter++]);
		cmd.Dispatch(glm::ceil((glm::vec2)m_Buffers[2].image.GetMipSize(m_MipLevels - 1) / glm::vec2(m_ComputeWorkGroupSize)));

		settings.Mode = Upsample;
		for (int currentMip = m_MipLevels - 2; currentMip >= 0; currentMip--)
		{
			settings.LOD = float(currentMip);
			cmd.PushConstants(settings);

			cmd.BindDescriptorSet(m_DescriptorSets[counter++]);
			cmd.Dispatch(glm::ceil((glm::vec2)m_Buffers[2].image.GetMipSize(currentMip) / glm::vec2(m_ComputeWorkGroupSize)));
		}
	}

	void BloomPass::DestroyImages()
	{
		for (int i = 0; i < 3; i++)
		{
			for (auto& view : m_Buffers[i].imageViews)
				view.Destroy();
			m_Buffers[i].image.Destroy();
			m_Buffers[i].imageViews.clear();
		}
		m_Sampler.Destroy();
	}

	void BloomPass::Deinit()
	{
		m_Shader.Destroy();
	}

	void CompositePass::Init()
	{
		m_Shader.Create("assets/shaders/composite.comp");
		vk::descriptorAllocator.Allocate(m_DescriptorSet, m_Shader.DescriptorLayout);
	}

	void CompositePass::SetUp(vk::Sampler sampler, vk::ImageView output, vk::ImageView input, vk::ImageView bloomInput)
	{
		vk::DescriptorWriter writer(m_DescriptorSet);
		writer.BindImage(0, sampler, output, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE)
			.BindImage(1, sampler, input, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER)
			.BindImage(2, sampler, bloomInput, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER);
	}

	void CompositePass::Execute(wc::CommandEncoder& cmd, glm::ivec2 size)
	{
		cmd.BindShader(m_Shader);
		cmd.BindDescriptorSet(m_DescriptorSet);
		struct
		{
			uint32_t Bloom;
		}data;
		data.Bloom = 1;
		cmd.PushConstants(data);
		cmd.Dispatch(glm::ceil((glm::vec2)size / glm::vec2(m_ComputeWorkGroupSize)));
	}

	void CompositePass::Deinit()
	{
		m_Shader.Destroy();
	}

	void CRTPass::Init()
	{
		m_Shader.Create("assets/shaders/crt.comp");
		vk::descriptorAllocator.Allocate(m_DescriptorSet, m_Shader.DescriptorLayout);
	}

	void CRTPass::SetUp(vk::Sampler sampler, vk::ImageView output, vk::ImageView input)
	{
		vk::DescriptorWriter writer(m_DescriptorSet);
		writer.BindImage(0, sampler, output, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE)
			.BindImage(1, sampler, input, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER);
	}

	void CRTPass::Execute(wc::CommandEncoder& cmd, glm::ivec2 size, float time)
	{
		cmd.BindShader(m_Shader);
		cmd.BindDescriptorSet(m_DescriptorSet);
		struct {
			float time = 0.f;
			uint32_t CRT;
			uint32_t Vignete;
			float Brighness;
		} m_Data;
		m_Data.time = time;
		m_Data.CRT = 1;
		m_Data.Vignete = 1;
		m_Data.Brighness = 1.f;

		cmd.PushConstants(m_Data);
		cmd.Dispatch(glm::ceil((glm::vec2)size / glm::vec2(m_ComputeWorkGroupSize)));
	}

	void CRTPass::Deinit()
	{
		m_Shader.Destroy();
	}

	auto Renderer2D::ScreenToWorld(glm::vec2 coords, float Zoom) const
	{
		float camX = ((2.f * coords.x / m_RenderSize.x) - 1.f);
		float camY = (1.f - (2.f * coords.y / m_RenderSize.y));
		return glm::vec2(camX, camY) * GetHalfSize(Zoom);
	}

	auto Renderer2D::WorldToScreen(glm::vec2 worldCoords, float Zoom) const
	{
		glm::vec2 relativeCoords = worldCoords / GetHalfSize(Zoom);

		float screenX = ((relativeCoords.x + 1.f) / 2.f) * m_RenderSize.x;
		float screenY = ((1.f - relativeCoords.y) / 2.f) * m_RenderSize.y;

		return glm::vec2(screenX, screenY);
	}

	void Renderer2D::Init()
	{
		bloom.Init();
		composite.Init();
		crt.Init();

		for (uint32_t i = 0; i < FRAME_OVERLAP; i++)
		{
			vk::SyncContext::GraphicsCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, m_Cmd[i]);
			vk::SyncContext::ComputeCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, m_ComputeCmd[i]);
		}

		{
			VkAttachmentDescription attachmentDescriptions[] = {
				{
					.format = VK_FORMAT_R32G32B32A32_SFLOAT, // @WARNING: if the image format is changed this should also be changed
					.samples = VK_SAMPLE_COUNT_1_BIT,
					.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
					.storeOp = VK_ATTACHMENT_STORE_OP_STORE,
					.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE,
					.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
					.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED,
					.finalLayout = VK_IMAGE_LAYOUT_GENERAL,
				},
				{
					.format = VK_FORMAT_R32G32_SINT, // @WARNING: if the image format is changed this should also be changed
					.samples = VK_SAMPLE_COUNT_1_BIT,
					.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
					.storeOp = VK_ATTACHMENT_STORE_OP_STORE,
					.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE,
					.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
					.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED,
					.finalLayout = VK_IMAGE_LAYOUT_GENERAL,
				},
				{
					.format = VK_FORMAT_D32_SFLOAT, // @WARNING: if the image format is changed this should also be changed
					.samples = VK_SAMPLE_COUNT_1_BIT,
					.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
					.storeOp = VK_ATTACHMENT_STORE_OP_STORE,
					.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
					.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
					.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED,
					.finalLayout = VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
				}
			};

			// Collect attachment references
			std::vector<VkAttachmentReference> colorReferences;

			colorReferences.push_back({ 0, VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL });
			colorReferences.push_back({ 1, VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL });

			VkAttachmentReference depthAttachmentRef = { 2, VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL };
			VkSubpassDescription subpass = {
				.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
				.colorAttachmentCount = static_cast<uint32_t>(colorReferences.size()),
				.pColorAttachments = colorReferences.data(),

				.pDepthStencilAttachment = &depthAttachmentRef,
			};

			// Use subpass dependencies for attachment layout transitions
			VkSubpassDependency dependencies[] = {
				{
					.srcSubpass = VK_SUBPASS_EXTERNAL,
					.dstSubpass = 0,
					.srcStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
					.dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
					.srcAccessMask = VK_ACCESS_MEMORY_READ_BIT,
					.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
					.dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
				},
				{
					.srcSubpass = 0,
					.dstSubpass = VK_SUBPASS_EXTERNAL,
					.srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
					.dstStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
					.srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
					.dstAccessMask = VK_ACCESS_MEMORY_READ_BIT,
					.dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
				},
				{
					.srcSubpass = VK_SUBPASS_EXTERNAL,
					.dstSubpass = 0,
					.srcStageMask = VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT | VK_PIPELINE_STAGE_LATE_FRAGMENT_TESTS_BIT,
					.dstStageMask = VK_PIPELINE_STAGE_EARLY_FRAGMENT_TESTS_BIT | VK_PIPELINE_STAGE_LATE_FRAGMENT_TESTS_BIT,
					.srcAccessMask = 0,
					.dstAccessMask = VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT,
				},
			};

			// Create render pass
			VkRenderPassCreateInfo renderPassInfo = {
				.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO,
				.attachmentCount = std::size(attachmentDescriptions),
				.pAttachments = attachmentDescriptions,
				.subpassCount = 1,
				.pSubpasses = &subpass,
				.dependencyCount = std::size(dependencies),
				.pDependencies = dependencies,
			};
			vkCreateRenderPass(VulkanContext::GetLogicalDevice(), &renderPassInfo, VulkanContext::GetAllocator(), &m_RenderPass);
		}

		VkDynamicState dynamicStates[] = { VK_DYNAMIC_STATE_VIEWPORT, VK_DYNAMIC_STATE_SCISSOR };

		{
			VkDescriptorBindingFlags flags[1];
			memset(flags, 0, sizeof(VkDescriptorBindingFlags) * (std::size(flags) - 1));
			flags[std::size(flags) - 1] = VK_DESCRIPTOR_BINDING_VARIABLE_DESCRIPTOR_COUNT_BIT | VK_DESCRIPTOR_BINDING_PARTIALLY_BOUND_BIT;

			wc::ShaderCreateInfo createInfo = {
				.renderPass = m_RenderPass,
				.bindingFlags = flags,
				.bindingFlagCount = (uint32_t)std::size(flags),

				.depthTest = true,
				.dynamicDescriptorCount = true,

				.dynamicState = dynamicStates,
				.dynamicStateCount = std::size(dynamicStates),
			};
			createInfo.blendAttachments.push_back(wc::CreateBlendAttachment());
			createInfo.blendAttachments.push_back(wc::CreateBlendAttachment(false));
			wc::ReadBinary("assets/shaders/Renderer2D.vert", createInfo.binaries[0]);
			wc::ReadBinary("assets/shaders/Renderer2D.frag", createInfo.binaries[1]);

			m_Shader.Create(createInfo);
		}

		{
			wc::ShaderCreateInfo createInfo = {
				.renderPass = m_RenderPass,

				.depthTest = true,

				.topology = VK_PRIMITIVE_TOPOLOGY_LINE_LIST,

				.dynamicState = dynamicStates,
				.dynamicStateCount = std::size(dynamicStates),
			};
			createInfo.blendAttachments.push_back(wc::CreateBlendAttachment());
			createInfo.blendAttachments.push_back(wc::CreateBlendAttachment(false));
			wc::ReadBinary("assets/shaders/Line.vert", createInfo.binaries[0]);
			wc::ReadBinary("assets/shaders/Line.frag", createInfo.binaries[1]);

			m_LineShader.Create(createInfo);
		}
	}

	void Renderer2D::AllocateNewDescriptor(uint32_t count)
	{
		TextureCapacity = count;

		if (m_DescriptorSet)
			vk::descriptorAllocator.Free(m_DescriptorSet);

		VkDescriptorSetVariableDescriptorCountAllocateInfo set_counts = {
			.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_ALLOCATE_INFO,
			.descriptorSetCount = 1,
			.pDescriptorCounts = &count,
		};
		vk::descriptorAllocator.Allocate(m_DescriptorSet, m_Shader.DescriptorLayout, &set_counts, set_counts.descriptorSetCount);
	}

	void Renderer2D::UpdateTextures(const AssetManager& assetManager)
	{
		vk::DescriptorWriter writer(m_DescriptorSet);

		std::vector<VkDescriptorImageInfo> infos;
		for (auto& image : assetManager.Textures)
			infos.emplace_back(image.sampler, image.view, VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL);

		writer.BindImages(0, infos, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER);
		writer.Update();
	}

	void Renderer2D::CreateScreen(glm::vec2 size)
	{
		m_RenderSize = size;

		{
			m_OutputImage.Create({
				.format = VK_FORMAT_R32G32B32A32_SFLOAT,
				.width = (uint32_t)m_RenderSize.x,
				.height = (uint32_t)m_RenderSize.y,
				.usage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT | VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT/*| VK_IMAGE_USAGE_STORAGE_BIT*/,
				});
			m_OutputImage.SetName("Renderer2D::OutputImage");

			m_OutputImageView.Create(m_OutputImage);
			m_OutputImageView.SetName("Renderer2D::OutputImageView");
		}

		{
			m_DepthImage.Create({
				.format = VK_FORMAT_D32_SFLOAT,
				.width = (uint32_t)m_RenderSize.x,
				.height = (uint32_t)m_RenderSize.y,
				.usage = VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT,
				});
			m_DepthImage.SetName("Renderer2D::DepthImage");

			m_DepthImageView.Create(m_DepthImage);
			m_DepthImageView.SetName("Renderer2D::DepthImageView");
		}

		{
			m_EntityImage.Create({
				.format = VK_FORMAT_R32G32_SINT,
				.width = (uint32_t)m_RenderSize.x,
				.height = (uint32_t)m_RenderSize.y,
				.usage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT,
				});
			m_EntityImage.SetName("Renderer2D::EntityImage");

			m_EntityImageView.Create(m_EntityImage);
			m_EntityImageView.SetName("Renderer2D::EntityImageView");
		}

		VkImageView attachments[] = { m_OutputImageView,m_EntityImageView, m_DepthImageView };
		VkFramebufferCreateInfo framebufferInfo = {
			.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO,
			.renderPass = m_RenderPass,
			.attachmentCount = std::size(attachments),
			.pAttachments = attachments,
			.width = (uint32_t)m_RenderSize.x,
			.height = (uint32_t)m_RenderSize.y,
			.layers = 1,
		};
		vkCreateFramebuffer(VulkanContext::GetLogicalDevice(), &framebufferInfo, VulkanContext::GetAllocator(), &m_Framebuffer);

		for (int i = 0; i < ARRAYSIZE(m_FinalImage); i++)
		{
			m_FinalImage[i].Create({
				.format = VK_FORMAT_R32G32B32A32_SFLOAT,
				.width = (uint32_t)m_RenderSize.x,
				.height = (uint32_t)m_RenderSize.y,
				.usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_STORAGE_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT,
				});
			m_FinalImage[i].SetName(std::format("Renderer2D::FinalImage[{}]", i));

			m_FinalImageView[i].Create(m_FinalImage[i]);
			m_FinalImageView[i].SetName(std::format("Renderer2D::FinalImageView[{}]", i));
		}

		vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
			for (int i = 0; i < ARRAYSIZE(m_FinalImage); i++)
				m_FinalImage[i].SetLayout(cmd, VK_IMAGE_ASPECT_COLOR_BIT, VK_IMAGE_LAYOUT_UNDEFINED, VK_IMAGE_LAYOUT_GENERAL);
			});

		bloom.CreateImages(m_RenderSize, m_OutputImage.GetMipLevelCount());

		// For now we are using the same sampler for sampling the screen and the bloom images but maybe it should be separated
		m_ScreenSampler.Create({
			.magFilter = vk::Filter::LINEAR,
			.minFilter = vk::Filter::LINEAR,
			.mipmapMode = vk::SamplerMipmapMode::LINEAR,
			.addressModeU = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.addressModeV = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			.addressModeW = vk::SamplerAddressMode::CLAMP_TO_EDGE,
			});

		int m_PassCount = 0; // @NOTE: Not sure if this is working properly
		int m_FinalPass = 0;

		auto GetImageBuffer = [&]()
			{
				m_FinalPass = m_PassCount++ % 2;
				return m_FinalImageView[m_FinalPass];
			};

		bloom.SetUp(m_OutputImageView);
		composite.SetUp(m_ScreenSampler, GetImageBuffer(), m_OutputImageView, bloom.GetOutput());
		{

			auto output = GetImageBuffer();
			auto input = GetImageBuffer();
			crt.SetUp(m_ScreenSampler, output, input);
		}

		ImguiImageID = MakeImGuiDescriptor(ImguiImageID, { m_ScreenSampler, m_FinalImageView[0]/*m_OutputImageView*/, VK_IMAGE_LAYOUT_GENERAL });
	}

	void Renderer2D::Resize(glm::vec2 newSize)
	{
		DestroyScreen();
		CreateScreen(newSize);
	}

	void Renderer2D::DestroyScreen()
	{
		vkDestroyFramebuffer(VulkanContext::GetLogicalDevice(), m_Framebuffer, VulkanContext::GetAllocator());
		m_Framebuffer = VK_NULL_HANDLE;

		m_OutputImage.Destroy();
		m_OutputImageView.Destroy();

		m_DepthImage.Destroy();
		m_DepthImageView.Destroy();

		m_EntityImage.Destroy();
		m_EntityImageView.Destroy();

		m_ScreenSampler.Destroy();

		for (int i = 0; i < ARRAYSIZE(m_FinalImage); i++)
		{
			m_FinalImage[i].Destroy();
			m_FinalImageView[i].Destroy();
		}

		bloom.DestroyImages();
	}

	void Renderer2D::Deinit()
	{
		bloom.Deinit();
		composite.Deinit();
		crt.Deinit();

		m_Shader.Destroy();
		m_LineShader.Destroy();

		DestroyScreen();

		vkDestroyRenderPass(VulkanContext::GetLogicalDevice(), m_RenderPass, VulkanContext::GetAllocator());
		m_RenderPass = VK_NULL_HANDLE;
	}

	void Renderer2D::Flush(RenderData& renderData, const glm::mat4& viewProj)
	{
		//if (!m_IndexCount && !m_LineVertexCount) return;

		{
			VkCommandBuffer& cmd = m_Cmd[CURRENT_FRAME];
			vkResetCommandBuffer(cmd, 0);

			VkCommandBufferBeginInfo begInfo = {
				.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO,
				.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT
			};

			vkBeginCommandBuffer(cmd, &begInfo);
			VkRenderPassBeginInfo rpInfo = { VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO };

			rpInfo.renderPass = m_RenderPass;
			rpInfo.framebuffer = m_Framebuffer;
			VkClearValue clearValues[] = {
				{.color = {0.f, 0.f, 0.f, 1.f}},
				{.color = {0, 0, 0, 0}},
				{.depthStencil = {
					.depth = 1.f
				}},
			};
			rpInfo.clearValueCount = std::size(clearValues);
			rpInfo.pClearValues = clearValues;

			rpInfo.renderArea.extent = { (uint32_t)m_RenderSize.x, (uint32_t)m_RenderSize.y };

			vkCmdBeginRenderPass(cmd, &rpInfo, VK_SUBPASS_CONTENTS_INLINE);

			VkViewport viewport = {
				.x = 0.f,
				.y = 0.f,
				//.y = createInfo.renderSize.y; // change this to 0 to invert
				.width = m_RenderSize.x,
				.height = m_RenderSize.y,
				//.height = -createInfo.renderSize.y; // remove the - to invert
				.minDepth = 0.f,
				.maxDepth = 1.f,
			};

			VkRect2D scissor = {
				.offset = { 0, 0 },
				.extent = { (uint32_t)m_RenderSize.x, (uint32_t)m_RenderSize.y },
			};


			vkCmdSetViewport(cmd, 0, 1, &viewport);
			vkCmdSetScissor(cmd, 0, 1, &scissor);

			struct
			{
				glm::mat4 ViewProj;
				VkDeviceAddress vertexBuffer;
			} m_data;
			m_data.ViewProj = viewProj;
			if (renderData.GetIndexCount())
			{
				renderData.UploadVertexData();
				m_data.vertexBuffer = renderData.GetVertexBuffer().GetDeviceAddress();
				vkCmdBindPipeline(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, m_Shader.Pipeline);
				vkCmdPushConstants(cmd, m_Shader.PipelineLayout, VK_SHADER_STAGE_VERTEX_BIT, 0, sizeof(m_data), &m_data);

				vkCmdBindDescriptorSets(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, m_Shader.PipelineLayout, 0, 1, &m_DescriptorSet, 0, nullptr);
				vkCmdBindIndexBuffer(cmd, renderData.GetIndexBuffer(), 0, VK_INDEX_TYPE_UINT32);
				vkCmdDrawIndexed(cmd, renderData.GetIndexCount(), 1, 0, 0, 0);
			}

			if (renderData.GetLineVertexCount())
			{
				renderData.UploadLineVertexData();
				m_data.vertexBuffer = renderData.GetLineVertexBuffer().GetDeviceAddress();

				vkCmdBindPipeline(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, m_LineShader.Pipeline);
				vkCmdPushConstants(cmd, m_Shader.PipelineLayout, VK_SHADER_STAGE_VERTEX_BIT, 0, sizeof(m_data), &m_data);

				vkCmdDraw(cmd, renderData.GetLineVertexCount(), 1, 0, 0);
			}


			vkCmdEndRenderPass(cmd);
			vkEndCommandBuffer(cmd);

			vk::SyncContext::Submit(cmd, vk::SyncContext::GetGraphicsQueue());
		}

		{
			wc::CommandEncoder cmd;
			bloom.Execute(cmd);
			composite.Execute(cmd, m_RenderSize);
			crt.Execute(cmd, m_RenderSize, 0.f);

			cmd.ExecuteCompute(m_ComputeCmd[CURRENT_FRAME]);
		}
	}
}