#pragma once
#define LEVEL_EDITOR_TILES

#include <format>

// Filesystem
#include <wc/Utils/FileDialogs.h>

#include "CommandParser.h"
#include "Globals.h"
#include "UI/Widgets.h"
//#include <imgui/ImGuizmo.h>

#include <wc/Rendering/Texture.h>

// Shader compilation
#include <shaderc/shaderc.hpp>

#include "Scene.h"

namespace wc
{
	struct EditorInstance
	{
		// Window managing
		bool SettingsEnabled = true;
		bool DebugStats = true;

		Scene scene;

		enum class SelectType { UNKNOWN, Object, Material };

		int32_t m_SelectedID = -1;
		SelectType m_SelectedType = SelectType::UNKNOWN;

		void Select(int32_t id = -1, SelectType type = SelectType::UNKNOWN)
		{
			m_SelectedID = id;
			m_SelectedType = type;
		}

		glm::vec2 RenderSize;
		glm::vec2 WindowPos;

		glm::vec2 ViewPortSize = glm::vec2(1.f);

		bool ResizeViewPort = false;
		bool ViewPortFocused = true;

		Texture texture;

		void LoadAssets()
		{
			texture.Allocate(ViewPortSize.x, ViewPortSize.y);
			scene.image.Allocate(ViewPortSize.x, ViewPortSize.y, 4);
		}

		void Create(glm::vec2 renderSize)
		{
			LoadAssets();

			auto Ground = scene.PushMaterial();
			scene.Materials[Ground].SetLambertian(glm::vec3(0.8, 0.8, 0.0));

			auto Center = scene.PushMaterial();
			scene.Materials[Center].SetLambertian(glm::vec3(0.7, 0.3, 0.3));

			auto Left = scene.PushMaterial();
			scene.Materials[Left].SetDiffuseLight(glm::vec3(0.8, 0.8, 0.8) * 2.f);

			auto Right = scene.PushMaterial();
			scene.Materials[Right].SetMetal(glm::vec3(0.8, 0.6, 0.2), 0.75f, 0.02f);

			auto glass = scene.PushMaterial();
			scene.Materials[glass].SetDielectric(glm::vec3(0.f, 0.5f, 05.f), 0.07f, 1.5f);

			scene.Spheres.push_back(Sphere(glm::vec3(0.0, 0.0, -1.0), 0.5, glass));
			scene.Spheres.push_back(Sphere(glm::vec3(-1.0, 0.0, -1.0), 0.5, Left));
			scene.Spheres.push_back(Sphere(glm::vec3(1.0, 0.0, -1.0), 0.5, Right));
			scene.Spheres.push_back(Sphere(glm::vec3(0.f, -100.5f, -1.f), 100.f, Ground));
		}

		void Destroy()
		{
			texture.Destroy();
		}

		void Input()
		{
			if (ResizeViewPort)
			{
				Resize(ViewPortSize);
				ResizeViewPort = false;
			}

			if (ViewPortFocused)
			{
				auto& deltaTime = Globals.deltaTime;
				// Input Goes here
			}
		}

		void Resize(glm::vec2 newSize)
		{
			texture.Destroy();
			scene.image.Free();

			texture.Allocate(newSize.x, newSize.y);
			scene.image.Allocate(ViewPortSize.x, ViewPortSize.y, 4);

			texture.MakeRenderable();
		}

		void Update()
		{

		}

		void UI()
		{
			const ImGuiViewport* viewport = ImGui::GetMainViewport();
			ImGui::SetNextWindowPos(viewport->WorkPos);
			ImGui::SetNextWindowSize(viewport->WorkSize);
			ImGui::SetNextWindowViewport(viewport->ID);
			ImGui::PushStyleVar(ImGuiStyleVar_WindowRounding, 0.f);
			ImGui::PushStyleVar(ImGuiStyleVar_WindowBorderSize, 0.f);

			ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.0f, 0.0f));
			ImGui::Begin("DockSpace", nullptr, ImGuiWindowFlags_MenuBar | ImGuiWindowFlags_NoDocking
				| ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove
				| ImGuiWindowFlags_NoBringToFrontOnFocus | ImGuiWindowFlags_NoNavFocus);
			ImGui::PopStyleVar();

