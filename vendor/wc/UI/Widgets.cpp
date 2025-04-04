#include "Widgets.h"

namespace wc
{
	namespace conv
	{
		glm::vec2 ImVec2ToGlm(const ImVec2& v) { return glm::vec2(v.x, v.y); }

		ImVec2 GlmToImVec2(const glm::vec2& v) {	return ImVec2(v.x, v.y); }

		glm::vec4 ImVec4ToGlm(const ImVec4& v) { return glm::vec4(v.x, v.y, v.z, v.w); }

		ImVec4 GlmToImVec4(const glm::vec4& v) { return ImVec4(v.x, v.y, v.z, v.w); }

		ImVec4 ImVec4Offset(const ImVec4& v, const float offset) { return ImVec4(v.x + offset, v.y + offset, v.z + offset, v.w + offset); }
	}

	namespace ui
	{
		//Center Window
		//if left on false, no need for ImGuiWindowFlags_NoMove
		void CenterNextWindow(bool once) { ImGui::SetNextWindowPos(ImGui::GetMainViewport()->GetCenter(), once ? ImGuiCond_Once : ImGuiCond_Always, ImVec2(0.5f, 0.5f)); }

		bool IsKeyPressedDissabled(ImGuiKey key) { return !(gui::GetCurrentContext()->CurrentItemFlags & ImGuiItemFlags_Disabled) && gui::IsKeyPressed(key); }

