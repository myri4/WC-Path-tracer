#pragma once
#define GLFW_EXPOSE_NATIVE_WIN32
#define GLFW_INCLUDE_NONE
#undef min
#undef max

#include "../Rendering/vk/VulkanContext.h"
#include "../Rendering/vk/Image.h"

#include <GLFW/glfw3.h>
#include <GLFW/glfw3native.h>
#include <glm/glm.hpp>
#include "Log.h"
#include "../imgui_backend/imgui_impl_glfw.h"

namespace wc 
{
    // @TODO: Implement and remake the whole event system
    enum class Action : uint8_t
    {
        RELEASED = 0,
        JUST_RELEASED,
        PRESSED,
        HOLD
    };

    inline double scrollX = 0.f, scrollY = 0.f;
    inline int MouseButtons[GLFW_MOUSE_BUTTON_LAST];
    inline int KeyButtons[GLFW_KEY_LAST];
    inline glm::uvec2 cursorPosition = glm::uvec2(0);

    namespace Key 
    {
        using KeyCode = uint16_t;

        enum : KeyCode 
        {
            // From glfw3.h
            Space = 32,
            Apostrophe = 39, /* ' */
            Comma = 44, /* , */
            Minus = 45, /* - */
            Period = 46, /* . */
            Slash = 47, /* / */

            D0 = 48, /* 0 */
            D1 = 49, /* 1 */
            D2 = 50, /* 2 */
            D3 = 51, /* 3 */
            D4 = 52, /* 4 */
            D5 = 53, /* 5 */
            D6 = 54, /* 6 */
            D7 = 55, /* 7 */
            D8 = 56, /* 8 */
            D9 = 57, /* 9 */

            Semicolon = 59, /* ; */
            Equal = 61, /* = */

            A = 65,
            B = 66,
            C = 67,
            D = 68,
            E = 69,
            F = 70,
            G = 71,
            H = 72,
            I = 73,
            J = 74,
            K = 75,
            L = 76,
            M = 77,
            N = 78,
            O = 79,
            P = 80,
            Q = 81,
            R = 82,
            S = 83,
            T = 84,
            U = 85,
            V = 86,
            W = 87,
            X = 88,
            Y = 89,
            Z = 90,

            LeftBracket = 91,  /* [ */
            Backslash = 92,  /* \ */
            RightBracket = 93,  /* ] */
            GraveAccent = 96,  /* ` */

            World1 = 161, /* non-US #1 */
            World2 = 162, /* non-US #2 */

            /* Function keys */
            Escape = 256,
            Enter = 257,
            Tab = 258,
            Backspace = 259,
            Insert = 260,
            Delete = 261,
            Right = 262,
            Left = 263,
            Down = 264,
            Up = 265,
            PageUp = 266,
            PageDown = 267,
            Home = 268,
            End = 269,
            CapsLock = 280,
            ScrollLock = 281,
            NumLock = 282,
            PrintScreen = 283,
            Pause = 284,
            F1 = 290,
            F2 = 291,
            F3 = 292,
            F4 = 293,
            F5 = 294,
            F6 = 295,
            F7 = 296,
            F8 = 297,
            F9 = 298,
            F10 = 299,
            F11 = 300,
            F12 = 301,
            F13 = 302,
            F14 = 303,
            F15 = 304,
            F16 = 305,
            F17 = 306,
            F18 = 307,
            F19 = 308,
            F20 = 309,
            F21 = 310,
            F22 = 311,
            F23 = 312,
            F24 = 313,
            F25 = 314,

            /* Keypad */
            KP0 = 320,
            KP1 = 321,
            KP2 = 322,
            KP3 = 323,
            KP4 = 324,
            KP5 = 325,
            KP6 = 326,
            KP7 = 327,
            KP8 = 328,
            KP9 = 329,
            KPDecimal = 330,
            KPDivide = 331,
            KPMultiply = 332,
            KPSubtract = 333,
            KPAdd = 334,
            KPEnter = 335,
            KPEqual = 336,

            LeftShift = 340,
            LeftControl = 341,
            LeftAlt = 342,
            LeftSuper = 343,
            RightShift = 344,
            RightControl = 345,
            RightAlt = 346,
            RightSuper = 347,
            Menu = 348
        };

        inline int GetKey(KeyCode keyCode) { return KeyButtons[keyCode]; }
    }

    namespace Mouse 
    {
        using MouseCode = uint16_t;

        enum : MouseCode 
        {
            Button0 = 0,
            Button1 = 1,
            Button2 = 2,
            Button3 = 3,
            Button4 = 4,
            Button5 = 5,
            Button6 = 6,
            Button7 = 7,

