#pragma once

#include <glm/glm.hpp>

#include <imgui/imgui.h>
#include <imgui/imgui_internal.h>
#include <imgui/misc/cpp/imgui_stdlib.h>
//#include <imguizmo/ImGuizmo.h>

#include <string>
#include <filesystem>
#include <vector>
#include <unordered_map>

//#include <imgui/imgui_widgets.cpp>
#ifdef _WIN32
#include <Windows.h> // Needed for file attributes
#endif

namespace gui = ImGui;

namespace wc
{
	namespace conv
	{
		glm::vec2 ImVec2ToGlm(const ImVec2& v);

		ImVec2 GlmToImVec2(const glm::vec2& v);

		glm::vec4 ImVec4ToGlm(const ImVec4& v);

		ImVec4 GlmToImVec4(const glm::vec4& v);

		ImVec4 ImVec4Offset(const ImVec4& v, const float offset);
	}

	namespace ui
	{
		//Center Window
		//if left on false, no need for ImGuiWindowFlags_NoMove
		void CenterNextWindow(bool once = false);

		bool IsKeyPressedDissabled(ImGuiKey key);

		std::string FileDialog(const char* name, const std::string& filter = ".*", const std::string& startPath = "", const bool limitToStart = false, const std::string& newFileFilter = "");

		void ApplyHue(ImGuiStyle& style, float hue);

		ImVec2 ImConv(glm::vec2 v);

		ImGuiStyle SoDark(float hue);

		void RenderArrowIcon(ImGuiDir dir, ImVec4 col = ImVec4(1, 1, 1, 1), float scale = 1.f);

		void HelpMarker(const char* desc, bool sameLine = true);

		//IMGUI include, dont USE!
		bool IsRootOfOpenMenuSet();

		void CloseIfCursorFarFromCenter(float distance = -1.f);

	    // add state if it is window
		void CloseIfCursorFarFromCenter(bool& winState, float distance = -1.f);

		bool MenuItemButton(const char* label, const char* shortcut = nullptr, bool closePopupOnClick = true, const char* icon = nullptr, bool selected = false, bool enabled = true);

		bool MatchPayloadType(const char* type);

		void DrawBgRows(float itemSpacingY = -1.f);

		bool BeginMenuFt(const char* label, ImFont* font);

	    //ImGui::PopColor(3) is needed
	    //if there is a loaded font, you need to pop
		void PushButtonColor(const ImVec4 color, const float hoverOffset = 0.8f, const float activeOffset = 0.9f, ImFont* font = nullptr);

		void DragButton2(const char* txt, glm::vec2& v);

		bool DragButton3(const char* txt, glm::vec3& v);

		void Separator();

		void Separator(const std::string& label);

		void SeparatorEx(ImGuiSeparatorFlags flags, float thickness, bool hover = false);

		void Text(const std::string& text);

		void HelpMarker(const std::string& desc);

