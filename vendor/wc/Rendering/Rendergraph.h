#pragma once

#include <functional>
#include <array>

#include "CommandEncoder.h"

namespace wc
{
	// Rendergraph

	enum class RDGResourceAccess : uint8_t
	{
		Write,
		Read,

		// For images
		RenderTargetColor,
	};

	enum class SizeClass : uint8_t
	{
		Relative,
		Absolute
	};

	struct GraphTask
	{
		enum class Type
		{
			GRAPHICS,
			COMPUTE,
			// TRANSFER?
		};
	};

	struct AttachmentInfo
	{
		SizeClass size_class = SizeClass::Relative;
		float size_x = 1.f;
		float size_y = 1.f;
		VkFormat format = VK_FORMAT_UNDEFINED;
		uint32_t sizeRelativeID;
		//uint32_t levels = 1;
		//uint32_t layers = 1;
		//bool persistent = true;
	};

	struct RenderAttachmentSpec
	{
		uint32_t attachmentID = 0;
		SizeClass size_class = SizeClass::Relative;
		float size_x = 1.f;
		float size_y = 1.f;
		VkFormat format = VK_FORMAT_UNDEFINED;
		bool bClear = false;
	};

	struct RenderAttachmentInfo : public RenderAttachmentSpec
	{
		VkClearValue clearValue; // @TODO: this is obsolete

		void SetClearColor(const glm::vec4& col)
		{
			for (int i = 0; i < 4; i++)
				clearValue.color.float32[i] = col[i];

			bClear = true;
		}
	};

	struct ImageDependency
	{
		uint32_t ID;
		RDGResourceAccess access;
	};

	struct GraphAttachment
	{
		std::string name;
		uint32_t width = 0;
		uint32_t height = 0;
		VkImageUsageFlags usageFlags = 0;

		vk::Image image;
		vk::ImageView view;

		SizeClass size_class = SizeClass::Relative;
		float size_x = 1.f;
		float size_y = 1.f;
		VkFormat format = VK_FORMAT_UNDEFINED;

		std::vector<ImageDependency> users;

		/*uint32_t GetReads()
		{
			uint32_t count = 0;
			for (auto& dep : users)
				if (dep.access == RDGResourceAccess::Read)
					count++;

			return count;
		}

		uint32_t GetWrites()
		{
			uint32_t count = 0;
			for (auto& dep : users)
				if (dep.access == RDGResourceAccess::Write)
					count++;

			return count;
		}*/
	};

	struct RenderPass;

	using DrawCallbackFunction = std::function<void(wc::CommandEncoder&)>;
	using InitRenderPassFunction = std::function<void(RenderPass*)>;

	struct RenderPass
	{
		PassType type;
		std::string name;
		DrawCallbackFunction DrawCallback;

		bool performSubmit = false;

		std::vector<VkImageMemoryBarrier> startBarriers;
		std::vector<VkImageMemoryBarrier> endBarriers;

		std::vector<AttachmentInfo> inputImages;
		std::vector<AttachmentInfo> outputImages;

		std::vector<VkClearValue> clearValues;
		std::vector<ImageDependency> imageDependencies;
		std::vector<RenderAttachmentSpec> colorAttachments;


		void AddColorInput(const AttachmentInfo& info) { inputImages.push_back(info); }
		void AddColorOutput(const AttachmentInfo& info) { outputImages.push_back(info); }

		void AddColorAttachment(const RenderAttachmentInfo& info)
		{
			colorAttachments.push_back(info);
			clearValues.push_back(info.clearValue);
		}

		void AddImageDependency(uint32_t id, RDGResourceAccess accessMode = RDGResourceAccess::Read) { imageDependencies.push_back({ id,accessMode }); }
	};

	struct GraphicsPass : public RenderPass
	{
		VkRenderPass renderPass = VK_NULL_HANDLE;
		VkFramebuffer framebuffer = VK_NULL_HANDLE;

		uint32_t renderWidth = 0;
		uint32_t renderHeight = 0;
	};

	struct ComputePass : public RenderPass
	{
		Shader shader;
	};