            LAST = Button7,
            LEFT = Button0,
            RIGHT = Button1,
            MIDDLE = Button2
        };

        inline int GetMouse(MouseCode key) { return MouseButtons[key]; }
        inline glm::uvec2 GetCursorPosition() { return cursorPosition; }

        inline glm::vec2 GetMouseScroll() { return glm::vec2(scrollX, scrollY); }
    }

    enum WindowMode { Normal, Maximized, Fullscreen };

    struct WindowCreateInfo 
    {
        uint32_t Width = 0;
        uint32_t Height = 0;
        std::string Name;
        WindowMode StartMode = WindowMode::Normal;
        bool VSync = false;
        bool Decorated = true;
        bool Resizeable = true;
    };

    inline const char* GetClipboard() { return glfwGetClipboardString(nullptr); }
    inline void SetClipboard(const std::string& string) { glfwSetClipboardString(nullptr, string.c_str()); }

    struct Monitor
    {
		Monitor() = default;
		Monitor(GLFWmonitor* monitor) { m_Monitor = monitor; }

		inline operator GLFWmonitor* () { return m_Monitor; }
		inline operator GLFWmonitor* () const { return m_Monitor; }

		inline operator bool() const { return m_Monitor != nullptr; }

        /*
        * @TODO: Get all video modes
        * @TODO: Get/Set user pointer
        * @TODO: Set gamma ramps
		int count;
        GLFWvidmode* modes = glfwGetVideoModes(monitor, &count);
        */

        auto GetVideoMode() const { return *glfwGetVideoMode(m_Monitor); }
        std::string GetName() const { return glfwGetMonitorName(m_Monitor); }
        auto GetGammaRamp() const { return *glfwGetGammaRamp(m_Monitor); }

        void SetGamma(float gamma) { glfwSetGamma(m_Monitor, gamma); }

        glm::ivec2 GetPhysicalSize() const
        {
			int width, height;
			glfwGetMonitorPhysicalSize(m_Monitor, &width, &height);
            return { width, height };
        }

		glm::vec2 GetContentScale() const
		{
			float xscale, yscale;
			glfwGetMonitorContentScale(m_Monitor, &xscale, &yscale);
			return { xscale, yscale };
		}

		glm::ivec2 GetVirtualPosition() const
		{
			int width, height;
            glfwGetMonitorPos(m_Monitor, &width, &height);
			return { width, height };
		}

    private:
        GLFWmonitor* m_Monitor = nullptr;
    };

    struct Window 
    {
        //half of actual border size
        const int borderSize = 5;
		bool resized = false;
		bool VSync = false;

		Window() = default;
		Window(GLFWwindow* window) { m_Window = window; }

		inline operator GLFWwindow* () { return m_Window; }
		inline operator GLFWwindow* () const { return m_Window; }

		inline operator bool() const { return m_Window != nullptr; }

        void Create(const WindowCreateInfo& info)
        {
            if (info.StartMode == WindowMode::Maximized)
                glfwWindowHint(GLFW_MAXIMIZED, true);
            else if (info.StartMode == WindowMode::Fullscreen)
                m_Monitor = glfwGetPrimaryMonitor();

            glfwWindowHint(GLFW_RESIZABLE, info.Resizeable);

            glfwWindowHint(GLFW_DECORATED, info.Decorated);

            m_Window = glfwCreateWindow(info.Width, info.Height, info.Name.c_str(), m_Monitor, nullptr);
            glfwSetWindowUserPointer(m_Window, this);

            glfwSetScrollCallback(m_Window, [](GLFWwindow* window, double xoffset, double yoffset) {
                scrollX = xoffset; scrollY = yoffset;

                ImGui_ImplGlfw_ScrollCallback(window, xoffset, yoffset);
                });

            glfwSetCharCallback(m_Window, [](GLFWwindow* window, uint32_t codepoint) {
                ImGui_ImplGlfw_CharCallback(window, codepoint);
                });

            glfwSetKeyCallback(m_Window, [](GLFWwindow* window, int key, int scancode, int action, int mods) {
                KeyButtons[key] = action;

                ImGui_ImplGlfw_KeyCallback(window, key, scancode, action, mods);
                });

            glfwSetCursorPosCallback(m_Window, [](GLFWwindow* window, double xpos, double ypos) {
                ImGui_ImplGlfw_CursorPosCallback(window, xpos, ypos);
                cursorPosition = glm::uvec2(xpos, ypos);
                });

            glfwSetMouseButtonCallback(m_Window, [](GLFWwindow* window, int button, int action, int mods) {
                MouseButtons[button] = action;
                ImGui_ImplGlfw_MouseButtonCallback(window, button, action, mods);
                });

            glfwSetCursorEnterCallback(m_Window, [](GLFWwindow* window, int entered) {
                ImGui_ImplGlfw_CursorEnterCallback(window, entered);
                });

            glfwSetWindowFocusCallback(m_Window, [](GLFWwindow* window, int focused) {
                ImGui_ImplGlfw_WindowFocusCallback(window, focused);
                });

            VSync = info.VSync;
        }

