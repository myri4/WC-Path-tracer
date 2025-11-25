#load "PathTracingRenderer.jai";
#load "ui_utils.jai";

#load "RenderData.jai";
#load "Renderer2D.jai";

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
gizmoOp := ImGuizmo.OPERATION.TRANSLATE;

pathTracer: PathTracingRenderer;
renderer2D: Renderer2D;
renderData: [vk.FRAME_OVERLAP]RenderData;

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
prevPos: Vector2;


InitEditor :: () {
	Init(*pathTracer);
	Init(*renderer2D);
	CreateScreen(*pathTracer, GetWindowSize());
	CreateScreen(*renderer2D, GetWindowSize());
	for * rd : renderData
		DrawLine(rd, .{}, .{});
}

ResizeEditor :: (size: Vector2) {
    if size.x < 0.0 || size.y < 0.0 {
        log_error("Invalid resize skipped!\n");
        return;
    }

    Resize(*pathTracer, size);
    Resize(*renderer2D, size);
}

DeinitEditor :: () {
	Deinit(*pathTracer);
	Deinit(*renderer2D);

	for * rd : renderData Free(rd);
}


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
		pathTracer.renderedFramesCount = 0;
	else 
		pathTracer.renderedFramesCount += 1;
}

UpdateEditor :: () {
	Update(*camera, ViewPortSize.x / ViewPortSize.y);
	UpdateMaterials(*pathTracer);
	Render(*pathTracer, camera);
	/*rd := *renderData[vk.CURRENT_FRAME_INDEX];

	for box : bvh {
		//if it_index > pathTracer.sceneData.boxID break;
		if box.triangleCount == 0 continue;
		DrawLineCube(rd, box.min, box.max);
	}

	proj := camera.projection;
	proj._22 *= -1.0;

	Flush(*renderer2D, rd, camera.view * proj);
	Reset(rd)*/
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

        allowedSelect := !ImGuizmo.IsOver() && !ImGuizmo.IsUsing();
		if selectedSphere == -1 allowedSelect = true;

		WindowPos = ImGui.GetWindowPos() + ImGui.GetCursorPos();
		RenderSize := WindowPos + availSize;

		GetWindowDrawList().AddImage(GetWindowDrawList(), .{_TexID = xx pathTracer.ImguiImageID}, WindowPos, RenderSize);
		//GetWindowDrawList().AddImage(GetWindowDrawList(), .{_TexID = xx renderer2D.imguiImageID}, WindowPos, RenderSize);

        projection := camera.projection;

		ImGuizmo.SetDrawlist();
		ImGuizmo.SetRect(WindowPos.x, WindowPos.y, availSize.x, availSize.y);
		if selectedSphere != -1 {
			sph := *pathTracer.spheres.data[selectedSphere];
			world_transform := transpose(make_translation_matrix4(sph.position));

			snap := float.[0.5, 0.5, 0.5];
			if ImGuizmo.Manipulate(
				xx *camera.view,
				xx *projection,
				gizmoOp,
				.WORLD,
				xx *world_transform,
				null,
				ifx ImGui.IsKeyDown(.LeftCtrl) snap.data else null
			) {
                pathTracer.renderedFramesCount = 0;
				translation:, rotation:, scale: Vector3;
				ImGuizmo.DecomposeMatrixToComponents(xx *world_transform, xx *translation, xx *rotation, xx *scale);

				sph.position = translation;
			}
		}
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
            for object, i : pathTracer.spheres.data {
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
                        //selectedSphere = cast(s32)(entities.count - 1);
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
		sphere := *pathTracer.spheres.data[selectedSphere];
		SeparatorText("Sphere");
		EditStruct(sphere);

		SeparatorText("Material");
		EditStruct(*pathTracer.materials.data[sphere.mat]);
	}
	End();
}

UI_SceneProperties :: () {
	if Begin("Scene properties", *showSceneProperties, .NoBackground | .AlwaysAutoResize) {
		EditStruct(*pathTracer);
		SeparatorText("Camera");
		EditStruct(*camera);
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
            dockspace_id := GetID("DockSpace");
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
		if showDebugStats UI_DebugStats();
	}
	End();
}
