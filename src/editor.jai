#load "PathTracingRenderer.jai";

// Debug stats
debugTimer: float32;

prevMaxFPS: u32;
maxFPS: u32;

prevMinFPS: u32;
minFPS: u32;

frameCount: u32;
frameCounter: u32;
prevFrameCounter: u32;

WindowPos: Vector2;
RenderSize: Vector2;

ViewPortSize := Vector2.{1.0, 1.0};

camera: Camera;
MouseSensitivity: float = 5.0;

pathTracer: PathTracingRenderer;

allowInput := true;

showSceneViewer := true;
showSceneProperties := true;
showSceneObjectsPanel := true;
showProperties := true;
showConsole := true;
showAssets := true;
showDebugStats := true;

deltaTime: float32;
lastFrame: float32;

windowFlags :=
    ImGui.WindowFlags.MenuBar | .NoDocking |
    .NoTitleBar | .NoCollapse |
    .NoResize | .NoMove |
    .NoBringToFrontOnFocus | .NoNavFocus |
    .MenuBar | .NoBackground;

themes := *u8.["SoDark".data, "Classic".data, "Dark".data, "Light".data];

selectedSphere: u32;
//selectedMaterial: u32;


InitEditor :: () {
	Init(*pathTracer);
	CreateScreen(*pathTracer, GetWindowSize());
}

ResizeEditor :: (size: Vector2) {
    if size.x < 0.0 || size.y < 0.0 {
        log_error("Invalid resize skipped!\n");
        return;
    }

    Resize(*pathTracer, size);
}

DeinitEditor :: () {
	Deinit(*pathTracer);
}

prevPos: Vector2;

InputEditor :: () {
	moved := false;
	if allowInput {
		yaw90 := radians(camera.yaw + 90.0);
		MovementSpeed := 4.0 * deltaTime;

		if ImGui.IsKeyDown(.W) {
			camera.position.x += camera.direction.x * MovementSpeed;
			camera.position.z += camera.direction.z * MovementSpeed;
			moved = true;
		}

		else if ImGui.IsKeyDown(.S) {
			camera.position.x -= camera.direction.x * MovementSpeed;
			camera.position.z -= camera.direction.z * MovementSpeed;
			moved = true;
		}
		
		if ImGui.IsKeyDown(.A) {
			camera.position.x -= cos(yaw90) * MovementSpeed;
			camera.position.z -= sin(yaw90) * MovementSpeed;
			moved = true;
		}
		else if ImGui.IsKeyDown(.D) {
			camera.position.x += cos(yaw90) * MovementSpeed;
			camera.position.z += sin(yaw90) * MovementSpeed;
			moved = true;
		}

		if ImGui.IsKeyDown(.Space) {
			camera.position.y += MovementSpeed;
			moved = true;
		}

		else if ImGui.IsKeyDown(.LeftShift) {
			camera.position.y -= MovementSpeed;
			moved = true;
		}


		if ImGui.IsKeyDown(.C) { 
			camera.fov = 10.0; 
			MouseSensitivity = 18;
			moved = true;
		}
		else {
			MouseSensitivity = 5.0;
			camera.fov = 90.0;
		}

		pos := GetCursorPosition();
		if ImGui.IsMouseDown(.Right) {
			ms: float = 1.0 / MouseSensitivity;

			camera.yaw -= (prevPos.x - pos.x) * ms;

			camera.pitch += (prevPos.y - pos.y) * ms;
			moved = true;
		}
		prevPos = pos;
	}

	if moved
		pathTracer.RenderedFramesCount = 0;
	else 
		pathTracer.RenderedFramesCount += 1;
}

UpdateEditor :: () {
	Update(*camera, ViewPortSize.x / ViewPortSize.y);
	UpdateMaterials(*pathTracer);
	Render(*pathTracer, camera);
}

UI_SceneViewer :: () {
	PushStyleVar(.WindowPadding, .{});
	if Begin("Scene", *showSceneViewer) {
		allowInput = IsWindowFocused() && IsWindowHovered();

		availSize := GetContentRegionAvail();
		if ViewPortSize != availSize {
			ViewPortSize = availSize;

            vkDeviceWaitIdle(vk.logicalDevice);
			ResizeEditor(ViewPortSize);
		}

		WindowPos = ImGui.GetWindowPos() + ImGui.GetCursorPos();
		RenderSize := WindowPos + availSize;

		GetWindowDrawList().AddImage(GetWindowDrawList(), .{_TexID = xx pathTracer.ImguiImageID}, WindowPos, RenderSize);
	}
	End();
	PopStyleVar(1);
}

