#module_parameters (
    FRAME_OVERLAP := 2,
    GRAPHICS_VALIDATION := true, 
    SYNCHRONIZATION_VALIDATION := true, 
    SHADER_DEBUG_PRINT := false
);

#load "Swapchain.jai";
#load "Debugging.jai";
#load "Synchronization.jai";
#load "Buffer.jai";
#load "Image.jai";
#load "Pipeline.jai";
#load "Descriptors.jai";

instance         : VkInstance;

physicalDevice   : PhysicalDevice;

logicalDevice  : VkDevice;
allocationCallbacks: *VkAllocationCallbacks;

allocator: VmaAllocator;

PhysicalDevice :: struct
{
    handle           : VkPhysicalDevice;

    properties       : VkPhysicalDeviceProperties;
    properties2      : VkPhysicalDeviceProperties2;
    memoryProperties : VkPhysicalDeviceMemoryProperties;
    features         : VkPhysicalDeviceFeatures;
}

GetQueueFamilyProperties :: (using device: PhysicalDevice) -> [..]VkQueueFamilyProperties
{
	count : u32 = 0;
	GetQueueFamilyProperties(device, *count, null); // Query the count of queue family properties

	data: [..]VkQueueFamilyProperties;
    array_resize(*data, count);
	GetQueueFamilyProperties(*count, data.data);

	return data;
}

get_vulkan_object_type :: (type: Type) -> VkObjectType 
{
	if type == {
        case VkInstance; return .INSTANCE;
	    case VkPhysicalDevice; return .PHYSICAL_DEVICE;
	    case VkDevice; return .DEVICE;
	    case VkQueue; return .QUEUE;
	    case VkSemaphore; return .SEMAPHORE;
	    case VkCommandBuffer; return .COMMAND_BUFFER;
	    case VkFence; return .FENCE;
	    case VkDeviceMemory; return .DEVICE_MEMORY;
	    case VkBuffer; return .BUFFER;
	    case VkImage; return .IMAGE;
	    case VkEvent; return .EVENT;
	    case VkQueryPool; return .QUERY_POOL;
	    case VkBufferView; return .BUFFER_VIEW;
	    case VkImageView; return .IMAGE_VIEW;
	    case VkShaderModule; return .SHADER_MODULE;
	    case VkPipelineCache; return .PIPELINE_CACHE;
	    case VkPipelineLayout; return .PIPELINE_LAYOUT;
	    case VkRenderPass; return .RENDER_PASS;
	    case VkPipeline; return .PIPELINE;
	    case VkDescriptorSetLayout; return .DESCRIPTOR_SET_LAYOUT;
	    case VkSampler; return .SAMPLER;
	    case VkDescriptorPool; return .DESCRIPTOR_POOL;
	    case VkDescriptorSet; return .DESCRIPTOR_SET;
	    case VkFramebuffer; return .FRAMEBUFFER;
	    case VkCommandPool; return .COMMAND_POOL;

        case VkSamplerYcbcrConversion; return .SAMPLER_YCBCR_CONVERSION;
        case VkDescriptorUpdateTemplate; return .DESCRIPTOR_UPDATE_TEMPLATE;
        case VkSurfaceKHR; return .SURFACE_KHR;
        case VkSwapchainKHR; return .SWAPCHAIN_KHR;
        case VkDisplayKHR; return .DISPLAY_KHR;
        case VkDisplayModeKHR; return .DISPLAY_MODE_KHR;
        //case VkDebugReportCallbackExt; return .DEBUG_REPORT_CALLBACK_EXT;
        //case VkObjectTableNVX; return .OBJECT_TABLE_NVX;
        //case VkIndirectCommandsLayoutNVX; return .INDIRECT_COMMANDS_LAYOUT_NVX;
        case VkDebugUtilsMessengerEXT; return .DEBUG_UTILS_MESSENGER_EXT;
    }
    assert(false, "Unknown type");

	return .UNKNOWN;
}