	struct RenderGraph
	{
		std::vector<RenderPass*> Passes;
		std::vector<GraphAttachment> Attachments;

		std::vector<Shader> Shaders;

		std::vector<VkCommandBuffer> usableCommands;
		std::vector<VkCommandBuffer> pendingCommands;

		std::vector<VkCommandBuffer> usableComputeCommands;
		std::vector<VkCommandBuffer> pendingComputeCommands;

	public:

		GraphicsPass* AddGraphicsPass(const std::string& name, InitRenderPassFunction initFunc, DrawCallbackFunction execution)
		{
			for (auto& pass : Passes)
				if (pass->name == name)
				{
					WC_CORE_ERROR("Redefintion of pass \"{}\".", name);
					return (GraphicsPass*)&pass;
				}

			auto* ptr = new GraphicsPass();

			ptr->name = name;
			ptr->DrawCallback = execution;
			ptr->type = PassType::Graphics;
			initFunc(ptr);
			Passes.push_back(ptr);
			return ptr;
		}

		ComputePass* AddComputePass(const std::string& name, InitRenderPassFunction initFunc, DrawCallbackFunction execution, const ComputeShaderCreateInfo& shaderInfo)
		{
			for (auto& pass : Passes)
				if (pass->name == name)
				{
					WC_CORE_ERROR("Redefintion of pass \"{}\".", name);
					return (ComputePass*)&pass;
				}

			auto* ptr = new ComputePass();

			ptr->shader.Create(shaderInfo);
			ptr->name = name;
			ptr->DrawCallback = execution;
			ptr->type = PassType::Compute;
			initFunc(ptr);
			Passes.push_back(ptr);
			return ptr;
		}

		GraphicsPass* GetGraphicsPass(const std::string& name)
		{
			for (auto& pass : Passes)
				if (pass->type == PassType::Graphics && pass->name == name)
					return (GraphicsPass*)pass;

			WC_CORE_ERROR("Pass \"{}\" does not exist.", name);

			return nullptr;
		}

		ComputePass* GetComputePass(const std::string& name)
		{
			for (auto& pass : Passes)
				if (pass->type == PassType::Compute && pass->name == name)
					return (ComputePass*)pass;

			WC_CORE_ERROR("Pass \"{}\" does not exist.", name);

			return nullptr;
		}

		uint32_t PushAttachment(RenderAttachmentInfo& info)
		{
			GraphAttachment attachment;
			attachment.size_class = info.size_class;
			attachment.size_x = info.size_x;
			attachment.size_y = info.size_y;
			attachment.format = info.format;
			Attachments.push_back(attachment);

			info.attachmentID = Attachments.size() - 1;
			return info.attachmentID;
		}

		GraphAttachment* GetAttachment(uint32_t i) { return &Attachments[i]; }

