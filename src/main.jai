UpdateApp :: ()
{
    defer {
        reset_temporary_storage();
    }
    Resize :: ()
    {
        w, h: s32;
        glfw.GetFramebufferSize(window, *w, *h);
        if w == 0 || h == 0
            return;

        vkDeviceWaitIdle(vk.logicalDevice);
        DestroySwapchain();
        Destroy(*swapchain.surface);
        if glfw.CreateWindowSurface(vk.instance, window, null, *swapchain.surface.handle) != .SUCCESS
        {
            log_error("Failed to create a new surface\n");
            return;
        }
        vk.QuerySurfaceCapabilities(*swapchain.surface);
        CreateSwapchain(window, xx w, xx h);

        // Resize renderers
        Resize(*pathTracer, .{xx w, xx h});
    }
    vkWaitForFences(vk.logicalDevice, 1, *RenderFences[vk.CURRENT_FRAME_INDEX], VK_TRUE, U64_MAX);
    currentFrame := glfw.GetTime().(float32);
    deltaTime = currentFrame - lastFrame;
    lastFrame = currentFrame;
    UpdateEditor();

    /*
    //extent := GetWindowExtent(window);

    //if extent.width > 0 && extent.height > 0 {...
    */

    swapchainImageIndex: u32;
    result := vkAcquireNextImageKHR(vk.logicalDevice, swapchain.handle, U64_MAX, swapchain.ImageAvailableSemaphores[vk.CURRENT_FRAME_INDEX], VK_NULL_HANDLE, *swapchainImageIndex);

    if result == .ERROR_OUT_OF_DATE_KHR {
    	Resize();
    	return;
    }
    if result != .SUCCESS && result != .SUBOPTIMAL_KHR
    	log_error("Acquire result: %\n", result);

    vkResetFences(vk.logicalDevice, 1, *RenderFences[vk.CURRENT_FRAME_INDEX]); // Deadlock fix    

    UI();

    cmd := MainCommandBuffers[vk.CURRENT_FRAME_INDEX];
    vkResetCommandBuffer(cmd, 0);

    clearValue := VkClearValue.{ color._float32 = .[0.0, 0.0, 0.0, 1.0] };

    cmdBeginInfo := VkCommandBufferBeginInfo.{ flags = VkCommandBufferUsageFlagBits.ONE_TIME_SUBMIT_BIT };
    vkBeginCommandBuffer(cmd, *cmdBeginInfo);
    rpInfo := VkRenderPassBeginInfo.{
        renderPass = swapchain.renderPass,
        framebuffer = swapchain.frameBuffers[swapchainImageIndex],
        renderArea.extent = swapchain.extent,
        clearValueCount = 1,
        pClearValues = *clearValue,
    };
    vkCmdBeginRenderPass(cmd, *rpInfo, VkSubpassContents.INLINE);
    ImGui.ImplVulkan_RenderDrawData(ImGui.GetDrawData(), cmd);

    vkCmdEndRenderPass(cmd);
    vkEndCommandBuffer(cmd);

    waitStage := VkPipelineStageFlags.[ .COLOR_ATTACHMENT_OUTPUT_BIT, .COMPUTE_SHADER_BIT ];
    waitSemaphores := VkSemaphore.[swapchain.ImageAvailableSemaphores[vk.CURRENT_FRAME_INDEX], vk.TimelineSemaphore];
    waitValues := u64.[0, vk.TimelineValue]; // @NOTE: Apparently the timeline semaphore should be waiting last?
    timelineInfo := VkTimelineSemaphoreSubmitInfo.{
        waitSemaphoreValueCount = waitValues.count,
        pWaitSemaphoreValues = waitValues.data,
    };

    submit := VkSubmitInfo.{
        pNext = *timelineInfo,
        commandBufferCount = 1,
        pCommandBuffers = *cmd,

        pWaitDstStageMask = waitStage.data,

        waitSemaphoreCount = waitSemaphores.count,
        pWaitSemaphores = waitSemaphores.data,

        signalSemaphoreCount = 1,
        pSignalSemaphores = *swapchain.PresentSemaphores[swapchainImageIndex],
    };

    vkQueueSubmit(vk.graphicsQueue, 1, *submit, RenderFences[vk.CURRENT_FRAME_INDEX]);

    presentInfo := VkPresentInfoKHR.{
        waitSemaphoreCount = 1,
        pWaitSemaphores = *swapchain.PresentSemaphores[swapchainImageIndex],

        swapchainCount = 1,
        pSwapchains = *swapchain.handle,

        pImageIndices = *swapchainImageIndex,
    };

    presentationResult := vkQueuePresentKHR(vk.graphicsQueue, *presentInfo); // @TODO: Should use present queue

    if presentationResult == .ERROR_OUT_OF_DATE_KHR || presentationResult == .SUBOPTIMAL_KHR //|| resized
        Resize();
    else if presentationResult != .SUCCESS
        log_error("Presentation result: %\n", presentationResult);

    UpdateFrameSyncs();
}

