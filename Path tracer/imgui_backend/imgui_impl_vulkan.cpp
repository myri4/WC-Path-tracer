#include "imgui/imgui.h"
#ifndef IMGUI_DISABLE
#include "imgui_impl_vulkan.h"
#include "../Rendering/Texture.h"
#include "../Rendering/Shader.h"

#include "../Memory/Buffer.h"

#include "../Rendering/vk/Buffer.h"
#include "../Rendering/vk/Commands.h"
#include "../Rendering/vk/Image.h"

// Visual Studio warnings
#ifdef _MSC_VER
#pragma warning (disable: 4127) // condition expression is constant
#endif

// For multi-viewport support:
// Helper structure we store in the void* RendererUserData field of each ImGuiViewport to easily retrieve our backend data.

struct ImGui_ImplVulkanH_FrameSemaphores
{
	vk::Semaphore         ImageAcquiredSemaphore;
	vk::Semaphore         RenderCompleteSemaphore;
};

struct ImGui_ImplVulkanH_Frame
{
	VkCommandBuffer     CommandBuffer;
	vk::Fence           Fence;
};

struct ImGui_ImplVulkanH_Window
{
	uint32_t            Width = 0;
	uint32_t            Height = 0;
	bool                ClearEnable = true;
	vk::Swapchain       Swapchain;
	VkClearValue        ClearValue = {};
	uint32_t            FrameIndex = 0;
	uint32_t            SemaphoreIndex = 0;
	uint32_t            swapchainImageIndex = 0;
	wc::FPtr<ImGui_ImplVulkanH_Frame> Frames;
	wc::FPtr<ImGui_ImplVulkanH_FrameSemaphores> FrameSemaphores;

	void CreateOrResize(uint32_t width, uint32_t height)
	{
		if (Swapchain)
		{
			VulkanContext::GetLogicalDevice().WaitIdle();
			FreeSyncs();
			Swapchain.DestroyFramebuffers();
		}
		// Create Swapchain
		Width = width;
		Height = height;

		Swapchain.surface.Query();
		Swapchain.Create(VkExtent2D{ width, height }, false, ClearEnable);
		AllocSyncs();
	}

	void AllocSyncs()
	{
		Frames.Allocate(Swapchain.images.Count);
		FrameSemaphores.Allocate(Swapchain.images.Count + 1);
		memset(Frames.Data, 0, sizeof(Frames[0]) * Frames.Count);
		memset(FrameSemaphores.Data, 0, sizeof(FrameSemaphores[0]) * FrameSemaphores.Count);

		// Create Command Buffers
		for (uint32_t i = 0; i < Frames.Count; i++)
		{
			ImGui_ImplVulkanH_Frame* fd = &Frames[i];
			vk::SyncContext::GraphicsCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, fd->CommandBuffer);

			fd->Fence.Create(VK_FENCE_CREATE_SIGNALED_BIT);
		}

		for (auto& fsd : FrameSemaphores)
		{
			fsd.ImageAcquiredSemaphore.Create();
			fsd.RenderCompleteSemaphore.Create();
		}
	}

	void FreeSyncs()
	{
		for (uint32_t i = 0; i < Frames.Count; i++)
		{
			Frames[i].Fence.Destroy();
			vk::SyncContext::GraphicsCommandPool.Free(Frames[i].CommandBuffer);
			Frames[i].CommandBuffer = VK_NULL_HANDLE;
		}

		for (auto& fsd : FrameSemaphores)
		{
			fsd.ImageAcquiredSemaphore.Destroy();
			fsd.RenderCompleteSemaphore.Destroy();
		}
		Frames.Free();
		FrameSemaphores.Free();
	}

	void Destroy(bool destroySurface = true)
	{
		VulkanContext::GetLogicalDevice().WaitIdle();
		FreeSyncs();

		Swapchain.DestroyFramebuffers();
		Swapchain.DestroyRenderPass();
		Swapchain.DestroySwapchain();
		if (destroySurface) Swapchain.surface.Destroy();

		auto surface = Swapchain.surface;
		*this = ImGui_ImplVulkanH_Window();
		Swapchain.surface = surface;
	}
};

struct ImGui_ImplVulkan_FrameRenderBuffers
{
	vk::Buffer VertexBuffer;
	vk::Buffer IndexBuffer;
};

struct ImGui_ImplVulkan_WindowRenderBuffers
{
	uint32_t            Index = 0;
	wc::FPtr<ImGui_ImplVulkan_FrameRenderBuffers> FrameRenderBuffers;