UI_SceneObjects :: () {
	if Begin("Scene objects", *showSceneObjectsPanel) {
		/*for i: 0..pathTracer.Spheres.data.count - 1 {
			if Button(tprint("Sphere %\0", i).data) selectedSphere = xx i;
		}*/

		if BeginChild("##ShowObjects", .{ 0, 0 }, .None, .HorizontalScrollbar) {
            DrawBgRows();

            objectMenuOpen := false;
            for object, i : pathTracer.Spheres.data {
                PushID(i.(s32));
                defer PopID();

                node_flags: TreeNodeFlags = .SpanAvailWidth | .Leaf;

                if i == selectedSphere
                    node_flags |= .Selected;

                //if no_children
                //    node_flags |= .Leaf;

                if TreeNodeEx(tprint("Sphere %\0", i).data, node_flags)
                    TreePop();

                if IsItemClicked() && !IsItemToggledOpen()
                    selectedSphere = xx i;

                if IsMouseDoubleClicked(.Left) && IsItemHovered() {
					print("@TODO: Make it when you double click the camera goes to the object\n");
                }

                if BeginPopupContextItem("Object right click menu") {
                    objectMenuOpen = true;
                    if MenuItem("Clone") {
                        //append(*entities, entity);
						print("@TODO: Implement\n");

                        CloseCurrentPopup(); // @TODO: maybe check if shift is pressed to not close the popup
                    }

                    Separator();

                    PushStyleColor(.HeaderHovered, .{0.92, 0.25, 0.2, 1.0});
                    if MenuItem("Delete") {
                        remove i;
                        CloseCurrentPopup();
                    }
                    PopStyleColor();

                    EndPopup();
                }
            }


            if !objectMenuOpen && BeginPopupContextWindow("Add object menu") {
                if BeginMenu("Create new object") {
                    if MenuItem("Ground") {
						print("@TODO: Implement\n");
                        //append(*entities, .{type = .Ground, position = .{camera.position.x, camera.position.y, 0.0}, size = .{0.5, 0.5}});
                        //selectedEntity = cast(s32)(entities.count - 1);
                        CloseCurrentPopup();
                    }

                    EndMenu();
                }

                EndPopup();
            }
        }
        EndChild();
	}
	End();
}

UI_Properties :: () {
	if Begin("Properties", *showProperties) {
		sphere := *pathTracer.Spheres.data[selectedSphere];
		material := *pathTracer.Materials.data[sphere.mat];
		SeparatorText("Sphere");
		DragButton3("Position", *sphere.position);
		Drag("Radius", *sphere.radius, 0.1);

		SeparatorText("Material");
		ColorEdit3("Albedo", *material.albedo.component);
		ColorEdit3("Emission", *material.emission.component);

		dragSpeed: float = 0.01;
		minVal := 0.001;
		maxVal := 1.0;
		Drag("Metallic", *material.metallic, dragSpeed, *minVal, *maxVal);
		Drag("Roughness", *material.roughness, dragSpeed, *minVal, *maxVal);
		Drag("Index of refraction", *material.ior, dragSpeed);
	}
	End();
}

UI_SceneProperties :: () {
	if Begin("Scene properties", *showSceneProperties, .NoBackground | .AlwaysAutoResize) {
		Drag("Samples", *pathTracer.samples, 0.1);
		Drag("Max bounce count", *pathTracer.MaxBounceCount, 0.1);
		SeparatorText("Camera");
		DragButton3("Position", *camera.position);
		Drag("Yaw", *camera.yaw, 0.1);
		Drag("Pitch", *camera.pitch, 0.1);
	}
	End();
}

UI_DebugStats :: () {
	if Begin("Debug Stats", *showDebugStats) {
		fps := (1.0 / deltaTime).(u32);
		Text("Frame time: %.4ms", deltaTime * 1000.0);
		Text("FPS: %", fps);
		Text("Max FPS: %", prevMaxFPS);
		Text("Min FPS: %", prevMinFPS);
		Text("Average FPS: %", prevFrameCounter);

		debugTimer += deltaTime;

		maxFPS = max(maxFPS, fps);
		minFPS = min(minFPS, fps);

		frameCount += 1;
		frameCounter += fps;

		if debugTimer >= 1.0 {
			prevMaxFPS = maxFPS;
			prevMinFPS = minFPS;
			prevFrameCounter = frameCounter / frameCount;
			debugTimer = 0.0;

			frameCount = 0;
			frameCounter = 0;

			maxFPS = fps;
			minFPS = fps;
		}
	}
	End();
}

