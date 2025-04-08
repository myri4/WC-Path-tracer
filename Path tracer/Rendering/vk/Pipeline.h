#pragma once

#include "VulkanContext.h"
#include "../../Memory/Buffer.h"

namespace vk 
{
	struct PipelineCache : public VkObject<VkPipelineCache> 
	{
		VkResult Create(const VkPipelineCacheCreateInfo& createInfo) 
		{ return vkCreatePipelineCache(VulkanContext::GetLogicalDevice(), &createInfo, VulkanContext::GetAllocator(), &m_Handle); }

		void Destroy() 
		{
			vkDestroyPipelineCache(VulkanContext::GetLogicalDevice(), m_Handle, VulkanContext::GetAllocator());
			m_Handle = VK_NULL_HANDLE;
		}

		VkResult MergePipelineCaches(uint32_t count, const VkPipelineCache* caches) 
		{ return vkMergePipelineCaches(VulkanContext::GetLogicalDevice(), m_Handle, count, caches); }

		wc::Buffer GetData() const 
		{
			wc::Buffer buffer;
			vkGetPipelineCacheData(VulkanContext::GetLogicalDevice(), m_Handle, &buffer.Size, nullptr);
			buffer.Allocate(buffer.Size);
			vkGetPipelineCacheData(VulkanContext::GetLogicalDevice(), m_Handle, &buffer.Size, buffer.Data);
			return buffer;
		}

		void SaveToFile(const std::string& filepath) const 
		{
			//PipelineCacheData data = GetData();
			//std::fstream file;
			//file.open(filepath, std::ios::out | std::ios::binary);
			//file.write((char*)data.data, data.size);
			//file.flush();
			//file.close();
			//free(data.data);
		}

		bool Valid(const void* data) 
		{
			auto& header = *(VkPipelineCacheHeaderVersionOne*)data;
			if (header.headerSize <= 0) return false;
			if (header.headerVersion != VK_PIPELINE_CACHE_HEADER_VERSION_ONE) return false;
			if (header.vendorID != VulkanContext::GetPhysicalDevice().GetProperties().vendorID)   return false;
			if (header.deviceID != VulkanContext::GetPhysicalDevice().GetProperties().deviceID)   return false;
			if (memcmp(header.pipelineCacheUUID, VulkanContext::GetPhysicalDevice().GetProperties().pipelineCacheUUID, sizeof(header.pipelineCacheUUID)) != 0) return false;
			return true;
		}
	};
}