		bool Drag(const std::string& label, float& v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag2(const std::string& label, float* v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag3(const std::string& label, float* v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag4(const std::string& label, float* v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag(const std::string& label, double& v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag2(const std::string& label, double* v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag3(const std::string& label, double* v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Drag4(const std::string& label, double* v, float v_speed = 1.f, float v_min = 0.f, float v_max = 0.f, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		//bool DragFloatRange2(const char* label, float* v_current_min, float* v_current_max, float v_speed = 1.0f, float v_min = 0.0f, float v_max = 0.0f, const char* format = "%.3f", const char* format_max = NULL, ImGuiSliderFlags flags = 0);
		bool Drag(const std::string& label, int& v, float v_speed = 1.f, int v_min = 0, int v_max = 0, const char* format = "%d", ImGuiSliderFlags flags = 0);

		bool Drag2(const std::string& label, int* v, float v_speed = 1.f, int v_min = 0, int v_max = 0, const char* format = "%d", ImGuiSliderFlags flags = 0);

		bool Drag3(const std::string& label, int* v, float v_speed = 1.f, int v_min = 0, int v_max = 0, const char* format = "%d", ImGuiSliderFlags flags = 0);

		bool Drag4(const std::string& label, int* v, float v_speed = 1.f, int v_min = 0, int v_max = 0, const char* format = "%d", ImGuiSliderFlags flags = 0);

		bool Drag(const std::string& label, uint32_t& v, float v_speed = 1.f, uint32_t v_min = 0, uint32_t v_max = 0, const char* format = "%u", ImGuiSliderFlags flags = 0);

		bool Drag2(const std::string& label, uint32_t* v, float v_speed = 1.f, uint32_t v_min = 0, uint32_t v_max = 0, const char* format = "%u", ImGuiSliderFlags flags = 0);

		bool Drag3(const std::string& label, uint32_t* v, float v_speed = 1.f, uint32_t v_min = 0, uint32_t v_max = 0, const char* format = "%u", ImGuiSliderFlags flags = 0);

		bool Drag4(const std::string& label, uint32_t* v, float v_speed = 1.f, uint32_t v_min = 0, uint32_t v_max = 0, const char* format = "%u", ImGuiSliderFlags flags = 0);

		bool Input(const std::string& label, float& v, float step = 0.f, float step_fast = 0.f, const char* format = "%.3f", ImGuiInputTextFlags flags = 0);

		bool Input2(const std::string& label, float* v, const char* format = "%.3f", ImGuiInputTextFlags flags = 0);

		bool Input3(const std::string& label, float* v, const char* format = "%.3f", ImGuiInputTextFlags flags = 0);

		bool Input4(const std::string& label, float* v, const char* format = "%.3f", ImGuiInputTextFlags flags = 0);

		bool Input(const std::string& label, int& v, int step = 1, int step_fast = 100, ImGuiInputTextFlags flags = 0);

		bool Input2(const std::string& label, int* v, ImGuiInputTextFlags flags = 0);

		bool Input3(const std::string& label, int* v, ImGuiInputTextFlags flags = 0);

		bool Input4(const std::string& label, int* v, ImGuiInputTextFlags flags = 0);

		bool InputUInt(const std::string& label, uint32_t& v, int step = 1, int step_fast = 100, ImGuiInputTextFlags flags = 0);

		bool InputDouble(const std::string& label, double& v, double step = 0.0, double step_fast = 0.0, const char* format = "%.6f", ImGuiInputTextFlags flags = 0);

		bool Checkbox(const std::string& label, bool& v);
		//bool DragIntRange2(const char* label, int* v_current_min, int* v_current_max, float v_speed = 1.0f, int v_min = 0, int v_max = 0, const char* format = "%d", const char* format_max = NULL, ImGuiSliderFlags flags = 0);
		//bool DragScalar(const char* label, ImGuiDataType data_type, void* p_data, float v_speed = 1.0f, const void* p_min = NULL, const void* p_max = NULL, const char* format = NULL, ImGuiSliderFlags flags = 0);
		//bool DragScalarN(const char* label, ImGuiDataType data_type, void* p_data, int components, float v_speed = 1.0f, const void* p_min = NULL, const void* p_max = NULL, const char* format = NULL, ImGuiSliderFlags flags = 0);

		bool Slider(const std::string& label, float& v, float v_min, float v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Slider2(const std::string& label, float* v, float v_min, float v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Slider3(const std::string& label, float* v, float v_min, float v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Slider4(const std::string& label, float* v, float v_min, float v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		//bool ImGui::SliderAngle(const char* label, float* v_rad, float v_degrees_min, float v_degrees_max, const char* format, ImGuiSliderFlags flags)

		bool Slider(const std::string& label, int& v, int v_min, int v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Slider2(const std::string& label, int* v, int v_min, int v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Slider3(const std::string& label, int* v, int v_min, int v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);

		bool Slider4(const std::string& label, int* v, int v_min, int v_max, const char* format = "%.3f", ImGuiSliderFlags flags = 0);
	}
}