Create :: (handle: *VkSemaphore, createInfo: VkSemaphoreCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateSemaphore(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkFence, createInfo: VkFenceCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateFence(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkBuffer, createInfo: VkBufferCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateBuffer(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkImage, createInfo: VkImageCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateImage(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkEvent, createInfo: VkEventCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateEvent(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkQueryPool, createInfo: VkQueryPoolCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateQueryPool(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkBufferView, createInfo: VkBufferViewCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateBufferView(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkImageView, createInfo: VkImageViewCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateImageView(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkShaderModule, createInfo: VkShaderModuleCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateShaderModule(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkPipelineCache, createInfo: VkPipelineCacheCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreatePipelineCache(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkPipelineLayout, createInfo: VkPipelineLayoutCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreatePipelineLayout(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkRenderPass, createInfo: VkRenderPassCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateRenderPass(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkDescriptorSetLayout, createInfo: VkDescriptorSetLayoutCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateDescriptorSetLayout(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkSampler, createInfo: VkSamplerCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateSampler(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkDescriptorPool, createInfo: VkDescriptorPoolCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateDescriptorPool(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkFramebuffer, createInfo: VkFramebufferCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateFramebuffer(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkCommandPool, createInfo: VkCommandPoolCreateInfo, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateCommandPool(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}
Create :: (handle: *VkSwapchainKHR, createInfo: VkSwapchainCreateInfoKHR, call := #caller_code) -> VkResult #expand #c_call {
    result := vkCreateSwapchainKHR(logicalDevice, *createInfo, allocationCallbacks, handle); 
    #insert AUTONAME_CODE;
    return result;
}

Destroy :: (handle: *VkInstance)            #c_call { vkDestroyInstance(handle, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkDevice)              #c_call { vkDestroyDevice(handle, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkSemaphore)           #c_call { vkDestroySemaphore(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkFence)               #c_call { vkDestroyFence(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkBuffer)              #c_call { vkDestroyBuffer(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkImage)               #c_call { vkDestroyImage(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkEvent)               #c_call { vkDestroyEvent(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkQueryPool)           #c_call { vkDestroyQueryPool(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkBufferView)          #c_call { vkDestroyBufferView(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkImageView)           #c_call { vkDestroyImageView(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkShaderModule)        #c_call { vkDestroyShaderModule(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkPipelineCache)       #c_call { vkDestroyPipelineCache(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkPipelineLayout)      #c_call { vkDestroyPipelineLayout(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkRenderPass)          #c_call { vkDestroyRenderPass(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkPipeline)            #c_call { vkDestroyPipeline(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkDescriptorSetLayout) #c_call { vkDestroyDescriptorSetLayout(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkSampler)             #c_call { vkDestroySampler(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkDescriptorPool)      #c_call { vkDestroyDescriptorPool(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkFramebuffer)         #c_call { vkDestroyFramebuffer(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkCommandPool)         #c_call { vkDestroyCommandPool(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }
Destroy :: (handle: *VkSwapchainKHR)        #c_call { vkDestroySwapchainKHR(logicalDevice, handle.*, allocationCallbacks); handle.* = VK_NULL_HANDLE; }

/*Destroy :: (device: VkDevice, handle: $T, pAllocator: *VkAllocationCallbacks) #c_call // @ReportCompiler?: see why we need to cast(explicity_type_of_handle)
{
    type :: type_of(handle);
    if type == {
        //case VkInstance; vkDestroyInstance(cast(VkInstance)handle, pAllocator); return;
	    //case VkDevice; vkDestroyDevice(cast(VkDevice)handle, pAllocator); return;
	    case VkSemaphore; vkDestroySemaphore(device, cast(VkSemaphore)handle, pAllocator); return;
	    case VkFence; vkDestroyFence(device, cast(VkFence)handle, pAllocator); return;
	    case VkBuffer; vkDestroyBuffer(device, cast(VkBuffer)handle, pAllocator); return;
	    case VkImage; vkDestroyImage(device, cast(VkImage)handle, pAllocator); return;
	    case VkEvent; vkDestroyEvent(device, cast(VkEvent)handle, pAllocator); return;
	    case VkQueryPool; vkDestroyQueryPool(device, cast(VkQueryPool)handle, pAllocator); return;
	    case VkBufferView; vkDestroyBufferView(device, cast(VkBufferView)handle, pAllocator); return;
	    case VkImageView; vkDestroyImageView(device, cast(VkImageView)handle, pAllocator); return;
	    case VkShaderModule; vkDestroyShaderModule(device, cast(VkShaderModule)handle, pAllocator); return;
	    case VkPipelineCache; vkDestroyPipelineCache(device, cast(VkPipelineCache)handle, pAllocator); return;
	    case VkPipelineLayout; vkDestroyPipelineLayout(device, cast(VkPipelineLayout)handle, pAllocator); return;
	    case VkRenderPass; vkDestroyRenderPass(device, cast(VkRenderPass)handle, pAllocator); return;
	    case VkPipeline; vkDestroyPipeline(device, cast(VkPipeline)handle, pAllocator); return;
	    case VkDescriptorSetLayout; vkDestroyDescriptorSetLayout(device, cast(VkDescriptorSetLayout)handle, pAllocator); return;
	    case VkSampler; vkDestroySampler(device, cast(VkSampler)handle, pAllocator); return;
	    case VkDescriptorPool; vkDestroyDescriptorPool(device, cast(VkDescriptorPool)handle, pAllocator); return;
	    case VkFramebuffer; vkDestroyFramebuffer(device, cast(VkFramebuffer)handle, pAllocator); return;
	    case VkCommandPool; vkDestroyCommandPool(device, cast(VkCommandPool)handle, pAllocator); return;
	    case VkSwapchainKHR; vkDestroySwapchainKHR(device, cast(VkSwapchainKHR)handle, pAllocator); return;
        case; push_context { print("Unhandled case for type %", type); }
    }
}*/

InitContext :: () -> bool
{
    push_allocator(temp);
    defer reset_temporary_storage();
    #if GRAPHICS_VALIDATION
    {
        layerCount : u32 = 0;
        vkEnumerateInstanceLayerProperties(*layerCount, null);

        availableLayers := NewArray(layerCount, VkLayerProperties, initialized = false);
        vkEnumerateInstanceLayerProperties(*layerCount, availableLayers.data);

        for requestedLayer : validationLayers
            for availableLayerProperties : availableLayers
            {
                if to_string(requestedLayer) == to_string(availableLayerProperties.layerName.data)
                {
                    validationLayersFound = true;
                    break;
                }
            }

        if !validationLayersFound
            log_error("Validation layers requested, but not available!\n");
    }
    
    appInfo := VkApplicationInfo.{
        pApplicationName = "Application",
        applicationVersion = VK_MAKE_API_VERSION(0, 1, 2, 0),
        pEngineName = "No Engine",
        engineVersion = VK_MAKE_API_VERSION(0, 1, 2, 0),
        apiVersion = VK_API_VERSION_1_2,
    };

    glfwExtensionCount: u32 = 0;
    glfwExtensions := glfw.GetRequiredInstanceExtensions(*glfwExtensionCount);

    extensions: [..]*u8;
    for i: 0..glfwExtensionCount - 1
        array_add(*extensions, glfwExtensions[i]);
    
    instanceCreateInfo := VkInstanceCreateInfo.{pApplicationInfo = *appInfo };

    #if GRAPHICS_VALIDATION 
    {
        debugCreateInfo: VkDebugUtilsMessengerCreateInfoEXT;
        validationFeatures: VkValidationFeaturesEXT;
        enabledFeatures: [..]VkValidationFeatureEnableEXT; // @Improve: This should be determined at compile time, even tho it isn't a big performance hit

        if validationLayersFound
        {
            if SHADER_DEBUG_PRINT 
                array_add(*enabledFeatures, .DEBUG_PRINTF_EXT);
            if SYNCHRONIZATION_VALIDATION 
                array_add(*enabledFeatures, .SYNCHRONIZATION_VALIDATION_EXT);

            array_add(*extensions, VK_EXT_DEBUG_UTILS_EXTENSION_NAME);


            instanceCreateInfo.enabledLayerCount = cast(u32) validationLayers.count;
            instanceCreateInfo.ppEnabledLayerNames = validationLayers.data;


            debugCreateInfo.messageSeverity = .VERBOSE_BIT_EXT | .WARNING_BIT_EXT | .ERROR_BIT_EXT;

            #if SHADER_DEBUG_PRINT
            {
                debugCreateInfo.messageSeverity |= INFO_BIT_EXT;
            }

            debugCreateInfo.messageType = .GENERAL_BIT_EXT | .VALIDATION_BIT_EXT | .PERFORMANCE_BIT_EXT;
            debugCreateInfo.pfnUserCallback = debug_callback;

            validationFeatures = .{
                enabledValidationFeatureCount = xx enabledFeatures.count,
                pEnabledValidationFeatures = enabledFeatures.data,
            };

            debugCreateInfo.pNext = *validationFeatures;

            instanceCreateInfo.pNext = *debugCreateInfo;
        }
    }
    
    instanceCreateInfo.enabledExtensionCount = xx extensions.count;
    instanceCreateInfo.ppEnabledExtensionNames =  extensions.data;
    
    result := vkCreateInstance(*instanceCreateInfo, allocationCallbacks, *instance);
    if  result != .SUCCESS
    {
        log_error("Failed to create instance with code %\n", result);
        return false;
    }   

    #if GRAPHICS_VALIDATION
    {
        if validationLayersFound
        {
            vkCreateDebugUtilsMessengerEXT  = xx vkGetInstanceProcAddr(instance, "vkCreateDebugUtilsMessengerEXT");
            vkDestroyDebugUtilsMessengerEXT = xx vkGetInstanceProcAddr(instance, "vkDestroyDebugUtilsMessengerEXT");
            vkSetDebugUtilsObjectNameEXT    = xx vkGetInstanceProcAddr(instance, "vkSetDebugUtilsObjectNameEXT");
            vkCmdBeginDebugUtilsLabelEXT    = xx vkGetInstanceProcAddr(instance, "vkCmdBeginDebugUtilsLabelEXT");
            vkCmdEndDebugUtilsLabelEXT      = xx vkGetInstanceProcAddr(instance, "vkCmdEndDebugUtilsLabelEXT");
            vkCmdInsertDebugUtilsLabelEXT   = xx vkGetInstanceProcAddr(instance, "vkCmdInsertDebugUtilsLabelEXT");
            vkQueueBeginDebugUtilsLabelEXT  = xx vkGetInstanceProcAddr(instance, "vkQueueBeginDebugUtilsLabelEXT");
            vkQueueEndDebugUtilsLabelEXT    = xx vkGetInstanceProcAddr(instance, "vkQueueEndDebugUtilsLabelEXT");
            vkQueueInsertDebugUtilsLabelEXT = xx vkGetInstanceProcAddr(instance, "vkQueueInsertDebugUtilsLabelEXT");

            debugCreateInfo.pNext = null;
            if vkCreateDebugUtilsMessengerEXT(instance, *debugCreateInfo, allocationCallbacks, *debug_messenger) != .VK_SUCCESS
            {
                log_error("Failed to set up debug messenger!\n");
                return false;
            }

            #if SHADER_DEBUG_PRINT  
            {
                array_add(*deviceExtensions, VK_KHR_SHADER_NON_SEMANTIC_INFO_EXTENSION_NAME);
            }
        }
    }
    

    deviceExtensions: [..]*u8; 
    array_add(*deviceExtensions, VK_KHR_SWAPCHAIN_EXTENSION_NAME);

    // Pick physical device 
    physicalDeviceCount: u32 = 0;
    vkEnumeratePhysicalDevices(instance, *physicalDeviceCount, null);

    if physicalDeviceCount == 0
    {
        log_error("Failed to find GPUs with Vulkan support!\n");
        return false;
    }

    physicalDevices := NewArray(physicalDeviceCount, VkPhysicalDevice, initialized = false);
    vkEnumeratePhysicalDevices(instance, *physicalDeviceCount, physicalDevices.data);

    indices: struct {
        graphicsFamily: u32 = U32_MAX;
        computeFamily:  u32 = U32_MAX;
        transferFamily: u32 = U32_MAX;
        //presentFamily: u32 = U32_MAX;
    };

    for physDevice : physicalDevices
    {
        extensionCount: u32;
        vkEnumerateDeviceExtensionProperties(physDevice, null, *extensionCount, null);

        availableExtensions := NewArray(extensionCount, VkExtensionProperties, initialized = false);
        vkEnumerateDeviceExtensionProperties(physDevice, null, *extensionCount, availableExtensions.data);

        extensionsSupported := true;
        for requiredExtension : deviceExtensions
        {
            found := false;
            for availableExtension : availableExtensions
            {
                if to_string(requiredExtension) == to_string(availableExtension.extensionName.data, c_style_strlen(availableExtension.extensionName.data))
                {
                    found = true;
                    break;
                }
            }

            if !found
            {
                extensionsSupported = false;
                break;
            }
        }

        indices = .{};
        queueFamiliesCount: u32 = 0;
        vkGetPhysicalDeviceQueueFamilyProperties(physDevice, *queueFamiliesCount, null);
        queueFamiliesProperties := NewArray(queueFamiliesCount, VkQueueFamilyProperties, initialized = false);
        vkGetPhysicalDeviceQueueFamilyProperties(physDevice, *queueFamiliesCount, queueFamiliesProperties.data);
        //log("Physical device % supports % queues families.", i, queueFamiliesCount);

        for queueFamilyProperties, i : queueFamiliesProperties
        {
            if queueFamilyProperties.queueFlags & VkQueueFlags.GRAPHICS_BIT  indices.graphicsFamily = xx i;
            if queueFamilyProperties.queueFlags & VkQueueFlags.COMPUTE_BIT   indices.computeFamily =  xx i;
            if queueFamilyProperties.queueFlags & VkQueueFlags.TRANSFER_BIT  indices.transferFamily = xx i;

            // supports_present := VK_FALSE;
            // vkGetPhysicalDeviceSurfaceSupportKHR(device, xx j, surface, *supports_present);

            //log("Queue family properites: %.", queueFamilyProperties);

            if indices.graphicsFamily != U32_MAX && indices.computeFamily != U32_MAX && indices.transferFamily != U32_MAX
                break;
        }

        //bool swapChainAdequate = false;
        //if (extensionsSupported) {
        //	SwapChainSupportDetails swapChainSupport = querySwapChainSupport(device, surface);
        //	swapChainAdequate = !swapChainSupport.formats.empty() && !swapChainSupport.presentModes.empty();
        //}

        if indices.graphicsFamily != U32_MAX && indices.computeFamily != U32_MAX && indices.transferFamily != U32_MAX && extensionsSupported /*&& swapChainAdequate*/
        {
            using physicalDevice;
            handle = physDevice;
            vkGetPhysicalDeviceFeatures(handle, *features);
            vkGetPhysicalDeviceProperties(handle, *properties);
            vkGetPhysicalDeviceMemoryProperties(handle, *memoryProperties);

            //properties2.pNext = pNext;
            vkGetPhysicalDeviceProperties2(handle, *properties2);

            break;
        }
    }

    if physicalDevice.handle == VK_NULL_HANDLE
    {
        log_error("Failed to find a suitable GPU!\n");
        return false;
    }

    deviceFeatures: VkPhysicalDeviceFeatures;
    if physicalDevice.features.samplerAnisotropy
        deviceFeatures.samplerAnisotropy = VK_TRUE;
    else
        log("Sampler anisotropy feature is not supported\n");

    if physicalDevice.features.independentBlend
        deviceFeatures.independentBlend = VK_TRUE;
    else
        log("Independent blend feature is not supported\n");

    features12 := VkPhysicalDeviceVulkan12Features.{
        shaderSampledImageArrayNonUniformIndexing = VK_TRUE,
        descriptorBindingPartiallyBound = VK_TRUE,
        descriptorBindingVariableDescriptorCount = VK_TRUE,
        runtimeDescriptorArray = VK_TRUE,
        scalarBlockLayout = VK_TRUE,
        timelineSemaphore = VK_TRUE,
        bufferDeviceAddress = VK_TRUE,
    };

    uniqueQueueFamilies: [..]u32;
    array_add_if_unique(*uniqueQueueFamilies, indices.graphicsFamily); // @Feature: this procedure should have a multi-argument version
    array_add_if_unique(*uniqueQueueFamilies, indices.computeFamily);
    array_add_if_unique(*uniqueQueueFamilies, indices.transferFamily);
    //array_add_if_unique(*uniqueQueueFamilies, indices.presentFamily);

    queueCreateInfos: [..]VkDeviceQueueCreateInfo;
    queuePriorities := float.[1.0];
    for queueFamily : uniqueQueueFamilies
        if queueFamily != U32_MAX
            array_add(*queueCreateInfos, .{
                queueFamilyIndex = queueFamily,
                queueCount = xx queuePriorities.count,
                pQueuePriorities = queuePriorities.data,
            });

    deviceCreateInfo := VkDeviceCreateInfo.{
        pNext = *features12,

        queueCreateInfoCount = xx queueCreateInfos.count,
        pQueueCreateInfos = queueCreateInfos.data,

        pEnabledFeatures = *deviceFeatures,

        enabledExtensionCount = xx deviceExtensions.count,
        ppEnabledExtensionNames =  deviceExtensions.data,
    };

    #if GRAPHICS_VALIDATION
    {
        if validationLayersFound
        {
            deviceCreateInfo.enabledLayerCount = validationLayers.count;
            deviceCreateInfo.ppEnabledLayerNames = validationLayers.data;
        }
    }
    
    if vkCreateDevice(physicalDevice.handle, *deviceCreateInfo, allocationCallbacks, *logicalDevice) != .SUCCESS
    {
        log_error("Failed to create logical device!\n");
        return false;
    }

    GetDeviceQueue :: (using q: *Queue, family: u32)
	{
		familyIndex = family;
		vkGetDeviceQueue(logicalDevice, family, 0, *handle);
	};

    if indices.graphicsFamily != U32_MAX GetDeviceQueue(*graphicsQueue, indices.graphicsFamily);
    if indices.computeFamily != U32_MAX  GetDeviceQueue(*computeQueue,  indices.computeFamily);
    if indices.transferFamily != U32_MAX GetDeviceQueue(*transferQueue, indices.transferFamily);
    //presentQueue.GetDeviceQueue(indices.presentFamily);

    allocatorCreateInfo := VmaAllocatorCreateInfo.{
        vulkanApiVersion = appInfo.apiVersion,
        physicalDevice = physicalDevice.handle,
        device = logicalDevice,
        instance = instance,
        flags = .BUFFER_DEVICE_ADDRESS_BIT,
    };

    if vmaCreateAllocator(*allocatorCreateInfo, *allocator) != .SUCCESS
    {
        log_error("Failed to create a memory allocator!\n");
        return false;
    }

    return true;
}

DeinitContext :: ()
{
    vmaDestroyAllocator(allocator);
    vkDestroyDevice(logicalDevice, null);

    #if GRAPHICS_VALIDATION
    {
        if validationLayersFound && vkDestroyDebugUtilsMessengerEXT 
        {
            vkDestroyDebugUtilsMessengerEXT(instance, debug_messenger, allocationCallbacks);
        }
    }
    vkDestroyInstance(instance, allocationCallbacks);
}

#scope_file
validationLayers := *u8.["VK_LAYER_KHRONOS_validation".data]; // @TODO: Make this consant when the compiler fixes the internal issue


debug_callback :: (severity: VkDebugUtilsMessageSeverityFlagBitsEXT, messageType: VkDebugUtilsMessageTypeFlagsEXT, pCallbackData: *VkDebugUtilsMessengerCallbackDataEXT, pUserData: *void) -> VkBool32 #c_call 
{
        logFlags := Log_Flags.NONE;
        type := "Unknown";

        if messageType == {
            case .GENERAL_BIT_EXT; type = "General"; return VK_FALSE;
            case .VALIDATION_BIT_EXT; type = "Validation";
            case .PERFORMANCE_BIT_EXT; type = "Performance";
        }

        if severity == {
            case .ERROR_BIT_EXT;   logFlags |= Log_Flags.ERROR;
            case .WARNING_BIT_EXT; logFlags |= Log_Flags.WARNING;
            case .INFO_BIT_EXT;    logFlags |= Log_Flags.NONE;
            case .VERBOSE_BIT_EXT; logFlags |= Log_Flags.VERBOSE_ONLY;
        }
        
    push_context {
        log("[%] %\n", type, to_string(pCallbackData.pMessage), flags = logFlags);
    }
    
    return VK_FALSE;
}

#import "Vulkan2"; 

#import "Basic";
#import "String";
#import "Program_Print";

#import "Compiler";

#import "Math";

glfw :: #import "glfw";

#if OS ==.WINDOWS { #import "Windows"; }

AUTONAME_CODE :: #string CODE
#if GRAPHICS_VALIDATION
    {
        if result != .SUCCESS return result;
        if validationLayersFound
        {
            name := #run -> string {
                nodes := compiler_get_nodes(call);       

                procCall := cast(*Code_Procedure_Call) nodes;

                builder: String_Builder;
                print_expression(*builder, procCall.arguments_sorted[0]);
                result := builder_to_string(*builder);
                return result;
            }

            SetObjectName(handle.*, name);
        }
    }
CODE