	void Destroy()
	{
		for (auto& frb : FrameRenderBuffers)
		{
			frb.VertexBuffer.Free();
			frb.IndexBuffer.Free();
		}
		FrameRenderBuffers.Free();
		Index = 0;
	}
};

struct ImGui_ImplVulkan_ViewportData
{
	bool                                    WindowOwned = false;
	ImGui_ImplVulkanH_Window                Window;

	ImGui_ImplVulkan_WindowRenderBuffers RenderBuffers;
};

struct ImGui_ImplVulkan_Data
{
	VkRenderPass RenderPass = VK_NULL_HANDLE;
	wc::Shader   Shader;
	wc::Texture  FontTexture;

	// Render buffers for main window
	ImGui_ImplVulkan_WindowRenderBuffers MainWindowRenderBuffers;
};

static ImGui_ImplVulkan_Data* ImGui_ImplVulkan_GetBackendData() { return ImGui::GetCurrentContext() ? (ImGui_ImplVulkan_Data*)ImGui::GetIO().BackendRendererUserData : nullptr; }

VkDescriptorSet MakeImGuiDescriptor(VkDescriptorSet dSet, const VkDescriptorImageInfo& imageInfo)
{
	if (dSet == VK_NULL_HANDLE) vk::descriptorAllocator.Allocate(dSet, ImGui_ImplVulkan_GetBackendData()->Shader.DescriptorLayout);

	vk::DescriptorWriter writer(dSet);
	writer.BindImage(0, imageInfo, VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER);

	return dSet;
}

