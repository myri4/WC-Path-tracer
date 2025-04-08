#include "fstream"
#include "filesystem"

#include "Editor.h"

#include "../Globals.h"

#include "../UI/Widgets.h"
// #include "../Rendering/Renderer2D.h"
#include "../Rendering/Texture.h"

#include "../Utils/List.h"
#include "../Utils/FileDialogs.h"

#include "../Renderers/PathTracingRenderer.h"

using namespace wc;

// Debug stats
float DebugTimer = 0.f;

uint32_t PrevMaxFPS = 0;
uint32_t MaxFPS = 0;

uint32_t PrevMinFPS = 0;
uint32_t MinFPS = 0;

uint32_t FrameCount = 0;
uint32_t FrameCounter = 0;
uint32_t PrevFrameCounter = 0;

glm::vec2 WindowPos;
glm::vec2 RenderSize;

glm::vec2 ViewPortSize = glm::vec2(1.f);

PathTracingRenderer PathTracer;

// Window Buttons
Texture t_Close;
Texture t_Minimize;
Texture t_Maximize;
Texture t_Collapse;

// Assets
Texture t_FolderOpen;
Texture t_FolderClosed;
Texture t_File;

// Scene Editor Buttons
Texture t_Play;
Texture t_Simulate;
Texture t_Stop;

// Entities
Texture t_Eye;
Texture t_EyeClosed;

// Console
Texture t_Debug;
Texture t_Info;
Texture t_Warning;
Texture t_Error;
Texture t_Critical;

bool allowInput = true;

bool showEditor = true;
bool showSceneProperties = true;
bool showEntities = true;
bool showProperties = true;
bool showConsole = true;
bool showAssets = true;
bool showDebugStats = false;
bool showStyleEditor = false;

void SaveStringToFile(const std::filesystem::path& filePath, const std::string& content)
{
	std::ofstream file(filePath);
	file << content;
}

void InitEditor()
{
	ImGuiStyle& style = ImGui::GetStyle();
	style = UI::SoDark(0.0f);

	PathTracer.Init();
	PathTracer.CreateScreen({ Globals.window.GetSize().x, Globals.window.GetSize().y });

	/*assetManager.Init();

	// Load Textures
	std::string assetPath = "assets/";
	std::string texturePath = assetPath + "textures/menu/";
	assetManager.LoadTexture(texturePath + "close.png", t_Close);
	assetManager.LoadTexture(texturePath + "minimize.png", t_Minimize);
	assetManager.LoadTexture(texturePath + "maximize.png", t_Maximize);
	assetManager.LoadTexture(texturePath + "collapse.png", t_Collapse);

	assetManager.LoadTexture(texturePath + "folder_open.png", t_FolderOpen);
	assetManager.LoadTexture(texturePath + "folder_closed.png", t_FolderClosed);
	assetManager.LoadTexture(texturePath + "file.png", t_File);

	assetManager.LoadTexture(texturePath + "play.png", t_Play);
	assetManager.LoadTexture(texturePath + "simulate.png", t_Simulate);
	assetManager.LoadTexture(texturePath + "stop.png", t_Stop);

	assetManager.LoadTexture(texturePath + "eye.png", t_Eye);
	assetManager.LoadTexture(texturePath + "eye_slash.png", t_EyeClosed);

	assetManager.LoadTexture(texturePath + "debug.png", t_Debug);
	assetManager.LoadTexture(texturePath + "info.png", t_Info);
	assetManager.LoadTexture(texturePath + "warning.png", t_Warning);
	assetManager.LoadTexture(texturePath + "error.png", t_Error);
	assetManager.LoadTexture(texturePath + "critical.png", t_Critical);*/
}

void ResizeEditor(glm::vec2 size)
{
	PathTracer.Resize(size);
}

void DestroyEditor()
{
	PathTracer.Deinit();
	/*assetManager.Free();
	m_Renderer.Deinit();*/
}