		void Build(glm::vec2 renderSize)
		{
			//grab all render targets
			for (uint32_t attachmentID = 0; attachmentID < Attachments.size(); attachmentID++)
			{
				auto& attachment = Attachments[attachmentID];
				for (uint32_t i = 0; i < Passes.size(); i++)
				{
					auto* rawPass = Passes[i];
					for (const auto& colorAttachment : rawPass->colorAttachments)
						if (colorAttachment.attachmentID == attachmentID)
						{
							attachment.users.push_back({ i, rawPass->type == PassType::Graphics ? RDGResourceAccess::RenderTargetColor : RDGResourceAccess::Write });
							break;
						}

					for (const auto& imageDependency : rawPass->imageDependencies)
						if (imageDependency.ID == attachmentID)
						{
							attachment.users.push_back({ i, imageDependency.access });
							break;
						}
				}

				for (auto& user : attachment.users)
					switch (user.access)
					{
					case RDGResourceAccess::Write:				attachment.usageFlags |= VK_IMAGE_USAGE_STORAGE_BIT; break;
					case RDGResourceAccess::Read:				attachment.usageFlags |= VK_IMAGE_USAGE_SAMPLED_BIT; break;
					case RDGResourceAccess::RenderTargetColor:  attachment.usageFlags |= VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT | VK_IMAGE_USAGE_SAMPLED_BIT; break;
					}

				vk::ImageSpecification imageSpec;

				if (attachment.size_class == SizeClass::Relative)
				{
					imageSpec.width = attachment.size_x * renderSize.x;
					imageSpec.height = attachment.size_y * renderSize.y;
				}
				else
				{
					imageSpec.width = attachment.size_x;
					imageSpec.height = attachment.size_y;
				}
				attachment.width = imageSpec.width;
				attachment.height = imageSpec.height;

				imageSpec.format = attachment.format;
				imageSpec.usage = attachment.usageFlags;
				attachment.image.Create(imageSpec, VMA_MEMORY_USAGE_GPU_ONLY, VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);
				attachment.image.SetName(attachment.name + ".image");
				VkImageViewCreateInfo imageViewInfo = {
					.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO,
					.image = attachment.image,
					.viewType = VK_IMAGE_VIEW_TYPE_2D,
					.format = attachment.format,
					.subresourceRange = {
						.aspectMask = 0,
						.baseMipLevel = 0,
						.levelCount = 1,
						.baseArrayLayer = 0,
						.layerCount = 1,
					}
				};
				auto& aspectMask = imageViewInfo.subresourceRange.aspectMask;

				// Select aspect mask and layout depending on usage
				if (attachment.usageFlags & VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT /*|| attachment.usageFlags & VK_IMAGE_USAGE_SAMPLED_BIT*/) aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;

				attachment.view.Create(imageViewInfo);
				attachment.view.SetName(attachment.name + ".view");
			}
			//make render passes

			auto FindAttachmentUser = [=](const GraphAttachment& attachment, const std::string& name) -> int
				{
					for (uint32_t i = 0; i < attachment.users.size(); i++)
						if (Passes[attachment.users[i].ID]->name == name)
							return i;

					return -1;
				};

			for (uint32_t i = 0; i < Passes.size(); i++)
			{
				auto& rawPass = Passes[i];
				if (rawPass->type == PassType::Graphics)
				{
					auto* pass = (GraphicsPass*)rawPass;
					std::vector<VkAttachmentReference> references;
					std::vector<VkAttachmentDescription> attachments;
					std::vector<VkImageView> attachmentViews;

					uint32_t colorAttachmentCount = pass->colorAttachments.size();
					uint32_t attachmentIndex = 0;
					for (const auto& colorAttachment : pass->colorAttachments)
					{
						auto& attachment = Attachments[colorAttachment.attachmentID];

						int useridx = FindAttachmentUser(attachment, pass->name);
						bool hasOutput = false;
						if (attachment.users[(useridx + 1) % attachment.users.size()].access == RDGResourceAccess::Read) hasOutput = true;

						bool first_use = (useridx == 0);

						VkAttachmentDescription desc = {
							.format = attachment.format,
							.samples = VK_SAMPLE_COUNT_1_BIT,

							.loadOp = first_use ? (colorAttachment.bClear ? VK_ATTACHMENT_LOAD_OP_CLEAR : VK_ATTACHMENT_LOAD_OP_DONT_CARE) : VK_ATTACHMENT_LOAD_OP_LOAD,
							.storeOp = hasOutput ? VK_ATTACHMENT_STORE_OP_STORE : VK_ATTACHMENT_STORE_OP_DONT_CARE,
							.initialLayout = first_use ? VK_IMAGE_LAYOUT_UNDEFINED : VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
							.finalLayout = VK_IMAGE_LAYOUT_GENERAL/*hasOutput ? VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL : VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL*/
						};

						attachments.push_back(desc);
						attachmentViews.push_back(attachment.view);

						references.push_back({ attachmentIndex++, VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL });

						pass->renderWidth = attachment.width;
						pass->renderHeight = attachment.height;
					}

					// Create render pass
					VkSubpassDescription subpass = {};
					subpass.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS;
					if (colorAttachmentCount)
					{
						subpass.pColorAttachments = references.data();
						subpass.colorAttachmentCount = colorAttachmentCount;
					}

					std::array<VkSubpassDependency, 2> dependencies = {};

					dependencies[0] = {
						.srcSubpass = VK_SUBPASS_EXTERNAL,
						.dstSubpass = 0,
						.srcStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
						.dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
						.srcAccessMask = VK_ACCESS_MEMORY_READ_BIT,
						.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
						.dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
					};

					dependencies[1] = {
						.srcSubpass = 0,
						.dstSubpass = VK_SUBPASS_EXTERNAL,
						.srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
						.dstStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
						.srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
						.dstAccessMask = VK_ACCESS_MEMORY_READ_BIT,
						.dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
					};

					VkRenderPassCreateInfo renderPassInfo = {
						.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO,
						.attachmentCount = colorAttachmentCount,
						.pAttachments = attachments.data(),
						.subpassCount = 1,
						.pSubpasses = &subpass,
						.dependencyCount = static_cast<uint32_t>(dependencies.size()),
						.pDependencies = dependencies.data(),
					};
					vkCreateRenderPass(VulkanContext::GetLogicalDevice(), &renderPassInfo, VulkanContext::GetAllocator(), &pass->renderPass);

					VkFramebufferCreateInfo fbufCreateInfo = {
						.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO,
						.renderPass = pass->renderPass,
						.attachmentCount = static_cast<uint32_t>(attachmentViews.size()),
						.pAttachments = attachmentViews.data(),
						.width = pass->renderWidth,
						.height = pass->renderHeight,
						.layers = 1,
					};

					vkCreateFramebuffer(VulkanContext::GetLogicalDevice(), &fbufCreateInfo, VulkanContext::GetAllocator(), &pass->framebuffer);
				}
				else if (rawPass->type == PassType::Compute)
				{
					// Build compute barriers
					for (const auto& ath : rawPass->colorAttachments)
					{
						auto& graphAth = Attachments[ath.attachmentID];

						VkImageSubresourceRange range = {
							.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
							.baseMipLevel = 0,
							.levelCount = 1,
							.baseArrayLayer = 0,
							.layerCount = 1,
						};

						int useridx = FindAttachmentUser(graphAth, rawPass->name);

						VkImageLayout current_layout = VK_IMAGE_LAYOUT_GENERAL;

						//we only add barrier when using the image for the first time, barriers are handled in the other cases
						if (useridx == 0)
							rawPass->startBarriers.push_back(vk::GenerateImageMemoryBarier(graphAth.image, VK_IMAGE_LAYOUT_UNDEFINED, current_layout, range));

						//find what is the next user
						if (useridx + 1 < graphAth.users.size())
						{
							VkImageLayout next_layout = VK_IMAGE_LAYOUT_UNDEFINED;

							auto& nextUsage = graphAth.users[useridx + 1].access;
							auto& nextUser = *Passes[graphAth.users[useridx + 1].ID];

							if (nextUser.type == PassType::Graphics)
								if (nextUsage == RDGResourceAccess::Read)
									next_layout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL;
								else
									next_layout = nextUsage == RDGResourceAccess::Read ? VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL : VK_IMAGE_LAYOUT_GENERAL;

							// END BARRIER
							rawPass->endBarriers.push_back(vk::GenerateImageMemoryBarier(graphAth.image, current_layout, next_layout, range));
						}
					}
				}
			}
		}