UI_Editor :: () {
	viewport := GetMainViewport();
    SetNextWindowPos(viewport.WorkPos);
    SetNextWindowSize(viewport.WorkSize);
    SetNextWindowViewport(viewport.ID_);

    PushStyleVar(.FramePadding, .{7.0, 7.0});
    PushStyleVar(.WindowRounding, 0.0);
    PushStyleVar(.WindowBorderSize, 0.0);
    PushStyleVar(.WindowPadding, .{});

	if Begin("DockSpace", flags = windowFlags) {
        PopStyleVar(4);
		//windowFlags |= .NoBackground;

		io := GetIO();
        if io.ConfigFlags_ & .DockingEnable {
            dockspace_id := GetID("MainDockSpace");
            DockSpace(dockspace_id, .{});
        }

		if BeginMenuBar() {
			if BeginMenu("View") {
				MenuItem("Scene viewer", null, *showSceneViewer);
				MenuItem("Scene properties", null, *showSceneProperties);
				MenuItem("Scene objects panel", null, *showSceneObjectsPanel);
				MenuItem("Properties", null, *showProperties);
				MenuItem("Console", null, *showConsole);
				MenuItem("Assets", null, *showAssets);
				MenuItem("Debug Statistics", null, *showDebugStats);

				EndMenu();
			}

			EndMenuBar();
		}

		if showSceneViewer UI_SceneViewer();
		if showSceneProperties UI_SceneProperties();
		if showSceneObjectsPanel UI_SceneObjects();
		if showProperties UI_Properties();
		//if (showAssets) UI_Assets();
		if showDebugStats UI_DebugStats();
	}
	End();
}




DrawBgRows :: (itemSpacingY: float32 = -1.0) {
	if itemSpacingY > -1 PushStyleVarY(.ItemSpacing, itemSpacingY);

    window := GetCurrentWindow();
	if window.SkipItems return;

	draw_list := GetWindowDrawList();
	style := GetStyle();

	scroll_y := GetScrollY();
	window_height := GetWindowHeight();

	row_height := style.ItemSpacing.y + GetTextLineHeight();

	row_start := cast(int)(scroll_y / row_height);
	row_count := cast(int)((scroll_y + window_height) / row_height) - row_start + 1;

	collOffset := 1.3;
	color_even := GetColorU32(style.Colors[Col.WindowBg]);
	color_odd := GetColorU32(.{ style.Colors[Col.WindowBg].x * collOffset, style.Colors[Col.WindowBg].y * collOffset, style.Colors[Col.WindowBg].z * collOffset, style.Colors[Col.WindowBg].w });

	win_pos := Vector2.{window.Pos.x, window.Pos.y - style.ItemSpacing.y * 0.5};
	clip_rect_min := Vector2.{ win_pos.x, win_pos.y };
	clip_rect_max := Vector2.{ win_pos.x + window.Size.x, win_pos.y + window_height };

	draw_list.PushClipRect(draw_list, clip_rect_min, clip_rect_max, true);

	for row: row_start.. (row_start + row_count) - 1 {
		col := ifx (row % 2 == 0)  color_even else color_odd;

		// Calculate row position
		y1 := win_pos.y + (row * row_height) - scroll_y;
		y2 := y1 + row_height;

		draw_list.AddRectFilled(draw_list,
			.{win_pos.x, y1},
			.{win_pos.x + window.Size.x, y2},
			col
		);
	}

	draw_list.PopClipRect(draw_list);
	if itemSpacingY > -1 PopStyleVar();
}