// Render function
void ImGui_ImplVulkan_RenderDrawData(ImDrawData* draw_data, VkCommandBuffer cmd, VkRenderPassBeginInfo rpInfo)
{
    // Avoid rendering when minimized, scale coordinates for retina displays (screen coordinates != framebuffer coordinates)
    int fb_width = (int)(draw_data->DisplaySize.x * draw_data->FramebufferScale.x);
    int fb_height = (int)(draw_data->DisplaySize.y * draw_data->FramebufferScale.y);
    if (fb_width <= 0 || fb_height <= 0)
        return;

    ImGui_ImplVulkan_Data* bd = ImGui_ImplVulkan_GetBackendData();

    // Allocate array to store enough vertex/index buffers. Each unique viewport gets its own storage.
    ImGui_ImplVulkan_ViewportData* viewport_renderer_data = (ImGui_ImplVulkan_ViewportData*)draw_data->OwnerViewport->RendererUserData;
    IM_ASSERT(viewport_renderer_data != nullptr);
    ImGui_ImplVulkan_WindowRenderBuffers* wrb = &viewport_renderer_data->RenderBuffers;
    if (!wrb->FrameRenderBuffers)
    {
        wrb->Index = 0;
        wrb->FrameRenderBuffers.Allocate(3); // @TODO: Change this
        memset(wrb->FrameRenderBuffers.Data, 0, sizeof(ImGui_ImplVulkan_FrameRenderBuffers) * wrb->FrameRenderBuffers.Count);
    }
    wrb->Index = (wrb->Index + 1) % wrb->FrameRenderBuffers.Count;
    ImGui_ImplVulkan_FrameRenderBuffers* rb = &wrb->FrameRenderBuffers[wrb->Index];

    if (draw_data->TotalVtxCount > 0)
    {
        // Create or resize the vertex/index buffers
        size_t vertex_size = draw_data->TotalVtxCount * sizeof(ImDrawVert);
        size_t index_size = draw_data->TotalIdxCount * sizeof(ImDrawIdx);
        if (rb->VertexBuffer == VK_NULL_HANDLE) rb->VertexBuffer.Allocate(vertex_size, vk::DEVICE_ADDRESS);
        else if (rb->VertexBuffer.Size() < vertex_size)
        {
            rb->VertexBuffer.Free();
            rb->VertexBuffer.Allocate(vertex_size, vk::DEVICE_ADDRESS);
        }

        if (rb->IndexBuffer == VK_NULL_HANDLE) rb->IndexBuffer.Allocate(index_size, VK_BUFFER_USAGE_INDEX_BUFFER_BIT);
        else if (rb->IndexBuffer.Size() < index_size)
        {
            rb->IndexBuffer.Free();
            rb->IndexBuffer.Allocate(index_size, VK_BUFFER_USAGE_INDEX_BUFFER_BIT);
        }

        vk::StagingBuffer vBuffer, iBuffer;
        vBuffer.Allocate(vertex_size);
        iBuffer.Allocate(index_size);
        ImDrawVert* vtx_dst = (ImDrawVert*)vBuffer.Map();
        ImDrawIdx* idx_dst = (ImDrawIdx*)iBuffer.Map();
        for (int n = 0; n < draw_data->CmdListsCount; n++)
        {
            const ImDrawList* cmd_list = draw_data->CmdLists[n];
            memcpy(vtx_dst, cmd_list->VtxBuffer.Data, cmd_list->VtxBuffer.Size * sizeof(ImDrawVert));
            memcpy(idx_dst, cmd_list->IdxBuffer.Data, cmd_list->IdxBuffer.Size * sizeof(ImDrawIdx));
            vtx_dst += cmd_list->VtxBuffer.Size;
            idx_dst += cmd_list->IdxBuffer.Size;
        }

        vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
            rb->VertexBuffer.SetData(cmd, vBuffer, vertex_size);
            rb->IndexBuffer.SetData(cmd, iBuffer, index_size);
            });
        
        vBuffer.Unmap();
        iBuffer.Unmap();
        vBuffer.Free();
        iBuffer.Free();
    }
	VkCommandBufferBeginInfo begInfo = { VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO };

	begInfo.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

	vkBeginCommandBuffer(cmd, &begInfo);
    vkCmdBeginRenderPass(cmd, &rpInfo, VK_SUBPASS_CONTENTS_INLINE);
	{
		vkCmdBindPipeline(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, bd->Shader.Pipeline);

		if (draw_data->TotalVtxCount > 0)
			vkCmdBindIndexBuffer(cmd, rb->IndexBuffer, 0, sizeof(ImDrawIdx) == 2 ? VK_INDEX_TYPE_UINT16 : VK_INDEX_TYPE_UINT32);

		// Setup viewport:
		VkViewport viewport;
		viewport.x = 0;
		viewport.y = 0;
		viewport.width = (float)fb_width;
		viewport.height = (float)fb_height;
		viewport.minDepth = 0.f;
		viewport.maxDepth = 1.f;
		vkCmdSetViewport(cmd, 0, 1, &viewport);

		struct
		{
			float scale[2];
			float translate[2];
            VkDeviceAddress vertexBuffer;
		}u_Data;
		u_Data.scale[0] = 2.f / draw_data->DisplaySize.x;
		u_Data.scale[1] = 2.f / draw_data->DisplaySize.y;
		u_Data.translate[0] = -1.f - draw_data->DisplayPos.x * u_Data.scale[0];
		u_Data.translate[1] = -1.f - draw_data->DisplayPos.y * u_Data.scale[1];
        u_Data.vertexBuffer = rb->VertexBuffer.GetDeviceAddress();
		vkCmdPushConstants(cmd, bd->Shader.PipelineLayout, VK_SHADER_STAGE_VERTEX_BIT, 0, sizeof(u_Data), &u_Data);
	}

    // Will project scissor/clipping rectangles into framebuffer space
    ImVec2 clip_off = draw_data->DisplayPos;         // (0,0) unless using multi-viewports
    ImVec2 clip_scale = draw_data->FramebufferScale; // (1,1) unless using retina display which are often (2,2)

    // Render command lists
    // (Because we merged all buffers into a single one, we maintain our own offset into them)
    int global_vtx_offset = 0;
    int global_idx_offset = 0;
    for (int n = 0; n < draw_data->CmdListsCount; n++)
    {
        const ImDrawList* cmd_list = draw_data->CmdLists[n];
        for (int cmd_i = 0; cmd_i < cmd_list->CmdBuffer.Size; cmd_i++)
        {
            const ImDrawCmd* pcmd = &cmd_list->CmdBuffer[cmd_i];
            if (pcmd->UserCallback != nullptr && pcmd->UserCallback != ImDrawCallback_ResetRenderState) pcmd->UserCallback(cmd_list, pcmd);
            else
            {
                // Project scissor/clipping rectangles into framebuffer space
                ImVec2 clip_min((pcmd->ClipRect.x - clip_off.x) * clip_scale.x, (pcmd->ClipRect.y - clip_off.y) * clip_scale.y);
                ImVec2 clip_max((pcmd->ClipRect.z - clip_off.x) * clip_scale.x, (pcmd->ClipRect.w - clip_off.y) * clip_scale.y);

                // Clamp to viewport as vkCmdSetScissor() won't accept values that are off bounds
                if (clip_min.x < 0.f) { clip_min.x = 0.f; }
                if (clip_min.y < 0.f) { clip_min.y = 0.f; }
                if (clip_max.x > fb_width) { clip_max.x = (float)fb_width; }
                if (clip_max.y > fb_height) { clip_max.y = (float)fb_height; }
                if (clip_max.x <= clip_min.x || clip_max.y <= clip_min.y)
                    continue;

                // Apply scissor/clipping rectangle
                VkRect2D scissor;
                scissor.offset.x = (int32_t)(clip_min.x);
                scissor.offset.y = (int32_t)(clip_min.y);
                scissor.extent.width = (uint32_t)(clip_max.x - clip_min.x);
                scissor.extent.height = (uint32_t)(clip_max.y - clip_min.y);
                vkCmdSetScissor(cmd, 0, 1, &scissor);

                // Bind DescriptorSet with font or user texture
                VkDescriptorSet desc_set = (VkDescriptorSet)pcmd->TextureId;
                if (sizeof(ImTextureID) < sizeof(ImU64))
                {
                    // We don't support texture switches if ImTextureID hasn't been redefined to be 64-bit. Do a flaky check that other textures haven't been used.
                    desc_set = bd->FontTexture.imageID;
                }
                vkCmdBindDescriptorSets(cmd, VK_PIPELINE_BIND_POINT_GRAPHICS, bd->Shader.PipelineLayout, 0, 1, &desc_set, 0, nullptr);

                // Draw
                vkCmdDrawIndexed(cmd, pcmd->ElemCount, 1, pcmd->IdxOffset + global_idx_offset, pcmd->VtxOffset + global_vtx_offset, 0);
            }
        }
        global_idx_offset += cmd_list->IdxBuffer.Size;
        global_vtx_offset += cmd_list->VtxBuffer.Size;
    }

    VkRect2D scissor = { { 0, 0 }, { (uint32_t)fb_width, (uint32_t)fb_height } };
    vkCmdSetScissor(cmd, 0, 1, &scissor);
    vkCmdEndRenderPass(cmd);
    vkEndCommandBuffer(cmd);
}