		std::string FileDialog(const char* name, const std::string& filter, const std::string& startPath, const bool limitToStart, const std::string& newFileFilter)
		{
			static std::filesystem::path currentPath;
			static std::vector<std::filesystem::path> disks;
			static std::string selectedPath;
			std::string finalPath;
			static std::vector<std::filesystem::directory_entry> fileEntries;

			CenterNextWindow();
			if (ImGui::BeginPopupModal(name, nullptr, ImGuiWindowFlags_NoSavedSettings))
			{
				// Initialize disks
				if (disks.empty())
				{
					for (char drive = 'A'; drive <= 'Z'; ++drive)
					{
						std::filesystem::path drive_path = std::string(1, drive) + ":\\";
						std::error_code ec;
						if (std::filesystem::exists(drive_path, ec))
						{
							disks.push_back(drive_path);
						}
					}

					if (startPath.empty()) currentPath = disks[0];
					else currentPath = startPath;
				}

				// Navigation controls
				ImGui::BeginDisabled(currentPath == currentPath.root_path() || (limitToStart ? currentPath == startPath : false));
				if (ImGui::ArrowButton("##back", ImGuiDir_Left))
				{
					if (currentPath.has_parent_path())
						currentPath = currentPath.parent_path();
					else
						currentPath = currentPath.root_path();
					fileEntries.clear();
				}
				ImGui::EndDisabled();

				ImGui::SameLine();
				float comboWidth = std::max(ImGui::CalcTextSize(currentPath.string().c_str()).x + 50, 300.0f);
				ImGui::SetWindowSize(ImVec2(ImGui::GetItemRectSize().x + comboWidth + ImGui::CalcTextSize("Refresh").x + ImGui::GetStyle().FramePadding.x * 4 + ImGui::GetStyle().ItemSpacing.x * 3, 0));
				ImGui::PushItemWidth(ImGui::GetContentRegionAvail().x - ImGui::GetStyle().ItemSpacing.x - ImGui::CalcTextSize("Refresh").x - ImGui::GetStyle().FramePadding.x * 2);
				if (ImGui::BeginCombo("##disks", currentPath.string().c_str()))
				{
					for (const auto& disk : disks)
					{
						if (ImGui::Selectable(disk.string().c_str()))
						{
							currentPath = disk;
							fileEntries.clear();
						}
					}
					ImGui::EndCombo();
				}

				// Refresh button
				ImGui::SameLine();
				if (ImGui::Button("Refresh"))
				{
					fileEntries.clear();
					std::error_code ec;
					std::filesystem::directory_iterator(currentPath, ec); // Force refresh
				}

				// File list
				if (ImGui::BeginChild("##file_list", ImVec2(0, 300.0f), true))
				{
					try
					{
						// Refresh directory contents if empty
						if (fileEntries.empty())
						{
							std::error_code ec;
							auto dir_iter = std::filesystem::directory_iterator(currentPath, ec);
							if (ec)
							{
								ImGui::TextColored(ImVec4(1, 0, 0, 1), "Error: %s", ec.message().c_str());
							}
							else
							{
								for (const auto& entry : dir_iter)
								{
									try
									{
										// Skip hidden/system files
#ifdef _WIN32
										DWORD attrs = GetFileAttributesW(entry.path().wstring().c_str());
										if (attrs & (FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_SYSTEM))
											continue;
#endif
										if (entry.path().filename().string()[0] == '$')
											continue;

										fileEntries.push_back(entry);
									}
									catch (...)
									{
										continue;
									}
								}

								// Sort directories first
								std::sort(fileEntries.begin(), fileEntries.end(),
									[](const auto& a, const auto& b) {
										std::string a_name = a.path().filename().string();
										std::string b_name = b.path().filename().string();
										std::transform(a_name.begin(), a_name.end(), a_name.begin(), ::tolower);
										std::transform(b_name.begin(), b_name.end(), b_name.begin(), ::tolower);

										if (a.is_directory() == b.is_directory())
											return a_name < b_name;
										return a.is_directory() > b.is_directory();
									});
							}
						}

						// Split filter into parts
						std::vector<std::string> filterParts;
						size_t start = 0;
						size_t end = filter.find(',');
						while (end != std::string::npos)
						{
							std::string part = filter.substr(start, end - start);
							part.erase(part.begin(), std::find_if(part.begin(), part.end(), [](int ch) { return !std::isspace(ch); }));
							part.erase(std::find_if(part.rbegin(), part.rend(), [](int ch) { return !std::isspace(ch); }).base(), part.end());
							if (!part.empty())
								filterParts.push_back(part);
							start = end + 1;
							end = filter.find(',', start);
						}
						std::string part = filter.substr(start);
						part.erase(part.begin(), std::find_if(part.begin(), part.end(), [](int ch) { return !std::isspace(ch); }));
						part.erase(std::find_if(part.rbegin(), part.rend(), [](int ch) { return !std::isspace(ch); }).base(), part.end());
						if (!part.empty()) filterParts.push_back(part);

						// Check if any filter is .*
						bool allowAll = std::any_of(filterParts.begin(), filterParts.end(), [](const std::string& part) { return part == ".*"; });

						// Display entries
						for (int i = 0; i < fileEntries.size(); i++)
						{
							const auto& entry = fileEntries[i];
							const bool isDirectory = entry.is_directory();
							std::string filename = entry.path().filename().string();

							// Filtering
							if (!isDirectory && !filter.empty() && !allowAll)
							{
								std::string entry_ext = entry.path().extension().string();
								std::transform(entry_ext.begin(), entry_ext.end(), entry_ext.begin(), ::tolower);

								bool matches = false;
								for (const auto& target_part : filterParts)
								{
									std::string target_ext = target_part;
									std::transform(target_ext.begin(), target_ext.end(), target_ext.begin(), ::tolower);
									if (entry_ext == target_ext)
									{
										matches = true;
										break;
									}
								}

								if (!matches)
									continue;
							}

							// Display as tree node
							ImGui::PushID(filename.c_str());
							ImGuiTreeNodeFlags flags = ImGuiTreeNodeFlags_SpanAvailWidth |
								ImGuiTreeNodeFlags_NoTreePushOnOpen |
								ImGuiTreeNodeFlags_OpenOnArrow;

							if (!isDirectory) flags |= ImGuiTreeNodeFlags_Leaf;

							if (selectedPath == entry.path().string()) flags |= ImGuiTreeNodeFlags_Selected;

							gui::SetNextItemOpen(false, ImGuiCond_Always);
							ImGui::TreeNodeEx("##node", flags, "%s", filename.c_str());

							if (ImGui::IsItemClicked())
							{
								if (isDirectory)
								{
									if (filter == ".") selectedPath = entry.path().string();
								}
								else selectedPath = entry.path().string();
							}

							if (ImGui::IsItemHovered() && ImGui::IsMouseDoubleClicked(0))
							{
								if (isDirectory)
								{
									currentPath = entry.path();
									fileEntries.clear();
								}
								else selectedPath = entry.path().string();
							}

							ImGui::PopID();
						}
					}
					catch (const std::exception& e)
					{
						ImGui::TextColored(ImVec4(1, 0, 0, 1), "Error: %s", e.what());
					}
				}
				ImGui::EndChild();

				// Selected file path
				ImGui::Text("Selected:"); ImGui::SameLine();
				auto selectedFileName = selectedPath.empty() ? "* None *" : std::filesystem::path(selectedPath).filename().string();
				std::string filterText = filter;
				if (filterText == ".*") filterText += " All";
				if (filterText == ".") filterText += " Folder";
				ImGui::SetNextItemWidth(ImGui::GetContentRegionAvail().x - ImGui::CalcTextSize(filterText.c_str()).x - ImGui::GetStyle().FramePadding.x * 2 - ImGui::GetStyle().ItemSpacing.x);
				ImGui::InputText("##SelectedFile", &selectedFileName, ImGuiInputTextFlags_ReadOnly);

				// Filter text
				ImGui::SameLine();
				std::vector<std::string> filterParts;
				size_t start = 0;
				size_t end = filter.find(',');
				while (end != std::string::npos)
				{
					std::string part = filter.substr(start, end - start);
					part.erase(part.begin(), std::find_if(part.begin(), part.end(), [](int ch) { return !std::isspace(ch); }));
					part.erase(std::find_if(part.rbegin(), part.rend(), [](int ch) { return !std::isspace(ch); }).base(), part.end());
					if (!part.empty())
						filterParts.push_back(part);
					start = end + 1;
					end = filter.find(',', start);
				}
				std::string part = filter.substr(start);
				part.erase(part.begin(), std::find_if(part.begin(), part.end(), [](int ch) { return !std::isspace(ch); }));
				part.erase(std::find_if(part.rbegin(), part.rend(), [](int ch) { return !std::isspace(ch); }).base(), part.end());
				if (!part.empty())
					filterParts.push_back(part);

				ImGui::SetNextItemWidth(ImGui::CalcTextSize(filterText.c_str()).x + ImGui::GetStyle().FramePadding.x * 2);
				ImGui::InputText("##Filter", &filterText, ImGuiInputTextFlags_ReadOnly);

				static std::string newFileName;
				if (!newFileFilter.empty())
				{
					gui::Text("NewFile Name:"); ImGui::SameLine();
					ImGui::SetNextItemWidth(ImGui::GetContentRegionAvail().x - ImGui::CalcTextSize(newFileFilter.c_str()).x - ImGui::GetStyle().FramePadding.x * 2 - ImGui::GetStyle().ItemSpacing.x);
					gui::InputText("##NewFile", &newFileName);
					ImGui::SameLine();
					std::string newFileText = newFileFilter;
					if (newFileFilter == ".*") newFileText += " All";
					if (newFileFilter == ".") newFileText += " Folder";
					ImGui::SetNextItemWidth(ImGui::CalcTextSize(newFileText.c_str()).x + ImGui::GetStyle().FramePadding.x * 2);
					gui::InputText("##NewFileFilter", &newFileText, ImGuiInputTextFlags_ReadOnly);
				}

				ImGui::BeginDisabled(selectedPath.empty() || (!newFileFilter.empty() && newFileName.empty()));
				if (ImGui::Button("OK", { gui::GetContentRegionMax().x * 0.3f, 0 }) || (IsKeyPressedDissabled(ImGuiKey_Enter) && !selectedPath.empty()))
				{
					if (newFileFilter.empty())
						finalPath = selectedPath;
					else
						finalPath = selectedPath + "\\" + newFileName + (newFileFilter != "." ? newFileFilter : "");
					newFileName.clear();
					selectedPath.clear();
					currentPath = disks[0];
					disks.clear();
					fileEntries.clear();
					ImGui::CloseCurrentPopup();
				}
				ImGui::EndDisabled();

				ImGui::SameLine();
				ImGui::SetCursorPosX(ImGui::GetContentRegionMax().x - gui::GetContentRegionMax().x * 0.3f);
				if (ImGui::Button("Cancel", { gui::GetContentRegionMax().x * 0.3f, 0 }) || ImGui::IsKeyPressed(ImGuiKey_Escape))
				{
					newFileName.clear();
					selectedPath.clear();
					currentPath = disks[0];
					disks.clear();
					fileEntries.clear();
					ImGui::CloseCurrentPopup();
				}

				ImGui::EndPopup();
			}

			return finalPath;
		}