void InputEditor()
{
	if (allowInput)
	{

		/*if (Key::GetKey(Key::LeftAlt))
		{
			const glm::vec2& mouse = Globals.window.GetCursorPos();
			glm::vec2 delta = (mouse - camera.m_InitialMousePosition) * 0.01f;
			camera.m_InitialMousePosition = mouse;

			if (Mouse::GetMouse(Mouse::LEFT))
			{
				auto panSpeed = camera.PanSpeed(m_Renderer.m_RenderSize);
				camera.FocalPoint += -camera.GetRightDirection() * delta.x * panSpeed.x * camera.m_Distance;
				camera.FocalPoint += camera.GetUpDirection() * delta.y * panSpeed.y * camera.m_Distance;
			}
			else if (Mouse::GetMouse(Mouse::RIGHT))
			{
				float yawSign = camera.GetUpDirection().y < 0 ? -1.f : 1.f;
				camera.Yaw += yawSign * delta.x * camera.RotationSpeed;
				camera.Pitch += delta.y * camera.RotationSpeed;
			}

			camera.UpdateView();
		}

		float scroll = Mouse::GetMouseScroll().y;
		if (scroll != 0.f)
		{
			float delta = scroll * 0.1f;
			{
				camera.m_Distance -= delta * camera.ZoomSpeed();
				if (camera.m_Distance < 1.f)
				{
					camera.FocalPoint += camera.GetForwardDirection();
					camera.m_Distance = 1.f;
				}
			}
			camera.UpdateView();
		}*/
	}
}

void UpdateEditor() 
{
	PathTracer.Render();
}

void UI_Editor()
{
	ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.f, 0.f));

	if (ImGui::Begin("Editor", &showEditor))
	{
		allowInput = ImGui::IsWindowFocused() && ImGui::IsWindowHovered();

		ImVec2 viewPortSize = ImGui::GetContentRegionAvail();
		if (ViewPortSize != *((glm::vec2*)&viewPortSize))
		{
			ViewPortSize = { viewPortSize.x, viewPortSize.y };

			VulkanContext::GetLogicalDevice().WaitIdle();
			ResizeEditor(ViewPortSize);
		}

		/*if (!Key::GetKey(Key::LeftAlt) && Mouse::GetMouse(Mouse::LEFT) && allowInput)
		{
			auto mousePos = (glm::ivec2)(Mouse::GetCursorPosition() - (glm::uvec2)WindowPos);

			uint32_t width = m_Renderer.m_RenderSize.x;
			uint32_t height = m_Renderer.m_RenderSize.y;

			if (mousePos.x > 0 && mousePos.y > 0 && mousePos.x < width && mousePos.y < height)
			{
				VulkanContext::GetLogicalDevice().WaitIdle();
				vk::StagingBuffer stagingBuffer;
				stagingBuffer.Allocate(sizeof(uint64_t), VK_BUFFER_USAGE_TRANSFER_DST_BIT);
				vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
					auto image = m_Renderer.m_EntityImage;
					image.SetLayout(cmd, VK_IMAGE_ASPECT_COLOR_BIT, VK_IMAGE_LAYOUT_GENERAL, VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL);

					VkBufferImageCopy copyRegion = {
						.imageSubresource = {
							.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
							.layerCount = 1,
						},
						.imageExtent = { 1, 1, 1 },
						.imageOffset = { mousePos.x, mousePos.y, 0},
					};

					vkCmdCopyImageToBuffer(cmd, image, VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL, stagingBuffer, 1, &copyRegion);

					image.SetLayout(cmd, VK_IMAGE_ASPECT_COLOR_BIT, VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL, VK_IMAGE_LAYOUT_GENERAL);
					});

				auto imagedata = (uint64_t*)stagingBuffer.Map();
				auto id = imagedata[0];
				m_Scene.SelectedEntity = flecs::entity(m_Scene.m_Scene.EntityWorld, id);

				stagingBuffer.Unmap();
				stagingBuffer.Free();
			}
		}*/

		auto viewportOffset = ImGui::GetWindowPos();
		ImVec2 cursorPos = ImGui::GetCursorPos(); // Position relative to window's content area
		ImVec2 availSize = ImGui::GetContentRegionAvail(); // Available region size

		ImVec2 viewportBounds[2];
		// Calculate absolute screen position of the available region's start and end
		viewportBounds[0] = ImVec2(viewportOffset.x + cursorPos.x, viewportOffset.y + cursorPos.y);
		viewportBounds[1] = ImVec2(viewportBounds[0].x + availSize.x, viewportBounds[0].y + availSize.y);

		WindowPos = *((glm::vec2*)&viewportBounds[0]);
		glm::vec2 RenderSize = *((glm::vec2*)&viewportBounds[1]) - WindowPos;

		ImGui::GetWindowDrawList()->AddImage((ImTextureID)PathTracer.ImguiImageID, ImVec2(WindowPos.x, WindowPos.y), ImVec2(WindowPos.x + RenderSize.x, WindowPos.y + RenderSize.y));
	}
	ImGui::PopStyleVar();
	ImGui::End();
}

