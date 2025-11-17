InitApp :: () -> bool {
    if !DebugCheckVersionAndDataLayout(IMGUI_VERSION, size_of(IO), size_of(Style), size_of(Vector2), size_of(Vector4), size_of(DrawVert), size_of(DrawIdx)) {
        log_error("Failed imgui DebugCheckVersionAndDataLayout\n");
        return false;
    }

    imguiContext = CreateContext();
    //SetCurrentContext(*imguiContext);

    vk.CreateDescriptorAllocator();

    init_info := ImplVulkan_InitInfo.{
        ApiVersion = VK_API_VERSION_1_2,
        Instance = vk.instance,
        PhysicalDevice = vk.physicalDevice.handle,
        Device = vk.logicalDevice,
        QueueFamily = vk.graphicsQueue.familyIndex,
        Queue = vk.graphicsQueue,
        PipelineCache = VK_NULL_HANDLE,
        DescriptorPool = vk.DescriptorAllocator.CurrentPool,
        RenderPass = swapchain.renderPass,
        MinImageCount = 2,
        ImageCount = 3,
        MSAASamples = ._1_BIT,
        Allocator = null,
        CheckVkResultFn = (err: VkResult) #c_call {
            push_context {
                if err == .SUCCESS
                    return;
                log_error("Vulkan Error: %\n", err);
                //if err < 0
                //    abort();
            }
        },
    };
    ImplVulkan_Init(*init_info);
    ImplGlfw_InitForVulkan(window, false);    

    io := GetIO();

    io.ConfigFlags_ |= .DockingEnable | .ViewportsEnable | .NavEnableKeyboard | .NavEnableGamepad;

    // Default font -> Poppins
    /*Globals.f_Default.Regular = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Regular.ttf", 17.f);
    Globals.f_Default.Bold = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Bold.ttf", 17.f);
    Globals.f_Default.Italic = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Italic.ttf", 17.f);
    Globals.f_Default.Thin = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Thin.ttf", 17.f);
    Globals.f_Default.Big = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Regular.ttf", 30.f);
    Globals.f_Default.Small = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Regular.ttf", 14.f);
    Globals.f_Default.Menu = io.Fonts.AddFontFromFileTTF("assets/fonts/Poppins/Poppins-Regular.ttf", 20.f);

    // Display font -> Neptune
    Globals.f_Display.Regular = io.Fonts.AddFontFromFileTTF("assets/fonts/SeedSans/SeedSans-Regular.ttf", 17.f);
    Globals.f_Display.Bold = io.Fonts.AddFontFromFileTTF("assets/fonts/SeedSans/SeedSans-Bold.ttf", 17.f);
    Globals.f_Display.Thin = io.Fonts.AddFontFromFileTTF("assets/fonts/SeedSans/SeedSans-Thin.ttf", 17.f);
    Globals.f_Display.Big = io.Fonts.AddFontFromFileTTF("assets/fonts/SeedSans/SeedSans-Regular.ttf", 30.f);
    Globals.f_Display.Small = io.Fonts.AddFontFromFileTTF("assets/fonts/SeedSans/SeedSans-Regular.ttf", 14.f);
    Globals.f_Display.Menu = io.Fonts.AddFontFromFileTTF("assets/fonts/SeedSans/SeedSans-Regular.ttf", 20.f);*/

    style := GetStyle();
    style.* = SoDark(0.43);
    if io.ConfigFlags_ & .ViewportsEnable {
        style.WindowRounding = 0;
        style.Colors[Col.WindowBg].w = 1;
    }

	InitEditor();

    return true;
}

UI :: () {
    ImplGlfw_NewFrame();
    ImplVulkan_NewFrame();
    NewFrame();
    //ImGuizmo.BeginFrame();
    UI_Editor();

    Render();

    if GetIO().ConfigFlags_ & .ViewportsEnable {
    	UpdatePlatformWindows();
    	RenderPlatformWindowsDefault();
    }
}

DeinitApp :: () {
	Deinit(*pathTracer);

	DeinitEditor();

    ImplGlfw_Shutdown();
    ImplVulkan_Shutdown();

    vk.DestroyDescriptorAllocator();

    DestroyContext();
}

using,except(Font, Table, GetWindowSize) ImGui :: #import "ImGui2"(BACKEND_GLFW = true, BACKEND_VULKAN = true);
ImGuizmo :: #import "ImGuizmo";

#load "editor.jai";


imguiContext: ImGuiContext;


ApplyHue :: (style: *Style, hue: float32)
{
	for i: 0..Col.COUNT - 1
	{
		col := *style.Colors[i];

		h, s, v: float32;
		ColorConvertRGBtoHSV(col.x, col.y, col.z, *h, *s, *v);
		h = hue;
		ColorConvertHSVtoRGB(h, s, v, *col.x, *col.y, *col.z);
	}
}