		void ApplyHue(ImGuiStyle& style, float hue)
		{
			for (int i = 0; i < ImGuiCol_COUNT; i++)
			{
				ImVec4& col = style.Colors[i];

				float h, s, v;
				ImGui::ColorConvertRGBtoHSV(col.x, col.y, col.z, h, s, v);
				h = hue;
				ImGui::ColorConvertHSVtoRGB(h, s, v, col.x, col.y, col.z);
			}
		}

		ImVec2 ImConv(glm::vec2 v) { return ImVec2(v.x, v.y); }

		ImGuiStyle SoDark(float hue)
		{
			ImGuiStyle style;
			ImVec4* colors = style.Colors;
			colors[ImGuiCol_Text] = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
			colors[ImGuiCol_TextDisabled] = ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
			colors[ImGuiCol_WindowBg] = ImVec4(0.10f, 0.10f, 0.10f, 1.00f);
			colors[ImGuiCol_ChildBg] = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
			colors[ImGuiCol_PopupBg] = ImVec4(0.19f, 0.19f, 0.19f, 0.92f);
			colors[ImGuiCol_Border] = ImVec4(0.33f, 0.33f, 0.33f, 0.59f);
			colors[ImGuiCol_BorderShadow] = ImVec4(0.00f, 0.00f, 0.00f, 0.24f);
			colors[ImGuiCol_FrameBg] = ImVec4(0.25f, 0.25f, 0.25f, 0.54f);
			colors[ImGuiCol_FrameBgHovered] = ImVec4(0.19f, 0.19f, 0.19f, 0.54f);
			colors[ImGuiCol_FrameBgActive] = ImVec4(0.20f, 0.22f, 0.23f, 1.00f);
			colors[ImGuiCol_TitleBg] = ImVec4(0.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_TitleBgActive] = ImVec4(0.06f, 0.06f, 0.06f, 1.00f);
			colors[ImGuiCol_TitleBgCollapsed] = ImVec4(0.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_MenuBarBg] = ImVec4(0.14f, 0.14f, 0.14f, 1.00f);
			colors[ImGuiCol_ScrollbarBg] = ImVec4(0.05f, 0.05f, 0.05f, 0.54f);
			colors[ImGuiCol_ScrollbarGrab] = ImVec4(0.34f, 0.34f, 0.34f, 0.54f);
			colors[ImGuiCol_ScrollbarGrabHovered] = ImVec4(0.40f, 0.40f, 0.40f, 0.54f);
			colors[ImGuiCol_ScrollbarGrabActive] = ImVec4(0.56f, 0.56f, 0.56f, 0.54f);
			colors[ImGuiCol_CheckMark] = ImVec4(0.33f, 0.67f, 0.86f, 1.00f);
			colors[ImGuiCol_SliderGrab] = ImVec4(0.34f, 0.34f, 0.34f, 0.54f);
			colors[ImGuiCol_SliderGrabActive] = ImVec4(0.56f, 0.56f, 0.56f, 0.54f);
			colors[ImGuiCol_Button] = ImVec4(0.30f, 0.30f, 0.30f, 0.54f);
			colors[ImGuiCol_ButtonHovered] = ImVec4(0.19f, 0.19f, 0.19f, 0.54f);
			colors[ImGuiCol_ButtonActive] = ImVec4(0.20f, 0.22f, 0.23f, 1.00f);
			colors[ImGuiCol_Header] = ImVec4(0.00f, 0.00f, 0.00f, 0.52f);
			colors[ImGuiCol_HeaderHovered] = ImVec4(0.00f, 0.00f, 0.00f, 0.36f);
			colors[ImGuiCol_HeaderActive] = ImVec4(0.20f, 0.22f, 0.23f, 0.33f);
			colors[ImGuiCol_Separator] = ImVec4(0.33f, 0.33f, 0.33f, 0.59f);
			colors[ImGuiCol_SeparatorHovered] = ImVec4(0.44f, 0.44f, 0.44f, 0.29f);
			colors[ImGuiCol_SeparatorActive] = ImVec4(1.000f, 0.000f, 0.000f, 0.500f);
			colors[ImGuiCol_ResizeGrip] = ImVec4(0.28f, 0.28f, 0.28f, 0.29f);
			colors[ImGuiCol_ResizeGripHovered] = ImVec4(0.44f, 0.44f, 0.44f, 0.29f);
			colors[ImGuiCol_ResizeGripActive] = ImVec4(1.00f, 0.00f, 0.00f, 0.50f);
			colors[ImGuiCol_Tab] = ImVec4(0.00f, 0.00f, 0.00f, 0.52f);
			colors[ImGuiCol_TabHovered] = ImVec4(0.14f, 0.14f, 0.14f, 1.00f);
			colors[ImGuiCol_TabActive] = ImVec4(0.20f, 0.20f, 0.20f, 0.36f);
			colors[ImGuiCol_TabUnfocused] = ImVec4(0.00f, 0.00f, 0.00f, 0.52f);
			colors[ImGuiCol_TabUnfocusedActive] = ImVec4(0.14f, 0.14f, 0.14f, 1.00f);
			colors[ImGuiCol_DockingPreview] = ImVec4(0.20f, 0.22f, 0.23f, 1.00f);
			colors[ImGuiCol_DockingEmptyBg] = ImVec4(0.20f, 0.20f, 0.20f, 0.36f);
			colors[ImGuiCol_PlotLines] = ImVec4(1.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_PlotLinesHovered] = ImVec4(1.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_PlotHistogram] = ImVec4(1.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_PlotHistogramHovered] = ImVec4(1.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_TableHeaderBg] = ImVec4(0.00f, 0.00f, 0.00f, 0.35f);
			colors[ImGuiCol_TableBorderStrong] = ImVec4(0.28f, 0.28f, 0.28f, 0.29f);
			colors[ImGuiCol_TableBorderLight] = ImVec4(0.28f, 0.28f, 0.28f, 0.29f);
			colors[ImGuiCol_TableRowBg] = ImVec4(0.10f, 0.10f, 0.10f, 1.00f); // -
			colors[ImGuiCol_TableRowBgAlt] = ImVec4(0.13f, 0.13f, 0.13f, 1.00f); // -
			colors[ImGuiCol_TextSelectedBg] = ImVec4(1.00f, 1.00f, 1.00f, 0.27f);
			colors[ImGuiCol_DragDropTarget] = ImVec4(0.33f, 0.67f, 0.86f, 1.00f);
			colors[ImGuiCol_NavHighlight] = ImVec4(1.00f, 0.00f, 0.00f, 1.00f);
			colors[ImGuiCol_NavWindowingHighlight] = ImVec4(1.00f, 0.00f, 0.00f, 0.70f);
			colors[ImGuiCol_NavWindowingDimBg] = ImVec4(1.00f, 0.00f, 0.00f, 0.20f);
			colors[ImGuiCol_ModalWindowDimBg] = ImVec4(0.22f, 0.22f, 0.22f, 0.373f);

			style.WindowPadding = ImVec2(8.00f, 8.00f);
			style.FramePadding = ImVec2(5.00f, 2.00f);
			style.CellPadding = ImVec2(6.00f, 6.00f);
			style.ItemSpacing = ImVec2(6.00f, 6.00f);
			style.ItemInnerSpacing = ImVec2(6.00f, 6.00f);
			style.TouchExtraPadding = ImVec2(0.00f, 0.00f);
			style.IndentSpacing = 25;
			style.ScrollbarSize = 15;
			style.GrabMinSize = 10;
			style.WindowBorderSize = 1;
			style.ChildBorderSize = 1;
			style.PopupBorderSize = 1;
			style.FrameBorderSize = 0;
			style.TabBorderSize = 1;
			style.WindowRounding = 7;
			style.ChildRounding = 4;
			style.FrameRounding = 2;
			style.PopupRounding = 4;
			style.ScrollbarRounding = 9;
			style.GrabRounding = 3;
			style.LogSliderDeadzone = 4;
			style.TabRounding = 4;
			style.WindowMenuButtonPosition = ImGuiDir_None;

			ApplyHue(style, hue);

			return style;
		}