		void Destroy()
		{
			for (auto& attachment : Attachments)
			{
				attachment.image.Destroy();
				attachment.view.Destroy();
			}

			for (auto& shader : Shaders)
			{
				shader.Destroy();
			}
			Shaders.clear();

			for (auto& rawPass : Passes)
			{
				if (rawPass->type == PassType::Graphics)
				{
					auto* pass = (GraphicsPass*)rawPass;
					vkDestroyRenderPass(VulkanContext::GetLogicalDevice(), pass->renderPass, VulkanContext::GetAllocator());
					pass->renderPass = VK_NULL_HANDLE;

					vkDestroyFramebuffer(VulkanContext::GetLogicalDevice(), pass->framebuffer, VulkanContext::GetAllocator());
					pass->framebuffer = VK_NULL_HANDLE;
				}
				else if (rawPass->type == PassType::Compute)
				{
					auto* pass = (ComputePass*)rawPass;
					pass->shader.Destroy();
				}

				delete rawPass;
			}

			Attachments.clear();
			Passes.clear();
		}

		void Execute()
		{
			for (auto& cmd : pendingCommands)
				usableCommands.push_back(cmd);

			pendingCommands.clear();

			for (auto& cmd : pendingComputeCommands)
				usableComputeCommands.push_back(cmd);

			pendingComputeCommands.clear();

			auto CreateCommandBuffer = [](std::vector<VkCommandBuffer>& usableCommands, std::vector<VkCommandBuffer>& pendingCommands, const vk::CommandPool& commandPool)
				{
					VkCommandBuffer buff;
					if (usableCommands.size() > 0)
					{
						buff = usableCommands.back();
						usableCommands.pop_back();
					}
					else
						commandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, buff);

					if (buff == VK_NULL_HANDLE)
						WC_CORE_ERROR("YHo WTF");

					pendingCommands.push_back(buff);
					vkResetCommandBuffer(buff, 0);
					return buff;
				};

