// @Cleanup: this whole file
window: *glfw.window;
windowWidth: u32 = 1600;
windowHeight: u32 = 900;
scrollX: float64;
scrollY: float64;

CreateWindow :: inline () -> bool {
    window = glfw.CreateWindow(xx windowWidth, xx windowHeight, "Tracer", null, null);
    if !window 
        return false;

    glfw.SetScrollCallback(window, (window: *glfw.window, xoffset: float64, yoffset: float64) #c_call {
        scrollX = xoffset; scrollY = yoffset;

        ImGui.ImplGlfw_ScrollCallback(window, xoffset, yoffset);
    });

    glfw.SetCharCallback(window, (window: *glfw.window, codepoint: u32) #c_call {
        ImGui.ImplGlfw_CharCallback(window, codepoint);
    });

    glfw.SetKeyCallback(window, (window: *glfw.window, key: s32, scancode: s32, action: s32, mods: s32) #c_call {
        ImGui.ImplGlfw_KeyCallback(window, key, scancode, action, mods);
    });

    glfw.SetCursorPosCallback(window, (window: *glfw.window, xpos: float64, ypos: float64) #c_call {
        ImGui.ImplGlfw_CursorPosCallback(window, xpos, ypos);
    });

    glfw.SetMouseButtonCallback(window, (window: *glfw.window, button: s32, action: s32, mods: s32) #c_call {
        ImGui.ImplGlfw_MouseButtonCallback(window, button, action, mods);
    });

    glfw.SetCursorEnterCallback(window, (window: *glfw.window, entered: s32) #c_call {
        ImGui.ImplGlfw_CursorEnterCallback(window, entered);
    });

    glfw.SetWindowFocusCallback(window, (window: *glfw.window, focused: s32) #c_call {
        ImGui.ImplGlfw_WindowFocusCallback(window, focused);
    });

    glfw.SetFramebufferSizeCallback(window, (window: *glfw.window, w: s32, h: s32) #c_call {
        windowWidth = xx w;
        windowHeight = xx h;
    });

    return true;
}

swapchain: struct {
    using #as swapchain: vk.Swapchain;
    frameBuffers: [..]VkFramebuffer;
    renderPass: VkRenderPass;

    PresentSemaphores, ImageAvailableSemaphores: [..]VkSemaphore;
};

RenderFences: [vk.FRAME_OVERLAP]VkFence;
MainCommandBuffers: [vk.FRAME_OVERLAP]VkCommandBuffer;


CreateSwapchain :: (window: *glfw.window, width: u32, height: u32) -> bool {
    result := vk.CreateSwapchain(*swapchain, swapchain.surface, width, height, false);
    if result != .SUCCESS || swapchain.handle == VK_NULL_HANDLE {
        log_error("Swapchain initialization failed.\n");
        return false;
    }

    hasClear := true;
    using swapchain;
    surfaceFormat := vk.SelectSurfaceFormat(swapchain.surface.formats);

    viewCreateInfo := VkImageViewCreateInfo.{
        viewType = ._2D,
        format = surfaceFormat.format,
        subresourceRange = .{
            aspectMask = VkImageAspectFlagBits.COLOR_BIT,
            levelCount = 1,
            layerCount = 1,
        },
    };

    for * view, i : imageViews {
        viewCreateInfo.image = swapchain.images[i];

        name := tprint("swapchain.imageViews[%]", i);
        if vk.Create(view, viewCreateInfo) != .SUCCESS {
            log_error("Failed creating %.\n", name);
            return false;
        }
        vk.SetObjectName(view.*, name);
    }

    if renderPass == VK_NULL_HANDLE {
        color_attachment := VkAttachmentDescription.{
            format = surfaceFormat.format,
            samples = ._1_BIT,
            loadOp = ifx hasClear  then .CLEAR else .DONT_CARE,
            storeOp = .STORE,
            stencilLoadOp = .DONT_CARE,
            stencilStoreOp = .DONT_CARE,
            initialLayout = .UNDEFINED,
            finalLayout = .PRESENT_SRC_KHR,
        };

        color_attachment_ref := VkAttachmentReference.{ 0, .COLOR_ATTACHMENT_OPTIMAL };

        subpass := VkSubpassDescription.{
            pipelineBindPoint = .GRAPHICS,
            colorAttachmentCount = 1,
            pColorAttachments = *color_attachment_ref,
        };

        dependency := VkSubpassDependency.{
            srcSubpass = VK_SUBPASS_EXTERNAL,
            srcStageMask = .COLOR_ATTACHMENT_OUTPUT_BIT,
            dstStageMask = .COLOR_ATTACHMENT_OUTPUT_BIT,
            dstAccessMask = .COLOR_ATTACHMENT_WRITE_BIT,
        };

        if vk.Create(*renderPass, .{
            attachmentCount = 1,
            pAttachments = *color_attachment,
            subpassCount = 1,
            pSubpasses = *subpass,
            dependencyCount = 1,
            pDependencies = *dependency,
        }) != .SUCCESS {
            log_error("Failed to create swapchain.renderPass\n");
            return false;
        }
        else
            vk.SetObjectName(renderPass, "swapchain.renderPass");
    }

    array_resize(*frameBuffers, images.count);
    array_resize(*PresentSemaphores, images.count);
    array_resize(*ImageAvailableSemaphores, images.count);

    for i: 0..images.count - 1 {
        vk.Create(*PresentSemaphores[i], .{});
		vk.Create(*ImageAvailableSemaphores[i], .{});
    }

    fb_info := VkFramebufferCreateInfo.{
        renderPass = renderPass,
        attachmentCount = 1,
        width = xx width,
        height = xx height,
        layers = 1,
    };

    for * frameBuffer, i: frameBuffers {
        fb_info.pAttachments = *imageViews[i];
        name := tprint("swapchain.frameBuffers[%]", i);
        if vk.Create(frameBuffer, fb_info) != .SUCCESS {
            log_error("Failed creating %.\n", name);
            return false;
        }

        vk.SetObjectName(frameBuffer.*, name);
    }

    return true;
}

DestroySwapchain :: () {
    using swapchain;
    Destroy(*handle);

    for * view : imageViews
        Destroy(view);

    for i: 0..images.count - 1 {
        Destroy(*PresentSemaphores[i]);
		Destroy(*ImageAvailableSemaphores[i]);
    }

    for * frameBuffer : frameBuffers
        Destroy(frameBuffer);
    
    Destroy(*renderPass);
}

GetWindowSize :: () -> Vector2 { 
    width, height: s32;
    
    glfw.GetWindowSize(window, *width, *height);
    return .{xx width, xx height};
}

GetCursorPosition :: () -> Vector2 { 
    x, y: float64;
    
    glfw.GetCursorPos(window, *x, *y);
    return .{xx x, xx y};
}