void UI_Entities()
{
	ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.f, 0.f));
	if (ImGui::Begin("Entities", &showEntities, ImGuiWindowFlags_MenuBar))
	{

	}
	ImGui::End();
}

void UI_Properties() {}

const std::unordered_map<spdlog::level::level_enum, std::pair<glm::vec4, std::string>> level_colors = { //@TODO: This could be deduced to just an array of colors
		{spdlog::level::trace,    {glm::vec4(0.f  , 184.f, 217.f, 255.f) / 255.f, "Debug"}}, // trace = debug
		{spdlog::level::info,     {glm::vec4(34.f , 197.f, 94.f , 255.f) / 255.f, "Info"}},
		{spdlog::level::warn,     {glm::vec4(255.f, 214.f, 102.f, 255.f) / 255.f, "Warn"}},
		{spdlog::level::err,      {glm::vec4(255.f, 86.f , 48.f , 255.f) / 255.f, "ERROR"}},
		{spdlog::level::critical, {glm::vec4(183.f, 29.f , 24.f , 255.f) / 255.f, "CRITICAL"}}
};

void UI_Console()
{
	ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.f, 0.f));
	if (ImGui::Begin("Console", &showConsole, ImGuiWindowFlags_MenuBar))
	{
		static bool scrollToBottom;

		static bool showDebug = true;
		static bool showInfo = true;
		static bool showWarn = true;
		static bool showError = true;
		static bool showCritical = true;

		ImGui::PopStyleVar();
		if (ImGui::BeginMenuBar())
		{
			if (ImGui::MenuItem("Clear"))
			{
				g_ConsoleSink->messages.clear();
			}

			if (ImGui::MenuItem("Copy"))
			{
				std::string logData;
				for (const auto& msg : g_ConsoleSink->messages)
				{
					auto local_time = msg.time + std::chrono::hours(2); // TODO - fix so it checks timezone
					std::string timeStr = std::format("[{:%H:%M:%S}] ", std::chrono::floor<std::chrono::seconds>(local_time));
					logData += timeStr + msg.payload + "\n"; // Assuming msg.payload is a string
				}
				ImGui::SetClipboardText(logData.c_str());
			}

			if (ImGui::BeginMenu("Show"))
			{
				ImGui::MenuItem("Debug", nullptr, &showDebug);
				ImGui::MenuItem("Info", nullptr, &showInfo);
				ImGui::MenuItem("Warning", nullptr, &showWarn);
				ImGui::MenuItem("Errors", nullptr, &showError);
				ImGui::MenuItem("Critical", nullptr, &showCritical);

				ImGui::EndMenu();
			}

			if (ImGui::BeginMenu("Settings"))
			{
				ImGui::MenuItem("Scroll To Bottom", nullptr, &scrollToBottom);

				ImGui::EndMenu();
			}

			ImGui::EndMenuBar();
		}
		ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.f, 0.f));

		ImGuiTableFlags window_flags = ImGuiTableFlags_Borders | ImGuiTableFlags_ScrollX | ImGuiTableFlags_ScrollY | ImGuiTableFlags_SizingFixedFit;
		if (!scrollToBottom) window_flags |= ImGuiTableFlags_RowBg;

		if (ImGui::BeginTable("ConsoleTable", 4, window_flags))
		{
			if (scrollToBottom)
				ImGui::SetScrollY(ImGui::GetScrollMaxY());

			ImGui::TableSetupScrollFreeze(3, 1); // Make top row always visible
			ImGui::TableSetupColumn("");
			ImGui::TableSetupColumn("Level");
			ImGui::TableSetupColumn("Time");
			ImGui::TableSetupColumn("Message");
			ImGui::TableHeadersRow();

			for (auto& msg : g_ConsoleSink->messages)
			{
				bool showMsg = true;
				switch (msg.level)
				{
				case spdlog::level::trace: showMsg = showDebug; break;
				case spdlog::level::info: showMsg = showInfo; break;
				case spdlog::level::warn: showMsg = showWarn; break;
				case spdlog::level::err: showMsg = showError; break;
				case spdlog::level::critical: showMsg = showCritical; break;
				}

				if (showMsg)
				{
					ImGui::TableNextRow();
					auto it = level_colors.find(msg.level);
					ImVec4 color;
					std::string prefix;
					std::string timeStr;
					Texture texture;
					if (it != level_colors.end())
					{
						color = conv::GlmToImVec4(it->second.first);
						prefix = it->second.second;
						auto local_time = msg.time + std::chrono::hours(2); // TODO - fix so it checks timezone
						timeStr = std::format("{:%H:%M:%S}", std::chrono::floor<std::chrono::seconds>(local_time));
						switch (msg.level)
						{
						case spdlog::level::trace: texture = t_Debug; break;
						case spdlog::level::info: texture = t_Info; break;
						case spdlog::level::warn: texture = t_Warning; break;
						case spdlog::level::err: texture = t_Error; break;
						case spdlog::level::critical: texture = t_Critical; break;
						default: texture = t_Info; break;
						}
					}

					//ImGui::PushFont(Globals.f_Default.Menu);
					ImGui::TableSetColumnIndex(0);
					ImGui::ImageWithBg(texture, { 20, 20 }, { 0, 0 }, { 1, 1 }, ImVec4(0, 0, 0, 0), color); ImGui::SameLine();
					/*ImGui::SetItemTooltip(prefix.c_str());*/

					ImGui::TableSetColumnIndex(1);
					ImGui::TextColored(color, prefix.c_str());

					ImGui::TableSetColumnIndex(2);
					ImGui::TextColored(color, timeStr.c_str());

					ImGui::TableSetColumnIndex(3);
					ImGui::TextColored(color, msg.payload.c_str());
					ImGui::PopFont();
				}

			}

			ImGui::EndTable();
		}
	}
	ImGui::End();
	ImGui::PopStyleVar();
}