			auto CreateCmdFromType = [=](PassType type)
				{
					if (type == PassType::Compute) return CreateCommandBuffer(usableComputeCommands, pendingComputeCommands, vk::SyncContext::ComputeCommandPool);
					return CreateCommandBuffer(usableCommands, pendingCommands, vk::SyncContext::GraphicsCommandPool);
				};

			VkCommandBuffer cmd = VK_NULL_HANDLE;
			bool recording = false;
			PassType previousType = Passes[0]->type;

			auto BeginRecording = [&](PassType type)
				{
					if (!recording)
					{
						if (type != previousType || !cmd) cmd = CreateCmdFromType(type);
						VkCommandBufferBeginInfo begInfo = {
							.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO,
							.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT
						};

						vkBeginCommandBuffer(cmd, &begInfo);
						recording = true;
					}
				};

			auto PerformSubmit = [&](vk::Queue queue)
				{
					vkEndCommandBuffer(cmd);
					recording = false;

					vk::SyncContext::Submit(cmd, queue);
				};

			for (uint32_t i = 0; i < Passes.size(); i++)
			{
				auto* rawPass = Passes[i];
				wc::CommandEncoder encoder;
				rawPass->DrawCallback(encoder);

				if (rawPass->type == PassType::Graphics)
				{
					auto* pass = (GraphicsPass*)rawPass;
					if (previousType == PassType::Compute && cmd) PerformSubmit(vk::SyncContext::GetComputeQueue());
					BeginRecording(pass->type);
					VkRenderPassBeginInfo renderPassInfo = { VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO };

					renderPassInfo.renderPass = pass->renderPass;
					renderPassInfo.framebuffer = pass->framebuffer;
					renderPassInfo.clearValueCount = pass->clearValues.size();
					renderPassInfo.pClearValues = pass->clearValues.data();
					renderPassInfo.renderArea.extent = { (uint32_t)pass->renderWidth , (uint32_t)pass->renderHeight };

					vkCmdBeginRenderPass(cmd, &renderPassInfo, VK_SUBPASS_CONTENTS_INLINE);



					VkPipelineLayout boundLayout = VK_NULL_HANDLE;
					for (auto& c : encoder.GetEncodeBuffer())
					{
						ICommand* command = (ICommand*)c;
						switch (command->type)
						{
						case CommandType::Custom:
							break;
						case CommandType::BindPipeline:
						{
							auto* pCmd = static_cast<CMD_BindPipeline*>(command);

							boundLayout = pCmd->layout;
							vkCmdBindPipeline(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, pCmd->pipeline);
						}
						break;
						case CommandType::BindDescriptorSet:
						{
							auto* pCmd = static_cast<CMD_BindDescriptorSet*>(command);

							vkCmdBindDescriptorSets(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, boundLayout, pCmd->setNumber, 1, (VkDescriptorSet*)&pCmd->descriptorSet, 0, nullptr);
						}
						break;
						case CommandType::BindIndexBuffer:
						{
							auto* pCmd = static_cast<CMD_BindIndexBuffer*>(command);

							vkCmdBindIndexBuffer(cmd, pCmd->indexBuffer, pCmd->offset, VK_INDEX_TYPE_UINT32);
						}
						break;
						case CommandType::DrawIndexedIndirect:
						{
							auto* pCmd = static_cast<CMD_DrawIndexedIndirect*>(command);

							VkBuffer buffer = reinterpret_cast<VkBuffer>(pCmd->indirectBuffer);

							vkCmdDrawIndexedIndirect(cmd, buffer, pCmd->offset, pCmd->count, sizeof(VkDrawIndexedIndirectCommand));
						}
						break;
						case CommandType::DrawIndexed:
						{
							auto* pCmd = static_cast<CMD_DrawIndexed*>(command);

							vkCmdDrawIndexed(cmd, pCmd->indexCount, pCmd->instanceCount, pCmd->firstIndex, pCmd->vertexOffset, pCmd->firstInstance);
						}
						break;
						case CommandType::Draw:
						{
							auto* pCmd = static_cast<CMD_Draw*>(command);

							vkCmdDraw(cmd, pCmd->vertexCount, pCmd->instanceCount, pCmd->firstVertex, pCmd->firstInstance);
						}
						break;
						case CommandType::PushConstants:
						{
							auto* pCmd = static_cast<CMD_PushConstants*>(command);
							vkCmdPushConstants(cmd, boundLayout, VK_SHADER_STAGE_ALL_GRAPHICS, pCmd->offset, pCmd->size, pCmd->data);
							free(pCmd->data);
						}
						break;
						}
					}

					vkCmdEndRenderPass(cmd);

					if (pass->performSubmit) PerformSubmit(vk::SyncContext::GetGraphicsQueue());
					previousType = pass->type;
				}
				else if (rawPass->type == PassType::Compute)
				{
					auto* pass = (ComputePass*)rawPass;
					if (previousType == PassType::Graphics && cmd) PerformSubmit(vk::SyncContext::GetGraphicsQueue());
					BeginRecording(pass->type);

					vkCmdBindPipeline(cmd, VK_PIPELINE_BIND_POINT_COMPUTE, pass->shader.Pipeline);

					for (auto& c : encoder.GetEncodeBuffer())
					{
						ICommand* command = (ICommand*)c;
						switch (command->type)
						{
						case CommandType::Custom:
							break;
						case CommandType::BindDescriptorSet:
						{
							auto* pCmd = static_cast<CMD_BindDescriptorSet*>(command);

							vkCmdBindDescriptorSets(cmd, VK_PIPELINE_BIND_POINT_COMPUTE, pass->shader.PipelineLayout, pCmd->setNumber, 1, (VkDescriptorSet*)&pCmd->descriptorSet, 0, nullptr);
						}
						break;
						case CommandType::Dispatch:
						{
							auto* pCmd = static_cast<CMD_Dispatch*>(command);
							vkCmdPipelineBarrier(cmd, VK_PIPELINE_STAGE_ALL_COMMANDS_BIT, VK_PIPELINE_STAGE_ALL_COMMANDS_BIT, 0, 0, nullptr, 0, nullptr, 0, nullptr);

							vkCmdDispatch(cmd, pCmd->groupCountX, pCmd->groupCountY, pCmd->groupCountZ);
							vkCmdPipelineBarrier(cmd, VK_PIPELINE_STAGE_ALL_COMMANDS_BIT, VK_PIPELINE_STAGE_ALL_COMMANDS_BIT, 0, 0, nullptr, 0, nullptr, 0, nullptr);
						}
						break;
						case CommandType::PushConstants:
						{
							auto* pCmd = static_cast<CMD_PushConstants*>(command);
							vkCmdPushConstants(cmd, pass->shader.PipelineLayout, VK_SHADER_STAGE_COMPUTE_BIT, pCmd->offset, pCmd->size, pCmd->data);
							free(pCmd->data);
						}
						break;
						}
					}


					if (pass->performSubmit) PerformSubmit(vk::SyncContext::GetComputeQueue());
				}
			}
			vkEndCommandBuffer(cmd);
			vk::SyncContext::Submit(cmd, previousType == PassType::Compute ? vk::SyncContext::GetComputeQueue() : vk::SyncContext::GetGraphicsQueue());
		}
	};
}