InputProc :: ()
{
    InputEditor();
}

main :: ()
{
    set_working_directory("data");

    glfw.SetErrorCallback( (err: s32, description: *u8) #c_call { push_context { log("%\n", to_string(description)); } });

    if !glfw.Init()  return;
    defer glfw.Terminate();

    glfw.WindowHint(glfw.CLIENT_API, glfw.NO_API);
    //glfw.WindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    if !vk.InitContext() return;
    defer vk.DeinitContext();

    CreateWindow();
    defer glfw.DestroyWindow(window);

    if glfw.CreateWindowSurface(vk.instance, window, null, *swapchain.surface.handle) != .SUCCESS
    {
        log_error("Window surface creation failed.\n");
        return;
    }
    defer vk.Destroy(*swapchain.surface);
    vk.QuerySurfaceCapabilities(*swapchain.surface);

    CreateSwapchain(window, windowWidth, windowHeight);
    defer DestroySwapchain();


    vk.InitSyncContext();
    {
        cmdAllocInfo := VkCommandBufferAllocateInfo.{ 
            commandPool = vk.GraphicsCommandPool,
            commandBufferCount = 1,
            level = .PRIMARY,        
        };

        for i: 0..vk.FRAME_OVERLAP-1 
        {
            vkAllocateCommandBuffers(vk.logicalDevice, *cmdAllocInfo, *MainCommandBuffers[i]);
            
            //cmdAllocInfo.commandPool = ComputeCommandPool;
            //vkAllocateCommandBuffers(logicalDevice, *cmdAllocInfo, *ComputeCommandBuffers[i]);
            
            vk.Create(*RenderFences[i], .{flags = .SIGNALED_BIT});
        }
    }

    defer {
        vkDeviceWaitIdle(vk.logicalDevice);
        vk.DestroySyncContext();

        for i: 0..vk.FRAME_OVERLAP-1
            vk.Destroy(*RenderFences[i]);
    }

    if !InitApp() return;
    defer {
        vkDeviceWaitIdle(vk.logicalDevice);
        inline DeinitApp();
    }

    while !glfw.WindowShouldClose(window)
    {
        scrollX = 0.0;
        scrollY = 0.0;
        glfw.PollEvents();
        
        InputProc();

        UpdateApp();
    }

    #if true {
        log("========= LEAK REPORT =========\n");
        report := make_leak_report();
        log_leak_report(report);
        log("========= END OF REPORT =======\n");
    }
}

#import "Basic"()(MEMORY_DEBUGGER = true);

#import "Hash_Table";
#import "String";
#import "Math";

#import "File";
#import "File_Utilities";

#import "Program_Print";
#import "Compiler";

glfw :: #import "glfw";

Input :: #import "Input";
#if OS ==.WINDOWS {
    win :: #import "Windows";
}

using,except(Image) vk :: #import "VKUtils"(FRAME_OVERLAP=1);
#import "Vulkan2"; // @TODO: find a better way of including already included modules

#load "window.jai";
#load "app.jai";

#load "utilityProcedures.jai";