#pragma once

#include "Descriptors.h"

namespace vk
{
	void DescriptorAllocator::Create()
	{
		CurrentPool = GrabPool();
		m_UsedPools.push_back(CurrentPool);
	}

	void DescriptorAllocator::ResetPools()
	{
		for (auto& p : m_UsedPools)
			vkResetDescriptorPool(VulkanContext::GetLogicalDevice(), p, 0);

		m_FreePools = m_UsedPools;
		m_UsedPools.clear();
		CurrentPool = VK_NULL_HANDLE;
	}

	bool DescriptorAllocator::Allocate(VkDescriptorSet& set, const VkDescriptorSetLayout& layout) { return Allocate(set, layout, nullptr, 1); }

	bool DescriptorAllocator::Allocate(VkDescriptorSet& set, const VkDescriptorSetLayout& layout, const void* pNext, uint32_t descriptorCount)
	{
		if (CurrentPool == VK_NULL_HANDLE)
		{
			CurrentPool = GrabPool();
			m_UsedPools.push_back(CurrentPool);
		}

		VkDescriptorSetAllocateInfo allocInfo = {
			.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO,
			.pNext = pNext,
			.descriptorPool = CurrentPool,
			.descriptorSetCount = descriptorCount,
			.pSetLayouts = &layout,
		};

		switch (vkAllocateDescriptorSets(VulkanContext::GetLogicalDevice(), &allocInfo, &set))
		{
		case VK_SUCCESS: return true;
		case VK_ERROR_FRAGMENTED_POOL:
		case VK_ERROR_OUT_OF_POOL_MEMORY:
			//allocate a new pool and retry
			CurrentPool = GrabPool();
			m_UsedPools.push_back(CurrentPool);

			//if it still fails then we have big issues
			if (vkAllocateDescriptorSets(VulkanContext::GetLogicalDevice(), &allocInfo, &set) == VK_SUCCESS) return true;
		}

		return false;
	}

	void DescriptorAllocator::Free(VkDescriptorSet descriptorSet)
	{
		vkFreeDescriptorSets(VulkanContext::GetLogicalDevice(), CurrentPool, 1, &descriptorSet); // @NOTE: This is very possible to produce errors in the future
	}

	void DescriptorAllocator::Destroy()
	{
		for (auto& p : m_FreePools)
			vkDestroyDescriptorPool(VulkanContext::GetLogicalDevice(), p, VulkanContext::GetAllocator());

		for (auto& p : m_UsedPools)
			vkDestroyDescriptorPool(VulkanContext::GetLogicalDevice(), p, VulkanContext::GetAllocator());
	}

	VkDescriptorPool DescriptorAllocator::GrabPool()
	{
		if (m_FreePools.size() > 0)
		{
			VkDescriptorPool pool = m_FreePools.back();
			m_FreePools.pop_back();
			return pool;
		}

		uint32_t count = 500;

		std::pair<VkDescriptorType, float> dSizes[] =
		{
			{ VK_DESCRIPTOR_TYPE_SAMPLER, 0.5f },
			{ VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER, 2.f },
			{ VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE, 2.f },
			{ VK_DESCRIPTOR_TYPE_STORAGE_IMAGE, 1.f },
			{ VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER, 0.5f },
			{ VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, 1.f },
		};


		std::array<VkDescriptorPoolSize, std::size(dSizes)> sizes;
		for (int i = 0; i < std::size(dSizes); i++)
			sizes[i] = { dSizes[i].first, uint32_t(dSizes[i].second * count) };

		VkDescriptorPoolCreateInfo pool_info = {
			.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO,
			.flags = VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT,
			.maxSets = count,
			.poolSizeCount = (uint32_t)sizes.size(),
			.pPoolSizes = sizes.data(),
		};

		VkDescriptorPool descriptorPool;
		vkCreateDescriptorPool(VulkanContext::GetLogicalDevice(), &pool_info, VulkanContext::GetAllocator(), &descriptorPool);

		return descriptorPool;
	}


	DescriptorWriter& DescriptorWriter::BindBuffer(uint32_t binding, const VkDescriptorBufferInfo& bufferInfo, VkDescriptorType type)
	{
		VkWriteDescriptorSet write = {
			.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,

			.dstSet = dstSet,
			.dstBinding = binding,
			.descriptorCount = 1,
			.descriptorType = type,
			.pBufferInfo = &m_BufferInfos.emplace_back(bufferInfo),
		};

		writes.push_back(write);
		return *this;
	}

	DescriptorWriter& DescriptorWriter::BindBuffer(uint32_t binding, VkBuffer buffer, size_t size, size_t offset, VkDescriptorType type) { return BindBuffer(binding, { buffer, offset, size }, type); }

	DescriptorWriter& DescriptorWriter::BindImage(uint32_t binding, const VkDescriptorImageInfo& imageInfo, VkDescriptorType type)
	{
		VkWriteDescriptorSet write = {
			.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,

			.dstSet = dstSet,
			.dstBinding = binding,
			.descriptorType = type,
			.descriptorCount = 1,
			.pImageInfo = &m_ImageInfos.emplace_back(imageInfo),
		};

		writes.push_back(write);
		return *this;
	}

	DescriptorWriter& DescriptorWriter::BindImage(uint32_t binding, VkSampler sampler, VkImageView image, VkImageLayout layout, VkDescriptorType type) { return BindImage(binding, { sampler, image, layout }, type); }

	DescriptorWriter& DescriptorWriter::BindImages(uint32_t binding, const std::vector<VkDescriptorImageInfo>& imageInfo, VkDescriptorType type)
	{
		VkWriteDescriptorSet write = {
			.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,

			.dstSet = dstSet,
			.dstBinding = binding,
			.descriptorCount = (uint32_t)imageInfo.size(),
			.descriptorType = type,
			.pImageInfo = imageInfo.data(),
		};

		writes.push_back(write);
		return *this;
	}

	void DescriptorWriter::Clear()
	{
		m_ImageInfos.clear();
		m_BufferInfos.clear();
		writes.clear();
	}

	void DescriptorWriter::Update()
	{
		if (!m_Updated)
		{
			vkUpdateDescriptorSets(VulkanContext::GetLogicalDevice(), (uint32_t)writes.size(), writes.data(), 0, nullptr);
			m_Updated = true;
		}
	}
}