		void RenderArrowIcon(ImGuiDir dir, ImVec4 col, float scale)
		{
			ImVec2 arrowPos = ImVec2(
				ImGui::GetWindowPos().x + ImGui::GetWindowSize().x - ImGui::GetStyle().ItemSpacing.x * 2 - ImGui::CalcTextSize(">").x,
				ImGui::GetCursorScreenPos().y - ImGui::GetTextLineHeight() - ImGui::GetStyle().ItemSpacing.y // Adjust to align with text height
			);

			ImGui::RenderArrow(
				ImGui::GetWindowDrawList(),
				arrowPos,
				ImGui::GetColorU32(col),
				dir,
				scale
			);
		}

		void HelpMarker(const char* desc, bool sameLine)
		{
			if (sameLine) ImGui::SameLine();
			ImGui::TextDisabled("(?)");
			if (ImGui::BeginItemTooltip())
			{
				ImGui::PushTextWrapPos(ImGui::GetFontSize() * 35.0f);
				ImGui::TextUnformatted(desc);
				ImGui::PopTextWrapPos();
				ImGui::EndTooltip();
			}
		}

		//IMGUI include, dont USE!
		bool IsRootOfOpenMenuSet()
		{
			ImGuiContext& g = *GImGui;
			ImGuiWindow* window = g.CurrentWindow;
			if ((g.OpenPopupStack.Size <= g.BeginPopupStack.Size) || (window->Flags & ImGuiWindowFlags_ChildMenu))
				return false;

			// Initially we used 'upper_popup->OpenParentId == window->IDStack.back()' to differentiate multiple menu sets from each others
			// (e.g. inside menu bar vs loose menu items) based on parent ID.
			// This would however prevent the use of e.g. PushID() user code submitting menus.
			// Previously this worked between popup and a first child menu because the first child menu always had the _ChildWindow flag,
			// making hovering on parent popup possible while first child menu was focused - but this was generally a bug with other side effects.
			// Instead we don't treat Popup specifically (in order to consistently support menu features in them), maybe the first child menu of a Popup
			// doesn't have the _ChildWindow flag, and we rely on this IsRootOfOpenMenuSet() check to allow hovering between root window/popup and first child menu.
			// In the end, lack of ID check made it so we could no longer differentiate between separate menu sets. To compensate for that, we at least check parent window nav layer.
			// This fixes the most common case of menu opening on hover when moving between window content and menu bar. Multiple different menu sets in same nav layer would still
			// open on hover, but that should be a lesser problem, because if such menus are close in proximity in window content then it won't feel weird and if they are far apart
			// it likely won't be a problem anyone runs into.
			const ImGuiPopupData* upper_popup = &g.OpenPopupStack[g.BeginPopupStack.Size];
			if (window->DC.NavLayerCurrent != upper_popup->ParentNavLayer)
				return false;
			return upper_popup->Window && (upper_popup->Window->Flags & ImGuiWindowFlags_ChildMenu) && ImGui::IsWindowChildOf(upper_popup->Window, window, true, false);
		}

		void CloseIfCursorFarFromCenter(float distance)
		{
			if (distance < 0.f) distance = glm::max(gui::GetWindowWidth(), gui::GetWindowHeight()) * 0.5f;
			const ImVec2 mousePos = gui::GetIO().MousePos;
			const ImVec2 windowPos = gui::GetWindowPos();
			const float windowWidth = gui::GetWindowWidth();
			const float windowHeight = gui::GetWindowHeight();

			if (gui::IsWindowFocused() && gui::IsMousePosValid() &&
				(mousePos.x < windowPos.x - distance ||
					mousePos.x > windowPos.x + windowWidth + distance ||
					mousePos.y < windowPos.y - distance ||
					mousePos.y > windowPos.y + windowHeight + distance))
			{
				gui::CloseCurrentPopup();
			}
		}

		// add state if it is window
		void CloseIfCursorFarFromCenter(bool& winState, float distance)
		{
			if (distance < 0.f) distance = glm::max(gui::GetWindowWidth(), gui::GetWindowHeight()) * 0.5f;
			const ImVec2 mousePos = gui::GetIO().MousePos;
			const ImVec2 windowPos = gui::GetWindowPos();
			const float windowWidth = gui::GetWindowWidth();
			const float windowHeight = gui::GetWindowHeight();

			if (gui::IsWindowFocused() && gui::IsMousePosValid() &&
				(mousePos.x < windowPos.x - distance ||
					mousePos.x > windowPos.x + windowWidth + distance ||
					mousePos.y < windowPos.y - distance ||
					mousePos.y > windowPos.y + windowHeight + distance))
			{
				winState = false;
			}
		}

