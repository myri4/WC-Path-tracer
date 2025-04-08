#pragma once

#include "vk/Image.h"
#include "vk/SyncContext.h"
#include "Shader.h"

namespace wc
{
	enum class PassType : uint8_t // @TODO: move this and the other enums in a seperate file
	{
		Graphics,
		Compute,
		Transfer, // @TODO: Implement
		CPU
	};

	enum class CommandType : uint8_t
	{
		Custom,
		BindDescriptorSet,
		BindIndexBuffer,
		DrawIndexedIndirect,
		DrawIndexed,
		Draw,
		Dispatch,
		PushConstants,
		BindPipeline,
	};

	struct ICommand
	{
		CommandType type;
	};

	template<CommandType cmd>
	struct Command : public ICommand
	{
		constexpr static CommandType cmd_type = cmd;
	};

	struct alignas(8) CMD_Custom : public Command<CommandType::Custom>
	{
		uint64_t id;
		void* data;
	};

	struct alignas(8) CMD_BindIndexBuffer : public Command<CommandType::BindIndexBuffer>
	{
		VkBuffer indexBuffer;
		VkIndexType indexType = VK_INDEX_TYPE_UINT32;
		uint64_t offset;
	};

	struct CMD_BindDescriptorSet : public Command< CommandType::BindDescriptorSet>
	{
		uint8_t setNumber;
		VkDescriptorSet descriptorSet;
	};

	struct alignas(8) CMD_DrawIndexedIndirect : public Command< CommandType::DrawIndexedIndirect>
	{
		VkBuffer indirectBuffer;
		uint32_t count;
		uint32_t offset;
	};

	struct alignas(8) CMD_DrawIndexed : public Command< CommandType::DrawIndexed>
	{
		uint32_t indexCount;
		uint32_t instanceCount;
		uint32_t firstIndex;
		int32_t vertexOffset;
		uint32_t firstInstance;
	};

	struct alignas(8) CMD_Draw : public Command<CommandType::Draw>
	{
		uint32_t vertexCount = 0;
		uint32_t instanceCount = 1;
		uint32_t firstVertex = 0;
		uint32_t firstInstance = 0;
	};

	struct alignas(8) CMD_Dispatch : public Command<CommandType::Dispatch>
	{
		uint32_t groupCountX = 0;
		uint32_t groupCountY = 0;
		uint32_t groupCountZ = 0;
	};

	struct alignas(8) CMD_PushConstants : public Command<CommandType::PushConstants>
	{
		uint32_t size = 0;
		void* data = 0;
		uint32_t offset = 0;
	};

	struct alignas(8) CMD_BindPipeline : public Command<CommandType::BindPipeline>
	{
		VkPipeline pipeline;
		VkPipelineLayout layout;
		VkDescriptorSetLayout descriptorLayout;
	};

	struct CommandEncoder
	{
		void BindShader(Shader shader)
		{
			auto* cmd = encode<CMD_BindPipeline>();

			cmd->type = CommandType::BindPipeline;
			cmd->pipeline = shader.Pipeline;
			cmd->layout = shader.PipelineLayout;
			cmd->descriptorLayout = shader.DescriptorLayout;
		}

		void BindDescriptorSet(VkDescriptorSet descriptorSet, uint8_t setNumber = 0)
		{
			auto* cmd = encode<CMD_BindDescriptorSet>();

			cmd->type = CommandType::BindDescriptorSet;
			cmd->setNumber = setNumber;
			cmd->descriptorSet = descriptorSet;
		}

		void BindIndexBuffer(VkBuffer indexBuffer, VkIndexType indexType = VK_INDEX_TYPE_UINT32, uint64_t offset = 0)
		{
			auto* cmd = encode<CMD_BindIndexBuffer>();

			cmd->indexBuffer = indexBuffer;
			cmd->indexType = indexType;
			cmd->offset = offset;
		}

		void DrawIndexedIndirect(VkBuffer indirectBuffer, uint32_t count, uint32_t offset)
		{
			auto* cmd = encode<CMD_DrawIndexedIndirect>();

			cmd->indirectBuffer = indirectBuffer;
			cmd->count = count;
			cmd->offset = offset;
		}