DragButton2 :: (txt: string, v: *Vector2, buttonWidth := 20.0, dragSpeed := 0.1) -> bool {
    spacing := GetStyle().ItemSpacing.x;

    availableWidth := GetContentRegionAvail().x;

    inputWidth := (availableWidth - (buttonWidth * 2) - (spacing * 3)) / 2;

    changed := false;

    PushStyleColor(.Button, .{1.0, 0.0, 0.0, 0.5});
    PushStyleColor(.ButtonHovered, .{1.0, 0.0, 0.0, 0.6});
    PushStyleColor(.ButtonActive, .{1.0, 0.0, 0.0, 0.75});
    if Button(tprint("X##X%", txt).data, .{buttonWidth, 0}) {
        if IsKeyDown(.LeftShift) v.x -= 1.0;
        else v.x += 1.0;
        changed = true;
    }
    PopStyleColor(3);

    SameLine(0, spacing);
    SetNextItemWidth(inputWidth);
    if DragFloat(tprint("##X%", txt).data, *v.x, dragSpeed)
        changed = true;

    SameLine(0, spacing);

    PushStyleColor(.Button, .{0.0, 1.0, 0.0, 0.5});
    PushStyleColor(.ButtonHovered, .{0.0, 1.0, 0.0, 0.6});
    PushStyleColor(.ButtonActive, .{0.0, 1.0, 0.0, 0.75});
    if Button(tprint("Y##Y%", txt).data, .{buttonWidth, 0}) {
        if IsKeyDown(.LeftShift) v.y -= 1.0;
        else v.y += 1.0;
        changed = true;
    }
    PopStyleColor(3);

    SameLine(0, spacing);
    SetNextItemWidth(inputWidth);
    if DragFloat(tprint("##Y%", txt).data, *v.y, dragSpeed)
        changed = true;

    return changed;
}

DragButton3 :: (txt: string, v: *Vector3, buttonWidth := 20.0, dragSpeed := 0.1) -> bool {
    spacing := GetStyle().ItemSpacing.x;

    availableWidth := GetContentRegionAvail().x;

    inputWidth := (availableWidth - (buttonWidth * 3) - (spacing * 5)) / 3;

    changed := false;

    PushStyleColor(.Button, .{1.0, 0.0, 0.0, 0.5});
    PushStyleColor(.ButtonHovered, .{1.0, 0.0, 0.0, 0.6});
    PushStyleColor(.ButtonActive, .{1.0, 0.0, 0.0, 0.75});
    if Button(tprint("X##X%", txt).data, .{buttonWidth, 0}) {
        if IsKeyDown(.LeftShift) v.x -= 1.0;
        else v.x += 1.0;
        changed = true;
    }
    PopStyleColor(3);

    SameLine(0, spacing);
    SetNextItemWidth(inputWidth);
    if DragFloat(tprint("##X%", txt).data, *v.x, dragSpeed)
        changed = true;

    SameLine(0, spacing);

    PushStyleColor(.Button, .{0.0, 1.0, 0.0, 0.5});
    PushStyleColor(.ButtonHovered, .{0.0, 1.0, 0.0, 0.6});
    PushStyleColor(.ButtonActive, .{0.0, 1.0, 0.0, 0.75});
    if Button(tprint("Y##Y%", txt).data, .{buttonWidth, 0}) {
        if IsKeyDown(.LeftShift) v.y -= 1.0;
        else v.y += 1.0;
        changed = true;
    }
    PopStyleColor(3);

    SameLine(0, spacing);
    SetNextItemWidth(inputWidth);
    if DragFloat(tprint("##Y%", txt).data, *v.y, dragSpeed)
        changed = true;

    SameLine(0, spacing);

    PushStyleColor(.Button, .{0.0, 0.0, 1.0, 0.5});
    PushStyleColor(.ButtonHovered, .{0.0, 0.0, 1.0, 0.6});
    PushStyleColor(.ButtonActive, .{0.0, 0.0, 1.0, 0.75});
    if Button(tprint("Z##Z%", txt).data, .{buttonWidth, 0}) {
        if IsKeyDown(.LeftShift) v.z -= 1.0;
        else v.z += 1.0;
        changed = true;
    }
    PopStyleColor(3);

    SameLine(0, spacing);
    SetNextItemWidth(inputWidth);
    if DragFloat(tprint("##Z%", txt).data, *v.z, dragSpeed)
        changed = true;

    return changed;
}

/*
IM_COL32 :: (R: u32, G: u32, B: u32, A: u32) -> u32 { return (A << IM_COL32_A_SHIFT) | (B << IM_COL32_B_SHIFT) | (G << IM_COL32_G_SHIFT) | (R << IM_COL32_R_SHIFT); }
GetWindowDockNode :: inline() -> *ImGui.DockNode { return ImGui.GImGui.CurrentWindow.DockNode_; }*/