			ImGui::PopStyleVar(2);

			ImGuiIO& io = ImGui::GetIO();
			if (io.ConfigFlags & ImGuiConfigFlags_DockingEnable)
			{
				ImGuiID dockspace_id = ImGui::GetID("MainDockSpace");
				ImGui::DockSpace(dockspace_id, ImVec2(0.f, 0.f));
			}

			if (ImGui::BeginMenuBar())
			{
				if (ImGui::BeginMenu("Settings"))
				{
					if (ImGui::MenuItem("Show settings window")) SettingsEnabled = true;

					UI::Separator("Utility");
					//UI::Checkbox("Load last level", LoadLastLevel);

					ImGui::EndMenu();
				}

				UI::Separator();
				//UI::Text(LevelPath);

			}
			ImGui::EndMenuBar();

			if (DebugStats) UI_DebugStats();
			if (SettingsEnabled) UI_Settings();
			UI_Console();
			UI_Objects();
			UI_Materials();
			UI_Properties();
			UI_Scene();

			ImGui::End();
		}

	private:

		void UI_Scene()
		{
			ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(0.f, 0.f));
			ImGui::Begin("Scene", nullptr, ImGuiWindowFlags_MenuBar | ImGuiWindowFlags_NoBackground);

			ViewPortFocused = ImGui::IsWindowFocused();
			ImVec2 viewPortSize = ImGui::GetContentRegionAvail();
			if (ViewPortSize != *((glm::vec2*)&viewPortSize))
			{
				ViewPortSize = { viewPortSize.x, viewPortSize.y };

				ResizeViewPort = true;
			}

			auto viewportMinRegion = ImGui::GetWindowContentRegionMin();
			auto viewportMaxRegion = ImGui::GetWindowContentRegionMax();
			auto viewportOffset = ImGui::GetWindowPos();
			ImVec2 viewportBounds[2];
			viewportBounds[0] = { viewportMinRegion.x + viewportOffset.x, viewportMinRegion.y + viewportOffset.y };
			viewportBounds[1] = { viewportMaxRegion.x + viewportOffset.x, viewportMaxRegion.y + viewportOffset.y };

			WindowPos = *((glm::vec2*)&viewportBounds[0]);
			RenderSize = *((glm::vec2*)&viewportBounds[1]) - WindowPos;

			//if (!m_ShouldReload)
			//{
				auto image = texture;
			//	if (m_PathTracing) image = m_PathRenderer.GetRenderImageID();
				ImGui::Image(image, viewPortSize);
			//}
			//else
			//{
			//	VulkanContext::GetLogicalDevice().WaitIdle();
			//	Resize(m_Renderer.GetRenderSize());
			//	m_ShouldReload = false;
			//}

			if (ImGui::BeginMenuBar())
			{
				if (ImGui::Button("Render"))
				{
					scene.Render();

					texture.SetData(scene.image.Data, texture.image.width, texture.image.height);
				}
			}
			ImGui::EndMenuBar();

			ImGui::End();
			ImGui::PopStyleVar();
		}

		std::string ConsoleBuffer;
		void UI_Console()
		{
			bool m_ConsoleAutoScroll = true;
			ImGui::Begin("Console", nullptr, ImGuiWindowFlags_MenuBar);

			if (ImGui::BeginMenuBar())
			{
				if (ImGui::BeginMenu("Options"))
				{
					UI::Checkbox("Auto-scroll", m_ConsoleAutoScroll);
					ImGui::EndMenu();
				}
				UI::Separator();
				if (ImGui::Button("Clear"))
					Log::GetConsoleSink()->messages.clear();

			}
			ImGui::EndMenuBar();

			ImGui::Separator();
			const float footer_height_to_reserve = ImGui::GetStyle().ItemSpacing.y + ImGui::GetFrameHeightWithSpacing();
			if (ImGui::BeginChild("ScrollingRegion", ImVec2(0, -footer_height_to_reserve), ImGuiChildFlags_None, ImGuiWindowFlags_HorizontalScrollbar))
			{
				for (auto& msg : Log::GetConsoleSink()->messages)
				{
					glm::vec4 color = glm::vec4(0.f);
					if (msg.level == spdlog::level::debug) color = glm::vec4(58.f, 150.f, 221.f, 255.f) / 255.f;
					else if (msg.level == spdlog::level::info) color = glm::vec4(19.f, 161.f, 14.f, 255.f) / 255.f;
					else if (msg.level == spdlog::level::warn) color = glm::vec4(249.f, 241.f, 165.f, 255.f) / 255.f;
					else if (msg.level == spdlog::level::err) color = glm::vec4(231.f, 72.f, 86.f, 255.f) / 255.f;
					else if (msg.level == spdlog::level::critical) color = glm::vec4(139.f, 0.f, 0.f, 255.f) / 255.f;
					ImGui::PushStyleColor(ImGuiCol_Text, { color.r, color.g, color.b, color.a });
					UI::Text(msg.payload);
					ImGui::PopStyleColor();
				}

				if (/*ScrollToBottom ||*/
					(m_ConsoleAutoScroll && ImGui::GetScrollY() >= ImGui::GetScrollMaxY()))
					ImGui::SetScrollHereY(1.f);
			}
			ImGui::EndChild();

			bool reclaim_focus = false;
			ImGuiInputTextFlags input_text_flags = ImGuiInputTextFlags_EnterReturnsTrue | ImGuiInputTextFlags_EscapeClearsAll | ImGuiInputTextFlags_CallbackHistory;
			if (ImGui::InputText("##Commandline", &ConsoleBuffer, input_text_flags))
			{
				if (ConsoleBuffer.size() > 0)
				{
					CommandParser parser;
					auto cmdType = parser.Parse(ConsoleBuffer);

					switch (cmdType)
					{
					case wc::CommandType::UNKNOWN:
					{
						WC_ERROR("Unknown command: {}", ConsoleBuffer);
					}
					break;
					case wc::CommandType::recompile:
					{
						//shaderc::Compiler compiler;
						//shaderc::CompileOptions opts;
						//opts.SetForcedVersionProfile(450, shaderc_profile_core);
						//opts.SetTargetEnvironment(shaderc_target_env_vulkan, shaderc_env_version_vulkan_1_2);
						//opts.SetOptimizationLevel(shaderc_optimization_level_performance);
						//const char* path = "hello";
						//auto module = compiler.CompileGlslToSpv(std::string(""), (shaderc_shader_kind)0, path, opts);
					}
					break;
					default:
						break;
					}

					ConsoleBuffer.clear();
					reclaim_focus = true;
				}
			}

			// Auto-focus on window apparition
			ImGui::SetItemDefaultFocus();
			if (reclaim_focus)
				ImGui::SetKeyboardFocusHere(-1); // Auto focus previous widget

			ImGui::End();
		}

		void UI_Objects()
		{
			ImGui::Begin("Spheres");

			for (uint32_t i = 0; i < scene.Spheres.size(); i++)
			{
				auto& sphere = scene.Spheres[i];

				std::string buttonName = std::format("Sphere {}", i);
				if (ImGui::Button(buttonName.c_str())) Select(i, SelectType::Object);

				ImGui::OpenPopupOnItemClick(buttonName.c_str(), ImGuiPopupFlags_MouseButtonRight);
				if (ImGui::BeginPopupContextItem(buttonName.c_str()))
				{
					if (ImGui::MenuItem("Delete"))
					{
						scene.Spheres.erase(scene.Spheres.begin() + i);
						ImGui::CloseCurrentPopup();
					}

					ImGui::EndPopup();
				}
			}


			if (ImGui::BeginPopupContextWindow("NewObject", ImGuiPopupFlags_MouseButtonRight | ImGuiPopupFlags_NoOpenOverItems))
			{
				if (ImGui::MenuItem("Sphere")) 
				{ 
					scene.Spheres.push_back(Sphere()); 
					ImGui::CloseCurrentPopup(); 
				}
				ImGui::EndPopup();
			}

			ImGui::End();
		}

		void UI_Materials()
		{
			ImGui::Begin("Materials");

			for (uint32_t i = 0; i < scene.Materials.size(); i++)
			{
				std::string buttonName = std::format("Material {}", i);
				if (ImGui::Button(buttonName.c_str())) Select(i, SelectType::Material);

				ImGui::OpenPopupOnItemClick(buttonName.c_str(), ImGuiPopupFlags_MouseButtonRight);
				if (ImGui::BeginPopupContextItem(buttonName.c_str()))
				{
					if (ImGui::MenuItem("Delete"))
					{
						scene.Materials.erase(scene.Materials.begin() + i);
						ImGui::CloseCurrentPopup();
					}

					ImGui::EndPopup();
				}
			}


			if (ImGui::BeginPopupContextWindow("NewObject", ImGuiPopupFlags_MouseButtonRight | ImGuiPopupFlags_NoOpenOverItems))
			{
				if (ImGui::MenuItem("New material"))
				{
					scene.PushMaterial();
					ImGui::CloseCurrentPopup();
				}
				ImGui::EndPopup();
			}

			ImGui::End();
		}

		void UI_DebugStats()
		{
			if (ImGui::Begin("Debug Stats", &DebugStats))
			{
				UI::Separator("Performance stats");
				UI::Text(std::format("FPS: {} ", 1.f / Globals.deltaTime));
				UI::Text(std::format("Frame time: {} ", Globals.deltaTime));
				UI::Separator("Renderer statistics");
				//auto size = m_Renderer.GetRenderSize();
				//UI::Text(std::format("Render size: {} : {}", size.x, size.y));
				UI::Separator("Camera");
				UI::Text(std::format("Position: {} {} {}", scene.camera.Position.x, scene.camera.Position.y, scene.camera.Position.z));
				//UI::Text(std::format("Rotation: {}", camera.Rotation));
				//UI::Text(std::format("Zoom: {}", camera.Zoom));

				ImGui::End();
			}
		}

		void UI_Properties()
		{
			ImGui::Begin("Properties");

			if (m_SelectedID != -1)
			{
				if (m_SelectedType == SelectType::Object)
				{
					auto& sphere = scene.Spheres[m_SelectedID];
					UI::Drag3("Position", glm::value_ptr(sphere.Position));
					UI::Drag("Radius", sphere.Radius);
				}
				else if (m_SelectedType == SelectType::Material)
				{
					auto& material = scene.Materials[m_SelectedID];
					ImGui::ColorEdit3("Albedo", glm::value_ptr(material.albedo));
					ImGui::ColorEdit3("Emission", glm::value_ptr(material.emission));

					UI::Drag("Roughness", material.roughness);
					UI::Drag("Index of refraction", material.ior);
					UI::Drag("Specular probability", material.specularProbability);
				}
			}

			ImGui::End();
		}

		void UI_Settings()
		{
			if (ImGui::Begin("Settings", &SettingsEnabled))
			{

				if (ImGui::CollapsingHeader("Rendering"))
				{
					UI::Drag("Samples", scene.Samples);
					UI::Drag("Max bounces", scene.Depth);
				}

				if (ImGui::CollapsingHeader("Utility"))
				{
				}

				ImGui::End();
			}
		}
	};
}