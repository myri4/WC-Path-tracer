MAX_SWAPCHAIN_IMAGES   :: 3;

Surface :: struct
{
    using #as handle: VkSurfaceKHR = VK_NULL_HANDLE;

    capabilities: VkSurfaceCapabilitiesKHR;
    formats: []VkSurfaceFormatKHR;
    presentModes: []VkPresentModeKHR;
}

QuerySurfaceCapabilities :: (using surface: *Surface)
{
    vkGetPhysicalDeviceSurfaceCapabilitiesKHR(physicalDevice.handle, handle, *capabilities);

    formatCount : u32;
    vkGetPhysicalDeviceSurfaceFormatsKHR(physicalDevice.handle, handle, *formatCount, null); // @TODO: maybe check the return code
    formats = NewArray(formatCount, VkSurfaceFormatKHR);
    vkGetPhysicalDeviceSurfaceFormatsKHR(physicalDevice.handle, handle, *formatCount, formats.data);
    
    presentModeCount : u32 = 0;
    vkGetPhysicalDeviceSurfacePresentModesKHR(physicalDevice.handle, handle, *presentModeCount, null);
    presentModes = NewArray(presentModeCount, VkPresentModeKHR);
    vkGetPhysicalDeviceSurfacePresentModesKHR(physicalDevice.handle, handle, *presentModeCount, presentModes.data);
}

Destroy :: (using surface: *Surface)
{
    vkDestroySurfaceKHR(instance, handle, null);
    handle = VK_NULL_HANDLE;
    capabilities = .{};
    array_free(formats);
    array_free(presentModes);
}

Swapchain :: struct
{
    handle: VkSwapchainKHR;
    surface: Surface;
    
    imageCount: u32;
    images: [MAX_SWAPCHAIN_IMAGES]VkImage;
    imageViews: [MAX_SWAPCHAIN_IMAGES]VkImageView;

    extent: VkExtent2D;
}

SelectSurfaceFormat :: (availableFormats: []VkSurfaceFormatKHR, requestedFormat := VkFormat.B8G8R8A8_UNORM, requestedColorSpace := VkColorSpaceKHR.COLOR_SPACE_SRGB_NONLINEAR_KHR) -> VkSurfaceFormatKHR
{
    for availableFormat : availableFormats
    {
        if availableFormat.format == requestedFormat && availableFormat.colorSpace == requestedColorSpace
            return availableFormat;
    }

    return availableFormats[0];
}

SelectPresentMode :: (availableModes: []VkPresentModeKHR, requestedMode: VkPresentModeKHR) -> VkPresentModeKHR
{
    for availablePresentMode : availableModes
            if availablePresentMode == requestedMode
                return availablePresentMode;
    
    return .FIFO_KHR;
}

CreateSwapchain :: (using,except(surface) swapchain: *Swapchain, surface: Surface, width: u32, height: u32, VSync: bool) -> VkResult
{
    swapchain.surface = surface;
    surfaceFormat := SelectSurfaceFormat(surface.formats);

    presentMode := ifx VSync  VkPresentModeKHR.FIFO_KHR else SelectPresentMode(surface.presentModes, .MAILBOX_KHR);
    
    extent = surface.capabilities.currentExtent;

    if surface.capabilities.currentExtent.width == U32_MAX
    {
        extent.width  = clamp(width,  surface.capabilities.minImageExtent.width,  surface.capabilities.maxImageExtent.width);
        extent.height = clamp(height, surface.capabilities.minImageExtent.height, surface.capabilities.maxImageExtent.height);
    }

    swapchainImageCount : u32 = surface.capabilities.minImageCount + 1;
    if surface.capabilities.maxImageCount > 0 && swapchainImageCount > surface.capabilities.maxImageCount
        swapchainImageCount = surface.capabilities.maxImageCount;

    createInfo := VkSwapchainCreateInfoKHR.{
        surface          = surface.handle,
        minImageCount    = swapchainImageCount,
        imageFormat      = surfaceFormat.format,
        imageColorSpace  = surfaceFormat.colorSpace,
        imageExtent      = extent,
        imageArrayLayers = 1, // 2 for stereo
        imageUsage       = .COLOR_ATTACHMENT_BIT | .TRANSFER_DST_BIT,
        imageSharingMode = .EXCLUSIVE,
        preTransform     = surface.capabilities.currentTransform,
        compositeAlpha   = .OPAQUE_BIT_KHR,
        presentMode      = presentMode,
        clipped          = VK_TRUE,
        oldSwapchain     = handle,
    };

    PRESENT_MODE_MAILBOX_IMAGE_COUNT :u32: 3;
    PRESENT_MODE_DEFAULT_IMAGE_COUNT :u32: 2;
    //swapchainImageCount = ifx presentMode == .MAILBOX_KHR  then PRESENT_MODE_MAILBOX_IMAGE_COUNT else  PRESENT_MODE_DEFAULT_IMAGE_COUNT;
    
    result := vkCreateSwapchainKHR(logicalDevice, *createInfo, null, *swapchain.handle);
    if result != .SUCCESS
        return result;

    vkGetSwapchainImagesKHR(logicalDevice, swapchain.handle, *swapchainImageCount, null);
    vkGetSwapchainImagesKHR(logicalDevice, swapchain.handle, *swapchainImageCount, swapchain.images.data);

    return result;
}