		bool MenuItemButton(const char* label, const char* shortcut, bool closePopupOnClick, const char* icon, bool selected, bool enabled)
		{
			ImGuiWindow* window = ImGui::GetCurrentWindow();
			if (window->SkipItems)
				return false;

			ImGuiContext& g = *GImGui;
			ImGuiStyle& style = g.Style;
			ImVec2 imPos = window->DC.CursorPos;
			ImVec2 label_size = ImGui::CalcTextSize(label, NULL, true);

			// See BeginMenuEx() for comments about this.
			const bool menuset_is_open = IsRootOfOpenMenuSet();
			if (menuset_is_open)
				ImGui::PushItemFlag(ImGuiItemFlags_NoWindowHoverableCheck, true);

			// We've been using the equivalent of ImGuiSelectableFlags_SetNavIdOnHover on all Selectable() since early Nav system days (commit 43ee5d73),
			// but I am unsure whether this should be kept at all. For now moved it to be an opt-in feature used by menus only.
			bool pressed;
			ImGui::PushID(label);
			if (!enabled)
				ImGui::BeginDisabled();

			// We use ImGuiSelectableFlags_NoSetKeyOwner to allow down on one menu item, move, up on another.
			const ImGuiSelectableFlags selectable_flags = ImGuiSelectableFlags_SelectOnRelease | ImGuiSelectableFlags_NoSetKeyOwner | ImGuiSelectableFlags_SetNavIdOnHover | closePopupOnClick ? ImGuiSelectableFlags_DontClosePopups : 0;
			const ImGuiMenuColumns* offsets = &window->DC.MenuColumns;
			if (window->DC.LayoutType == ImGuiLayoutType_Horizontal)
			{
				// Mimic the exact layout spacing of BeginMenu() to allow MenuItem() inside a menu bar, which is a little misleading but may be useful
				// Note that in this situation: we don't render the shortcut, we render a highlight instead of the selected tick mark.
				float w = label_size.x;
				window->DC.CursorPos.x += IM_TRUNC(style.ItemSpacing.x * 0.5f);
				ImVec2 text_pos(window->DC.CursorPos.x + offsets->OffsetLabel, window->DC.CursorPos.y + window->DC.CurrLineTextBaseOffset);
				ImGui::PushStyleVarX(ImGuiStyleVar_ItemSpacing, style.ItemSpacing.x * 2.0f);
				pressed = ImGui::Selectable("", selected, selectable_flags, ImVec2(w, 0.0f));
				ImGui::PopStyleVar();
				if (g.LastItemData.StatusFlags & ImGuiItemStatusFlags_Visible)
					ImGui::RenderText(text_pos, label);
				window->DC.CursorPos.x += IM_TRUNC(style.ItemSpacing.x * (-1.0f + 0.5f)); // -1 spacing to compensate the spacing added when Selectable() did a SameLine(). It would also work to call SameLine() ourselves after the PopStyleVar().
			}
			else
			{
				// Menu item inside a vertical menu
				// (In a typical menu window where all items are BeginMenu() or MenuItem() calls, extra_w will always be 0.0f.
				//  Only when they are other items sticking out we're going to add spacing, yet only register minimum width into the layout system.
				float icon_w = (icon && icon[0]) ? ImGui::CalcTextSize(icon, NULL).x : 0.0f;
				float shortcut_w = (shortcut && shortcut[0]) ? ImGui::CalcTextSize(shortcut, NULL).x : 0.0f;
				float checkmark_w = IM_TRUNC(g.FontSize * 1.20f);
				float min_w = window->DC.MenuColumns.DeclColumns(icon_w, label_size.x, shortcut_w, checkmark_w); // Feedback for next frame
				float stretch_w = ImMax(0.0f, ImGui::GetContentRegionAvail().x - min_w);
				pressed = ImGui::Selectable("", false, selectable_flags | ImGuiSelectableFlags_SpanAvailWidth, ImVec2(min_w, label_size.y));
				if (g.LastItemData.StatusFlags & ImGuiItemStatusFlags_Visible)
				{
					ImGui::RenderText(ImVec2(imPos.x + offsets->OffsetLabel, imPos.y), label);
					if (icon_w > 0.0f)
						ImGui::RenderText(ImVec2(imPos.x + offsets->OffsetIcon, imPos.y), icon);
					if (shortcut_w > 0.0f)
					{
						ImGui::PushStyleColor(ImGuiCol_Text, style.Colors[ImGuiCol_TextDisabled]);
						ImGui::LogSetNextTextDecoration("(", ")");
						ImGui::RenderText(ImVec2(imPos.x + offsets->OffsetShortcut + stretch_w, imPos.y), shortcut, NULL, false);
						ImGui::PopStyleColor();
					}
					if (selected)
						ImGui::RenderCheckMark(window->DrawList, ImVec2(offsets->OffsetMark + stretch_w + g.FontSize * 0.40f + imPos.x, g.FontSize * 0.134f * 0.5f + imPos.y), ImGui::GetColorU32(ImGuiCol_Text), g.FontSize * 0.866f);
				}
			}
			IMGUI_TEST_ENGINE_ITEM_INFO(g.LastItemData.ID, label, g.LastItemData.StatusFlags | ImGuiItemStatusFlags_Checkable | (selected ? ImGuiItemStatusFlags_Checked : 0));
			if (!enabled)
				ImGui::EndDisabled();
			ImGui::PopID();
			if (menuset_is_open)
				ImGui::PopItemFlag();

			return pressed;
		}

		bool MatchPayloadType(const char* type)
		{
			if (type == nullptr) return ImGui::IsDragDropActive();
			return ImGui::IsDragDropActive() && strcmp(ImGui::GetDragDropPayload()->DataType, type) == 0;
		}

