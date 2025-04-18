#pragma warning(push)
#pragma warning(disable : 4702) // Disable unreachable code
//#define GLM_FORCE_PURE
//#define GLM_FORCE_INTRINSICS 

#include "magic_enum.hpp"
#include "filesystem"

#include "imgui_backend/imgui_impl_glfw.h"
#include "imgui_backend/imgui_impl_vulkan.h"
#include "Globals.h"

#include "Editor/Editor.h"

using namespace wc;

vk::Swapchain swapchain;

void Resize()
{
	auto size = Globals.window.GetFramebufferSize();
	if (size.x == 0 || size.y == 0)
		return;

	VulkanContext::GetLogicalDevice().WaitIdle();
	swapchain.Destroy();
	swapchain.Create(Globals.window);

	// Resize renderers
	ResizeEditor(Globals.window.GetSize());
	Globals.window.resized = false;
}

//----------------------------------------------------------------------------------------------------------------------
bool InitApp()
{
	WindowCreateInfo windowInfo =
	{
		.Width = 1280,
		.Height = 720,
		.Name = "Editor",
		.StartMode = WindowMode::Maximized,
		.VSync = false,
		.Resizeable = true,
	};
	Globals.window.Create(windowInfo);
	Globals.window.SetFramebufferResizeCallback([](GLFWwindow* window, int w, int h)
		{
			reinterpret_cast<wc::Window*>(glfwGetWindowUserPointer(window))->resized = true;
		});
	swapchain.Create(Globals.window);

	vk::SyncContext::Create();

	vk::descriptorAllocator.Create();

	ImGui::CreateContext();

	ImGuiIO& io = ImGui::GetIO();
	io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;
	io.IniFilename = "imgui.ini";
	//io.ConfigFlags |= ImGuiConfigFlags_ViewportsEnable;

	ImGui_ImplGlfw_InitForVulkan(Globals.window, false);

	ImGui_ImplVulkan_Init(swapchain.RenderPass);
	ImGui_ImplVulkan_CreateFontsTexture();
		
	InitEditor();

	return true;
}

