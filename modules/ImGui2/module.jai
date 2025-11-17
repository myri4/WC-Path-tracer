#module_parameters (
BACKEND_VULKAN := false,
BACKEND_GLFW := false
);

Vector :: struct (T: Type) {
    Size: s32;
    Capacity: s32;
    Data: *T;
}

DrawCallback :: #type (parent_list: *DrawList, cmd: *DrawCmd) #c_call;

Drag :: (label: *u8, p_data: *$T, v_speed: float = 1.0, p_min: *T = null, p_max: *T = null, format: *u8 = null, flags: SliderFlags = .None) -> bool
{
    dataType :: #run GetDataType(type_info(T));
    
    return DragScalar(label, dataType, xx p_data, v_speed, xx p_min, xx p_max, format, flags);
}

#scope_module

#import "Basic";
#import "Math";

#load "imgui.jai";

#if BACKEND_VULKAN { #load "backend_vulkan.jai"; }
#if BACKEND_GLFW { #load "backend_glfw.jai"; }

#if OS == .WINDOWS {
    #library,system,link_always "user32";
    #library,system,link_always "shell32";
}

GetDataType :: (info: *Type_Info) -> DataType
{
    if info.type == {
        case .INTEGER;
            int_info := cast(*Type_Info_Integer) info;
            if int_info.signed 
            {
                if int_info.runtime_size == {
                    case 1; return .S8;
                    case 2; return .S16;
                    case 4; return .S32;
                    case 8; return .S64;
                }
            } 
            else 
            {
                if int_info.runtime_size == {
                    case 1; return .U8;
                    case 2; return .U16;
                    case 4; return .U32;
                    case 8; return .U64;
                }
            }
            
        case .FLOAT;
            float_info := cast(*Type_Info_Float) info;
            if float_info.runtime_size == {
                case 4; return .Float;
                case 8; return .Double;
            }
        case;
            print("Unsupported type %\n", info);
    }

    return .Bool;
}
