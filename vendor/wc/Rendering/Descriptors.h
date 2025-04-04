#pragma once

#include "vk/VulkanContext.h"
#include <array>
#include <deque>
#include <vector>

namespace vk 
{
	struct DescriptorAllocator 
	{
		void Create();

		void ResetPools();

		bool Allocate(VkDescriptorSet& set, const VkDescriptorSetLayout& layout);

		bool Allocate(VkDescriptorSet& set, const VkDescriptorSetLayout& layout, const void* pNext, uint32_t descriptorCount);

		void Free(VkDescriptorSet descriptorSet);

		void Destroy();

		VkDescriptorPool GrabPool();

		VkDescriptorPool CurrentPool;
		std::vector<VkDescriptorPool> m_UsedPools;
		std::vector<VkDescriptorPool> m_FreePools;
	}inline descriptorAllocator;

	struct DescriptorWriter 
	{
	private:
		std::deque<VkDescriptorImageInfo> m_ImageInfos;
		std::deque<VkDescriptorBufferInfo> m_BufferInfos;
		bool m_Updated = false;
	public:
		std::vector<VkWriteDescriptorSet> writes;
		VkDescriptorSet dstSet = VK_NULL_HANDLE;

		DescriptorWriter(VkDescriptorSet dSet) { dstSet = dSet; }
		~DescriptorWriter() { Update(); }

		DescriptorWriter& BindBuffer(uint32_t binding, const VkDescriptorBufferInfo& bufferInfo, VkDescriptorType type = VK_DESCRIPTOR_TYPE_STORAGE_BUFFER);

		DescriptorWriter& BindBuffer(uint32_t binding, VkBuffer buffer, size_t size, size_t offset, VkDescriptorType type = VK_DESCRIPTOR_TYPE_STORAGE_BUFFER);

		DescriptorWriter& BindImage(uint32_t binding, const VkDescriptorImageInfo& imageInfo, VkDescriptorType type);

		DescriptorWriter& BindImage(uint32_t binding, VkSampler sampler, VkImageView image, VkImageLayout layout, VkDescriptorType type);

		DescriptorWriter& BindImages(uint32_t binding, const std::vector<VkDescriptorImageInfo>& imageInfo, VkDescriptorType type);

		void Clear();

		void Update();
	};
}