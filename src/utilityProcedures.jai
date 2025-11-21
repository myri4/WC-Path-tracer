/*
This file contains some functions that are completetly out of place in other parts of the code
but are needed for its functioning due to some missing parts of the standard library.

@TODO: 
Add find_by procedure
Add multi-argument append_if_unique
Add pop_back procedure
*/

log_warning :: (format_string: string, args: ..Any, loc := #caller_location, flags := Log_Flags.NONE, user_flags : u32 = 0, section : *Log_Section = null) {
    log(format_string, ..args, loc, flags | .WARNING, user_flags, section);
} @PrintLike

push_logger :: (logger: Logger) #expand #no_debug {
    old_logger     := context.logger;
    context.logger  = logger;

    `defer context.logger = old_logger;
}

get_identifier_name :: (name: Code) -> string {
    #import "Compiler";

    node := compiler_get_nodes(name);
    if node.kind != .IDENT {
        compiler_report("Not an identifier.", make_location(node));
        return "";
    }

    ident := cast(*Code_Ident) node;
    return ident.name;
}

// WARN(perf): This is O(n) on the # of values in the enum!
enum_to_string :: (value: $T) -> string {
    info_enum := type_info(T);
    for info_enum.values if it == xx value {
        return info_enum.names[it_index];
    }
    return "";
}

// WARN(perf): This is O(n) on the # of values in the enum!
string_to_enum :: (name: string, $T: Type) -> success: bool, result: T {
    info_enum := type_info(T);
    for info_enum.names if it == name {
        return true, xx info_enum.values[it_index];
    }
    return false, -1;
}

radians :: (angle: float) -> float { return angle * PI / 180.0; }
round :: (f: float) -> float { return floor(f + 0.5); }

floor :: (v: Vector2) -> Vector2 { return .{ floor(v.x), floor(v.y) }; }
ceil :: (v: Vector2) -> Vector2 { return .{ ceil(v.x), ceil(v.y) }; }
round :: (v: Vector2) -> Vector2 { return .{ floor(v.x + 0.5), floor(v.y + 0.5) }; }

append :: (builder: *String_Builder, value: int) { print_integer(builder, .{value=value}); }

copy :: array_copy;
free :: array_free;
reset :: array_reset;
append :: array_add;
append_if_unique :: array_add_if_unique;
insert_at :: array_insert_at;
unordered_remove_by_value :: array_unordered_remove_by_value;
unordered_remove_by_index :: array_unordered_remove_by_index;
ordered_remove_by_value :: array_ordered_remove_by_value;
ordered_remove_by_index :: array_ordered_remove_by_index;
find :: array_find;
reserve :: array_reserve;
resize :: array_resize;

ensure_space :: table_ensure_space;
append :: table_add;
set :: table_set;
contains :: table_contains;
find_pointer :: table_find_pointer;
find :: table_find;
find_multiple :: table_find_multiple;
//remove :: table_remove;

// IMPORTANT!!!! DO NOT FORGET TO PUT '\0' AT THE END OF EVERY FILTER STRING!!!!!

/*OpenFileDialog :: (window: *glfw.window, filter: string) -> bool, string {
    #if OS == .WINDOWS {
        ofn: OPENFILENAMEA;
        ofn.lStructSize = size_of(OPENFILENAMEA);
        ofn.hwndOwner = glfw.GetWin32Window(window);
        szFile: [260]u8;
        currentDir: [256]u8;
        ofn.lpstrFile = szFile.data;
        ofn.nMaxFile = size_of(type_of(szFile));
        if GetCurrentDirectoryA(256, currentDir.data)
            ofn.lpstrInitialDir = currentDir.data;
        ofn.lpstrFilter = temp_c_string(filter);
        ofn.nFilterIndex = 1;
        ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST | OFN_NOCHANGEDIR;

        if GetOpenFileNameA(*ofn)
            return true, copy_string(to_string(ofn.lpstrFile),,temp);
    }
    else log_error("UNSUPPORTED OS!\n");

	return false, "";
}

SaveFileDialog :: (window: *glfw.window, filter: string) -> bool, string {
    #if OS == .WINDOWS {
        ofn: OPENFILENAMEA;
        ofn.lStructSize = size_of(OPENFILENAMEA);
        ofn.hwndOwner = glfw.GetWin32Window(window);
        szFile: [260]u8;
        currentDir: [256]u8;
        ofn.lpstrFile = szFile.data;
        ofn.nMaxFile = size_of(type_of(szFile));
        if GetCurrentDirectoryA(256, currentDir.data)
            ofn.lpstrInitialDir = currentDir.data;
        ofn.lpstrFilter = temp_c_string(filter);
        ofn.nFilterIndex = 1;
        ofn.Flags = OFN_PATHMUSTEXIST | OFN_OVERWRITEPROMPT | OFN_NOCHANGEDIR;

        index := find_index_from_left(filter, #char "\0");
        if index >= 0 {
            ofn.lpstrDefExt = filter.data + index + 1;
        }

        if GetSaveFileNameA(*ofn)
            return true, copy_string(to_string(ofn.lpstrFile),,temp);
    }
    else log_error("UNSUPPORTED OS!\n");

	return false, "";
}*/

#scope_file