		void SetResizeCallback(GLFWwindowsizefun func) { glfwSetWindowSizeCallback(m_Window, func);	}
        void SetFramebufferResizeCallback(GLFWframebuffersizefun func) { glfwSetFramebufferSizeCallback(m_Window, func); }

        void SetFocus(bool focus = true) { glfwWindowHint(GLFW_FOCUSED, focus); }

        void Destroy() 
        { 
            glfwDestroyWindow(m_Window);
            m_Window = nullptr;
        }

        float GetAspectRatio() const
        {
            auto size = GetSize();
            return ((float)size.x / (float)size.y);
        }

        void PoolEvents() const 
        {
            scrollY = scrollX = 0.f;
            glfwPollEvents();
        }

        glm::ivec2 GetPosition() const
        {
            int xpos, ypos;
            glfwGetWindowPos(m_Window, &xpos, &ypos);
            return { xpos, ypos };
        }

        glm::ivec2 GetSize() const 
        {
            int width, height;
            glfwGetWindowSize(m_Window, &width, &height);
            return { width, height };
        }

		glm::ivec2 GetFramebufferSize() const
		{
			int width, height;
            glfwGetFramebufferSize(m_Window, &width, &height);
			return { width, height };
		}

        VkExtent2D GetExtent() const 
        {
            int width, height;
            glfwGetWindowSize(m_Window, &width, &height);
            return { (uint32_t)width, (uint32_t)height };
        }

        VkExtent2D GetFramebufferExtent() const 
        {
            int width, height;
            glfwGetFramebufferSize(m_Window, &width, &height);
            return { (uint32_t)width, (uint32_t)height };
        }

        void Close(bool value = true) const { glfwSetWindowShouldClose(m_Window, value); }

        bool IsOpen() const { return !glfwWindowShouldClose(m_Window); }

        bool HasFocus() const { return glfwGetWindowAttrib(m_Window, GLFW_FOCUSED); }

        void SetCursorPos(glm::ivec2 pos) { glfwSetCursorPos(m_Window, pos.x, pos.y); }

        void SetMaximized(bool maximized) 
        {
            if (maximized) glfwMaximizeWindow(m_Window);
            else glfwRestoreWindow(m_Window);
        }

		bool IsMaximized() const { return glfwGetWindowAttrib(m_Window, GLFW_MAXIMIZED); }

        void SetMinimized(bool minimized)
		{
		    if (minimized) glfwIconifyWindow(m_Window);
		    else glfwRestoreWindow(m_Window);
		}

        bool IsMinimized() const { return glfwGetWindowAttrib(m_Window, GLFW_ICONIFIED); }

        void SetPosition(glm::ivec2 pos) { glfwSetWindowPos(m_Window, pos.x, pos.y); }

        void SetTitle(const std::string& title) { glfwSetWindowTitle(m_Window, title.c_str()); }

        void SetSize(glm::ivec2 size) { glfwSetWindowSize(m_Window, size.x, size.y); }

        void SetSizeLimits(glm::ivec2 minSize, glm::ivec2 maxSize) { glfwSetWindowSizeLimits(m_Window, minSize.x, minSize.y, maxSize.x, maxSize.y); }

        void Maximize() { glfwMaximizeWindow(m_Window); }

        void Minimize() { glfwIconifyWindow(m_Window); }

        void Restore() { glfwRestoreWindow(m_Window); }

        void SetCursorMode(int value) { glfwSetInputMode(m_Window, GLFW_CURSOR, value); }

        void Focus() { glfwFocusWindow(m_Window); }

        void RequestAttention() { glfwRequestWindowAttention(m_Window); }

		void SetMonitor() 
        {
			auto mode = m_Monitor.GetVideoMode();
			glfwSetWindowMonitor(m_Window, m_Monitor, 0, 0, mode.width, mode.height, GLFW_DONT_CARE);
		}

        glm::ivec2 GetCursorPos() 
        {
            double x, y;
            glfwGetCursorPos(m_Window, &x, &y);
            return glm::ivec2(x, y);
        }
    private:

        void SetAttrib(int attrib, int value) const { glfwSetWindowAttrib(m_Window, attrib, value); }
        int GetAttrib(int attrib) const { return glfwGetWindowAttrib(m_Window, attrib); }

        GLFWwindow* m_Window = nullptr;
        Monitor m_Monitor;
    };
}