void UI_DebugStats()
{
	if (ImGui::Begin("Debug Stats", &showDebugStats, ImGuiWindowFlags_NoBackground | ImGuiWindowFlags_AlwaysAutoResize))
	{
		// Draw background if docked, if not, only tint
		ImGuiDockNode* dockNode = ImGui::GetWindowDockNode();
		if (!dockNode) // Window is floating
		{
			ImGui::GetWindowDrawList()->AddRectFilled(ImGui::GetWindowPos(), { ImGui::GetWindowPos().x + ImGui::GetWindowSize().x, ImGui::GetWindowPos().y + ImGui::GetWindowSize().y }, IM_COL32(20, 20, 20, 60));
		}
		else // Window is docked
		{
			ImVec4 bgColor = ImGui::GetStyleColorVec4(ImGuiCol_WindowBg);
			ImGui::GetWindowDrawList()->AddRectFilled(ImGui::GetWindowPos(),
				{ ImGui::GetWindowPos().x + ImGui::GetWindowSize().x, ImGui::GetWindowPos().y + ImGui::GetWindowSize().y },
				ImGui::ColorConvertFloat4ToU32(bgColor));
		}

		uint32_t fps = 1.f / Globals.deltaTime;
		UI::Text(std::format("Frame time: {:.4f}ms", Globals.deltaTime * 1000.f));
		UI::Text(std::format("FPS: {}", fps));
		UI::Text(std::format("Max FPS: {}", PrevMaxFPS));
		UI::Text(std::format("Min FPS: {}", PrevMinFPS));
		UI::Text(std::format("Average FPS: {}", PrevFrameCounter));

		DebugTimer += Globals.deltaTime;

		MaxFPS = glm::max(MaxFPS, fps);
		MinFPS = glm::min(MinFPS, fps);

		FrameCount++;
		FrameCounter += fps;

		if (DebugTimer >= 1.f)
		{
			PrevMaxFPS = MaxFPS;
			PrevMinFPS = MinFPS;
			PrevFrameCounter = FrameCounter / FrameCount;
			DebugTimer = 0.f;

			FrameCount = 0;
			FrameCounter = 0;

			MaxFPS = MinFPS = fps;
		}
	}
	ImGui::End();
}