//----------------------------------------------------------------------------------------------------------------------
void UpdateApp()
{
	//auto r = 
	vk::SyncContext::GetRenderFence().Wait();

	//WC_CORE_INFO("Acquire result: {}, {}", magic_enum::enum_name(r), (int)r);

	Globals.UpdateTime();
	UpdateEditor();

	//auto extent = Globals.window.GetExtent();

	//if (extent.width > 0 && extent.height > 0)
	{
		uint32_t swapchainImageIndex = 0;

		VkResult result = swapchain.AcquireNextImage(swapchainImageIndex, vk::SyncContext::GetImageAvaibleSemaphore());

		if (result == VK_ERROR_OUT_OF_DATE_KHR)
		{
			Resize();
			return;
		}
		if (result != VK_SUCCESS && result != VK_SUBOPTIMAL_KHR)
		{
			WC_CORE_ERROR("Acquire result: {}, {}", magic_enum::enum_name(result), (int)result);
		}
		vk::SyncContext::GetRenderFence().Reset(); // deadlock fix


		ImGui_ImplGlfw_NewFrame();
		ImGui::NewFrame();
		//ImGuizmo::BeginFrame();

		UIEditor();

		ImGui::Render();

		auto& cmd = vk::SyncContext::GetMainCommandBuffer();
		vkResetCommandBuffer(cmd, 0);

		//editor.Render();

		if (ImGui::GetIO().ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
		{
			ImGui::UpdatePlatformWindows();
			ImGui::RenderPlatformWindowsDefault();
		}


		VkClearValue clearValue = {
			.color = { 0.f, 0.f, 0.f, 0.f },
		};

		VkRenderPassBeginInfo rpInfo = {
			.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO,

			.renderPass = swapchain.RenderPass,
			.framebuffer = swapchain.Framebuffers[swapchainImageIndex],
			.renderArea.extent = swapchain.extent,
			.clearValueCount = 1,
			.pClearValues = &clearValue,
		};

		ImGui_ImplVulkan_RenderDrawData(ImGui::GetDrawData(), cmd, rpInfo);

		VkPipelineStageFlags waitStage[] = { VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT, VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT };
		vk::Semaphore waitSemaphores[] = { vk::SyncContext::GetImageAvaibleSemaphore(), vk::SyncContext::m_TimelineSemaphore, };
		uint64_t waitValues[] = { 0, vk::SyncContext::m_TimelineValue }; // @NOTE: Apparently the timeline semaphore should be waiting last?
		VkTimelineSemaphoreSubmitInfo timelineInfo = {
			.sType = VK_STRUCTURE_TYPE_TIMELINE_SEMAPHORE_SUBMIT_INFO,
			.waitSemaphoreValueCount = std::size(waitValues),
			.pWaitSemaphoreValues = waitValues,
		};

		VkSubmitInfo submit = {
			.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO,
			.pNext = &timelineInfo,
			.commandBufferCount = 1,
			.pCommandBuffers = &cmd,

			.pWaitDstStageMask = waitStage,

			.waitSemaphoreCount = std::size(waitSemaphores),
			.pWaitSemaphores = (VkSemaphore*)waitSemaphores,

			.signalSemaphoreCount = 1,
			.pSignalSemaphores = &vk::SyncContext::GetPresentSemaphore(),
		};

		vk::SyncContext::GetGraphicsQueue().Submit(submit, vk::SyncContext::GetRenderFence());

		VkPresentInfoKHR presentInfo = {
			.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR,
			.waitSemaphoreCount = 1,
			.pWaitSemaphores = &vk::SyncContext::GetPresentSemaphore(),

			.swapchainCount = 1,
			.pSwapchains = &swapchain,

			.pImageIndices = &swapchainImageIndex,
		};

		VkResult presentationResult = vkQueuePresentKHR(vk::SyncContext::GetPresentQueue(), &presentInfo);

		if (presentationResult == VK_ERROR_OUT_OF_DATE_KHR || presentationResult == VK_SUBOPTIMAL_KHR || Globals.window.resized)
		{
			Resize();
		}
		else if (presentationResult != VK_SUCCESS)
		{
			WC_CORE_ERROR("Presentation result: {}, code: {}", magic_enum::enum_name(presentationResult), (int)presentationResult);
		}

		vk::SyncContext::UpdateFrame();
	}
}

//----------------------------------------------------------------------------------------------------------------------
void UpdateAppFrame()
{
	while (Globals.window.IsOpen())
	{
		Globals.window.PoolEvents();

		if (Globals.window.HasFocus()) InputEditor();

		UpdateApp();
	}
}

//----------------------------------------------------------------------------------------------------------------------
void DeinitApp()
{
	VulkanContext::GetLogicalDevice().WaitIdle();
	glfwWaitEvents();

	Globals.window.Destroy();
	swapchain.Destroy();
	ImGui_ImplVulkan_Shutdown();
	ImGui_ImplGlfw_Shutdown();
	ImGui::DestroyContext();

	vk::descriptorAllocator.Destroy();
	DestroyEditor();

	vk::SyncContext::Destroy();
}

int main()
{
	InitLog();

	std::filesystem::current_path("../../../../Path tracer/workdir");

	glfwSetErrorCallback([](int err, const char* description) { WC_CORE_ERROR(description); /*WC_DEBUGBREAK();*/ });
	//glfwSetMonitorCallback([](GLFWmonitor* monitor, int event)
	//	{
	//		if (event == GLFW_CONNECTED)
	//		else if (event == GLFW_DISCONNECTED)
	//	});
	if (!glfwInit())
		return 1;

	if (VulkanContext::Create())
	{
		glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);

		if (InitApp())
			UpdateAppFrame();

		DeinitApp();

		VulkanContext::Destroy();
	}

	glfwTerminate();

	return 0;
}