bool ImGui_ImplVulkan_CreateFontsTexture()
{
    ImGuiIO& io = ImGui::GetIO();
    ImGui_ImplVulkan_Data* bd = ImGui_ImplVulkan_GetBackendData();

    uint8_t* pixels;
    int width, height;
    io.Fonts->GetTexDataAsRGBA32(&pixels, &width, &height);

    // Create the Image:
    wc::TextureSpecification texSpec = 
    {
        .format = VK_FORMAT_R8G8B8A8_UNORM,
        .width = (uint32_t)width,
        .height = (uint32_t)height,
        .usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_TRANSFER_DST_BIT,

		.magFilter = vk::Filter::LINEAR,
		.minFilter = vk::Filter::LINEAR,
		.mipmapMode = vk::SamplerMipmapMode::LINEAR,
		.addressModeU = vk::SamplerAddressMode::REPEAT,
		.addressModeV = vk::SamplerAddressMode::REPEAT,
		.addressModeW = vk::SamplerAddressMode::REPEAT,
    };
	bd->FontTexture.Allocate(texSpec);
	bd->FontTexture.SetName("imgui_font_texture");
    bd->FontTexture.SetData(pixels, width, height);

    // Store our identifier
    io.Fonts->SetTexID(bd->FontTexture);

    return true;
}

void ImGui_ImplVulkan_DestroyFontsTexture()
{
    ImGuiIO& io = ImGui::GetIO();
    ImGui_ImplVulkan_Data* bd = ImGui_ImplVulkan_GetBackendData();

    bd->FontTexture.Destroy();
    io.Fonts->SetTexID(0);
}

//--------------------------------------------------------------------------------------------------------
// MULTI-VIEWPORT / PLATFORM INTERFACE SUPPORT
//--------------------------------------------------------------------------------------------------------