		void DrawBgRows(float itemSpacingY)
		{
			if (itemSpacingY > -1) gui::PushStyleVarY(ImGuiStyleVar_ItemSpacing, itemSpacingY);

			ImGuiWindow* window = ImGui::GetCurrentWindow();
			if (window->SkipItems) return;

			ImDrawList* draw_list = ImGui::GetWindowDrawList();
			ImGuiStyle& style = ImGui::GetStyle();

			const float scroll_y = ImGui::GetScrollY();
			const float window_height = ImGui::GetWindowHeight();

			const float row_height = style.ItemSpacing.y + ImGui::GetTextLineHeight();

			const int row_start = static_cast<int>(scroll_y / row_height);
			const int row_count = static_cast<int>((scroll_y + window_height) / row_height) - row_start + 1;

			const float collOffset = 1.3f;
			const ImU32 color_even = ImGui::GetColorU32(style.Colors[ImGuiCol_WindowBg]);
			const ImU32 color_odd = ImGui::GetColorU32({ style.Colors[ImGuiCol_WindowBg].x * collOffset, style.Colors[ImGuiCol_WindowBg].y * collOffset, style.Colors[ImGuiCol_WindowBg].z * collOffset, style.Colors[ImGuiCol_WindowBg].w });

			// Get starting position of the window's content area
			const ImVec2 win_pos = ImVec2(window->Pos.x, window->Pos.y - style.ItemSpacing.y * 0.5f);
			const ImVec2 clip_rect_min = { win_pos.x, win_pos.y };
			const ImVec2 clip_rect_max = { win_pos.x + window->Size.x, win_pos.y + window_height };

			// Clip drawing to the visible area
			draw_list->PushClipRect(clip_rect_min, clip_rect_max, true);

			for (int row = row_start; row < row_start + row_count; row++)
			{
				// Alternate colors
				const ImU32 col = (row % 2 == 0) ? color_even : color_odd;

				// Calculate row position
				const float y1 = win_pos.y + (row * row_height) - scroll_y;
				const float y2 = y1 + row_height;

				// Draw the row background
				draw_list->AddRectFilled(
					ImVec2(win_pos.x, y1),
					ImVec2(win_pos.x + window->Size.x, y2),
					col
				);
			}

			draw_list->PopClipRect();
			gui::PopStyleVar();
		}

		bool BeginMenuFt(const char* label, ImFont* font)
		{
			gui::PushFont(font);
			bool result = ImGui::BeginMenu(label);
			gui::PopFont();
			return result;
		}

