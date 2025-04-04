#pragma once

#pragma warning(push, 0)
#define VK_NO_PROTOTYPES
#define VMA_STATIC_VULKAN_FUNCTIONS 0
#define VMA_DYNAMIC_VULKAN_FUNCTIONS 1

#define WC_GRAPHICS_VALIDATION 1
#define WC_SYNCHRONIZATION_VALIDATION 1
#define WC_SHADER_DEBUG_PRINT 0

#include <Volk/volk.h>
#include <vma/vk_mem_alloc.h>

#pragma warning(pop)

#include <glm/glm.hpp>

#include <string>

template<class T>
inline VkObjectType GetObjectType()
{
	if (typeid(T) == typeid(VkInstance)) return VK_OBJECT_TYPE_INSTANCE;
	if (typeid(T) == typeid(VkPhysicalDevice)) return VK_OBJECT_TYPE_PHYSICAL_DEVICE;
	if (typeid(T) == typeid(VkDevice)) return VK_OBJECT_TYPE_DEVICE;
	if (typeid(T) == typeid(VkQueue)) return VK_OBJECT_TYPE_QUEUE;
	if (typeid(T) == typeid(VkSemaphore)) return VK_OBJECT_TYPE_SEMAPHORE;
	if (typeid(T) == typeid(VkCommandBuffer)) return VK_OBJECT_TYPE_COMMAND_BUFFER;
	if (typeid(T) == typeid(VkFence)) return VK_OBJECT_TYPE_FENCE;
	if (typeid(T) == typeid(VkDeviceMemory)) return VK_OBJECT_TYPE_DEVICE_MEMORY;
	if (typeid(T) == typeid(VkBuffer)) return VK_OBJECT_TYPE_BUFFER;
	if (typeid(T) == typeid(VkImage)) return VK_OBJECT_TYPE_IMAGE;
	if (typeid(T) == typeid(VkEvent)) return VK_OBJECT_TYPE_EVENT;
	if (typeid(T) == typeid(VkQueryPool)) return VK_OBJECT_TYPE_QUERY_POOL;
	if (typeid(T) == typeid(VkBufferView)) return VK_OBJECT_TYPE_BUFFER_VIEW;
	if (typeid(T) == typeid(VkImageView)) return VK_OBJECT_TYPE_IMAGE_VIEW;
	if (typeid(T) == typeid(VkShaderModule)) return VK_OBJECT_TYPE_SHADER_MODULE;
	if (typeid(T) == typeid(VkPipelineCache)) return VK_OBJECT_TYPE_PIPELINE_CACHE;
	if (typeid(T) == typeid(VkPipelineLayout)) return VK_OBJECT_TYPE_PIPELINE_LAYOUT;
	if (typeid(T) == typeid(VkRenderPass)) return VK_OBJECT_TYPE_RENDER_PASS;
	if (typeid(T) == typeid(VkPipeline)) return VK_OBJECT_TYPE_PIPELINE;
	if (typeid(T) == typeid(VkDescriptorSetLayout)) return VK_OBJECT_TYPE_DESCRIPTOR_SET_LAYOUT;
	if (typeid(T) == typeid(VkSampler)) return VK_OBJECT_TYPE_SAMPLER;
	if (typeid(T) == typeid(VkDescriptorPool)) return VK_OBJECT_TYPE_DESCRIPTOR_POOL;
	if (typeid(T) == typeid(VkDescriptorSet)) return VK_OBJECT_TYPE_DESCRIPTOR_SET;
	if (typeid(T) == typeid(VkFramebuffer)) return VK_OBJECT_TYPE_FRAMEBUFFER;
	if (typeid(T) == typeid(VkCommandPool)) return VK_OBJECT_TYPE_COMMAND_POOL;

	return VK_OBJECT_TYPE_UNKNOWN;
}

namespace VulkanContext
{
	void SetObjectName(VkObjectType object_type, uint64_t object_handle, const char* object_name);

	template<class T>
	void SetObjectName(T handle, const char* name) { SetObjectName(GetObjectType<T>(), (uint64_t)handle, name); }

	template<class T>
	void SetObjectName(T handle, const std::string& name) { SetObjectName(handle, name.c_str()); }


	void BeginLabel(VkCommandBuffer cmd, const char* labelName, const glm::vec4& color = glm::vec4(1.f));

	void InsertLabel(VkCommandBuffer cmd, const char* labelName, const glm::vec4& color = glm::vec4(1.f));

	void EndLabel(VkCommandBuffer cmd);


	void BeginLabel(VkQueue queue, const char* labelName, const glm::vec4& color = glm::vec4(1.f));

	void InsertLabel(VkQueue queue, const char* labelName, const glm::vec4& color = glm::vec4(1.f));

	void EndLabel(VkQueue queue);


	bool Create();

	void Destroy();
}