void UIEditor()
{
	const ImGuiViewport* viewport = ImGui::GetMainViewport();
	ImGui::SetNextWindowPos(viewport->WorkPos);
	ImGui::SetNextWindowSize(viewport->WorkSize);
	ImGui::SetNextWindowViewport(viewport->ID);

	ImGui::PushStyleVar(ImGuiStyleVar_WindowRounding, 0.f);
	ImGui::PushStyleVar(ImGuiStyleVar_WindowBorderSize, 0.f);

	static ImGuiWindowFlags windowFlags =
		ImGuiWindowFlags_MenuBar | ImGuiWindowFlags_NoDocking
		| ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse
		| ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove
		| ImGuiWindowFlags_NoBringToFrontOnFocus | ImGuiWindowFlags_NoNavFocus;
	if (ImGui::Begin("DockSpace", nullptr, windowFlags))
	{
		ImGui::PopStyleVar(2);
		//windowFlags |= ImGuiWindowFlags_NoBackground;

		ImGuiIO& io = ImGui::GetIO();
		if (io.ConfigFlags & ImGuiConfigFlags_DockingEnable)
		{
			ImGuiID dockspace_id = ImGui::GetID("MainDockSpace");
			ImGui::DockSpace(dockspace_id, ImVec2(0.f, 0.f));
		}

		if (ImGui::BeginMenuBar())
		{
			if (ImGui::BeginMenu("View"))
			{
				ImGui::MenuItem("Editor", nullptr, &showEditor);
				ImGui::MenuItem("Scene properties", nullptr, &showSceneProperties);
				ImGui::MenuItem("Entities", nullptr, &showEntities);
				ImGui::MenuItem("Properties", nullptr, &showProperties);
				ImGui::MenuItem("Console", nullptr, &showConsole);
				ImGui::MenuItem("Assets", nullptr, &showAssets);
				ImGui::MenuItem("Debug Statistics", nullptr, &showDebugStats);
				ImGui::MenuItem("Style Editor", nullptr, &showStyleEditor);

				ImGui::EndMenu();
			}

			ImGui::EndMenuBar();
		}

		if (showEditor) UI_Editor();
		//if (showSceneProperties) UI_SceneProperties();
		//if (showEntities) UI_Entities();
		if (showProperties) UI_Properties();
		if (showConsole) UI_Console();
		//if (showAssets) UI_Assets();
		if (showDebugStats) UI_DebugStats();
	}
	ImGui::End();
}