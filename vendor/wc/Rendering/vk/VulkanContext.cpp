#include "VulkanContext.h"

#include <GLFW/glfw3.h>

#include "../../Utils/Log.h"

#include <magic_enum.hpp>
#include <set>
#include <unordered_set>
#include <source_location>

namespace VulkanContext
{
	VkInstance& GetInstance() { return instance; }
	vk::PhysicalDevice& GetPhysicalDevice() { return physicalDevice; }
	vk::LogicalDevice& GetLogicalDevice() { return logicalDevice; }
	VmaAllocator& GetMemoryAllocator() { return MemoryAllocator; }
	VkAllocationCallbacks* GetAllocator() { return nullptr; }

#if WC_GRAPHICS_VALIDATION
	bool bValidationLayers = false;
	VkDebugUtilsMessengerEXT debug_messenger;
#endif	

	void BeginLabel(VkCommandBuffer cmd, const char* labelName, const glm::vec4& color)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers)
		{
			VkDebugUtilsLabelEXT label = { VK_STRUCTURE_TYPE_DEBUG_UTILS_LABEL_EXT };
			label.pLabelName = labelName;
			label.color[0] = color[0];
			label.color[1] = color[1];
			label.color[2] = color[2];
			label.color[3] = color[3];
			vkCmdBeginDebugUtilsLabelEXT(cmd, &label);
		}
#endif
	}

	void InsertLabel(VkCommandBuffer cmd, const char* labelName, const glm::vec4& color)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers)
		{
			VkDebugUtilsLabelEXT label = { VK_STRUCTURE_TYPE_DEBUG_UTILS_LABEL_EXT };
			label.pLabelName = labelName;
			label.color[0] = color[0];
			label.color[1] = color[1];
			label.color[2] = color[2];
			label.color[3] = color[3];
			vkCmdInsertDebugUtilsLabelEXT(cmd, &label);
		}
#endif
	}

	void EndLabel(VkCommandBuffer cmd)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers) vkCmdEndDebugUtilsLabelEXT(cmd);
#endif
	}


	void BeginLabel(VkQueue queue, const char* labelName, const glm::vec4& color)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers)
		{
			VkDebugUtilsLabelEXT label = { VK_STRUCTURE_TYPE_DEBUG_UTILS_LABEL_EXT };
			label.pLabelName = labelName;
			label.color[0] = color[0];
			label.color[1] = color[1];
			label.color[2] = color[2];
			label.color[3] = color[3];
			vkQueueBeginDebugUtilsLabelEXT(queue, &label);
		}
#endif
	}

	void InsertLabel(VkQueue queue, const char* labelName, const glm::vec4& color)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers)
		{
			VkDebugUtilsLabelEXT label = { VK_STRUCTURE_TYPE_DEBUG_UTILS_LABEL_EXT };
			label.pLabelName = labelName;
			label.color[0] = color[0];
			label.color[1] = color[1];
			label.color[2] = color[2];
			label.color[3] = color[3];
			vkQueueInsertDebugUtilsLabelEXT(queue, &label);
		}
#endif
	}

	void EndLabel(VkQueue queue)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers) vkQueueEndDebugUtilsLabelEXT(queue);
