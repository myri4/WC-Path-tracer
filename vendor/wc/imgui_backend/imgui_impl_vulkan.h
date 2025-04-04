#pragma once
#ifndef IMGUI_DISABLE
#include "imgui/imgui.h"      // IMGUI_IMPL_API

// Vulkan includes
#include "../Memory/Buffer.h"

#include "../Rendering/vk/Buffer.h"
#include "../Rendering/vk/Commands.h"
#include "../Rendering/vk/Image.h"
#include "../Rendering/vk/SyncContext.h"
#include "../Rendering/Descriptors.h"
#include "../Rendering/Shader.h"
#include "../Rendering/Swapchain.h"

// Called by user code
void         ImGui_ImplVulkan_Init(VkRenderPass rp);
void         ImGui_ImplVulkan_Shutdown();
void         ImGui_ImplVulkan_RenderDrawData(ImDrawData* draw_data, VkCommandBuffer cmd, VkRenderPassBeginInfo rpInfo);
bool         ImGui_ImplVulkan_CreateFontsTexture();
void         ImGui_ImplVulkan_DestroyFontsTexture();

VkDescriptorSet MakeImGuiDescriptor(VkDescriptorSet dSet, const VkDescriptorImageInfo& imageInfo);

#endif // #ifndef IMGUI_DISABLE