static void ImGui_ImplVulkan_CreateWindow(ImGuiViewport* viewport)
{
    ImGui_ImplVulkan_ViewportData* vd = IM_NEW(ImGui_ImplVulkan_ViewportData)();
    viewport->RendererUserData = vd;
    ImGui_ImplVulkanH_Window* wd = &vd->Window;

	// Create surface
	ImGuiPlatformIO& platform_io = ImGui::GetPlatformIO();
    platform_io.Platform_CreateVkSurface(viewport, (ImU64)VulkanContext::GetInstance(), (const void*)VulkanContext::GetAllocator(), (ImU64*)&wd->Swapchain.surface);

    // Create SwapChain, RenderPass, Framebuffer, etc.
    wd->ClearEnable = (viewport->Flags & ImGuiViewportFlags_NoRendererClear) ? false : true;
    wd->CreateOrResize((int)viewport->Size.x, (int)viewport->Size.y);
    vd->WindowOwned = true;
}

static void ImGui_ImplVulkan_DestroyWindow(ImGuiViewport* viewport)
{
    // The main viewport (owned by the application) will always have RendererUserData == 0 since we didn't create the data for it.
    ImGui_ImplVulkan_ViewportData* vd = (ImGui_ImplVulkan_ViewportData*)viewport->RendererUserData;
    if (vd)
    {
        if (vd->WindowOwned)
            vd->Window.Destroy();
        vd->RenderBuffers.Destroy();
        IM_DELETE(vd);
    }
    viewport->RendererUserData = nullptr;
}

static void ImGui_ImplVulkan_SetWindowSize(ImGuiViewport* viewport, ImVec2 size)
{
    ImGui_ImplVulkan_ViewportData* vd = (ImGui_ImplVulkan_ViewportData*)viewport->RendererUserData;
    if (!vd) return;// This is nullptr for the main viewport (which is left to the user/app to handle)
        
    vd->Window.ClearEnable = (viewport->Flags & ImGuiViewportFlags_NoRendererClear) ? false : true;
    vd->Window.CreateOrResize((int)size.x, (int)size.y);
}

static void ImGui_ImplVulkan_RenderWindow(ImGuiViewport* viewport, void*)
{
    ImGui_ImplVulkan_ViewportData* vd = (ImGui_ImplVulkan_ViewportData*)viewport->RendererUserData;
    ImGui_ImplVulkanH_Window* wd = &vd->Window;

    ImGui_ImplVulkanH_Frame* fd = &wd->Frames[wd->FrameIndex];
    ImGui_ImplVulkanH_FrameSemaphores* fsd = &wd->FrameSemaphores[wd->SemaphoreIndex];

    auto err = wd->Swapchain.AcquireNextImage(wd->swapchainImageIndex, fsd->ImageAcquiredSemaphore);
    fd = &wd->Frames[wd->swapchainImageIndex];
    fd->Fence.Wait();
    fd->Fence.Reset();

    if (err == VK_ERROR_OUT_OF_DATE_KHR)
        return;

    wd->ClearValue.color = { 0.f, 0.f, 0.f, 1.f };
    vkResetCommandBuffer(fd->CommandBuffer, 0);
    {
        VkRenderPassBeginInfo info = { VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO };
        info.renderPass = wd->Swapchain.RenderPass;
        info.framebuffer = wd->Swapchain.Framebuffers[wd->swapchainImageIndex];
        info.renderArea.extent.width = wd->Width;
        info.renderArea.extent.height = wd->Height;
        if (wd->ClearEnable)
        {
            info.clearValueCount = 1;
            info.pClearValues = &wd->ClearValue;
        }

        ImGui_ImplVulkan_RenderDrawData(viewport->DrawData, fd->CommandBuffer, info);
    }

    vk::SyncContext::Submit(fd->CommandBuffer, vk::SyncContext::GetGraphicsQueue(), VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT, fd->Fence);
}

static void ImGui_ImplVulkan_SwapBuffers(ImGuiViewport* viewport, void*)
{
    ImGui_ImplVulkan_ViewportData* vd = (ImGui_ImplVulkan_ViewportData*)viewport->RendererUserData;
    ImGui_ImplVulkanH_Window* wd = &vd->Window;

    ImGui_ImplVulkanH_FrameSemaphores* fsd = &wd->FrameSemaphores[wd->SemaphoreIndex];
    auto err = wd->Swapchain.Present(wd->swapchainImageIndex, fsd->RenderCompleteSemaphore);
    if (err == VK_ERROR_OUT_OF_DATE_KHR || err == VK_SUBOPTIMAL_KHR)
        vd->Window.CreateOrResize((int)viewport->Size.x, (int)viewport->Size.y);

    wd->FrameIndex = (wd->FrameIndex + 1) % wd->Frames.Count;
    wd->SemaphoreIndex = (wd->SemaphoreIndex + 1) % wd->FrameSemaphores.Count;
}