#endif
	}

	void SetObjectName(VkObjectType type, uint64_t handle, const char* name)
	{
#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers)
		{
			VkDebugUtilsObjectNameInfoEXT name_info = { VK_STRUCTURE_TYPE_DEBUG_UTILS_OBJECT_NAME_INFO_EXT };
			name_info.objectType = type;
			name_info.objectHandle = handle;
			name_info.pObjectName = name;
			vkSetDebugUtilsObjectNameEXT(GetLogicalDevice(), &name_info);
		}
#endif
	}

	bool Create()
	{
		if (volkInitialize() != VK_SUCCESS)
		{
			WC_CORE_ERROR("Failed to initialise volk!");
			return false;
		}
		// Create Instance
#if WC_GRAPHICS_VALIDATION
		std::vector<const char*> validationLayers = { "VK_LAYER_KHRONOS_validation" };
		uint32_t layerCount = 0;
		vkEnumerateInstanceLayerProperties(&layerCount, nullptr);

		std::vector<VkLayerProperties> availableLayers(layerCount);
		vkEnumerateInstanceLayerProperties(&layerCount, availableLayers.data());

		for (const char* layerName : validationLayers)
			for (const auto& layerProperties : availableLayers)
				if (strcmp(layerName, layerProperties.layerName) == 0)
				{
					bValidationLayers = true;
					break;
				}

		if (!bValidationLayers)
		{
			WC_CORE_ERROR("Validation layers requested, but not available!");
			return false;
		}
#endif

		VkApplicationInfo appInfo = {
			.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO,
			.pApplicationName = "WC Application",
			.applicationVersion = VK_MAKE_API_VERSION(0, 1, 2, 0),
			.pEngineName = "WC Engine",
			.engineVersion = VK_MAKE_API_VERSION(0, 1, 2, 0),
			.apiVersion = VK_API_VERSION_1_2,
		};

		VkInstanceCreateInfo instanceCreateInfo = { VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO };
		instanceCreateInfo.pApplicationInfo = &appInfo;

		uint32_t glfwExtensionCount = 0;
		const char** glfwExtensions;
		glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

		std::vector<const char*> extensions(glfwExtensions, glfwExtensions + glfwExtensionCount);

#if WC_GRAPHICS_VALIDATION
		VkDebugUtilsMessengerCreateInfoEXT debugCreateInfo;
		VkValidationFeaturesEXT validationFeatures;
		VkValidationFeatureEnableEXT enabledFeatures[] = {
#if WC_SHADER_DEBUG_PRINT
				VK_VALIDATION_FEATURE_ENABLE_DEBUG_PRINTF_EXT,
#endif
#if WC_SYNCHRONIZATION_VALIDATION
				VK_VALIDATION_FEATURE_ENABLE_SYNCHRONIZATION_VALIDATION_EXT,
#endif
				//VK_VALIDATION_FEATURE_ENABLE_BEST_PRACTICES_EXT
		};

		if (bValidationLayers)
		{
			extensions.push_back(VK_EXT_DEBUG_UTILS_EXTENSION_NAME);


			instanceCreateInfo.enabledLayerCount = static_cast<uint32_t>(validationLayers.size());
			instanceCreateInfo.ppEnabledLayerNames = validationLayers.data();

			debugCreateInfo = { VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT };
			debugCreateInfo.messageSeverity = VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT; // VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT?

#if WC_SHADER_DEBUG_PRINT
			debugCreateInfo.messageSeverity |= VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT;
#endif

			debugCreateInfo.messageType = VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT;
			debugCreateInfo.pfnUserCallback = [](VkDebugUtilsMessageSeverityFlagBitsEXT severity,
				VkDebugUtilsMessageTypeFlagsEXT messageType,
				const VkDebugUtilsMessengerCallbackDataEXT* pCallbackData,
				void* pUserData) -> VkBool32 VKAPI_CALL
				{
					std::string type;
					switch (messageType)
					{
					case VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT:
						type = "General";
						break;
					case VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT:
						type = "Validation";
						break;
					case VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT:
						type = "Performance";
						break;
					default:
						type = "Unknown";
						break;
					}

					switch (severity)
					{
					case VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT:
						WC_CORE_ERROR("[{}] {}", type, pCallbackData->pMessage);
						//WC_DEBUGBREAK();
						//OutputDebugString(pCallbackData->pMessage);
						break;

					case VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT:
						WC_CORE_WARN("[{}] {}", type, pCallbackData->pMessage);
						break;

					case VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT:
						WC_CORE_TRACE("[{}] {}", type, pCallbackData->pMessage);
						break;

					case VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT:
						//WC_CORE_TRACE(pCallbackData->pMessage);
						break;
					}

					return true;
				};

			//VkValidationFeatureDisableEXT disabledFeatures[] = {};

			validationFeatures = {
				.sType = VK_STRUCTURE_TYPE_VALIDATION_FEATURES_EXT,
				.enabledValidationFeatureCount = (uint32_t)std::size(enabledFeatures),
				.pEnabledValidationFeatures = enabledFeatures,
				//.disabledValidationFeatureCount = (uint32_t)std::size(disabledFeatures);
				//.pDisabledValidationFeatures = disabledFeatures;
			};

			debugCreateInfo.pNext = &validationFeatures;

			instanceCreateInfo.pNext = &debugCreateInfo;
		}
#endif


		instanceCreateInfo.enabledExtensionCount = static_cast<uint32_t>(extensions.size());
		instanceCreateInfo.ppEnabledExtensionNames = extensions.data();

		if (vkCreateInstance(&instanceCreateInfo, nullptr, &instance) != VK_SUCCESS)
		{
			WC_CORE_ERROR("Failed to create instance!");
			return false;
		}

		volkLoadInstance(instance);

		const std::vector<const char*> deviceExtensions = { VK_KHR_SWAPCHAIN_EXTENSION_NAME, };

#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers)
		{
			debugCreateInfo.pNext = nullptr; // by spec definition
			if (vkCreateDebugUtilsMessengerEXT(instance, &debugCreateInfo, VulkanContext::GetAllocator(), &debug_messenger) != VK_SUCCESS)
			{
				WC_CORE_ERROR("Failed to set up debug messenger!");
				return false;
			}

#if WC_SHADER_DEBUG_PRINT
			deviceExtensions.push_back(VK_KHR_SHADER_NON_SEMANTIC_INFO_EXTENSION_NAME);
#endif
		}
#endif		

		// Pick physical device 
		uint32_t deviceCount = 0;
		vkEnumeratePhysicalDevices(instance, &deviceCount, nullptr);

		if (deviceCount == 0)
		{
			WC_CORE_ERROR("Failed to find GPUs with Vulkan support!");
			return false;
		}

		std::vector<VkPhysicalDevice> devices(deviceCount);
		vkEnumeratePhysicalDevices(instance, &deviceCount, devices.data());

		struct
		{
			std::optional<uint32_t> graphicsFamily;
			//std::optional<uint32_t> presentFamily;
			std::optional<uint32_t> computeFamily;
			std::optional<uint32_t> transferFamily;

			bool IsComplete() { return graphicsFamily.has_value() && /*presentFamily.has_value() &&*/ computeFamily.has_value() && transferFamily.has_value(); }
			void Reset()
			{
				graphicsFamily.reset();
				//presentFamily.reset();
				computeFamily.reset();
				transferFamily.reset();
			}
		} indices;

		for (const auto& physDevice : devices)
		{
			uint32_t extensionCount;
			vkEnumerateDeviceExtensionProperties(physDevice, nullptr, &extensionCount, nullptr);

			std::vector<VkExtensionProperties> availableExtensions(extensionCount);
			vkEnumerateDeviceExtensionProperties(physDevice, nullptr, &extensionCount, availableExtensions.data());

			bool extensionsSupported = true;
			for (const auto& requiredExtension : deviceExtensions)
			{
				bool found = false;
				for (const auto& availableExtension : availableExtensions)
				{
					if (requiredExtension == std::string(availableExtension.extensionName))
					{
						found = true;
						break;
					}
				}

				if (!found)
				{
					extensionsSupported = false;
					break;
				}
			}

			indices.Reset();
			uint32_t queueFamilyCount = 0;
			vkGetPhysicalDeviceQueueFamilyProperties(physDevice, &queueFamilyCount, nullptr);

			std::vector<VkQueueFamilyProperties> queueFamilies(queueFamilyCount);
			vkGetPhysicalDeviceQueueFamilyProperties(physDevice, &queueFamilyCount, queueFamilies.data());

			for (uint32_t i = 0; i < queueFamilies.size(); i++)
			{
				if (queueFamilies[i].queueFlags & VK_QUEUE_GRAPHICS_BIT)  indices.graphicsFamily = i;
				if (queueFamilies[i].queueFlags & VK_QUEUE_COMPUTE_BIT)   indices.computeFamily = i;
				if (queueFamilies[i].queueFlags & VK_QUEUE_TRANSFER_BIT)  indices.transferFamily = i;

				if (indices.IsComplete())
					break;
			}

			//bool swapChainAdequate = false;
			//if (extensionsSupported) {
			//	SwapChainSupportDetails swapChainSupport = querySwapChainSupport(device, surface);
			//	swapChainAdequate = !swapChainSupport.formats.empty() && !swapChainSupport.presentModes.empty();
			//}

			if (indices.IsComplete() && extensionsSupported /*&& swapChainAdequate*/)
			{
				physicalDevice.SetDevice(physDevice);

				break;
			}
		}

		if (physicalDevice == VK_NULL_HANDLE)
		{
			WC_CORE_ERROR("Failed to find a suitable GPU!");
			return false;
		}

		{ // Create Logical Device
			VkPhysicalDeviceFeatures deviceFeatures = {};
			auto supportedFeatures = physicalDevice.GetFeatures();
			if (supportedFeatures.samplerAnisotropy)
				deviceFeatures.samplerAnisotropy = true;
			else
				WC_CORE_WARN("Sampler anisotropy feature is not supported")

				if (supportedFeatures.independentBlend)
					deviceFeatures.independentBlend = true;
				else
					WC_CORE_WARN("Independent blend feature is not supported")

					VkPhysicalDeviceVulkan12Features features12 = {
						.sType = VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES,

						.shaderSampledImageArrayNonUniformIndexing = true,
						.descriptorBindingPartiallyBound = true,
						.descriptorBindingVariableDescriptorCount = true,
						.runtimeDescriptorArray = true,
						.scalarBlockLayout = true,
						.timelineSemaphore = true,
						.bufferDeviceAddress = true,
				};


			std::set<uint32_t> uniqueQueueFamilies = {
				indices.graphicsFamily.value(),
				//indices.presentFamily.value(),
				indices.computeFamily.value(),
				indices.transferFamily.value(),
			};

			std::vector<VkDeviceQueueCreateInfo> queueCreateInfos;
			float queuePriorities[] = { 1.f };
			for (const auto& queueFamily : uniqueQueueFamilies)
				queueCreateInfos.push_back({
					.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO,
					.queueFamilyIndex = queueFamily,
					.queueCount = (uint32_t)std::size(queuePriorities),
					.pQueuePriorities = queuePriorities,
					});

			VkDeviceCreateInfo createInfo = {
				.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO,
				.pNext = &features12,

				.queueCreateInfoCount = static_cast<uint32_t>(queueCreateInfos.size()),
				.pQueueCreateInfos = queueCreateInfos.data(),

				.pEnabledFeatures = &deviceFeatures,

				.enabledExtensionCount = static_cast<uint32_t>(deviceExtensions.size()),
				.ppEnabledExtensionNames = deviceExtensions.data(),
			};

#if WC_GRAPHICS_VALIDATION
			if (bValidationLayers)
			{
				createInfo.enabledLayerCount = static_cast<uint32_t>(validationLayers.size());
				createInfo.ppEnabledLayerNames = validationLayers.data();
			}
#endif

			if (logicalDevice.Create(physicalDevice, createInfo) != VK_SUCCESS)
			{
				WC_CORE_ERROR("Failed to create logical device!");
				return false;
			}

			auto GetDeviceQueue = [](vk::Queue& q, uint32_t family)
				{
					q.queueFamily = family;
					vkGetDeviceQueue(GetLogicalDevice(), family, 0, &q);
				};

			GetDeviceQueue(vk::GraphicsQueue, indices.graphicsFamily.value());
			//presentQueue.GetDeviceQueue(indices.presentFamily.value());
			GetDeviceQueue(vk::ComputeQueue, indices.computeFamily.value());
			GetDeviceQueue(vk::TransferQueue, indices.transferFamily.value());

			vk::GraphicsQueue.SetName("GraphicsQueue");
			vk::ComputeQueue.SetName("ComputeQueue");
			vk::TransferQueue.SetName("TransferQueue");
		}

		VmaVulkanFunctions vulkanFunctions = {
			.vkGetInstanceProcAddr = vkGetInstanceProcAddr,
			.vkGetDeviceProcAddr = vkGetDeviceProcAddr,
		};

		VmaAllocatorCreateInfo allocatorInfo = {
			.vulkanApiVersion = appInfo.apiVersion,
			.physicalDevice = physicalDevice,
			.device = GetLogicalDevice(),
			.instance = instance,
			.pVulkanFunctions = &vulkanFunctions,
			.flags = VMA_ALLOCATOR_CREATE_BUFFER_DEVICE_ADDRESS_BIT,
		};

		if (vmaCreateAllocator(&allocatorInfo, &MemoryAllocator) != VK_SUCCESS)
		{
			WC_CORE_ERROR("Failed to create a memory allocator!");
			return false;
		}

		return true;
	}

	void Destroy()
	{
		vmaDestroyAllocator(MemoryAllocator);
		logicalDevice.Destroy();

#if WC_GRAPHICS_VALIDATION
		if (bValidationLayers) vkDestroyDebugUtilsMessengerEXT(instance, debug_messenger, VulkanContext::GetAllocator());
#endif
		vkDestroyInstance(instance, nullptr);
		volkFinalize();
	}
}