namespace vk
{
	template <typename T>
	struct VkObject
	{
	protected:
		T m_Handle = VK_NULL_HANDLE;
	public:
		VkObject() = default;
		VkObject(T handle) { m_Handle = handle; }

		operator bool() const { return m_Handle != VK_NULL_HANDLE; }
		VkObjectType GetType() const { return GetObjectType<T>(); }

		void SetName(const char* name) const { VulkanContext::SetObjectName(GetType(), (uint64_t)m_Handle, name); }
		void SetName(const std::string& name) const { SetName(name.c_str()); }

		operator T& () { return m_Handle; }
		operator const T& () const { return m_Handle; }

		T* operator*() { return &m_Handle; }
		T const* operator*() const { return &m_Handle; }

		T* operator&() { return &m_Handle; }
		const T* operator&() const { return &m_Handle; }
	};

	class PhysicalDevice : public VkObject<VkPhysicalDevice>
	{
		VkPhysicalDeviceFeatures features = {};
		VkPhysicalDeviceProperties properties = {};
		VkPhysicalDeviceProperties2 properties2 = {};
		VkPhysicalDeviceMemoryProperties memoryProperties = {};
	public:

		using VkObject<VkPhysicalDevice>::VkObject;

		void SetDevice(VkPhysicalDevice physicalDevice)
		{
			m_Handle = physicalDevice;
			vkGetPhysicalDeviceFeatures(m_Handle, &features);
			vkGetPhysicalDeviceProperties(m_Handle, &properties);
			vkGetPhysicalDeviceMemoryProperties(m_Handle, &memoryProperties);
		}

		VkResult GetImageFormatProperties(VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkImageFormatProperties* pImageFormatProperties)
		{
			return vkGetPhysicalDeviceImageFormatProperties(m_Handle, format, type, tiling, usage, flags, pImageFormatProperties);
		}

		void GetQueueFamilyProperties(uint32_t* pQueueFamilyPropertyCount, VkQueueFamilyProperties* pQueueFamilyProperties)
		{
			vkGetPhysicalDeviceQueueFamilyProperties(m_Handle, pQueueFamilyPropertyCount, pQueueFamilyProperties);
		}

		std::vector<VkQueueFamilyProperties> GetQueueFamilyProperties()
		{
			uint32_t count = 0;
			GetQueueFamilyProperties(&count, nullptr); // Query the count of queue family properties

			std::vector<VkQueueFamilyProperties> data(count);
			GetQueueFamilyProperties(&count, data.data());

			return data;
		}

		VkFormatProperties GetFormatProperties(VkFormat format)
		{
			VkFormatProperties formatProperties;
			vkGetPhysicalDeviceFormatProperties(m_Handle, format, &formatProperties);
			return formatProperties;
		}

		void QueryProperties2(void* pNext = nullptr)
		{
			properties2.sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2;
			properties2.pNext = pNext;
			vkGetPhysicalDeviceProperties2(m_Handle, &properties2);
		}

		auto GetLimits() const { return properties.limits; }
		auto GetFeatures() const { return features; }

		auto GetProperties() const { return properties; }
		auto GetProperties2() const { return properties2; }

		auto GetMemoryProperties() const { return memoryProperties; }
	};


	struct LogicalDevice : public VkObject<VkDevice>
	{
		VkResult Create(VkPhysicalDevice physicalDevice, const VkDeviceCreateInfo& createInfo) { return vkCreateDevice(physicalDevice, &createInfo, nullptr, &m_Handle); }

		PFN_vkVoidFunction GetProcAddress(const char* pName) { return vkGetDeviceProcAddr(m_Handle, pName); }

		void WaitIdle() { vkDeviceWaitIdle(m_Handle); }

		void Destroy() { vkDestroyDevice(m_Handle, nullptr); }
	};

	struct Queue : public vk::VkObject<VkQueue>
	{
		uint32_t queueFamily = 0;

		VkResult Submit(const VkSubmitInfo& submit_info, VkFence fence = VK_NULL_HANDLE) const { return vkQueueSubmit(m_Handle, 1, &submit_info, fence); }

		VkResult PresentKHR(const VkPresentInfoKHR& present_info) const { return vkQueuePresentKHR(m_Handle, &present_info); }

		void WaitIdle() const { vkQueueWaitIdle(m_Handle); }
	};

	inline Queue GraphicsQueue;
	//inline Queue PresentQueue;
	inline Queue ComputeQueue;
	inline Queue TransferQueue;
}

namespace VulkanContext
{
	inline VkInstance instance;
	inline vk::PhysicalDevice physicalDevice;
	inline vk::LogicalDevice logicalDevice;

	inline VmaAllocator MemoryAllocator;

	VkInstance& GetInstance();
	vk::PhysicalDevice& GetPhysicalDevice();
	vk::LogicalDevice& GetLogicalDevice();
	VmaAllocator& GetMemoryAllocator();
	VkAllocationCallbacks* GetAllocator();
}