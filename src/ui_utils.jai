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

EditStruct :: (structValue: *$T) {
    info := type_info(T);
    if info.type != .STRUCT  assert(false, "Trying to edit non struct stuff");
    struct_info := cast(*Type_Info_Struct)info;
    if BeginTable("properties", 2, .Resizable | .BordersInnerV | .SizingStretchProp) {
        TableSetupColumn("Label", .WidthFixed);
        TableSetupColumn("Value", .WidthStretch);
        for member, i : struct_info.members {
            for note : member.notes {
                if note == "NoDisplay"
                    continue member;
            }
            member_ptr := (structValue).(*u8) + member.offset_in_bytes;
            EditStructMember(member_ptr, *member);
        }
        EndTable();
    }
}

EditStructMember :: (data: *void, memberInfo: *Type_Info_Struct_Member, dragSpeed: float = 0.1) {
	push_allocator(temp);
	defer reset_temporary_storage();
    name := memberInfo.name;
    typeInfo := memberInfo.type;
    noEdit := false;
    hasRange := false;
    minValue: float64;
    maxValue: float64;
    
    for note : memberInfo.notes {
        if starts_with(note, "Name=") { 
            name = copy_string(slice(note, 5, note.count - 5));
            replace_chars(name, "_", #char " ");
        }
        else if note == "NoEdit" { noEdit = true; }
        else if starts_with(note, "Range[") {
            hasRange = true;
            content := slice(note, 6, note.count - 7); // Remove "Range[" and "]"
            parts := split(content, ",");
            for part : parts {
                trimmed := trim(part);
                if starts_with(trimmed, "min=") {
                    min_str := slice(trimmed, 4, trimmed.count - 4);
                    minValue = string_to_float64(min_str);
                } 
				else if starts_with(trimmed, "max=") {
                    max_str := slice(trimmed, 4, trimmed.count - 4);
                    maxValue = string_to_float64(max_str);
                }
            }
        }
    }
    
    TableNextRow();
    TableNextColumn();
    AlignTextToFramePadding();
    Text(name);
    TableNextColumn();
    
    SetNextItemWidth(-FLOAT32_MIN);
    
    if noEdit {
        Text("%", Any.{type = typeInfo, value_pointer = data});
    } else {
        if typeInfo.type == {
            case .INTEGER;
                if hasRange {
                    min_int := cast(s64)minValue;
                    max_int := cast(s64)maxValue;
                    SliderScalar(tprint("##%", name).data, ImGui.GetDataType(typeInfo), data, *min_int, *max_int);
                } else {
                    DragScalar(tprint("##%", name).data, ImGui.GetDataType(typeInfo), data, dragSpeed);
                }
            case .FLOAT;
                if hasRange {
                    min_float := cast(float32)minValue;
                    max_float := cast(float32)maxValue;
                    SliderScalar(tprint("##%", name).data, ImGui.GetDataType(typeInfo), data, *min_float, *max_float);
                } else {
                    DragScalar(tprint("##%", name).data, ImGui.GetDataType(typeInfo), data, dragSpeed);
                }
            case .BOOL;
                Checkbox(tprint("##%", name).data, cast(*bool) data);
            case .ENUM;
                enum_info := cast(*Type_Info_Enum) typeInfo;
                current_value := cast(*s64, data).*;

                enum_name: string;
                for enum_info.values if it == xx current_value {
                    enum_name = enum_info.names[it_index];
                    break;
                }

                if !enum_name enum_name = tprint("%", current_value);
                
                if BeginCombo(tprint("##%\0", name).data, tprint("%\0", enum_name).data) {
                    for enum_name, index : enum_info.names {
                        is_selected := (current_value == index);
                        if Selectable(tprint("%\0", enum_name).data, is_selected) cast(*s64, data).* = index;
                        if is_selected SetItemDefaultFocus();
                    }
                    EndCombo();
                }
            case .STRUCT;
                struct_info := cast(*Type_Info_Struct) typeInfo;
                if struct_info.name == {
                    case "Vector2";
                        DragButton2(name, data, dragSpeed = dragSpeed);
                    case "Vector3";
                        color := false;
                        for note : memberInfo.notes {
                            if note == "Color" {
                                color = true;
                                break;
                            }
                        }
                        if color 
                            ColorEdit3(tprint("##%\0", name).data, data, .Float);
                        else 
                            DragButton3(name, data, dragSpeed = dragSpeed);
                    case "Vector4";
                        color := false;
                        for note : memberInfo.notes {
                            if note == "Color" {
                                color = true;
                                break;
                            }
                        }
                        if color ColorEdit4(tprint("##%\0", name).data, data);
                        else DragFloat4(tprint("##%", name).data, data, dragSpeed);
                    case;
                        if TreeNode(tprint("WARNING!!! %##%", name, name).data) {
                            if BeginTable(tprint("nested_%", name).data, 2, .SizingStretchProp | .BordersInnerV) {
                                TableSetupColumn("Label", .WidthFixed);
                                TableSetupColumn("Value", .WidthStretch);
                                for member : struct_info.members {
                                    member_ptr := cast(*u8) data + member.offset_in_bytes;
                                    EditStructMember(member_ptr, *member, dragSpeed);
                                }
                                EndTable();
                            }
                            TreePop();
                        }
                }
            case;
                Text("% (unsupported type: %)", name, typeInfo.type);
        }
    }
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