		void DrawIndexed(uint32_t indexCount, uint32_t instanceCount = 1, uint32_t vertexOffset = 0, uint32_t firstIndex = 0, uint32_t firstInstance = 0)
		{
			auto* cmd = encode<CMD_DrawIndexed>();

			cmd->indexCount = indexCount;
			cmd->instanceCount = instanceCount;
			cmd->firstIndex = firstIndex;
			cmd->vertexOffset = vertexOffset;
			cmd->firstInstance = firstInstance;
		}

		void Draw(uint32_t vertexCount, uint32_t instanceCount = 1, uint32_t firstVertex = 0, uint32_t firstInstance = 0)
		{
			auto* cmd = encode<CMD_Draw>();

			cmd->vertexCount = vertexCount;
			cmd->instanceCount = instanceCount;
			cmd->firstVertex = firstVertex;
			cmd->firstInstance = firstInstance;
		}

		void Dispatch(uint32_t groupCountX, uint32_t groupCountY, uint32_t groupCountZ)
		{
			auto* cmd = encode<CMD_Dispatch>();

			cmd->groupCountX = groupCountX;
			cmd->groupCountY = groupCountY;
			cmd->groupCountZ = groupCountZ;
		}

		void Dispatch(const glm::ivec3& groupCount)	{ Dispatch(groupCount.x, groupCount.y, groupCount.z); }

		void Dispatch(glm::ivec2 groupCount) { Dispatch(groupCount.x, groupCount.y, 1);	}

		void Dispatch(glm::vec2 groupCount) { Dispatch(glm::ivec2(groupCount)); }

		void PushConstants(uint32_t size, const void* data, uint32_t offset = 0)
		{
			auto* cmd = encode<CMD_PushConstants>();
			cmd->size = size;
			cmd->offset = offset;
			cmd->data = malloc(size);
			memcpy(cmd->data, data, size);
		}

		template<typename T>
		void PushConstants(const T& data)
		{
			PushConstants(sizeof(data), &data, 0);
		}

		void ExecuteCompute(VkCommandBuffer cmd)
		{
			vkResetCommandBuffer(cmd, 0);

			VkCommandBufferBeginInfo begInfo = {
				.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO,
				.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT
			};

			vkBeginCommandBuffer(cmd, &begInfo);

			VkPipelineLayout boundLayout = VK_NULL_HANDLE;

			for (auto& c : encode_buffer)
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
					vkCmdBindPipeline(cmd, VK_PIPELINE_BIND_POINT_COMPUTE, pCmd->pipeline);
				}
				break;
				case CommandType::BindDescriptorSet:
				{
					auto* pCmd = static_cast<CMD_BindDescriptorSet*>(command);

					vkCmdBindDescriptorSets(cmd, VK_PIPELINE_BIND_POINT_COMPUTE, boundLayout, pCmd->setNumber, 1, (VkDescriptorSet*)&pCmd->descriptorSet, 0, nullptr);
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
					vkCmdPushConstants(cmd, boundLayout, VK_SHADER_STAGE_COMPUTE_BIT, pCmd->offset, pCmd->size, pCmd->data);
					free(pCmd->data);
				}
				break;
				}
			}
			
			vkEndCommandBuffer(cmd);

			vk::SyncContext::Submit(cmd, vk::SyncContext::GetComputeQueue());
		}

		void CustomCommand(uint64_t id, void* data)
		{
			auto* cmd = encode<CMD_Custom>();

			cmd->id = id;
			cmd->data = data;
		}

		void Reset()
		{
			for (auto& cmd : encode_buffer)
				free(cmd);
			encode_buffer.clear();
		}

		~CommandEncoder()
		{
			Reset();
		}

		auto GetEncodeBuffer() { return encode_buffer; }
	private:
		template<typename T>
		T* encode()
		{
			T* cmd = new T(); // call the constructor
			cmd->type = T::cmd_type;
			encode_buffer.push_back(cmd);
			return cmd;
		}

		std::vector<void*> encode_buffer;
	};	
}