SoDark :: (hue: float32) -> Style
{
	style: Style;
    style.Constructor(*style);
	colors := style.Colors;
	colors[Col.Text] = .{1.0, 1.0, 1.0, 1.0};
	colors[Col.TextDisabled] = .{0.50, 0.50, 0.50, 1.0};
	colors[Col.WindowBg] = .{0.10, 0.10, 0.10, 1.0};
	colors[Col.ChildBg] = .{0.0, 0.0, 0.0, 0.0};
	colors[Col.PopupBg] = .{0.19, 0.19, 0.19, 0.92};
	colors[Col.Border] = .{0.33, 0.33, 0.33, 0.59};
	colors[Col.BorderShadow] = .{0.0, 0.0, 0.0, 0.24};
	colors[Col.FrameBg] = .{0.25, 0.25, 0.25, 0.54};
	colors[Col.FrameBgHovered] = .{0.19, 0.19, 0.19, 0.54};
	colors[Col.FrameBgActive] = .{0.20, 0.22, 0.23, 1.0};
	colors[Col.TitleBg] = .{0.0, 0.0, 0.0, 1.0};
	colors[Col.TitleBgActive] = .{0.06, 0.06, 0.06, 1.0};
	colors[Col.TitleBgCollapsed] = .{0.0, 0.0, 0.0, 1.0};
	colors[Col.MenuBarBg] = .{0.14, 0.14, 0.14, 1.0};
	colors[Col.ScrollbarBg] = .{0.05, 0.05, 0.05, 0.54};
	colors[Col.ScrollbarGrab] = .{0.34, 0.34, 0.34, 0.54};
	colors[Col.ScrollbarGrabHovered] = .{0.40, 0.40, 0.40, 0.54};
	colors[Col.ScrollbarGrabActive] = .{0.56, 0.56, 0.56, 0.54};
	colors[Col.CheckMark] = .{0.33, 0.67, 0.86, 1.0};
	colors[Col.SliderGrab] = .{0.34, 0.34, 0.34, 0.54};
	colors[Col.SliderGrabActive] = .{0.56, 0.56, 0.56, 0.54};
	colors[Col.Button] = .{0.30, 0.30, 0.30, 0.54};
	colors[Col.ButtonHovered] = .{0.19, 0.19, 0.19, 0.54};
	colors[Col.ButtonActive] = .{0.20, 0.22, 0.23, 1.0};
	colors[Col.Header] = .{0.0, 0.0, 0.0, 0.52};
	colors[Col.HeaderHovered] = .{0.0, 0.0, 0.0, 0.36};
	colors[Col.HeaderActive] = .{0.20, 0.22, 0.23, 0.33};
	colors[Col.Separator] = .{0.33, 0.33, 0.33, 0.59};
	colors[Col.SeparatorHovered] = .{0.44, 0.44, 0.44, 0.29};
	colors[Col.SeparatorActive] = .{1.000, 0.000, 0.000, 0.500};
	colors[Col.ResizeGrip] = .{0.28, 0.28, 0.28, 0.29};
	colors[Col.ResizeGripHovered] = .{0.44, 0.44, 0.44, 0.29};
	colors[Col.ResizeGripActive] = .{1.0, 0.0, 0.0, 0.50};
	colors[Col.Tab] = .{0.0, 0.0, 0.0, 0.52};
	colors[Col.TabHovered] = .{0.14, 0.14, 0.14, 1.0};
	colors[Col.DockingPreview] = .{0.20, 0.22, 0.23, 1.0};
	colors[Col.DockingEmptyBg] = .{0.20, 0.20, 0.20, 0.36};
	colors[Col.PlotLines] = .{1.0, 0.0, 0.0, 1.0};
	colors[Col.PlotLinesHovered] = .{1.0, 0.0, 0.0, 1.0};
	colors[Col.PlotHistogram] = .{1.0, 0.0, 0.0, 1.0};
	colors[Col.PlotHistogramHovered] = .{1.0, 0.0, 0.0, 1.0};
	colors[Col.TableHeaderBg] = .{0.0, 0.0, 0.0, 0.35};
	colors[Col.TableBorderStrong] = .{0.28, 0.28, 0.28, 0.29};
	colors[Col.TableBorderLight] = .{0.28, 0.28, 0.28, 0.29};
	colors[Col.TableRowBg] = .{0.10, 0.10, 0.10, 1.0}; // -
	colors[Col.TableRowBgAlt] = .{0.13, 0.13, 0.13, 1.0}; // -
	colors[Col.TextSelectedBg] = .{1.0, 1.0, 1.0, 0.27};
	colors[Col.DragDropTarget] = .{0.33, 0.67, 0.86, 1.0};
	colors[Col.NavWindowingHighlight] = .{1.0, 0.0, 0.0, 0.70};
	colors[Col.NavWindowingDimBg] = .{1.0, 0.0, 0.0, 0.20};
	colors[Col.ModalWindowDimBg] = .{0.22, 0.22, 0.22, 0.373};

	style.WindowPadding = .{8.0, 8.0};
	style.FramePadding = .{5.0, 2.0};
	style.CellPadding = .{6.0, 6.0};
	style.ItemSpacing = .{6.0, 6.0};
	style.ItemInnerSpacing = .{6.0, 6.0};
	style.TouchExtraPadding = .{0.0, 0.0};
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
	style.WindowMenuButtonPosition = .None;

	ApplyHue(*style, hue);

	return style;
}