		//ImGui::PopColor(3) is needed
		//if there is a loaded font, you need to pop
		void PushButtonColor(const ImVec4 color, const float hoverOffset, const float activeOffset, ImFont* font)
		{
			if (font)gui::PushFont(font);
			gui::PushStyleColor(ImGuiCol_Button, color);
			gui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(color.x * hoverOffset, color.y * hoverOffset, color.z * hoverOffset, color.w));
			gui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(color.x * activeOffset, color.y * activeOffset, color.z * activeOffset, color.w));
		}

		void DragButton2(const char* txt, glm::vec2& v) // make this a bool func
		{
			// Define a fixed width for the buttons
			const float buttonWidth = 20.0f;

			// Calculate the available width for the input fields
			float inputWidth = (gui::CalcItemWidth() - buttonWidth * 2 - ImGui::GetStyle().ItemSpacing.x) / 2;

			// Draw colored button for "X"
			ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(1.0f, 0.0f, 0.0f, 0.5f)); // Red color
			ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(1.0f, 0.0f, 0.0f, 0.6f)); // Red color
			ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(1.0f, 0.0f, 0.0f, 0.75f)); // Red color
			if (ImGui::Button((std::string("X##X") + txt).c_str(), ImVec2(buttonWidth, 0)))
			{
				if (ImGui::IsKeyDown(ImGuiKey_LeftShift)) { v.x -= 1.0f; }
				else { v.x += 1.0f; }
			}
			ImGui::PopStyleColor(3);
			ImGui::SameLine(0, 0);

			ImGui::SetNextItemWidth(inputWidth);
			ImGui::DragFloat((std::string("##X") + txt).c_str(), &v.x, 0.1f);

			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);

			// Draw colored button for "Y"
			ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.0f, 1.0f, 0.0f, 0.5f)); // Green color
			ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0.0f, 1.0f, 0.0f, 0.6f)); // Green color
			ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(0.0f, 1.0f, 0.0f, 0.75f)); // Green color
			if (ImGui::Button((std::string("Y##Y") + txt).c_str(), ImVec2(buttonWidth, 0)))
			{
				if (ImGui::IsKeyDown(ImGuiKey_LeftShift)) { v.y -= 1.0f; }
				else { v.y += 1.0f; }
			}
			ImGui::PopStyleColor(3);
			ImGui::SameLine(0, 0);

			ImGui::SetNextItemWidth(inputWidth);
			ImGui::DragFloat((std::string("##Y") + txt).c_str(), &v.y, 0.1f);


			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
			ImGui::AlignTextToFramePadding();
			ImGui::Text(txt);

			//HelpMarker("Pressing SHIFT makes the step for the buttons -1.0, instead of 1.0");
		}

		bool DragButton3(const char* txt, glm::vec3& v) // Changed to bool return type
		{
			// Define a fixed width for the buttons
			const float buttonWidth = 20.0f;

			// Calculate the available width for the input fields
			float inputWidth = (gui::CalcItemWidth() - buttonWidth * 3 - ImGui::GetStyle().ItemSpacing.x * 2) / 3;

			// Draw colored button for "X"
			ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(1.0f, 0.0f, 0.0f, 0.5f)); // Red color
			ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(1.0f, 0.0f, 0.0f, 0.6f)); // Red color
			ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(1.0f, 0.0f, 0.0f, 0.75f)); // Red color
			if (ImGui::Button((std::string("X##X") + txt).c_str(), ImVec2(buttonWidth, 0)))
			{
				if (ImGui::IsKeyDown(ImGuiKey_LeftShift)) { v.x -= 1.0f; }
				else { v.x += 1.0f; }
			}
			ImGui::PopStyleColor(3);
			ImGui::SameLine(0, 0);

			ImGui::SetNextItemWidth(inputWidth);
			ImGui::DragFloat((std::string("##X") + txt).c_str(), &v.x, 0.1f);

			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);

			// Draw colored button for "Y"
			ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.0f, 1.0f, 0.0f, 0.5f)); // Green color
			ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0.0f, 1.0f, 0.0f, 0.6f)); // Green color
			ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(0.0f, 1.0f, 0.0f, 0.75f)); // Green color
			if (ImGui::Button((std::string("Y##Y") + txt).c_str(), ImVec2(buttonWidth, 0)))
			{
				if (ImGui::IsKeyDown(ImGuiKey_LeftShift)) { v.y -= 1.0f; }
				else { v.y += 1.0f; }
			}
			ImGui::PopStyleColor(3);
			ImGui::SameLine(0, 0);

			ImGui::SetNextItemWidth(inputWidth);
			ImGui::DragFloat((std::string("##Y") + txt).c_str(), &v.y, 0.1f);

			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);

			// Draw colored button for "Z"
			ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0.0f, 0.0f, 1.0f, 0.5f)); // Blue color
			ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0.0f, 0.0f, 1.0f, 0.6f)); // Blue color
			ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(0.0f, 0.0f, 1.0f, 0.75f)); // Blue color
			if (ImGui::Button((std::string("Z##Z") + txt).c_str(), ImVec2(buttonWidth, 0)))
			{
				if (ImGui::IsKeyDown(ImGuiKey_LeftShift)) { v.z -= 1.0f; }
				else { v.z += 1.0f; }
			}
			ImGui::PopStyleColor(3);
			ImGui::SameLine(0, 0);

			ImGui::SetNextItemWidth(inputWidth);
			ImGui::DragFloat((std::string("##Z") + txt).c_str(), &v.z, 0.1f);

			ImGui::SameLine(0, ImGui::GetStyle().ItemInnerSpacing.x);
			ImGui::AlignTextToFramePadding();
			ImGui::Text(txt);

			// Return true if any of the values were modified
			return ImGui::IsItemEdited();
		}

		void Separator()
		{
			ImGui::Separator();
		}

		void Separator(const std::string& label)
		{
			ImGui::SeparatorText(label.c_str());
		}

		void SeparatorEx(ImGuiSeparatorFlags flags, float thickness, bool hover)
		{
			ImGuiWindow* window = gui::GetCurrentWindow();
			if (window->SkipItems)
				return;

			ImGuiContext& g = *GImGui;
			IM_ASSERT(ImIsPowerOfTwo(flags & (ImGuiSeparatorFlags_Horizontal | ImGuiSeparatorFlags_Vertical)));   // Check that only 1 option is selected
			IM_ASSERT(thickness > 0.0f);

			if (flags & ImGuiSeparatorFlags_Vertical)
			{
				// Vertical separator, for menu bars (use current line height).
				float y1 = window->DC.CursorPos.y;
				float y2 = window->DC.CursorPos.y + window->DC.CurrLineSize.y;
				const ImRect bb(ImVec2(window->DC.CursorPos.x, y1), ImVec2(window->DC.CursorPos.x + thickness, y2));
				gui::ItemSize(ImVec2(thickness, 0.0f));
				if (!gui::ItemAdd(bb, 0))
					return;

				// Draw
				window->DrawList->AddRectFilled(bb.Min, bb.Max, gui::GetColorU32(hover && gui::IsMouseHoveringRect(gui::GetItemRectMin(), gui::GetItemRectMax()) ? ImGuiCol_SeparatorHovered : ImGuiCol_Separator));
				if (g.LogEnabled)
					gui::LogText(" |");
			}
			else if (flags & ImGuiSeparatorFlags_Horizontal)
			{
				// Horizontal Separator
				float x1 = window->DC.CursorPos.x;
				float x2 = window->WorkRect.Max.x;

				// Preserve legacy behavior inside Columns()
				// Before Tables API happened, we relied on Separator() to span all columns of a Columns() set.
				// We currently don't need to provide the same feature for tables because tables naturally have border features.
				ImGuiOldColumns* columns = (flags & ImGuiSeparatorFlags_SpanAllColumns) ? window->DC.CurrentColumns : NULL;
				if (columns)
				{
					x1 = window->Pos.x + window->DC.Indent.x; // Used to be Pos.x before 2023/10/03
					x2 = window->Pos.x + window->Size.x;
					gui::PushColumnsBackground();
				}

				// We don't provide our width to the layout so that it doesn't get feed back into AutoFit
				// FIXME: This prevents ->CursorMaxPos based bounding box evaluation from working (e.g. TableEndCell)
				const float thickness_for_layout = (thickness == 1.0f) ? 0.0f : thickness; // FIXME: See 1.70/1.71 Separator() change: makes legacy 1-px separator not affect layout yet. Should change.
				const ImRect bb(ImVec2(x1, window->DC.CursorPos.y), ImVec2(x2, window->DC.CursorPos.y + thickness));
				gui::ItemSize(ImVec2(0.0f, thickness_for_layout));

				if (gui::ItemAdd(bb, 0))
				{
					// Draw
					window->DrawList->AddRectFilled(bb.Min, bb.Max, gui::GetColorU32(hover && gui::IsMouseHoveringRect(gui::GetItemRectMin(), gui::GetItemRectMax()) ? ImGuiCol_SeparatorHovered : ImGuiCol_Separator));
					if (g.LogEnabled)
						gui::LogRenderedText(&bb.Min, "--------------------------------\n");

				}
				if (columns)
				{
					gui::PopColumnsBackground();
					columns->LineMinY = window->DC.CursorPos.y;
				}
			}
		}

		void Text(const std::string& text)
		{
			ImGui::TextUnformatted(text.c_str());
		}

		void HelpMarker(const std::string& desc)
		{
			ImGui::TextDisabled("(?)");
			if (ImGui::BeginItemTooltip())
			{
				ImGui::PushTextWrapPos(ImGui::GetFontSize() * 35.0f);
				Text(desc);
				ImGui::PopTextWrapPos();
				ImGui::EndTooltip();
			}
		}

		bool Drag(const std::string& label, float& v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalar(label.c_str(), ImGuiDataType_Float, &v, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag2(const std::string& label, float* v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_Float, v, 2, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag3(const std::string& label, float* v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_Float, v, 3, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag4(const std::string& label, float* v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_Float, v, 4, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag(const std::string& label, double& v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalar(label.c_str(), ImGuiDataType_Double, &v, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag2(const std::string& label, double* v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_Double, v, 2, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag3(const std::string& label, double* v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_Double, v, 3, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag4(const std::string& label, double* v, float v_speed, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_Double, v, 4, v_speed, &v_min, &v_max, format, flags);
		}

		//bool DragFloatRange2(const char* label, float* v_current_min, float* v_current_max, float v_speed = 1.0f, float v_min.0f, float v_max.0f, const char* format, const char* format_max = NULL, ImGuiSliderFlags flags);
		bool Drag(const std::string& label, int& v, float v_speed, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalar(label.c_str(), ImGuiDataType_S32, &v, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag2(const std::string& label, int* v, float v_speed, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_S32, v, 2, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag3(const std::string& label, int* v, float v_speed, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_S32, v, 3, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag4(const std::string& label, int* v, float v_speed, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_S32, v, 4, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag(const std::string& label, uint32_t& v, float v_speed, uint32_t v_min, uint32_t v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalar(label.c_str(), ImGuiDataType_U32, &v, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag2(const std::string& label, uint32_t* v, float v_speed, uint32_t v_min, uint32_t v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_U32, v, 2, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag3(const std::string& label, uint32_t* v, float v_speed, uint32_t v_min, uint32_t v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_U32, v, 3, v_speed, &v_min, &v_max, format, flags);
		}

		bool Drag4(const std::string& label, uint32_t* v, float v_speed, uint32_t v_min, uint32_t v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::DragScalarN(label.c_str(), ImGuiDataType_U32, v, 4, v_speed, &v_min, &v_max, format, flags);
		}

		bool Input(const std::string& label, float& v, float step, float step_fast, const char* format, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalar(label.c_str(), ImGuiDataType_Float, (void*)&v, (void*)(step > 0.0f ? &step : NULL), (void*)(step_fast > 0.0f ? &step_fast : NULL), format, flags);
		}

		bool Input2(const std::string& label, float* v, const char* format, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalarN(label.c_str(), ImGuiDataType_Float, v, 2, NULL, NULL, format, flags);
		}

		bool Input3(const std::string& label, float* v, const char* format, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalarN(label.c_str(), ImGuiDataType_Float, v, 3, NULL, NULL, format, flags);
		}

		bool Input4(const std::string& label, float* v, const char* format, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalarN(label.c_str(), ImGuiDataType_Float, v, 4, NULL, NULL, format, flags);
		}

		bool Input(const std::string& label, int& v, int step, int step_fast, ImGuiInputTextFlags flags)
		{
			// Hexadecimal input provided as a convenience but the flag name is awkward. Typically you'd use InputText() to parse your own data, if you want to handle prefixes.
			const char* format = (flags & ImGuiInputTextFlags_CharsHexadecimal) ? "%08X" : "%d";
			return ImGui::InputScalar(label.c_str(), ImGuiDataType_S32, (void*)v, (void*)(step > 0 ? &step : NULL), (void*)(step_fast > 0 ? &step_fast : NULL), format, flags);
		}

		bool Input2(const std::string& label, int* v, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalarN(label.c_str(), ImGuiDataType_S32, v, 2, NULL, NULL, "%d", flags);
		}

		bool Input3(const std::string& label, int* v, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalarN(label.c_str(), ImGuiDataType_S32, v, 3, NULL, NULL, "%d", flags);
		}

		bool Input4(const std::string& label, int* v, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalarN(label.c_str(), ImGuiDataType_S32, v, 4, NULL, NULL, "%d", flags);
		}

		bool InputUInt(const std::string& label, uint32_t& v, int step, int step_fast, ImGuiInputTextFlags flags)
		{
			// Hexadecimal input provided as a convenience but the flag name is awkward. Typically you'd use InputText() to parse your own data, if you want to handle prefixes.
			const char* format = (flags & ImGuiInputTextFlags_CharsHexadecimal) ? "%08X" : "%d";
			return ImGui::InputScalar(label.c_str(), ImGuiDataType_U32, &v, (void*)(step > 0 ? &step : NULL), (void*)(step_fast > 0 ? &step_fast : NULL), format, flags);
		}

		bool InputDouble(const std::string& label, double& v, double step, double step_fast, const char* format, ImGuiInputTextFlags flags)
		{
			return ImGui::InputScalar(label.c_str(), ImGuiDataType_Double, (void*)&v, (void*)(step > 0.0 ? &step : NULL), (void*)(step_fast > 0.0 ? &step_fast : NULL), format, flags);
		}

		bool Checkbox(const std::string& label, bool& v)
		{
			return ImGui::Checkbox(label.c_str(), &v);
		}
		//bool DragIntRange2(const char* label, int* v_current_min, int* v_current_max, float v_speed = 1.0f, int v_min, int v_max, const char* format, const char* format_max = NULL, ImGuiSliderFlags flags);
		//bool DragScalar(const char* label, ImGuiDataType data_type, void* p_data, float v_speed = 1.0f, const void* p_min = NULL, const void* p_max = NULL, const char* format = NULL, ImGuiSliderFlags flags);
		//bool DragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed = 1.0f, const void* p_min = NULL, const void* p_max = NULL, const char* format = NULL, ImGuiSliderFlags flags);

		bool Slider(const std::string& label, float& v, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalar(label.c_str(), ImGuiDataType_Float, &v, &v_min, &v_max, format, flags);
		}

		bool Slider2(const std::string& label, float* v, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalarN(label.c_str(), ImGuiDataType_Float, v, 2, &v_min, &v_max, format, flags);
		}

		bool Slider3(const std::string& label, float* v, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalarN(label.c_str(), ImGuiDataType_Float, v, 3, &v_min, &v_max, format, flags);
		}

		bool Slider4(const std::string& label, float* v, float v_min, float v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalarN(label.c_str(), ImGuiDataType_Float, v, 4, &v_min, &v_max, format, flags);
		}

		//bool ImGui::SliderAngle(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format, ImGuiSliderFlags flags)

		bool Slider(const std::string& label, int& v, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalar(label.c_str(), ImGuiDataType_S32, &v, &v_min, &v_max, format, flags);
		}

		bool Slider2(const std::string& label, int* v, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalarN(label.c_str(), ImGuiDataType_S32, v, 2, &v_min, &v_max, format, flags);
		}

		bool Slider3(const std::string& label, int* v, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalarN(label.c_str(), ImGuiDataType_S32, v, 3, &v_min, &v_max, format, flags);
		}

		bool Slider4(const std::string& label, int* v, int v_min, int v_max, const char* format, ImGuiSliderFlags flags)
		{
			return ImGui::SliderScalarN(label.c_str(), ImGuiDataType_S32, v, 4, &v_min, &v_max, format, flags);
		}
	}
}