void ImGui_ImplVulkan_Init(VkRenderPass rp)
{
    ImGuiIO& io = ImGui::GetIO();

    // Setup backend capabilities flags
    ImGui_ImplVulkan_Data* bd = IM_NEW(ImGui_ImplVulkan_Data)();
    io.BackendRendererUserData = (void*)bd;
    io.BackendRendererName = "imgui_impl_vulkan";
    io.BackendFlags |= ImGuiBackendFlags_RendererHasVtxOffset;  // We can honor the ImDrawCmd::VtxOffset field, allowing for large meshes.
    io.BackendFlags |= ImGuiBackendFlags_RendererHasViewports;  // We can create multi-viewports on the Renderer side (optional)

    bd->RenderPass = rp;

	// Bilinear sampling is required by default. Set 'io.Fonts->Flags |= ImFontAtlasFlags_NoBakedLines' or 'style.AntiAliasedLinesUseTex = false' to allow point/nearest sampling.
	wc::ShaderCreateInfo createInfo;
	createInfo.frontFace = VK_FRONT_FACE_COUNTER_CLOCKWISE;
	wc::ReadBinary("assets/shaders/imgui.vert", createInfo.binaries[0]);
	wc::ReadBinary("assets/shaders/imgui.frag", createInfo.binaries[1]);
    auto blending = wc::CreateBlendAttachment();
    blending.srcAlphaBlendFactor = VK_BLEND_FACTOR_ONE;
    createInfo.blendAttachments.push_back(blending);
	createInfo.renderPass = bd->RenderPass;
	VkDynamicState dynamic_states[2] = { VK_DYNAMIC_STATE_VIEWPORT, VK_DYNAMIC_STATE_SCISSOR };
	createInfo.dynamicStateCount = std::size(dynamic_states);
	createInfo.dynamicState = dynamic_states;

	bd->Shader.Create(createInfo);

    // Our render function expect RendererUserData to be storing the window render buffer we need (for the main viewport we won't use ->Window)
    ImGui::GetMainViewport()->RendererUserData = IM_NEW(ImGui_ImplVulkan_ViewportData)();

    if (io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
    {
		ImGuiPlatformIO& platform_io = ImGui::GetPlatformIO();
		platform_io.Renderer_CreateWindow = ImGui_ImplVulkan_CreateWindow;
		platform_io.Renderer_DestroyWindow = ImGui_ImplVulkan_DestroyWindow;
		platform_io.Renderer_SetWindowSize = ImGui_ImplVulkan_SetWindowSize;
		platform_io.Renderer_RenderWindow = ImGui_ImplVulkan_RenderWindow;
		platform_io.Renderer_SwapBuffers = ImGui_ImplVulkan_SwapBuffers;
    }
}

void ImGui_ImplVulkan_Shutdown()
{
    ImGui_ImplVulkan_Data* bd = ImGui_ImplVulkan_GetBackendData();

    // First destroy objects in all viewports
    ImGuiPlatformIO& platform_io = ImGui::GetPlatformIO();
    for (int n = 0; n < platform_io.Viewports.Size; n++)
        if (ImGui_ImplVulkan_ViewportData* vd = (ImGui_ImplVulkan_ViewportData*)platform_io.Viewports[n]->RendererUserData)
            vd->RenderBuffers.Destroy();

    ImGui_ImplVulkan_DestroyFontsTexture();

    bd->Shader.Destroy();

    // Manually delete main viewport render data in-case we haven't initialized for viewports
    ImGuiViewport* main_viewport = ImGui::GetMainViewport();
    if (ImGui_ImplVulkan_ViewportData* vd = (ImGui_ImplVulkan_ViewportData*)main_viewport->RendererUserData)
        IM_DELETE(vd);
    main_viewport->RendererUserData = nullptr;

    // Clean up windows    
    ImGui::DestroyPlatformWindows();

    ImGuiIO& io = ImGui::GetIO();
    io.BackendRendererName = nullptr;
    io.BackendRendererUserData = nullptr;
    io.BackendFlags &= ~(ImGuiBackendFlags_RendererHasVtxOffset | ImGuiBackendFlags_RendererHasViewports);
    IM_DELETE(bd);
}
//-----------------------------------------------------------------------------

#endif // #ifndef IMGUI_DISABLE
