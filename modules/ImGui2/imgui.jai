//
// This file was auto-generated using the following command:
//
// jai scripts/generate_bindings.jai
//



IMGUI_DISABLE_OBSOLETE_FUNCTIONS :: 1;
IMGUI_VERSION :: "1.92.3 WIP";
IMGUI_VERSION_NUM :: 19226;

TextureID_Invalid :: cast(TextureID) 0;

IMGUI_PAYLOAD_TYPE_COLOR_3F :: "_COL3F";
IMGUI_PAYLOAD_TYPE_COLOR_4F :: "_COL4F";

IM_UNICODE_CODEPOINT_INVALID :: 0xFFFD;

IM_UNICODE_CODEPOINT_MAX :: 0xFFFF;

IM_COL32_R_SHIFT :: 0;
IM_COL32_G_SHIFT :: 8;
IM_COL32_B_SHIFT :: 16;
IM_COL32_A_SHIFT :: 24;
IM_COL32_A_MASK :: 0xFF000000;

IM_DRAWLIST_TEX_LINES_WIDTH_MAX :: 32;

FontAtlasRectId_Invalid :: -1;

IMGUI_PAYLOAD_TYPE_WINDOW :: "_IMWINDOW";

IM_PI :: 3.14159265358979323846;

IM_NEWLINE :: "\r\n";

IM_TABSIZE :: 4;

IM_PRId64 :: "lld";
IM_PRIu64 :: "llu";
IM_PRIX64 :: "llX";

IM_DRAWLIST_CIRCLE_AUTO_SEGMENT_MIN :: 4;
IM_DRAWLIST_CIRCLE_AUTO_SEGMENT_MAX :: 512;

IM_DRAWLIST_ARCFAST_TABLE_SIZE :: 48;

IM_DRAWLIST_ARCFAST_SAMPLE_MAX :: IM_DRAWLIST_ARCFAST_TABLE_SIZE;

IMSTB_TEXTEDIT_STRING :: InputTextState;

IMSTB_TEXTEDIT_GETWIDTH_NEWLINE :: -1.0;
IMSTB_TEXTEDIT_UNDOSTATECOUNT :: 99;
IMSTB_TEXTEDIT_UNDOCHARCOUNT :: 999;

Key_LegacyNativeKey_BEGIN :: 0;
Key_LegacyNativeKey_END :: 512;

KeyOwner_Any :: cast(ID) 0;
KeyOwner_NoOwner :: cast,trunc(ID) -1;

SelectionUserData_Invalid :: cast,trunc(SelectionUserData) -1;

DOCKING_HOST_DRAW_CHANNEL_BG :: 0;
DOCKING_HOST_DRAW_CHANNEL_FG :: 1;

IMGUI_TABLE_MAX_COLUMNS :: 512;

IMGUI_FONT_SIZE_MAX :: 512.0;
IMGUI_FONT_SIZE_THRESHOLD_FOR_LOADADVANCEXONLYMODE :: 128.0;

FontAtlasRectId_IndexMask :: 0x0007FFFF;
FontAtlasRectId_GenerationMask :: 0x3FF00000;
FontAtlasRectId_GenerationShift :: 20;

// Scalar data types
ID :: u32;
S8 :: s8;
U8 :: u8;
S16 :: s16;
U16 :: u16;
S32 :: s32;
U32 :: u32;
S64 :: s64;
U64 :: u64;

// Enumerations
// - We don't use strongly typed enums much because they add constraints (can't extend in private code, can't store typed in bit fields, extra casting on iteration)
// - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
//   - In Visual Studio: CTRL+comma ("Edit.GoToAll") can follow symbols inside comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
//   - In Visual Studio w/ Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols inside comments.
//   - In VS Code, CLion, etc.: CTRL+click can follow symbols inside comments.
Dir :: enum s32 {
    None  :: -1;
    Left  :: 0;
    Right :: 1;
    Up    :: 2;
    Down  :: 3;
    COUNT :: 4;
}

// A key identifier (ImGuiKey_XXX or ImGuiMod_XXX value): can represent Keyboard, Mouse and Gamepad values.
// All our named keys are >= 512. Keys value 0 to 511 are left unused and were legacy native/opaque key values (< 1.87).
// Support for legacy keys was completely removed in 1.91.5.
// Read details about the 1.87+ transition : https://github.com/ocornut/imgui/issues/4921
// Note that "Keys" related to physical keys and are not the same concept as input "Characters", the later are submitted via io.AddInputCharacter().
// The keyboard key enum values are named after the keys on a standard US keyboard, and on other keyboard types the keys reported may not match the keycaps.
Key :: enum s32 {
    None                :: 0;
    NamedKey_BEGIN      :: 512;

    Tab                 :: 512;
    LeftArrow           :: 513;
    RightArrow          :: 514;
    UpArrow             :: 515;
    DownArrow           :: 516;
    PageUp              :: 517;
    PageDown            :: 518;
    Home                :: 519;
    End                 :: 520;
    Insert              :: 521;
    Delete              :: 522;
    Backspace           :: 523;
    Space               :: 524;
    Enter               :: 525;
    Escape              :: 526;
    LeftCtrl            :: 527;
    LeftShift           :: 528;
    LeftAlt             :: 529;
    LeftSuper           :: 530;
    RightCtrl           :: 531;
    RightShift          :: 532;
    RightAlt            :: 533;
    RightSuper          :: 534;
    Menu                :: 535;
    _0                  :: 536;
    _1                  :: 537;
    _2                  :: 538;
    _3                  :: 539;
    _4                  :: 540;
    _5                  :: 541;
    _6                  :: 542;
    _7                  :: 543;
    _8                  :: 544;
    _9                  :: 545;
    A                   :: 546;
    B                   :: 547;
    C                   :: 548;
    D                   :: 549;
    E                   :: 550;
    F                   :: 551;
    G                   :: 552;
    H                   :: 553;
    I                   :: 554;
    J                   :: 555;
    K                   :: 556;
    L                   :: 557;
    M                   :: 558;
    N                   :: 559;
    O                   :: 560;
    P                   :: 561;
    Q                   :: 562;
    R                   :: 563;
    S                   :: 564;
    T                   :: 565;
    U                   :: 566;
    V                   :: 567;
    W                   :: 568;
    X                   :: 569;
    Y                   :: 570;
    Z                   :: 571;
    F1                  :: 572;
    F2                  :: 573;
    F3                  :: 574;
    F4                  :: 575;
    F5                  :: 576;
    F6                  :: 577;
    F7                  :: 578;
    F8                  :: 579;
    F9                  :: 580;
    F10                 :: 581;
    F11                 :: 582;
    F12                 :: 583;
    F13                 :: 584;
    F14                 :: 585;
    F15                 :: 586;
    F16                 :: 587;
    F17                 :: 588;
    F18                 :: 589;
    F19                 :: 590;
    F20                 :: 591;
    F21                 :: 592;
    F22                 :: 593;
    F23                 :: 594;
    F24                 :: 595;
    Apostrophe          :: 596;
    Comma               :: 597;
    Minus               :: 598;
    Period              :: 599;
    Slash               :: 600;
    Semicolon           :: 601;
    Equal               :: 602;
    LeftBracket         :: 603;
    Backslash           :: 604;
    RightBracket        :: 605;
    GraveAccent         :: 606;
    CapsLock            :: 607;
    ScrollLock          :: 608;
    NumLock             :: 609;
    PrintScreen         :: 610;
    Pause               :: 611;
    Keypad0             :: 612;
    Keypad1             :: 613;
    Keypad2             :: 614;
    Keypad3             :: 615;
    Keypad4             :: 616;
    Keypad5             :: 617;
    Keypad6             :: 618;
    Keypad7             :: 619;
    Keypad8             :: 620;
    Keypad9             :: 621;
    KeypadDecimal       :: 622;
    KeypadDivide        :: 623;
    KeypadMultiply      :: 624;
    KeypadSubtract      :: 625;
    KeypadAdd           :: 626;
    KeypadEnter         :: 627;
    KeypadEqual         :: 628;
    AppBack             :: 629;
    AppForward          :: 630;
    Oem102              :: 631;

    GamepadStart        :: 632;
    GamepadBack         :: 633;
    GamepadFaceLeft     :: 634;
    GamepadFaceRight    :: 635;
    GamepadFaceUp       :: 636;
    GamepadFaceDown     :: 637;
    GamepadDpadLeft     :: 638;
    GamepadDpadRight    :: 639;
    GamepadDpadUp       :: 640;
    GamepadDpadDown     :: 641;
    GamepadL1           :: 642;
    GamepadR1           :: 643;
    GamepadL2           :: 644;
    GamepadR2           :: 645;
    GamepadL3           :: 646;
    GamepadR3           :: 647;
    GamepadLStickLeft   :: 648;
    GamepadLStickRight  :: 649;
    GamepadLStickUp     :: 650;
    GamepadLStickDown   :: 651;
    GamepadRStickLeft   :: 652;
    GamepadRStickRight  :: 653;
    GamepadRStickUp     :: 654;
    GamepadRStickDown   :: 655;

    MouseLeft           :: 656;
    MouseRight          :: 657;
    MouseMiddle         :: 658;
    MouseX1             :: 659;
    MouseX2             :: 660;
    MouseWheelX         :: 661;
    MouseWheelY         :: 662;

    ReservedForModCtrl  :: 663;
    ReservedForModShift :: 664;
    ReservedForModAlt   :: 665;
    ReservedForModSuper :: 666;

    NamedKey_END        :: 667;
    NamedKey_COUNT      :: 155;

    ImGuiMod_None       :: 0;
    ImGuiMod_Ctrl       :: 4096;
    ImGuiMod_Shift      :: 8192;
    ImGuiMod_Alt        :: 16384;
    ImGuiMod_Super      :: 32768;
    ImGuiMod_Mask_      :: 61440;
}

// Enumeration for AddMouseSourceEvent() actual source of Mouse Input data.
// Historically we use "Mouse" terminology everywhere to indicate pointer data, e.g. MousePos, IsMousePressed(), io.AddMousePosEvent()
// But that "Mouse" data can come from different source which occasionally may be useful for application to know about.
// You can submit a change of pointer type using io.AddMouseSourceEvent().
MouseSource :: enum s32 {
    Mouse       :: 0;
    TouchScreen :: 1;
    Pen         :: 2;
    COUNT       :: 3;
}

// A sorting direction
SortDirection :: enum U8 {
    None       :: 0;
    Ascending  :: 1;
    Descending :: 2;
}

KeyChord :: s32;

// Character types
// (we generally use UTF-8 encoded string in the API. This is storage specifically for a decoded character used for keyboard input and display)
Wchar32 :: u32;
Wchar16 :: u16;

Wchar :: Wchar16;

// Multi-Selection item index or identifier when using BeginMultiSelect()
// - Used by SetNextItemSelectionUserData() + and inside ImGuiMultiSelectIO structure.
// - Most users are likely to use this store an item INDEX but this may be used to store a POINTER/ID as well. Read comments near ImGuiMultiSelectIO for details.
SelectionUserData :: S64;

// Callback and functions types
InputTextCallback :: #type (data: *InputTextCallbackData) -> s32 #c_call;
SizeCallback :: #type (data: *SizeCallbackData) -> void #c_call;
MemAllocFunc :: #type (sz: u64, user_data: *void) -> *void #c_call;
MemFreeFunc :: #type (ptr: *void, user_data: *void) -> void #c_call;

TextureID :: U64;

// ImTextureRef = higher-level identifier for a texture. Store a ImTextureID _or_ a ImTextureData*.
// The identifier is valid even before the texture has been uploaded to the GPU/graphics system.
// This is what gets passed to functions such as `ImGui::Image()`, `ImDrawList::AddImage()`.
// This is what gets stored in draw commands (`ImDrawCmd`) to identify a texture during rendering.
// - When a texture is created by user code (e.g. custom images), we directly stores the low-level ImTextureID.
//   Because of this, when displaying your own texture you are likely to ever only manage ImTextureID values on your side.
// - When a texture is created by the backend, we stores a ImTextureData* which becomes an indirection
//   to extract the ImTextureID value during rendering, after texture upload has happened.
// - To create a ImTextureRef from a ImTextureData you can use ImTextureData::GetTexRef().
//   We intentionally do not provide an ImTextureRef constructor for this: we don't expect this
//   to be frequently useful to the end-user, and it would be erroneously called by many legacy code.
// - If you want to bind the current atlas when using custom rectangle, you can use io.Fonts->TexRef.
// - Binding generators for languages such as C (which don't have constructors), should provide a helper, e.g.
//      inline ImTextureRef ImTextureRefFromID(ImTextureID tex_id) { ImTextureRef tex_ref = { ._TexData = NULL, .TexID = tex_id }; return tex_ref; }
// In 1.92 we changed most drawing functions using ImTextureID to use ImTextureRef.
// We intentionally do not provide an implicit ImTextureRef -> ImTextureID cast operator because it is technically lossy to convert ImTextureRef to ImTextureID before rendering.
TextureRef :: struct {
    Constructor :: (this: *TextureRef) -> void #cpp_method #foreign ImGui "??0ImTextureRef@@QEAA@XZ";

    // This is provided for consistency (but we don't actually use this)
    GetTexID :: (this: *TextureRef) -> TextureID #cpp_method #foreign ImGui "?GetTexID@ImTextureRef@@QEBA_KXZ";

    _TexData: *TextureData; //      A texture, generally owned by a ImFontAtlas. Will convert to ImTextureID during render loop, after texture has been uploaded.
    _TexID:   TextureID; // _OR_ Low-level backend texture identifier, if already uploaded or created by user/app. Generally provided to e.g. ImGui::Image() calls.
}
//-----------------------------------------------------------------------------
// [SECTION] Dear ImGui end-user API functions
// (Note that ImGui:: being a namespace, you can add extra ImGui:: functions in your own separate file. Please don't modify imgui source files!)
//-----------------------------------------------------------------------------

// Context creation and access
// - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
// - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
//   for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
CreateContext :: (shared_font_atlas: *FontAtlas = null) -> *ImGuiContext #foreign ImGui "?CreateContext@ImGui@@YAPEAUImGuiContext@@PEAUImFontAtlas@@@Z";
DestroyContext :: (ctx: *ImGuiContext = null) -> void #foreign ImGui "?DestroyContext@ImGui@@YAXPEAUImGuiContext@@@Z";
GetCurrentContext :: () -> *ImGuiContext #foreign ImGui "?GetCurrentContext@ImGui@@YAPEAUImGuiContext@@XZ";
SetCurrentContext :: (ctx: *ImGuiContext) -> void #foreign ImGui "?SetCurrentContext@ImGui@@YAXPEAUImGuiContext@@@Z";

// Main
GetIO :: () -> *IO #foreign ImGui "?GetIO@ImGui@@YAAEAUImGuiIO@@XZ";
GetPlatformIO :: () -> *PlatformIO #foreign ImGui "?GetPlatformIO@ImGui@@YAAEAUImGuiPlatformIO@@XZ";
GetStyle :: () -> *Style #foreign ImGui "?GetStyle@ImGui@@YAAEAUImGuiStyle@@XZ";
NewFrame :: () -> void #foreign ImGui "?NewFrame@ImGui@@YAXXZ";
EndFrame :: () -> void #foreign ImGui "?EndFrame@ImGui@@YAXXZ";
Render :: () -> void #foreign ImGui "?Render@ImGui@@YAXXZ";
GetDrawData :: () -> *DrawData #foreign ImGui "?GetDrawData@ImGui@@YAPEAUImDrawData@@XZ";

// Demo, Debug, Information
ShowDemoWindow :: (p_open: *bool = null) -> void #foreign ImGui "?ShowDemoWindow@ImGui@@YAXPEA_N@Z";
ShowMetricsWindow :: (p_open: *bool = null) -> void #foreign ImGui "?ShowMetricsWindow@ImGui@@YAXPEA_N@Z";
ShowDebugLogWindow :: (p_open: *bool = null) -> void #foreign ImGui "?ShowDebugLogWindow@ImGui@@YAXPEA_N@Z";
ShowIDStackToolWindow :: (p_open: *bool = null) -> void #foreign ImGui "?ShowIDStackToolWindow@ImGui@@YAXPEA_N@Z";
ShowAboutWindow :: (p_open: *bool = null) -> void #foreign ImGui "?ShowAboutWindow@ImGui@@YAXPEA_N@Z";
ShowStyleEditor :: (ref: *Style = null) -> void #foreign ImGui "?ShowStyleEditor@ImGui@@YAXPEAUImGuiStyle@@@Z";
ShowStyleSelector :: (label: *u8) -> bool #foreign ImGui "?ShowStyleSelector@ImGui@@YA_NPEBD@Z";
ShowFontSelector :: (label: *u8) -> void #foreign ImGui "?ShowFontSelector@ImGui@@YAXPEBD@Z";
ShowUserGuide :: () -> void #foreign ImGui "?ShowUserGuide@ImGui@@YAXXZ";
GetVersion :: () -> *u8 #foreign ImGui "?GetVersion@ImGui@@YAPEBDXZ";

// Styles
StyleColorsDark :: (dst: *Style = null) -> void #foreign ImGui "?StyleColorsDark@ImGui@@YAXPEAUImGuiStyle@@@Z";
StyleColorsLight :: (dst: *Style = null) -> void #foreign ImGui "?StyleColorsLight@ImGui@@YAXPEAUImGuiStyle@@@Z";
StyleColorsClassic :: (dst: *Style = null) -> void #foreign ImGui "?StyleColorsClassic@ImGui@@YAXPEAUImGuiStyle@@@Z";

// Windows
// - Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
// - Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
//   which clicking will set the boolean to false when clicked.
// - You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
//   Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
// - Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
//   anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
//   [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
//    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
//    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
// - Note that the bottom of window stack always contains a window called "Debug".
Begin :: (name: *u8, p_open: *bool = null, flags: WindowFlags = .None) -> bool #foreign ImGui "?Begin@ImGui@@YA_NPEBDPEA_NH@Z";
End :: () -> void #foreign ImGui "?End@ImGui@@YAXXZ";

// Child Windows
// - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
// - Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
//   This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Borders == true.
//   Consider updating your old code:
//      BeginChild("Name", size, false)   -> Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
//      BeginChild("Name", size, true)    -> Begin("Name", size, ImGuiChildFlags_Borders);
// - Manual sizing (each axis can use a different setting e.g. ImVec2(0.0f, 400.0f)):
//     == 0.0f: use remaining parent window size for this axis.
//      > 0.0f: use specified size for this axis.
//      < 0.0f: right/bottom-align to specified distance from available content boundaries.
// - Specifying ImGuiChildFlags_AutoResizeX or ImGuiChildFlags_AutoResizeY makes the sizing automatic based on child contents.
//   Combining both ImGuiChildFlags_AutoResizeX _and_ ImGuiChildFlags_AutoResizeY defeats purpose of a scrolling region and is NOT recommended.
// - BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
//   anything to the window. Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
//   [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
//    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
//    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
BeginChild :: (str_id: *u8, size: *Vector2, child_flags: ChildFlags = .None, window_flags: WindowFlags = .None) -> bool #foreign ImGui "?BeginChild@ImGui@@YA_NPEBDAEBUImVec2@@HH@Z";
BeginChild :: (str_id: *u8, size: Vector2 = .{0, 0}, child_flags: ChildFlags = .None, window_flags: WindowFlags = .None) -> bool #no_context {
    return BeginChild(str_id, *size, child_flags, window_flags);
}
BeginChild :: (id: ID, size: *Vector2, child_flags: ChildFlags = .None, window_flags: WindowFlags = .None) -> bool #foreign ImGui "?BeginChild@ImGui@@YA_NIAEBUImVec2@@HH@Z";
BeginChild :: (id: ID, size: Vector2 = .{0, 0}, child_flags: ChildFlags = .None, window_flags: WindowFlags = .None) -> bool #no_context {
    return BeginChild(id, *size, child_flags, window_flags);
}
EndChild :: () -> void #foreign ImGui "?EndChild@ImGui@@YAXXZ";

// Windows Utilities
// - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
IsWindowAppearing :: () -> bool #foreign ImGui "?IsWindowAppearing@ImGui@@YA_NXZ";
IsWindowCollapsed :: () -> bool #foreign ImGui "?IsWindowCollapsed@ImGui@@YA_NXZ";
IsWindowFocused :: (flags: FocusedFlags = .None) -> bool #foreign ImGui "?IsWindowFocused@ImGui@@YA_NH@Z";
IsWindowHovered :: (flags: HoveredFlags = .None) -> bool #foreign ImGui "?IsWindowHovered@ImGui@@YA_NH@Z";
GetWindowDrawList :: () -> *DrawList #foreign ImGui "?GetWindowDrawList@ImGui@@YAPEAUImDrawList@@XZ";
GetWindowDpiScale :: () -> float #foreign ImGui "?GetWindowDpiScale@ImGui@@YAMXZ";
GetWindowPos :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetWindowPos@ImGui@@YA?AUImVec2@@XZ";
GetWindowSize :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetWindowSize@ImGui@@YA?AUImVec2@@XZ";
GetWindowWidth :: () -> float #foreign ImGui "?GetWindowWidth@ImGui@@YAMXZ";
GetWindowHeight :: () -> float #foreign ImGui "?GetWindowHeight@ImGui@@YAMXZ";
GetWindowViewport :: () -> *Viewport #foreign ImGui "?GetWindowViewport@ImGui@@YAPEAUImGuiViewport@@XZ";

// Window manipulation
// - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
SetNextWindowPos :: (pos: *Vector2, cond: Cond = .None, pivot: *Vector2) -> void #foreign ImGui "?SetNextWindowPos@ImGui@@YAXAEBUImVec2@@H0@Z";
SetNextWindowPos :: (pos: Vector2, cond: Cond = .None, pivot: Vector2 = .{0, 0}) #no_context {
    SetNextWindowPos(*pos, cond, *pivot);
}
SetNextWindowSize :: (size: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetNextWindowSize@ImGui@@YAXAEBUImVec2@@H@Z";
SetNextWindowSize :: (size: Vector2, cond: Cond = .None) #no_context {
    SetNextWindowSize(*size, cond);
}
SetNextWindowSizeConstraints :: (size_min: *Vector2, size_max: *Vector2, custom_callback: SizeCallback = null, custom_callback_data: *void = null) -> void #foreign ImGui "?SetNextWindowSizeConstraints@ImGui@@YAXAEBUImVec2@@0P6AXPEAUImGuiSizeCallbackData@@@ZPEAX@Z";
SetNextWindowSizeConstraints :: (size_min: Vector2, size_max: Vector2, custom_callback: SizeCallback = null, custom_callback_data: *void = null) #no_context {
    SetNextWindowSizeConstraints(*size_min, *size_max, custom_callback, custom_callback_data);
}
SetNextWindowContentSize :: (size: *Vector2) -> void #foreign ImGui "?SetNextWindowContentSize@ImGui@@YAXAEBUImVec2@@@Z";
SetNextWindowContentSize :: (size: Vector2) #no_context {
    SetNextWindowContentSize(*size);
}
SetNextWindowCollapsed :: (collapsed: bool, cond: Cond = .None) -> void #foreign ImGui "?SetNextWindowCollapsed@ImGui@@YAX_NH@Z";
SetNextWindowFocus :: () -> void #foreign ImGui "?SetNextWindowFocus@ImGui@@YAXXZ";
SetNextWindowScroll :: (scroll: *Vector2) -> void #foreign ImGui "?SetNextWindowScroll@ImGui@@YAXAEBUImVec2@@@Z";
SetNextWindowScroll :: (scroll: Vector2) #no_context {
    SetNextWindowScroll(*scroll);
}
SetNextWindowBgAlpha :: (alpha: float) -> void #foreign ImGui "?SetNextWindowBgAlpha@ImGui@@YAXM@Z";
SetNextWindowViewport :: (viewport_id: ID) -> void #foreign ImGui "?SetNextWindowViewport@ImGui@@YAXI@Z";
SetWindowPos :: (pos: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetWindowPos@ImGui@@YAXAEBUImVec2@@H@Z";
SetWindowPos :: (pos: Vector2, cond: Cond = .None) #no_context {
    SetWindowPos(*pos, cond);
}
SetWindowSize :: (size: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetWindowSize@ImGui@@YAXAEBUImVec2@@H@Z";
SetWindowSize :: (size: Vector2, cond: Cond = .None) #no_context {
    SetWindowSize(*size, cond);
}
SetWindowCollapsed :: (collapsed: bool, cond: Cond = .None) -> void #foreign ImGui "?SetWindowCollapsed@ImGui@@YAX_NH@Z";
SetWindowFocus :: () -> void #foreign ImGui "?SetWindowFocus@ImGui@@YAXXZ";
SetWindowPos :: (name: *u8, pos: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetWindowPos@ImGui@@YAXPEBDAEBUImVec2@@H@Z";
SetWindowPos :: (name: *u8, pos: Vector2, cond: Cond = .None) #no_context {
    SetWindowPos(name, *pos, cond);
}
SetWindowSize :: (name: *u8, size: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetWindowSize@ImGui@@YAXPEBDAEBUImVec2@@H@Z";
SetWindowSize :: (name: *u8, size: Vector2, cond: Cond = .None) #no_context {
    SetWindowSize(name, *size, cond);
}
SetWindowCollapsed :: (name: *u8, collapsed: bool, cond: Cond = .None) -> void #foreign ImGui "?SetWindowCollapsed@ImGui@@YAXPEBD_NH@Z";
SetWindowFocus :: (name: *u8) -> void #foreign ImGui "?SetWindowFocus@ImGui@@YAXPEBD@Z";

// Windows Scrolling
// - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
// - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
GetScrollX :: () -> float #foreign ImGui "?GetScrollX@ImGui@@YAMXZ";
GetScrollY :: () -> float #foreign ImGui "?GetScrollY@ImGui@@YAMXZ";
SetScrollX :: (scroll_x: float) -> void #foreign ImGui "?SetScrollX@ImGui@@YAXM@Z";
SetScrollY :: (scroll_y: float) -> void #foreign ImGui "?SetScrollY@ImGui@@YAXM@Z";
GetScrollMaxX :: () -> float #foreign ImGui "?GetScrollMaxX@ImGui@@YAMXZ";
GetScrollMaxY :: () -> float #foreign ImGui "?GetScrollMaxY@ImGui@@YAMXZ";
SetScrollHereX :: (center_x_ratio: float = 0.5) -> void #foreign ImGui "?SetScrollHereX@ImGui@@YAXM@Z";
SetScrollHereY :: (center_y_ratio: float = 0.5) -> void #foreign ImGui "?SetScrollHereY@ImGui@@YAXM@Z";
SetScrollFromPosX :: (local_x: float, center_x_ratio: float = 0.5) -> void #foreign ImGui "?SetScrollFromPosX@ImGui@@YAXMM@Z";
SetScrollFromPosY :: (local_y: float, center_y_ratio: float = 0.5) -> void #foreign ImGui "?SetScrollFromPosY@ImGui@@YAXMM@Z";

// Parameters stacks (font)
//  - PushFont(font, 0.0f)                       // Change font and keep current size
//  - PushFont(NULL, 20.0f)                      // Keep font and change current size
//  - PushFont(font, 20.0f)                      // Change font and set size to 20.0f
//  - PushFont(font, style.FontSizeBase * 2.0f)  // Change font and set size to be twice bigger than current size.
//  - PushFont(font, font->LegacySize)           // Change font and set size to size passed to AddFontXXX() function. Same as pre-1.92 behavior.
// *IMPORTANT* before 1.92, fonts had a single size. They can now be dynamically be adjusted.
//  - In 1.92 we have REMOVED the single parameter version of PushFont() because it seems like the easiest way to provide an error-proof transition.
//  - PushFont(font) before 1.92 = PushFont(font, font->LegacySize) after 1.92          // Use default font size as passed to AddFontXXX() function.
// *IMPORTANT* global scale factors are applied over the provided size.
//  - Global scale factors are: 'style.FontScaleMain', 'style.FontScaleDpi' and maybe more.
// -  If you want to apply a factor to the _current_ font size:
//  - CORRECT:   PushFont(NULL, style.FontSizeBase)         // use current unscaled size    == does nothing
//  - CORRECT:   PushFont(NULL, style.FontSizeBase * 2.0f)  // use current unscaled size x2 == make text twice bigger
//  - INCORRECT: PushFont(NULL, GetFontSize())              // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
//  - INCORRECT: PushFont(NULL, GetFontSize() * 2.0f)       // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
PushFont :: (font: *Font, font_size_base_unscaled: float) -> void #foreign ImGui "?PushFont@ImGui@@YAXPEAUImFont@@M@Z";
PopFont :: () -> void #foreign ImGui "?PopFont@ImGui@@YAXXZ";
GetFont :: () -> *Font #foreign ImGui "?GetFont@ImGui@@YAPEAUImFont@@XZ";
GetFontSize :: () -> float #foreign ImGui "?GetFontSize@ImGui@@YAMXZ";
GetFontBaked :: () -> *FontBaked #foreign ImGui "?GetFontBaked@ImGui@@YAPEAUImFontBaked@@XZ";

// Parameters stacks (shared)
PushStyleColor :: (idx: Col, col: U32) -> void #foreign ImGui "?PushStyleColor@ImGui@@YAXHI@Z";
PushStyleColor :: (idx: Col, col: *Vector4) -> void #foreign ImGui "?PushStyleColor@ImGui@@YAXHAEBUImVec4@@@Z";
PushStyleColor :: (idx: Col, col: Vector4) #no_context {
    PushStyleColor(idx, *col);
}
PopStyleColor :: (count: s32 = 1) -> void #foreign ImGui "?PopStyleColor@ImGui@@YAXH@Z";
PushStyleVar :: (idx: StyleVar, val: float) -> void #foreign ImGui "?PushStyleVar@ImGui@@YAXHM@Z";
PushStyleVar :: (idx: StyleVar, val: *Vector2) -> void #foreign ImGui "?PushStyleVar@ImGui@@YAXHAEBUImVec2@@@Z";
PushStyleVar :: (idx: StyleVar, val: Vector2) #no_context {
    PushStyleVar(idx, *val);
}
PushStyleVarX :: (idx: StyleVar, val_x: float) -> void #foreign ImGui "?PushStyleVarX@ImGui@@YAXHM@Z";
PushStyleVarY :: (idx: StyleVar, val_y: float) -> void #foreign ImGui "?PushStyleVarY@ImGui@@YAXHM@Z";
PopStyleVar :: (count: s32 = 1) -> void #foreign ImGui "?PopStyleVar@ImGui@@YAXH@Z";
PushItemFlag :: (option: ItemFlags, enabled: bool) -> void #foreign ImGui "?PushItemFlag@ImGui@@YAXH_N@Z";
PopItemFlag :: () -> void #foreign ImGui "?PopItemFlag@ImGui@@YAXXZ";

// Parameters stacks (current window)
PushItemWidth :: (item_width: float) -> void #foreign ImGui "?PushItemWidth@ImGui@@YAXM@Z";
PopItemWidth :: () -> void #foreign ImGui "?PopItemWidth@ImGui@@YAXXZ";
SetNextItemWidth :: (item_width: float) -> void #foreign ImGui "?SetNextItemWidth@ImGui@@YAXM@Z";
CalcItemWidth :: () -> float #foreign ImGui "?CalcItemWidth@ImGui@@YAMXZ";
PushTextWrapPos :: (wrap_local_pos_x: float = 0.0) -> void #foreign ImGui "?PushTextWrapPos@ImGui@@YAXM@Z";
PopTextWrapPos :: () -> void #foreign ImGui "?PopTextWrapPos@ImGui@@YAXXZ";

// Style read access
// - Use the ShowStyleEditor() function to interactively see/edit the colors.
GetFontTexUvWhitePixel :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetFontTexUvWhitePixel@ImGui@@YA?AUImVec2@@XZ";
GetColorU32 :: (idx: Col, alpha_mul: float = 1.0) -> U32 #foreign ImGui "?GetColorU32@ImGui@@YAIHM@Z";
GetColorU32 :: (col: *Vector4) -> U32 #foreign ImGui "?GetColorU32@ImGui@@YAIAEBUImVec4@@@Z";
GetColorU32 :: (col: Vector4) -> U32 #no_context {
    return GetColorU32(*col);
}
GetColorU32 :: (col: U32, alpha_mul: float = 1.0) -> U32 #foreign ImGui "?GetColorU32@ImGui@@YAIIM@Z";
GetStyleColorVec4 :: (idx: Col) -> *Vector4 #foreign ImGui "?GetStyleColorVec4@ImGui@@YAAEBUImVec4@@H@Z";

// Layout cursor positioning
// - By "cursor" we mean the current output position.
// - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
// - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
// - YOU CAN DO 99% OF WHAT YOU NEED WITH ONLY GetCursorScreenPos() and GetContentRegionAvail().
// - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
//    - Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. -> this is the preferred way forward.
//    - Window-local coordinates:   SameLine(offset), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), PushTextWrapPos()
//    - Window-local coordinates:   GetContentRegionMax(), GetWindowContentRegionMin(), GetWindowContentRegionMax() --> all obsoleted. YOU DON'T NEED THEM.
// - GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from window-local to absolute coordinates. Try not to use it.
GetCursorScreenPos :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetCursorScreenPos@ImGui@@YA?AUImVec2@@XZ";
SetCursorScreenPos :: (pos: *Vector2) -> void #foreign ImGui "?SetCursorScreenPos@ImGui@@YAXAEBUImVec2@@@Z";
SetCursorScreenPos :: (pos: Vector2) #no_context {
    SetCursorScreenPos(*pos);
}
GetContentRegionAvail :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetContentRegionAvail@ImGui@@YA?AUImVec2@@XZ";
GetCursorPos :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetCursorPos@ImGui@@YA?AUImVec2@@XZ";
GetCursorPosX :: () -> float #foreign ImGui "?GetCursorPosX@ImGui@@YAMXZ";
GetCursorPosY :: () -> float #foreign ImGui "?GetCursorPosY@ImGui@@YAMXZ";
SetCursorPos :: (local_pos: *Vector2) -> void #foreign ImGui "?SetCursorPos@ImGui@@YAXAEBUImVec2@@@Z";
SetCursorPos :: (local_pos: Vector2) #no_context {
    SetCursorPos(*local_pos);
}
SetCursorPosX :: (local_x: float) -> void #foreign ImGui "?SetCursorPosX@ImGui@@YAXM@Z";
SetCursorPosY :: (local_y: float) -> void #foreign ImGui "?SetCursorPosY@ImGui@@YAXM@Z";
GetCursorStartPos :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetCursorStartPos@ImGui@@YA?AUImVec2@@XZ";

// Other layout functions
Separator :: () -> void #foreign ImGui "?Separator@ImGui@@YAXXZ";
SameLine :: (offset_from_start_x: float = 0.0, spacing: float = -1.0) -> void #foreign ImGui "?SameLine@ImGui@@YAXMM@Z";
NewLine :: () -> void #foreign ImGui "?NewLine@ImGui@@YAXXZ";
Spacing :: () -> void #foreign ImGui "?Spacing@ImGui@@YAXXZ";
Dummy :: (size: *Vector2) -> void #foreign ImGui "?Dummy@ImGui@@YAXAEBUImVec2@@@Z";
Dummy :: (size: Vector2) #no_context {
    Dummy(*size);
}
Indent :: (indent_w: float = 0.0) -> void #foreign ImGui "?Indent@ImGui@@YAXM@Z";
Unindent :: (indent_w: float = 0.0) -> void #foreign ImGui "?Unindent@ImGui@@YAXM@Z";
BeginGroup :: () -> void #foreign ImGui "?BeginGroup@ImGui@@YAXXZ";
EndGroup :: () -> void #foreign ImGui "?EndGroup@ImGui@@YAXXZ";
AlignTextToFramePadding :: () -> void #foreign ImGui "?AlignTextToFramePadding@ImGui@@YAXXZ";
GetTextLineHeight :: () -> float #foreign ImGui "?GetTextLineHeight@ImGui@@YAMXZ";
GetTextLineHeightWithSpacing :: () -> float #foreign ImGui "?GetTextLineHeightWithSpacing@ImGui@@YAMXZ";
GetFrameHeight :: () -> float #foreign ImGui "?GetFrameHeight@ImGui@@YAMXZ";
GetFrameHeightWithSpacing :: () -> float #foreign ImGui "?GetFrameHeightWithSpacing@ImGui@@YAMXZ";

// ID stack/scopes
// Read the FAQ (docs/FAQ.md or http://dearimgui.com/faq) for more details about how ID are handled in dear imgui.
// - Those questions are answered and impacted by understanding of the ID stack system:
//   - "Q: Why is my widget not reacting when I click on it?"
//   - "Q: How can I have widgets with an empty label?"
//   - "Q: How can I have multiple widgets with the same label?"
// - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
//   want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
// - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
// - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
//   whereas "str_id" denote a string that is only used as an ID and not normally displayed.
PushID :: (str_id: *u8) -> void #foreign ImGui "?PushID@ImGui@@YAXPEBD@Z";
PushID :: (str_id_begin: *u8, str_id_end: *u8) -> void #foreign ImGui "?PushID@ImGui@@YAXPEBD0@Z";
PushID :: (str_id: string) #no_context {
    PushID(str_id.data, str_id.data + str_id.count);
}
PushID :: (ptr_id: *void) -> void #foreign ImGui "?PushID@ImGui@@YAXPEBX@Z";
PushID :: (int_id: s32) -> void #foreign ImGui "?PushID@ImGui@@YAXH@Z";
PopID :: () -> void #foreign ImGui "?PopID@ImGui@@YAXXZ";
GetID :: (str_id: *u8) -> ID #foreign ImGui "?GetID@ImGui@@YAIPEBD@Z";
GetID :: (str_id_begin: *u8, str_id_end: *u8) -> ID #foreign ImGui "?GetID@ImGui@@YAIPEBD0@Z";
GetID :: (str_id: string) -> ID #no_context {
    return GetID(str_id.data, str_id.data + str_id.count);
}
GetID :: (ptr_id: *void) -> ID #foreign ImGui "?GetID@ImGui@@YAIPEBX@Z";
GetID :: (int_id: s32) -> ID #foreign ImGui "?GetID@ImGui@@YAIH@Z";

// Widgets: Text
TextUnformatted :: (text: *u8, text_end: *u8 = null) -> void #foreign ImGui "?TextUnformatted@ImGui@@YAXPEBD0@Z";
TextUnformatted :: (text: string) #no_context {
    TextUnformatted(text.data, text.data + text.count);
}
Text_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?Text@ImGui@@YAXPEBDZZ";
Text :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    Text_CFormat("%s", formatted_text.data);
} @PrintLike

TextColored_CFormat :: (col: *Vector4, fmt: *u8, __args: ..Any) -> void #foreign ImGui "?TextColored@ImGui@@YAXAEBUImVec4@@PEBDZZ";
TextColored :: (col: Vector4, fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    TextColored_CFormat(*col, "%s", formatted_text.data);
} @PrintLike

TextDisabled_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?TextDisabled@ImGui@@YAXPEBDZZ";
TextDisabled :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    TextDisabled_CFormat("%s", formatted_text.data);
} @PrintLike

TextWrapped_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?TextWrapped@ImGui@@YAXPEBDZZ";
TextWrapped :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    TextWrapped_CFormat("%s", formatted_text.data);
} @PrintLike

LabelText_CFormat :: (label: *u8, fmt: *u8, __args: ..Any) -> void #foreign ImGui "?LabelText@ImGui@@YAXPEBD0ZZ";
LabelText :: (label: *u8, fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    LabelText_CFormat(label, "%s", formatted_text.data);
} @PrintLike

BulletText_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?BulletText@ImGui@@YAXPEBDZZ";
BulletText :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    BulletText_CFormat("%s", formatted_text.data);
} @PrintLike

SeparatorText :: (label: *u8) -> void #foreign ImGui "?SeparatorText@ImGui@@YAXPEBD@Z";

// Widgets: Main
// - Most widgets return true when the value has been changed or when pressed/selected
// - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
Button :: (label: *u8, size: *Vector2) -> bool #foreign ImGui "?Button@ImGui@@YA_NPEBDAEBUImVec2@@@Z";
Button :: (label: *u8, size: Vector2 = .{0, 0}) -> bool #no_context {
    return Button(label, *size);
}
SmallButton :: (label: *u8) -> bool #foreign ImGui "?SmallButton@ImGui@@YA_NPEBD@Z";
InvisibleButton :: (str_id: *u8, size: *Vector2, flags: ButtonFlags = .None) -> bool #foreign ImGui "?InvisibleButton@ImGui@@YA_NPEBDAEBUImVec2@@H@Z";
InvisibleButton :: (str_id: *u8, size: Vector2, flags: ButtonFlags = .None) -> bool #no_context {
    return InvisibleButton(str_id, *size, flags);
}
ArrowButton :: (str_id: *u8, dir: Dir) -> bool #foreign ImGui "?ArrowButton@ImGui@@YA_NPEBDW4ImGuiDir@@@Z";
Checkbox :: (label: *u8, v: *bool) -> bool #foreign ImGui "?Checkbox@ImGui@@YA_NPEBDPEA_N@Z";
CheckboxFlags :: (label: *u8, flags: *s32, flags_value: s32) -> bool #foreign ImGui "?CheckboxFlags@ImGui@@YA_NPEBDPEAHH@Z";
CheckboxFlags :: (label: *u8, flags: *u32, flags_value: u32) -> bool #foreign ImGui "?CheckboxFlags@ImGui@@YA_NPEBDPEAII@Z";
RadioButton :: (label: *u8, active: bool) -> bool #foreign ImGui "?RadioButton@ImGui@@YA_NPEBD_N@Z";
RadioButton :: (label: *u8, v: *s32, v_button: s32) -> bool #foreign ImGui "?RadioButton@ImGui@@YA_NPEBDPEAHH@Z";
ProgressBar :: (fraction: float, size_arg: *Vector2, overlay: *u8 = null) -> void #foreign ImGui "?ProgressBar@ImGui@@YAXMAEBUImVec2@@PEBD@Z";
ProgressBar :: (fraction: float, size_arg: Vector2 = .{-FLOAT32_MIN, 0}, overlay: *u8 = null) #no_context {
    ProgressBar(fraction, *size_arg, overlay);
}
Bullet :: () -> void #foreign ImGui "?Bullet@ImGui@@YAXXZ";
TextLink :: (label: *u8) -> bool #foreign ImGui "?TextLink@ImGui@@YA_NPEBD@Z";
TextLinkOpenURL :: (label: *u8, url: *u8 = null) -> bool #foreign ImGui "?TextLinkOpenURL@ImGui@@YA_NPEBD0@Z";

// Widgets: Images
// - Read about ImTextureID/ImTextureRef  here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
// - 'uv0' and 'uv1' are texture coordinates. Read about them from the same link above.
// - Image() pads adds style.ImageBorderSize on each side, ImageButton() adds style.FramePadding on each side.
// - ImageButton() draws a background based on regular Button() color + optionally an inner background if specified.
// - An obsolete version of Image(), before 1.91.9 (March 2025), had a 'tint_col' parameter which is now supported by the ImageWithBg() function.
Image :: (tex_ref: TextureRef, image_size: *Vector2, uv0: *Vector2, uv1: *Vector2) -> void #foreign ImGui "?Image@ImGui@@YAXUImTextureRef@@AEBUImVec2@@11@Z";
Image :: (tex_ref: TextureRef, image_size: Vector2, uv0: Vector2 = .{0, 0}, uv1: Vector2 = .{1, 1}) #no_context {
    Image(tex_ref, *image_size, *uv0, *uv1);
}
ImageWithBg :: (tex_ref: TextureRef, image_size: *Vector2, uv0: *Vector2, uv1: *Vector2, bg_col: *Vector4, tint_col: *Vector4) -> void #foreign ImGui "?ImageWithBg@ImGui@@YAXUImTextureRef@@AEBUImVec2@@11AEBUImVec4@@2@Z";
ImageWithBg :: (tex_ref: TextureRef, image_size: Vector2, uv0: Vector2 = .{0, 0}, uv1: Vector2 = .{1, 1}, bg_col: Vector4 = .{0, 0, 0, 0}, tint_col: Vector4 = .{1, 1, 1, 1}) #no_context {
    ImageWithBg(tex_ref, *image_size, *uv0, *uv1, *bg_col, *tint_col);
}
ImageButton :: (str_id: *u8, tex_ref: TextureRef, image_size: *Vector2, uv0: *Vector2, uv1: *Vector2, bg_col: *Vector4, tint_col: *Vector4) -> bool #foreign ImGui "?ImageButton@ImGui@@YA_NPEBDUImTextureRef@@AEBUImVec2@@22AEBUImVec4@@3@Z";
ImageButton :: (str_id: *u8, tex_ref: TextureRef, image_size: Vector2, uv0: Vector2 = .{0, 0}, uv1: Vector2 = .{1, 1}, bg_col: Vector4 = .{0, 0, 0, 0}, tint_col: Vector4 = .{1, 1, 1, 1}) -> bool #no_context {
    return ImageButton(str_id, tex_ref, *image_size, *uv0, *uv1, *bg_col, *tint_col);
}

// Widgets: Combo Box (Dropdown)
// - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
// - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
BeginCombo :: (label: *u8, preview_value: *u8, flags: ComboFlags = .None) -> bool #foreign ImGui "?BeginCombo@ImGui@@YA_NPEBD0H@Z";
EndCombo :: () -> void #foreign ImGui "?EndCombo@ImGui@@YAXXZ";
Combo :: (label: *u8, current_item: *s32, items: **u8, items_count: s32, popup_max_height_in_items: s32 = -1) -> bool #foreign ImGui "?Combo@ImGui@@YA_NPEBDPEAHQEBQEBDHH@Z";
Combo :: (label: *u8, current_item: *s32, items_separated_by_zeros: *u8, popup_max_height_in_items: s32 = -1) -> bool #foreign ImGui "?Combo@ImGui@@YA_NPEBDPEAH0H@Z";
Combo :: (label: *u8, current_item: *s32, getter: #type (user_data: *void, idx: s32) -> *u8 #c_call, user_data: *void, items_count: s32, popup_max_height_in_items: s32 = -1) -> bool #foreign ImGui "?Combo@ImGui@@YA_NPEBDPEAHP6APEBDPEAXH@Z2HH@Z";

// Widgets: Drag Sliders
// - CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
// - For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
//   the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g. &myvector.x
// - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
// - Format string may also be set to NULL or use the default format ("%f" or "%d").
// - Speed are per-pixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For keyboard/gamepad navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
// - Use v_min < v_max to clamp edits to given limits. Note that CTRL+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
// - Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = -FLT_MAX / INT_MIN to avoid clamping to a minimum.
// - We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
// - Legacy: Pre-1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
//   If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
DragFloat :: (label: *u8, v: *float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragFloat@ImGui@@YA_NPEBDPEAMMMM0H@Z";
DragFloat2 :: (label: *u8, v: *[2] float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragFloat2@ImGui@@YA_NPEBDQEAMMMM0H@Z";
DragFloat3 :: (label: *u8, v: *[3] float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragFloat3@ImGui@@YA_NPEBDQEAMMMM0H@Z";
DragFloat4 :: (label: *u8, v: *[4] float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragFloat4@ImGui@@YA_NPEBDQEAMMMM0H@Z";
DragFloatRange2 :: (label: *u8, v_current_min: *float, v_current_max: *float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", format_max: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?DragFloatRange2@ImGui@@YA_NPEBDPEAM1MMM00H@Z";
DragInt :: (label: *u8, v: *s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragInt@ImGui@@YA_NPEBDPEAHMHH0H@Z";
DragInt2 :: (label: *u8, v: *[2] s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragInt2@ImGui@@YA_NPEBDQEAHMHH0H@Z";
DragInt3 :: (label: *u8, v: *[3] s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragInt3@ImGui@@YA_NPEBDQEAHMHH0H@Z";
DragInt4 :: (label: *u8, v: *[4] s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?DragInt4@ImGui@@YA_NPEBDQEAHMHH0H@Z";
DragIntRange2 :: (label: *u8, v_current_min: *s32, v_current_max: *s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", format_max: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?DragIntRange2@ImGui@@YA_NPEBDPEAH1MHH00H@Z";
DragScalar :: (label: *u8, data_type: DataType, p_data: *void, v_speed: float = 1.0, p_min: *void = null, p_max: *void = null, format: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?DragScalar@ImGui@@YA_NPEBDHPEAXMPEBX20H@Z";
DragScalarN :: (label: *u8, data_type: DataType, p_data: *void, components: s32, v_speed: float = 1.0, p_min: *void = null, p_max: *void = null, format: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?DragScalarN@ImGui@@YA_NPEBDHPEAXHMPEBX20H@Z";

// Widgets: Regular Sliders
// - CTRL+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
// - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
// - Format string may also be set to NULL or use the default format ("%f" or "%d").
// - Legacy: Pre-1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
//   If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
SliderFloat :: (label: *u8, v: *float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderFloat@ImGui@@YA_NPEBDPEAMMM0H@Z";
SliderFloat2 :: (label: *u8, v: *[2] float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderFloat2@ImGui@@YA_NPEBDQEAMMM0H@Z";
SliderFloat3 :: (label: *u8, v: *[3] float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderFloat3@ImGui@@YA_NPEBDQEAMMM0H@Z";
SliderFloat4 :: (label: *u8, v: *[4] float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderFloat4@ImGui@@YA_NPEBDQEAMMM0H@Z";
SliderAngle :: (label: *u8, v_rad: *float, v_degrees_min: float = -360.0, v_degrees_max: float = +360.0, format: *u8 = "%.0f deg", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderAngle@ImGui@@YA_NPEBDPEAMMM0H@Z";
SliderInt :: (label: *u8, v: *s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderInt@ImGui@@YA_NPEBDPEAHHH0H@Z";
SliderInt2 :: (label: *u8, v: *[2] s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderInt2@ImGui@@YA_NPEBDQEAHHH0H@Z";
SliderInt3 :: (label: *u8, v: *[3] s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderInt3@ImGui@@YA_NPEBDQEAHHH0H@Z";
SliderInt4 :: (label: *u8, v: *[4] s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderInt4@ImGui@@YA_NPEBDQEAHHH0H@Z";
SliderScalar :: (label: *u8, data_type: DataType, p_data: *void, p_min: *void, p_max: *void, format: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderScalar@ImGui@@YA_NPEBDHPEAXPEBX20H@Z";
SliderScalarN :: (label: *u8, data_type: DataType, p_data: *void, components: s32, p_min: *void, p_max: *void, format: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?SliderScalarN@ImGui@@YA_NPEBDHPEAXHPEBX20H@Z";
VSliderFloat :: (label: *u8, size: *Vector2, v: *float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #foreign ImGui "?VSliderFloat@ImGui@@YA_NPEBDAEBUImVec2@@PEAMMM0H@Z";
VSliderFloat :: (label: *u8, size: Vector2, v: *float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: SliderFlags = .None) -> bool #no_context {
    return VSliderFloat(label, *size, v, v_min, v_max, format, flags);
}
VSliderInt :: (label: *u8, size: *Vector2, v: *s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #foreign ImGui "?VSliderInt@ImGui@@YA_NPEBDAEBUImVec2@@PEAHHH0H@Z";
VSliderInt :: (label: *u8, size: Vector2, v: *s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: SliderFlags = .None) -> bool #no_context {
    return VSliderInt(label, *size, v, v_min, v_max, format, flags);
}
VSliderScalar :: (label: *u8, size: *Vector2, data_type: DataType, p_data: *void, p_min: *void, p_max: *void, format: *u8 = null, flags: SliderFlags = .None) -> bool #foreign ImGui "?VSliderScalar@ImGui@@YA_NPEBDAEBUImVec2@@HPEAXPEBX30H@Z";
VSliderScalar :: (label: *u8, size: Vector2, data_type: DataType, p_data: *void, p_min: *void, p_max: *void, format: *u8 = null, flags: SliderFlags = .None) -> bool #no_context {
    return VSliderScalar(label, *size, data_type, p_data, p_min, p_max, format, flags);
}

// Widgets: Input with Keyboard
// - If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
// - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
InputText :: (label: *u8, buf: *u8, buf_size: u64, flags: InputTextFlags = .None, callback: InputTextCallback = null, user_data: *void = null) -> bool #foreign ImGui "?InputText@ImGui@@YA_NPEBDPEAD_KHP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z";
InputTextMultiline :: (label: *u8, buf: *u8, buf_size: u64, size: *Vector2, flags: InputTextFlags = .None, callback: InputTextCallback = null, user_data: *void = null) -> bool #foreign ImGui "?InputTextMultiline@ImGui@@YA_NPEBDPEAD_KAEBUImVec2@@HP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z";
InputTextMultiline :: (label: *u8, buf: *u8, buf_size: u64, size: Vector2 = .{0, 0}, flags: InputTextFlags = .None, callback: InputTextCallback = null, user_data: *void = null) -> bool #no_context {
    return InputTextMultiline(label, buf, buf_size, *size, flags, callback, user_data);
}
InputTextWithHint :: (label: *u8, hint: *u8, buf: *u8, buf_size: u64, flags: InputTextFlags = .None, callback: InputTextCallback = null, user_data: *void = null) -> bool #foreign ImGui "?InputTextWithHint@ImGui@@YA_NPEBD0PEAD_KHP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z";
InputFloat :: (label: *u8, v: *float, step: float = 0.0, step_fast: float = 0.0, format: *u8 = "%.3f", flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputFloat@ImGui@@YA_NPEBDPEAMMM0H@Z";
InputFloat2 :: (label: *u8, v: *[2] float, format: *u8 = "%.3f", flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputFloat2@ImGui@@YA_NPEBDQEAM0H@Z";
InputFloat3 :: (label: *u8, v: *[3] float, format: *u8 = "%.3f", flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputFloat3@ImGui@@YA_NPEBDQEAM0H@Z";
InputFloat4 :: (label: *u8, v: *[4] float, format: *u8 = "%.3f", flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputFloat4@ImGui@@YA_NPEBDQEAM0H@Z";
InputInt :: (label: *u8, v: *s32, step: s32 = 1, step_fast: s32 = 100, flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputInt@ImGui@@YA_NPEBDPEAHHHH@Z";
InputInt2 :: (label: *u8, v: *[2] s32, flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputInt2@ImGui@@YA_NPEBDQEAHH@Z";
InputInt3 :: (label: *u8, v: *[3] s32, flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputInt3@ImGui@@YA_NPEBDQEAHH@Z";
InputInt4 :: (label: *u8, v: *[4] s32, flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputInt4@ImGui@@YA_NPEBDQEAHH@Z";
InputDouble :: (label: *u8, v: *float64, step: float64 = 0.0, step_fast: float64 = 0.0, format: *u8 = "%.6f", flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputDouble@ImGui@@YA_NPEBDPEANNN0H@Z";
InputScalar :: (label: *u8, data_type: DataType, p_data: *void, p_step: *void = null, p_step_fast: *void = null, format: *u8 = null, flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputScalar@ImGui@@YA_NPEBDHPEAXPEBX20H@Z";
InputScalarN :: (label: *u8, data_type: DataType, p_data: *void, components: s32, p_step: *void = null, p_step_fast: *void = null, format: *u8 = null, flags: InputTextFlags = .None) -> bool #foreign ImGui "?InputScalarN@ImGui@@YA_NPEBDHPEAXHPEBX20H@Z";

// Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
// - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
// - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
ColorEdit3 :: (label: *u8, col: *[3] float, flags: ColorEditFlags = .None) -> bool #foreign ImGui "?ColorEdit3@ImGui@@YA_NPEBDQEAMH@Z";
ColorEdit4 :: (label: *u8, col: *[4] float, flags: ColorEditFlags = .None) -> bool #foreign ImGui "?ColorEdit4@ImGui@@YA_NPEBDQEAMH@Z";
ColorPicker3 :: (label: *u8, col: *[3] float, flags: ColorEditFlags = .None) -> bool #foreign ImGui "?ColorPicker3@ImGui@@YA_NPEBDQEAMH@Z";
ColorPicker4 :: (label: *u8, col: *[4] float, flags: ColorEditFlags = .None, ref_col: *float = null) -> bool #foreign ImGui "?ColorPicker4@ImGui@@YA_NPEBDQEAMHPEBM@Z";
ColorButton :: (desc_id: *u8, col: *Vector4, flags: ColorEditFlags = .None, size: *Vector2) -> bool #foreign ImGui "?ColorButton@ImGui@@YA_NPEBDAEBUImVec4@@HAEBUImVec2@@@Z";
ColorButton :: (desc_id: *u8, col: Vector4, flags: ColorEditFlags = .None, size: Vector2 = .{0, 0}) -> bool #no_context {
    return ColorButton(desc_id, *col, flags, *size);
}
SetColorEditOptions :: (flags: ColorEditFlags) -> void #foreign ImGui "?SetColorEditOptions@ImGui@@YAXH@Z";

// Widgets: Trees
// - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
TreeNode :: (label: *u8) -> bool #foreign ImGui "?TreeNode@ImGui@@YA_NPEBD@Z";
TreeNode_CFormat :: (str_id: *u8, fmt: *u8, __args: ..Any) -> bool #foreign ImGui "?TreeNode@ImGui@@YA_NPEBD0ZZ";
TreeNode :: (str_id: *u8, fmt: string, __args: ..Any) -> bool {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return TreeNode_CFormat(str_id, "%s", formatted_text.data);
} @PrintLike
TreeNode_CFormat :: (ptr_id: *void, fmt: *u8, __args: ..Any) -> bool #foreign ImGui "?TreeNode@ImGui@@YA_NPEBXPEBDZZ";
TreeNode :: (ptr_id: *void, fmt: string, __args: ..Any) -> bool {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return TreeNode_CFormat(ptr_id, "%s", formatted_text.data);
} @PrintLike

TreeNodeEx :: (label: *u8, flags: TreeNodeFlags = .None) -> bool #foreign ImGui "?TreeNodeEx@ImGui@@YA_NPEBDH@Z";
TreeNodeEx_CFormat :: (str_id: *u8, flags: TreeNodeFlags, fmt: *u8, __args: ..Any) -> bool #foreign ImGui "?TreeNodeEx@ImGui@@YA_NPEBDH0ZZ";
TreeNodeEx :: (str_id: *u8, flags: TreeNodeFlags, fmt: string, __args: ..Any) -> bool {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return TreeNodeEx_CFormat(str_id, flags, "%s", formatted_text.data);
} @PrintLike
TreeNodeEx_CFormat :: (ptr_id: *void, flags: TreeNodeFlags, fmt: *u8, __args: ..Any) -> bool #foreign ImGui "?TreeNodeEx@ImGui@@YA_NPEBXHPEBDZZ";
TreeNodeEx :: (ptr_id: *void, flags: TreeNodeFlags, fmt: string, __args: ..Any) -> bool {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return TreeNodeEx_CFormat(ptr_id, flags, "%s", formatted_text.data);
} @PrintLike

TreePush :: (str_id: *u8) -> void #foreign ImGui "?TreePush@ImGui@@YAXPEBD@Z";
TreePush :: (ptr_id: *void) -> void #foreign ImGui "?TreePush@ImGui@@YAXPEBX@Z";
TreePop :: () -> void #foreign ImGui "?TreePop@ImGui@@YAXXZ";
GetTreeNodeToLabelSpacing :: () -> float #foreign ImGui "?GetTreeNodeToLabelSpacing@ImGui@@YAMXZ";
CollapsingHeader :: (label: *u8, flags: TreeNodeFlags = .None) -> bool #foreign ImGui "?CollapsingHeader@ImGui@@YA_NPEBDH@Z";
CollapsingHeader :: (label: *u8, p_visible: *bool, flags: TreeNodeFlags = .None) -> bool #foreign ImGui "?CollapsingHeader@ImGui@@YA_NPEBDPEA_NH@Z";
SetNextItemOpen :: (is_open: bool, cond: Cond = .None) -> void #foreign ImGui "?SetNextItemOpen@ImGui@@YAX_NH@Z";
SetNextItemStorageID :: (storage_id: ID) -> void #foreign ImGui "?SetNextItemStorageID@ImGui@@YAXI@Z";

// Widgets: Selectables
// - A selectable highlights when hovered, and can display another color when selected.
// - Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
Selectable :: (label: *u8, selected := false, flags: SelectableFlags = .None, size: *Vector2) -> bool #foreign ImGui "?Selectable@ImGui@@YA_NPEBD_NHAEBUImVec2@@@Z";
Selectable :: (label: *u8, selected := false, flags: SelectableFlags = .None, size: Vector2 = .{0, 0}) -> bool #no_context {
    return Selectable(label, selected, flags, *size);
}
Selectable :: (label: *u8, p_selected: *bool, flags: SelectableFlags = .None, size: *Vector2) -> bool #foreign ImGui "?Selectable@ImGui@@YA_NPEBDPEA_NHAEBUImVec2@@@Z";
Selectable :: (label: *u8, p_selected: *bool, flags: SelectableFlags = .None, size: Vector2 = .{0, 0}) -> bool #no_context {
    return Selectable(label, p_selected, flags, *size);
}

// Multi-selection system for Selectable(), Checkbox(), TreeNode() functions [BETA]
// - This enables standard multi-selection/range-selection idioms (CTRL+Mouse/Keyboard, SHIFT+Mouse/Keyboard, etc.) in a way that also allow a clipper to be used.
// - ImGuiSelectionUserData is often used to store your item index within the current view (but may store something else).
// - Read comments near ImGuiMultiSelectIO for instructions/details and see 'Demo->Widgets->Selection State & Multi-Select' for demo.
// - TreeNode() is technically supported but... using this correctly is more complicated. You need some sort of linear/random access to your tree,
//   which is suited to advanced trees setups already implementing filters and clipper. We will work simplifying the current demo.
// - 'selection_size' and 'items_count' parameters are optional and used by a few features. If they are costly for you to compute, you may avoid them.
BeginMultiSelect :: (flags: MultiSelectFlags, selection_size: s32 = -1, items_count: s32 = -1) -> *MultiSelectIO #foreign ImGui "?BeginMultiSelect@ImGui@@YAPEAUImGuiMultiSelectIO@@HHH@Z";
EndMultiSelect :: () -> *MultiSelectIO #foreign ImGui "?EndMultiSelect@ImGui@@YAPEAUImGuiMultiSelectIO@@XZ";
SetNextItemSelectionUserData :: (selection_user_data: SelectionUserData) -> void #foreign ImGui "?SetNextItemSelectionUserData@ImGui@@YAX_J@Z";
IsItemToggledSelection :: () -> bool #foreign ImGui "?IsItemToggledSelection@ImGui@@YA_NXZ";

// Widgets: List Boxes
// - This is essentially a thin wrapper to using BeginChild/EndChild with the ImGuiChildFlags_FrameStyle flag for stylistic changes + displaying a label.
// - If you don't need a label you can probably simply use BeginChild() with the ImGuiChildFlags_FrameStyle flag for the same result.
// - You can submit contents and manage your selection state however you want it, by creating e.g. Selectable() or any other items.
// - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analogous to how Combos are created.
// - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
// - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
BeginListBox :: (label: *u8, size: *Vector2) -> bool #foreign ImGui "?BeginListBox@ImGui@@YA_NPEBDAEBUImVec2@@@Z";
BeginListBox :: (label: *u8, size: Vector2 = .{0, 0}) -> bool #no_context {
    return BeginListBox(label, *size);
}
EndListBox :: () -> void #foreign ImGui "?EndListBox@ImGui@@YAXXZ";
ListBox :: (label: *u8, current_item: *s32, items: **u8, items_count: s32, height_in_items: s32 = -1) -> bool #foreign ImGui "?ListBox@ImGui@@YA_NPEBDPEAHQEBQEBDHH@Z";
ListBox :: (label: *u8, current_item: *s32, getter: #type (user_data: *void, idx: s32) -> *u8 #c_call, user_data: *void, items_count: s32, height_in_items: s32 = -1) -> bool #foreign ImGui "?ListBox@ImGui@@YA_NPEBDPEAHP6APEBDPEAXH@Z2HH@Z";

// Widgets: Data Plotting
// - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
PlotLines :: (label: *u8, values: *float, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: Vector2 = .{0, 0}, stride: s32 = 4) -> void #foreign ImGui "?PlotLines@ImGui@@YAXPEBDPEBMHH0MMUImVec2@@H@Z";
PlotLines :: (label: *u8, values_getter: #type (data: *void, idx: s32) -> float #c_call, data: *void, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: Vector2 = .{0, 0}) -> void #foreign ImGui "?PlotLines@ImGui@@YAXPEBDP6AMPEAXH@Z1HH0MMUImVec2@@@Z";
PlotHistogram :: (label: *u8, values: *float, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: Vector2 = .{0, 0}, stride: s32 = 4) -> void #foreign ImGui "?PlotHistogram@ImGui@@YAXPEBDPEBMHH0MMUImVec2@@H@Z";
PlotHistogram :: (label: *u8, values_getter: #type (data: *void, idx: s32) -> float #c_call, data: *void, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: Vector2 = .{0, 0}) -> void #foreign ImGui "?PlotHistogram@ImGui@@YAXPEBDP6AMPEAXH@Z1HH0MMUImVec2@@@Z";

// Widgets: Value() Helpers.
// - Those are merely shortcut to calling Text() with a format string. Output single value in "name: value" format (tip: freely declare more in your code to handle your types. you can add functions to the ImGui namespace)
Value :: (prefix: *u8, b: bool) -> void #foreign ImGui "?Value@ImGui@@YAXPEBD_N@Z";
Value :: (prefix: *u8, v: s32) -> void #foreign ImGui "?Value@ImGui@@YAXPEBDH@Z";
Value :: (prefix: *u8, v: u32) -> void #foreign ImGui "?Value@ImGui@@YAXPEBDI@Z";
Value :: (prefix: *u8, v: float, float_format: *u8 = null) -> void #foreign ImGui "?Value@ImGui@@YAXPEBDM0@Z";

// Widgets: Menus
// - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
// - Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
// - Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
// - Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
BeginMenuBar :: () -> bool #foreign ImGui "?BeginMenuBar@ImGui@@YA_NXZ";
EndMenuBar :: () -> void #foreign ImGui "?EndMenuBar@ImGui@@YAXXZ";
BeginMainMenuBar :: () -> bool #foreign ImGui "?BeginMainMenuBar@ImGui@@YA_NXZ";
EndMainMenuBar :: () -> void #foreign ImGui "?EndMainMenuBar@ImGui@@YAXXZ";
BeginMenu :: (label: *u8, enabled := true) -> bool #foreign ImGui "?BeginMenu@ImGui@@YA_NPEBD_N@Z";
EndMenu :: () -> void #foreign ImGui "?EndMenu@ImGui@@YAXXZ";
MenuItem :: (label: *u8, shortcut: *u8 = null, selected := false, enabled := true) -> bool #foreign ImGui "?MenuItem@ImGui@@YA_NPEBD0_N1@Z";
MenuItem :: (label: *u8, shortcut: *u8, p_selected: *bool, enabled := true) -> bool #foreign ImGui "?MenuItem@ImGui@@YA_NPEBD0PEA_N_N@Z";

// Tooltips
// - Tooltips are windows following the mouse. They do not take focus away.
// - A tooltip window can contain items of any types.
// - SetTooltip() is more or less a shortcut for the 'if (BeginTooltip()) { Text(...); EndTooltip(); }' idiom (with a subtlety that it discard any previously submitted tooltip)
BeginTooltip :: () -> bool #foreign ImGui "?BeginTooltip@ImGui@@YA_NXZ";
EndTooltip :: () -> void #foreign ImGui "?EndTooltip@ImGui@@YAXXZ";
SetTooltip_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?SetTooltip@ImGui@@YAXPEBDZZ";
SetTooltip :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    SetTooltip_CFormat("%s", formatted_text.data);
} @PrintLike

// Tooltips: helpers for showing a tooltip when hovering an item
// - BeginItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip) && BeginTooltip())' idiom.
// - SetItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)) { SetTooltip(...); }' idiom.
// - Where 'ImGuiHoveredFlags_ForTooltip' itself is a shortcut to use 'style.HoverFlagsForTooltipMouse' or 'style.HoverFlagsForTooltipNav' depending on active input type. For mouse it defaults to 'ImGuiHoveredFlags_Stationary | ImGuiHoveredFlags_DelayShort'.
BeginItemTooltip :: () -> bool #foreign ImGui "?BeginItemTooltip@ImGui@@YA_NXZ";
SetItemTooltip_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?SetItemTooltip@ImGui@@YAXPEBDZZ";
SetItemTooltip :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    SetItemTooltip_CFormat("%s", formatted_text.data);
} @PrintLike

// Popups, Modals
//  - They block normal mouse hovering detection (and therefore most mouse interactions) behind them.
//  - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
//  - Their visibility state (~bool) is held internally instead of being held by the programmer as we are used to with regular Begin*() calls.
//  - The 3 properties above are related: we need to retain popup visibility state in the library because popups may be closed as any time.
//  - You can bypass the hovering restriction by using ImGuiHoveredFlags_AllowWhenBlockedByPopup when calling IsItemHovered() or IsWindowHovered().
//  - IMPORTANT: Popup identifiers are relative to the current ID stack, so OpenPopup and BeginPopup generally needs to be at the same level of the stack.
//    This is sometimes leading to confusing mistakes. May rework this in the future.
//  - BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards if returned true. ImGuiWindowFlags are forwarded to the window.
//  - BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
BeginPopup :: (str_id: *u8, flags: WindowFlags = .None) -> bool #foreign ImGui "?BeginPopup@ImGui@@YA_NPEBDH@Z";
BeginPopupModal :: (name: *u8, p_open: *bool = null, flags: WindowFlags = .None) -> bool #foreign ImGui "?BeginPopupModal@ImGui@@YA_NPEBDPEA_NH@Z";
EndPopup :: () -> void #foreign ImGui "?EndPopup@ImGui@@YAXXZ";

// Popups: open/close functions
//  - OpenPopup(): set popup state to open. ImGuiPopupFlags are available for opening options.
//  - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
//  - CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
//  - CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
//  - Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
//  - Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
//  - IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
OpenPopup :: (str_id: *u8, popup_flags: PopupFlags = .None) -> void #foreign ImGui "?OpenPopup@ImGui@@YAXPEBDH@Z";
OpenPopup :: (id: ID, popup_flags: PopupFlags = .None) -> void #foreign ImGui "?OpenPopup@ImGui@@YAXIH@Z";
OpenPopupOnItemClick :: (str_id: *u8 = null, popup_flags: PopupFlags = .MouseButtonRight) -> void #foreign ImGui "?OpenPopupOnItemClick@ImGui@@YAXPEBDH@Z";
CloseCurrentPopup :: () -> void #foreign ImGui "?CloseCurrentPopup@ImGui@@YAXXZ";

// Popups: open+begin combined functions helpers
//  - Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
//  - They are convenient to easily create context menus, hence the name.
//  - IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
//  - IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to re-add the ImGuiPopupFlags_MouseButtonRight.
BeginPopupContextItem :: (str_id: *u8 = null, popup_flags: PopupFlags = .MouseButtonRight) -> bool #foreign ImGui "?BeginPopupContextItem@ImGui@@YA_NPEBDH@Z";
BeginPopupContextWindow :: (str_id: *u8 = null, popup_flags: PopupFlags = .MouseButtonRight) -> bool #foreign ImGui "?BeginPopupContextWindow@ImGui@@YA_NPEBDH@Z";
BeginPopupContextVoid :: (str_id: *u8 = null, popup_flags: PopupFlags = .MouseButtonRight) -> bool #foreign ImGui "?BeginPopupContextVoid@ImGui@@YA_NPEBDH@Z";

// Popups: query functions
//  - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
//  - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
//  - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
IsPopupOpen :: (str_id: *u8, flags: PopupFlags = .None) -> bool #foreign ImGui "?IsPopupOpen@ImGui@@YA_NPEBDH@Z";

// Tables
// - Full-featured replacement for old Columns API.
// - See Demo->Tables for demo code. See top of imgui_tables.cpp for general commentary.
// - See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
// The typical call flow is:
// - 1. Call BeginTable(), early out if returning false.
// - 2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
// - 3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
// - 4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
// - 5. Populate contents:
//    - In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
//    - If you are using tables as a sort of grid, where every column is holding the same type of contents,
//      you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
//      TableNextColumn() will automatically wrap-around into the next row if needed.
//    - IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
//    - Summary of possible call flow:
//        - TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
//        - TableNextRow() -> TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK
//        -                   TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
//        - TableNextRow()                           -> Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
// - 5. Call EndTable()
BeginTable :: (str_id: *u8, columns: s32, flags: TableFlags = .None, outer_size: *Vector2, inner_width: float = 0.0) -> bool #foreign ImGui "?BeginTable@ImGui@@YA_NPEBDHHAEBUImVec2@@M@Z";
BeginTable :: (str_id: *u8, columns: s32, flags: TableFlags = .None, outer_size: Vector2 = .{0.0, 0.0}, inner_width: float = 0.0) -> bool #no_context {
    return BeginTable(str_id, columns, flags, *outer_size, inner_width);
}
EndTable :: () -> void #foreign ImGui "?EndTable@ImGui@@YAXXZ";
TableNextRow :: (row_flags: TableRowFlags = .None, min_row_height: float = 0.0) -> void #foreign ImGui "?TableNextRow@ImGui@@YAXHM@Z";
TableNextColumn :: () -> bool #foreign ImGui "?TableNextColumn@ImGui@@YA_NXZ";
TableSetColumnIndex :: (column_n: s32) -> bool #foreign ImGui "?TableSetColumnIndex@ImGui@@YA_NH@Z";

// Tables: Headers & Columns declaration
// - Use TableSetupColumn() to specify label, resizing policy, default width/weight, id, various other flags etc.
// - Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
//   Headers are required to perform: reordering, sorting, and opening the context menu.
//   The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
// - You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
//   some advanced use cases (e.g. adding custom widgets in header row).
// - Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled.
TableSetupColumn :: (label: *u8, flags: TableColumnFlags = .None, init_width_or_weight: float = 0.0, user_id: ID = 0) -> void #foreign ImGui "?TableSetupColumn@ImGui@@YAXPEBDHMI@Z";
TableSetupScrollFreeze :: (cols: s32, rows: s32) -> void #foreign ImGui "?TableSetupScrollFreeze@ImGui@@YAXHH@Z";
TableHeader :: (label: *u8) -> void #foreign ImGui "?TableHeader@ImGui@@YAXPEBD@Z";
TableHeadersRow :: () -> void #foreign ImGui "?TableHeadersRow@ImGui@@YAXXZ";
TableAngledHeadersRow :: () -> void #foreign ImGui "?TableAngledHeadersRow@ImGui@@YAXXZ";

// Tables: Sorting & Miscellaneous functions
// - Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
//   When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
//   changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
//   else you may wastefully sort your data every frame!
// - Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
TableGetSortSpecs :: () -> *TableSortSpecs #foreign ImGui "?TableGetSortSpecs@ImGui@@YAPEAUImGuiTableSortSpecs@@XZ";
TableGetColumnCount :: () -> s32 #foreign ImGui "?TableGetColumnCount@ImGui@@YAHXZ";
TableGetColumnIndex :: () -> s32 #foreign ImGui "?TableGetColumnIndex@ImGui@@YAHXZ";
TableGetRowIndex :: () -> s32 #foreign ImGui "?TableGetRowIndex@ImGui@@YAHXZ";
TableGetColumnName :: (column_n: s32 = -1) -> *u8 #foreign ImGui "?TableGetColumnName@ImGui@@YAPEBDH@Z";
TableGetColumnFlags :: (column_n: s32 = -1) -> TableColumnFlags #foreign ImGui "?TableGetColumnFlags@ImGui@@YAHH@Z";
TableSetColumnEnabled :: (column_n: s32, v: bool) -> void #foreign ImGui "?TableSetColumnEnabled@ImGui@@YAXH_N@Z";
TableGetHoveredColumn :: () -> s32 #foreign ImGui "?TableGetHoveredColumn@ImGui@@YAHXZ";
TableSetBgColor :: (target: TableBgTarget, color: U32, column_n: s32 = -1) -> void #foreign ImGui "?TableSetBgColor@ImGui@@YAXHIH@Z";

// Legacy Columns API (prefer using Tables!)
// - You can also use SameLine(pos_x) to mimic simplified columns.
Columns :: (count: s32 = 1, id: *u8 = null, borders := true) -> void #foreign ImGui "?Columns@ImGui@@YAXHPEBD_N@Z";
NextColumn :: () -> void #foreign ImGui "?NextColumn@ImGui@@YAXXZ";
GetColumnIndex :: () -> s32 #foreign ImGui "?GetColumnIndex@ImGui@@YAHXZ";
GetColumnWidth :: (column_index: s32 = -1) -> float #foreign ImGui "?GetColumnWidth@ImGui@@YAMH@Z";
SetColumnWidth :: (column_index: s32, width: float) -> void #foreign ImGui "?SetColumnWidth@ImGui@@YAXHM@Z";
GetColumnOffset :: (column_index: s32 = -1) -> float #foreign ImGui "?GetColumnOffset@ImGui@@YAMH@Z";
SetColumnOffset :: (column_index: s32, offset_x: float) -> void #foreign ImGui "?SetColumnOffset@ImGui@@YAXHM@Z";
GetColumnsCount :: () -> s32 #foreign ImGui "?GetColumnsCount@ImGui@@YAHXZ";

// Tab Bars, Tabs
// - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
BeginTabBar :: (str_id: *u8, flags: TabBarFlags = .None) -> bool #foreign ImGui "?BeginTabBar@ImGui@@YA_NPEBDH@Z";
EndTabBar :: () -> void #foreign ImGui "?EndTabBar@ImGui@@YAXXZ";
BeginTabItem :: (label: *u8, p_open: *bool = null, flags: TabItemFlags = .None) -> bool #foreign ImGui "?BeginTabItem@ImGui@@YA_NPEBDPEA_NH@Z";
EndTabItem :: () -> void #foreign ImGui "?EndTabItem@ImGui@@YAXXZ";
TabItemButton :: (label: *u8, flags: TabItemFlags = .None) -> bool #foreign ImGui "?TabItemButton@ImGui@@YA_NPEBDH@Z";
SetTabItemClosed :: (tab_or_docked_window_label: *u8) -> void #foreign ImGui "?SetTabItemClosed@ImGui@@YAXPEBD@Z";

// Docking
// [BETA API] Enable with io.ConfigFlags |= ImGuiConfigFlags_DockingEnable.
// Note: You can use most Docking facilities without calling any API. You DO NOT need to call DockSpace() to use Docking!
// - Drag from window title bar or their tab to dock/undock. Hold SHIFT to disable docking.
// - Drag from window menu button (upper-left button) to undock an entire node (all windows).
// - When io.ConfigDockingWithShift == true, you instead need to hold SHIFT to enable docking.
// About dockspaces:
// - Use DockSpaceOverViewport() to create a window covering the screen or a specific viewport + a dockspace inside it.
//   This is often used with ImGuiDockNodeFlags_PassthruCentralNode to make it transparent.
// - Use DockSpace() to create an explicit dock node _within_ an existing window. See Docking demo for details.
// - Important: Dockspaces need to be submitted _before_ any window they can host. Submit it early in your frame!
// - Important: Dockspaces need to be kept alive if hidden, otherwise windows docked into it will be undocked.
//   e.g. if you have multiple tabs with a dockspace inside each tab: submit the non-visible dockspaces with ImGuiDockNodeFlags_KeepAliveOnly.
DockSpace :: (dockspace_id: ID, size: *Vector2, flags: DockNodeFlags = .None, window_class: *WindowClass = null) -> ID #foreign ImGui "?DockSpace@ImGui@@YAIIAEBUImVec2@@HPEBUImGuiWindowClass@@@Z";
DockSpace :: (dockspace_id: ID, size: Vector2 = .{0, 0}, flags: DockNodeFlags = .None, window_class: *WindowClass = null) -> ID #no_context {
    return DockSpace(dockspace_id, *size, flags, window_class);
}
DockSpaceOverViewport :: (dockspace_id: ID = 0, viewport: *Viewport = null, flags: DockNodeFlags = .None, window_class: *WindowClass = null) -> ID #foreign ImGui "?DockSpaceOverViewport@ImGui@@YAIIPEBUImGuiViewport@@HPEBUImGuiWindowClass@@@Z";
SetNextWindowDockID :: (dock_id: ID, cond: Cond = .None) -> void #foreign ImGui "?SetNextWindowDockID@ImGui@@YAXIH@Z";
SetNextWindowClass :: (window_class: *WindowClass) -> void #foreign ImGui "?SetNextWindowClass@ImGui@@YAXPEBUImGuiWindowClass@@@Z";
GetWindowDockID :: () -> ID #foreign ImGui "?GetWindowDockID@ImGui@@YAIXZ";
IsWindowDocked :: () -> bool #foreign ImGui "?IsWindowDocked@ImGui@@YA_NXZ";

// Logging/Capture
// - All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
LogToTTY :: (auto_open_depth: s32 = -1) -> void #foreign ImGui "?LogToTTY@ImGui@@YAXH@Z";
LogToFile :: (auto_open_depth: s32 = -1, filename: *u8 = null) -> void #foreign ImGui "?LogToFile@ImGui@@YAXHPEBD@Z";
LogToClipboard :: (auto_open_depth: s32 = -1) -> void #foreign ImGui "?LogToClipboard@ImGui@@YAXH@Z";
LogFinish :: () -> void #foreign ImGui "?LogFinish@ImGui@@YAXXZ";
LogButtons :: () -> void #foreign ImGui "?LogButtons@ImGui@@YAXXZ";
LogText_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?LogText@ImGui@@YAXPEBDZZ";
LogText :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    LogText_CFormat("%s", formatted_text.data);
} @PrintLike

// Drag and Drop
// - On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
// - On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
// - If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
// - An item can be both drag source and drop target.
BeginDragDropSource :: (flags: DragDropFlags = .None) -> bool #foreign ImGui "?BeginDragDropSource@ImGui@@YA_NH@Z";
SetDragDropPayload :: (type: *u8, data: *void, sz: u64, cond: Cond = .None) -> bool #foreign ImGui "?SetDragDropPayload@ImGui@@YA_NPEBDPEBX_KH@Z";
EndDragDropSource :: () -> void #foreign ImGui "?EndDragDropSource@ImGui@@YAXXZ";
BeginDragDropTarget :: () -> bool #foreign ImGui "?BeginDragDropTarget@ImGui@@YA_NXZ";
AcceptDragDropPayload :: (type: *u8, flags: DragDropFlags = .None) -> *Payload #foreign ImGui "?AcceptDragDropPayload@ImGui@@YAPEBUImGuiPayload@@PEBDH@Z";
EndDragDropTarget :: () -> void #foreign ImGui "?EndDragDropTarget@ImGui@@YAXXZ";
GetDragDropPayload :: () -> *Payload #foreign ImGui "?GetDragDropPayload@ImGui@@YAPEBUImGuiPayload@@XZ";

// Disabling [BETA API]
// - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
// - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
// - Tooltips windows by exception are opted out of disabling.
// - BeginDisabled(false)/EndDisabled() essentially does nothing but is provided to facilitate use of boolean expressions (as a micro-optimization: if you have tens of thousands of BeginDisabled(false)/EndDisabled() pairs, you might want to reformulate your code to avoid making those calls)
BeginDisabled :: (disabled := true) -> void #foreign ImGui "?BeginDisabled@ImGui@@YAX_N@Z";
EndDisabled :: () -> void #foreign ImGui "?EndDisabled@ImGui@@YAXXZ";

// Clipping
// - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
PushClipRect :: (clip_rect_min: *Vector2, clip_rect_max: *Vector2, intersect_with_current_clip_rect: bool) -> void #foreign ImGui "?PushClipRect@ImGui@@YAXAEBUImVec2@@0_N@Z";
PushClipRect :: (clip_rect_min: Vector2, clip_rect_max: Vector2, intersect_with_current_clip_rect: bool) #no_context {
    PushClipRect(*clip_rect_min, *clip_rect_max, intersect_with_current_clip_rect);
}
PopClipRect :: () -> void #foreign ImGui "?PopClipRect@ImGui@@YAXXZ";

// Focus, Activation
SetItemDefaultFocus :: () -> void #foreign ImGui "?SetItemDefaultFocus@ImGui@@YAXXZ";
SetKeyboardFocusHere :: (offset: s32 = 0) -> void #foreign ImGui "?SetKeyboardFocusHere@ImGui@@YAXH@Z";

// Keyboard/Gamepad Navigation
SetNavCursorVisible :: (visible: bool) -> void #foreign ImGui "?SetNavCursorVisible@ImGui@@YAX_N@Z";

// Overlapping mode
SetNextItemAllowOverlap :: () -> void #foreign ImGui "?SetNextItemAllowOverlap@ImGui@@YAXXZ";

// Item/Widgets Utilities and Query Functions
// - Most of the functions are referring to the previous Item that has been submitted.
// - See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
IsItemHovered :: (flags: HoveredFlags = .None) -> bool #foreign ImGui "?IsItemHovered@ImGui@@YA_NH@Z";
IsItemActive :: () -> bool #foreign ImGui "?IsItemActive@ImGui@@YA_NXZ";
IsItemFocused :: () -> bool #foreign ImGui "?IsItemFocused@ImGui@@YA_NXZ";
IsItemClicked :: (mouse_button: MouseButton = .Left) -> bool #foreign ImGui "?IsItemClicked@ImGui@@YA_NH@Z";
IsItemVisible :: () -> bool #foreign ImGui "?IsItemVisible@ImGui@@YA_NXZ";
IsItemEdited :: () -> bool #foreign ImGui "?IsItemEdited@ImGui@@YA_NXZ";
IsItemActivated :: () -> bool #foreign ImGui "?IsItemActivated@ImGui@@YA_NXZ";
IsItemDeactivated :: () -> bool #foreign ImGui "?IsItemDeactivated@ImGui@@YA_NXZ";
IsItemDeactivatedAfterEdit :: () -> bool #foreign ImGui "?IsItemDeactivatedAfterEdit@ImGui@@YA_NXZ";
IsItemToggledOpen :: () -> bool #foreign ImGui "?IsItemToggledOpen@ImGui@@YA_NXZ";
IsAnyItemHovered :: () -> bool #foreign ImGui "?IsAnyItemHovered@ImGui@@YA_NXZ";
IsAnyItemActive :: () -> bool #foreign ImGui "?IsAnyItemActive@ImGui@@YA_NXZ";
IsAnyItemFocused :: () -> bool #foreign ImGui "?IsAnyItemFocused@ImGui@@YA_NXZ";
GetItemID :: () -> ID #foreign ImGui "?GetItemID@ImGui@@YAIXZ";
GetItemRectMin :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetItemRectMin@ImGui@@YA?AUImVec2@@XZ";
GetItemRectMax :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetItemRectMax@ImGui@@YA?AUImVec2@@XZ";
GetItemRectSize :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetItemRectSize@ImGui@@YA?AUImVec2@@XZ";

// Viewports
// - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
// - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
// - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
GetMainViewport :: () -> *Viewport #foreign ImGui "?GetMainViewport@ImGui@@YAPEAUImGuiViewport@@XZ";

// Background/Foreground Draw Lists
GetBackgroundDrawList :: (viewport: *Viewport = null) -> *DrawList #foreign ImGui "?GetBackgroundDrawList@ImGui@@YAPEAUImDrawList@@PEAUImGuiViewport@@@Z";
GetForegroundDrawList :: (viewport: *Viewport = null) -> *DrawList #foreign ImGui "?GetForegroundDrawList@ImGui@@YAPEAUImDrawList@@PEAUImGuiViewport@@@Z";

// Miscellaneous Utilities
IsRectVisible :: (size: *Vector2) -> bool #foreign ImGui "?IsRectVisible@ImGui@@YA_NAEBUImVec2@@@Z";
IsRectVisible :: (size: Vector2) -> bool #no_context {
    return IsRectVisible(*size);
}
IsRectVisible :: (rect_min: *Vector2, rect_max: *Vector2) -> bool #foreign ImGui "?IsRectVisible@ImGui@@YA_NAEBUImVec2@@0@Z";
IsRectVisible :: (rect_min: Vector2, rect_max: Vector2) -> bool #no_context {
    return IsRectVisible(*rect_min, *rect_max);
}
GetTime :: () -> float64 #foreign ImGui "?GetTime@ImGui@@YANXZ";
GetFrameCount :: () -> s32 #foreign ImGui "?GetFrameCount@ImGui@@YAHXZ";
GetDrawListSharedData :: () -> *DrawListSharedData #foreign ImGui "?GetDrawListSharedData@ImGui@@YAPEAUImDrawListSharedData@@XZ";
GetStyleColorName :: (idx: Col) -> *u8 #foreign ImGui "?GetStyleColorName@ImGui@@YAPEBDH@Z";
SetStateStorage :: (storage: *Storage) -> void #foreign ImGui "?SetStateStorage@ImGui@@YAXPEAUImGuiStorage@@@Z";
GetStateStorage :: () -> *Storage #foreign ImGui "?GetStateStorage@ImGui@@YAPEAUImGuiStorage@@XZ";

// Text Utilities
CalcTextSize :: (text: *u8, text_end: *u8 = null, hide_text_after_double_hash := false, wrap_width: float = -1.0) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?CalcTextSize@ImGui@@YA?AUImVec2@@PEBD0_NM@Z";
CalcTextSize :: (text: string, hide_text_after_double_hash := false, wrap_width: float = -1.0) -> Vector2 #no_context {
    return CalcTextSize(text.data, text.data + text.count, hide_text_after_double_hash, wrap_width);
}

// Color Utilities
ColorConvertU32ToFloat4 :: (in: U32) -> Vector4 #cpp_return_type_is_non_pod #foreign ImGui "?ColorConvertU32ToFloat4@ImGui@@YA?AUImVec4@@I@Z";
ColorConvertFloat4ToU32 :: (in: *Vector4) -> U32 #foreign ImGui "?ColorConvertFloat4ToU32@ImGui@@YAIAEBUImVec4@@@Z";
ColorConvertFloat4ToU32 :: (in: Vector4) -> U32 #no_context {
    return ColorConvertFloat4ToU32(*in);
}
ColorConvertRGBtoHSV :: (r: float, g: float, b: float, out_h: *float, out_s: *float, out_v: *float) -> void #foreign ImGui "?ColorConvertRGBtoHSV@ImGui@@YAXMMMAEAM00@Z";
ColorConvertHSVtoRGB :: (h: float, s: float, v: float, out_r: *float, out_g: *float, out_b: *float) -> void #foreign ImGui "?ColorConvertHSVtoRGB@ImGui@@YAXMMMAEAM00@Z";

// Inputs Utilities: Keyboard/Mouse/Gamepad
// - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
// - (legacy: before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. This was obsoleted in 1.87 (2022-02) and completely removed in 1.91.5 (2024-11). See https://github.com/ocornut/imgui/issues/4921)
// - (legacy: any use of ImGuiKey will assert when key < 512 to detect passing legacy native/user indices)
IsKeyDown :: (key: Key) -> bool #foreign ImGui "?IsKeyDown@ImGui@@YA_NW4ImGuiKey@@@Z";
IsKeyPressed :: (key: Key, repeat := true) -> bool #foreign ImGui "?IsKeyPressed@ImGui@@YA_NW4ImGuiKey@@_N@Z";
IsKeyReleased :: (key: Key) -> bool #foreign ImGui "?IsKeyReleased@ImGui@@YA_NW4ImGuiKey@@@Z";
IsKeyChordPressed :: (key_chord: KeyChord) -> bool #foreign ImGui "?IsKeyChordPressed@ImGui@@YA_NH@Z";
GetKeyPressedAmount :: (key: Key, repeat_delay: float, rate: float) -> s32 #foreign ImGui "?GetKeyPressedAmount@ImGui@@YAHW4ImGuiKey@@MM@Z";
GetKeyName :: (key: Key) -> *u8 #foreign ImGui "?GetKeyName@ImGui@@YAPEBDW4ImGuiKey@@@Z";
SetNextFrameWantCaptureKeyboard :: (want_capture_keyboard: bool) -> void #foreign ImGui "?SetNextFrameWantCaptureKeyboard@ImGui@@YAX_N@Z";

// Inputs Utilities: Shortcut Testing & Routing [BETA]
// - ImGuiKeyChord = a ImGuiKey + optional ImGuiMod_Alt/ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Super.
//       ImGuiKey_C                          // Accepted by functions taking ImGuiKey or ImGuiKeyChord arguments
//       ImGuiMod_Ctrl | ImGuiKey_C          // Accepted by functions taking ImGuiKeyChord arguments
//   only ImGuiMod_XXX values are legal to combine with an ImGuiKey. You CANNOT combine two ImGuiKey values.
// - The general idea is that several callers may register interest in a shortcut, and only one owner gets it.
//      Parent   -> call Shortcut(Ctrl+S)    // When Parent is focused, Parent gets the shortcut.
//        Child1 -> call Shortcut(Ctrl+S)    // When Child1 is focused, Child1 gets the shortcut (Child1 overrides Parent shortcuts)
//        Child2 -> no call                  // When Child2 is focused, Parent gets the shortcut.
//   The whole system is order independent, so if Child1 makes its calls before Parent, results will be identical.
//   This is an important property as it facilitate working with foreign code or larger codebase.
// - To understand the difference:
//   - IsKeyChordPressed() compares mods and call IsKeyPressed() -> function has no side-effect.
//   - Shortcut() submits a route, routes are resolved, if it currently can be routed it calls IsKeyChordPressed() -> function has (desirable) side-effects as it can prevents another call from getting the route.
// - Visualize registered routes in 'Metrics/Debugger->Inputs'.
Shortcut :: (key_chord: KeyChord, flags: InputFlags = .None) -> bool #foreign ImGui "?Shortcut@ImGui@@YA_NHH@Z";
SetNextItemShortcut :: (key_chord: KeyChord, flags: InputFlags = .None) -> void #foreign ImGui "?SetNextItemShortcut@ImGui@@YAXHH@Z";

// Inputs Utilities: Key/Input Ownership [BETA]
// - One common use case would be to allow your items to disable standard inputs behaviors such
//   as Tab or Alt key handling, Mouse Wheel scrolling, etc.
//   e.g. Button(...); SetItemKeyOwner(ImGuiKey_MouseWheelY); to make hovering/activating a button disable wheel for scrolling.
// - Reminder ImGuiKey enum include access to mouse buttons and gamepad, so key ownership can apply to them.
// - Many related features are still in imgui_internal.h. For instance, most IsKeyXXX()/IsMouseXXX() functions have an owner-id-aware version.
SetItemKeyOwner :: (key: Key) -> void #foreign ImGui "?SetItemKeyOwner@ImGui@@YAXW4ImGuiKey@@@Z";

// Inputs Utilities: Mouse
// - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
// - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
// - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
IsMouseDown :: (button: MouseButton) -> bool #foreign ImGui "?IsMouseDown@ImGui@@YA_NH@Z";
IsMouseClicked :: (button: MouseButton, repeat := false) -> bool #foreign ImGui "?IsMouseClicked@ImGui@@YA_NH_N@Z";
IsMouseReleased :: (button: MouseButton) -> bool #foreign ImGui "?IsMouseReleased@ImGui@@YA_NH@Z";
IsMouseDoubleClicked :: (button: MouseButton) -> bool #foreign ImGui "?IsMouseDoubleClicked@ImGui@@YA_NH@Z";
IsMouseReleasedWithDelay :: (button: MouseButton, delay: float) -> bool #foreign ImGui "?IsMouseReleasedWithDelay@ImGui@@YA_NHM@Z";
GetMouseClickedCount :: (button: MouseButton) -> s32 #foreign ImGui "?GetMouseClickedCount@ImGui@@YAHH@Z";
IsMouseHoveringRect :: (r_min: *Vector2, r_max: *Vector2, clip := true) -> bool #foreign ImGui "?IsMouseHoveringRect@ImGui@@YA_NAEBUImVec2@@0_N@Z";
IsMouseHoveringRect :: (r_min: Vector2, r_max: Vector2, clip := true) -> bool #no_context {
    return IsMouseHoveringRect(*r_min, *r_max, clip);
}
IsMousePosValid :: (mouse_pos: *Vector2 = null) -> bool #foreign ImGui "?IsMousePosValid@ImGui@@YA_NPEBUImVec2@@@Z";
IsAnyMouseDown :: () -> bool #foreign ImGui "?IsAnyMouseDown@ImGui@@YA_NXZ";
GetMousePos :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetMousePos@ImGui@@YA?AUImVec2@@XZ";
GetMousePosOnOpeningCurrentPopup :: () -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetMousePosOnOpeningCurrentPopup@ImGui@@YA?AUImVec2@@XZ";
IsMouseDragging :: (button: MouseButton, lock_threshold: float = -1.0) -> bool #foreign ImGui "?IsMouseDragging@ImGui@@YA_NHM@Z";
GetMouseDragDelta :: (button: MouseButton = .Left, lock_threshold: float = -1.0) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetMouseDragDelta@ImGui@@YA?AUImVec2@@HM@Z";
ResetMouseDragDelta :: (button: MouseButton = .Left) -> void #foreign ImGui "?ResetMouseDragDelta@ImGui@@YAXH@Z";
GetMouseCursor :: () -> MouseCursor #foreign ImGui "?GetMouseCursor@ImGui@@YAHXZ";
SetMouseCursor :: (cursor_type: MouseCursor) -> void #foreign ImGui "?SetMouseCursor@ImGui@@YAXH@Z";
SetNextFrameWantCaptureMouse :: (want_capture_mouse: bool) -> void #foreign ImGui "?SetNextFrameWantCaptureMouse@ImGui@@YAX_N@Z";

// Clipboard Utilities
// - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
GetClipboardText :: () -> *u8 #foreign ImGui "?GetClipboardText@ImGui@@YAPEBDXZ";
SetClipboardText :: (text: *u8) -> void #foreign ImGui "?SetClipboardText@ImGui@@YAXPEBD@Z";

// Settings/.Ini Utilities
// - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
// - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
// - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
LoadIniSettingsFromDisk :: (ini_filename: *u8) -> void #foreign ImGui "?LoadIniSettingsFromDisk@ImGui@@YAXPEBD@Z";
LoadIniSettingsFromMemory :: (ini_data: *u8, ini_size: u64 = 0) -> void #foreign ImGui "?LoadIniSettingsFromMemory@ImGui@@YAXPEBD_K@Z";
SaveIniSettingsToDisk :: (ini_filename: *u8) -> void #foreign ImGui "?SaveIniSettingsToDisk@ImGui@@YAXPEBD@Z";
SaveIniSettingsToMemory :: (out_ini_size: *u64 = null) -> *u8 #foreign ImGui "?SaveIniSettingsToMemory@ImGui@@YAPEBDPEA_K@Z";

// Debug Utilities
// - Your main debugging friend is the ShowMetricsWindow() function, which is also accessible from Demo->Tools->Metrics Debugger
DebugTextEncoding :: (text: *u8) -> void #foreign ImGui "?DebugTextEncoding@ImGui@@YAXPEBD@Z";
DebugFlashStyleColor :: (idx: Col) -> void #foreign ImGui "?DebugFlashStyleColor@ImGui@@YAXH@Z";
DebugStartItemPicker :: () -> void #foreign ImGui "?DebugStartItemPicker@ImGui@@YAXXZ";
DebugCheckVersionAndDataLayout :: (version_str: *u8, sz_io: u64, sz_style: u64, sz_vec2: u64, sz_vec4: u64, sz_drawvert: u64, sz_drawidx: u64) -> bool #foreign ImGui "?DebugCheckVersionAndDataLayout@ImGui@@YA_NPEBD_K11111@Z";

DebugLog_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign ImGui "?DebugLog@ImGui@@YAXPEBDZZ";
DebugLog :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    DebugLog_CFormat("%s", formatted_text.data);
} @PrintLike

// Memory Allocators
// - Those functions are not reliant on the current context.
// - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
//   for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
SetAllocatorFunctions :: (alloc_func: MemAllocFunc, free_func: MemFreeFunc, user_data: *void = null) -> void #foreign ImGui "?SetAllocatorFunctions@ImGui@@YAXP6APEAX_KPEAX@ZP6AX11@Z1@Z";
GetAllocatorFunctions :: (p_alloc_func: *MemAllocFunc, p_free_func: *MemFreeFunc, p_user_data: **void) -> void #foreign ImGui "?GetAllocatorFunctions@ImGui@@YAXPEAP6APEAX_KPEAX@ZPEAP6AX11@ZPEAPEAX@Z";
MemAlloc :: (size: u64) -> *void #foreign ImGui "?MemAlloc@ImGui@@YAPEAX_K@Z";
MemFree :: (ptr: *void) -> void #foreign ImGui "?MemFree@ImGui@@YAXPEAX@Z";

// (Optional) Platform/OS interface for multi-viewport support
// Read comments around the ImGuiPlatformIO structure for more details.
// Note: You may use GetWindowViewport() to get the current viewport of the current window.
UpdatePlatformWindows :: () -> void #foreign ImGui "?UpdatePlatformWindows@ImGui@@YAXXZ";
RenderPlatformWindowsDefault :: (platform_render_arg: *void = null, renderer_render_arg: *void = null) -> void #foreign ImGui "?RenderPlatformWindowsDefault@ImGui@@YAXPEAX0@Z";
DestroyPlatformWindows :: () -> void #foreign ImGui "?DestroyPlatformWindows@ImGui@@YAXXZ";
FindViewportByID :: (id: ID) -> *Viewport #foreign ImGui "?FindViewportByID@ImGui@@YAPEAUImGuiViewport@@I@Z";
FindViewportByPlatformHandle :: (platform_handle: *void) -> *Viewport #foreign ImGui "?FindViewportByPlatformHandle@ImGui@@YAPEAUImGuiViewport@@PEAX@Z";

// Windows
// We should always have a CurrentWindow in the stack (there is an implicit "Debug" window)
// If this ever crashes because g.CurrentWindow is NULL, it means that either:
// - ImGui::NewFrame() has never been called, which is illegal.
// - You are calling ImGui functions after ImGui::EndFrame()/ImGui::Render() and before the next ImGui::NewFrame(), which is also illegal.
GetIO :: (ctx: *ImGuiContext) -> *IO #foreign ImGui "?GetIO@ImGui@@YAAEAUImGuiIO@@PEAUImGuiContext@@@Z";
GetPlatformIO :: (ctx: *ImGuiContext) -> *PlatformIO #foreign ImGui "?GetPlatformIO@ImGui@@YAAEAUImGuiPlatformIO@@PEAUImGuiContext@@@Z";
GetCurrentWindowRead :: () -> *Window #foreign ImGui "?GetCurrentWindowRead@ImGui@@YAPEAUImGuiWindow@@XZ";
GetCurrentWindow :: () -> *Window #foreign ImGui "?GetCurrentWindow@ImGui@@YAPEAUImGuiWindow@@XZ";
FindWindowByID :: (id: ID) -> *Window #foreign ImGui "?FindWindowByID@ImGui@@YAPEAUImGuiWindow@@I@Z";
FindWindowByName :: (name: *u8) -> *Window #foreign ImGui "?FindWindowByName@ImGui@@YAPEAUImGuiWindow@@PEBD@Z";
UpdateWindowParentAndRootLinks :: (window: *Window, flags: WindowFlags, parent_window: *Window) -> void #foreign ImGui "?UpdateWindowParentAndRootLinks@ImGui@@YAXPEAUImGuiWindow@@H0@Z";
UpdateWindowSkipRefresh :: (window: *Window) -> void #foreign ImGui "?UpdateWindowSkipRefresh@ImGui@@YAXPEAUImGuiWindow@@@Z";
CalcWindowNextAutoFitSize :: (window: *Window) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?CalcWindowNextAutoFitSize@ImGui@@YA?AUImVec2@@PEAUImGuiWindow@@@Z";
IsWindowChildOf :: (window: *Window, potential_parent: *Window, popup_hierarchy: bool, dock_hierarchy: bool) -> bool #foreign ImGui "?IsWindowChildOf@ImGui@@YA_NPEAUImGuiWindow@@0_N1@Z";
IsWindowWithinBeginStackOf :: (window: *Window, potential_parent: *Window) -> bool #foreign ImGui "?IsWindowWithinBeginStackOf@ImGui@@YA_NPEAUImGuiWindow@@0@Z";
IsWindowAbove :: (potential_above: *Window, potential_below: *Window) -> bool #foreign ImGui "?IsWindowAbove@ImGui@@YA_NPEAUImGuiWindow@@0@Z";
IsWindowNavFocusable :: (window: *Window) -> bool #foreign ImGui "?IsWindowNavFocusable@ImGui@@YA_NPEAUImGuiWindow@@@Z";
SetWindowPos :: (window: *Window, pos: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetWindowPos@ImGui@@YAXPEAUImGuiWindow@@AEBUImVec2@@H@Z";
SetWindowPos :: (window: *Window, pos: Vector2, cond: Cond = .None) #no_context {
    SetWindowPos(window, *pos, cond);
}
SetWindowSize :: (window: *Window, size: *Vector2, cond: Cond = .None) -> void #foreign ImGui "?SetWindowSize@ImGui@@YAXPEAUImGuiWindow@@AEBUImVec2@@H@Z";
SetWindowSize :: (window: *Window, size: Vector2, cond: Cond = .None) #no_context {
    SetWindowSize(window, *size, cond);
}
SetWindowCollapsed :: (window: *Window, collapsed: bool, cond: Cond = .None) -> void #foreign ImGui "?SetWindowCollapsed@ImGui@@YAXPEAUImGuiWindow@@_NH@Z";
SetWindowHitTestHole :: (window: *Window, pos: *Vector2, size: *Vector2) -> void #foreign ImGui "?SetWindowHitTestHole@ImGui@@YAXPEAUImGuiWindow@@AEBUImVec2@@1@Z";
SetWindowHitTestHole :: (window: *Window, pos: Vector2, size: Vector2) #no_context {
    SetWindowHitTestHole(window, *pos, *size);
}
SetWindowHiddenAndSkipItemsForCurrentFrame :: (window: *Window) -> void #foreign ImGui "?SetWindowHiddenAndSkipItemsForCurrentFrame@ImGui@@YAXPEAUImGuiWindow@@@Z";

WindowRectAbsToRel :: (window: *Window, r: *Rect) -> Rect #cpp_return_type_is_non_pod #foreign ImGui "?WindowRectAbsToRel@ImGui@@YA?AUImRect@@PEAUImGuiWindow@@AEBU2@@Z";
WindowRectAbsToRel :: (window: *Window, r: Rect) -> Rect #no_context {
    return WindowRectAbsToRel(window, *r);
}
WindowRectRelToAbs :: (window: *Window, r: *Rect) -> Rect #cpp_return_type_is_non_pod #foreign ImGui "?WindowRectRelToAbs@ImGui@@YA?AUImRect@@PEAUImGuiWindow@@AEBU2@@Z";
WindowRectRelToAbs :: (window: *Window, r: Rect) -> Rect #no_context {
    return WindowRectRelToAbs(window, *r);
}
WindowPosAbsToRel :: (window: *Window, p: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?WindowPosAbsToRel@ImGui@@YA?AUImVec2@@PEAUImGuiWindow@@AEBU2@@Z";
WindowPosAbsToRel :: (window: *Window, p: Vector2) -> Vector2 #no_context {
    return WindowPosAbsToRel(window, *p);
}
WindowPosRelToAbs :: (window: *Window, p: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?WindowPosRelToAbs@ImGui@@YA?AUImVec2@@PEAUImGuiWindow@@AEBU2@@Z";
WindowPosRelToAbs :: (window: *Window, p: Vector2) -> Vector2 #no_context {
    return WindowPosRelToAbs(window, *p);
}

// Windows: Display Order and Focus Order
FocusWindow :: (window: *Window, flags: FocusRequestFlags = 0) -> void #foreign ImGui "?FocusWindow@ImGui@@YAXPEAUImGuiWindow@@H@Z";
FocusTopMostWindowUnderOne :: (under_this_window: *Window, ignore_window: *Window, filter_viewport: *Viewport, flags: FocusRequestFlags) -> void #foreign ImGui "?FocusTopMostWindowUnderOne@ImGui@@YAXPEAUImGuiWindow@@0PEAUImGuiViewport@@H@Z";
BringWindowToFocusFront :: (window: *Window) -> void #foreign ImGui "?BringWindowToFocusFront@ImGui@@YAXPEAUImGuiWindow@@@Z";
BringWindowToDisplayFront :: (window: *Window) -> void #foreign ImGui "?BringWindowToDisplayFront@ImGui@@YAXPEAUImGuiWindow@@@Z";
BringWindowToDisplayBack :: (window: *Window) -> void #foreign ImGui "?BringWindowToDisplayBack@ImGui@@YAXPEAUImGuiWindow@@@Z";
BringWindowToDisplayBehind :: (window: *Window, above_window: *Window) -> void #foreign ImGui "?BringWindowToDisplayBehind@ImGui@@YAXPEAUImGuiWindow@@0@Z";
FindWindowDisplayIndex :: (window: *Window) -> s32 #foreign ImGui "?FindWindowDisplayIndex@ImGui@@YAHPEAUImGuiWindow@@@Z";
FindBottomMostVisibleWindowWithinBeginStack :: (window: *Window) -> *Window #foreign ImGui "?FindBottomMostVisibleWindowWithinBeginStack@ImGui@@YAPEAUImGuiWindow@@PEAU2@@Z";

// Windows: Idle, Refresh Policies [EXPERIMENTAL]
SetNextWindowRefreshPolicy :: (flags: WindowRefreshFlags) -> void #foreign ImGui "?SetNextWindowRefreshPolicy@ImGui@@YAXH@Z";

// Fonts, drawing
RegisterUserTexture :: (tex: *TextureData) -> void #foreign ImGui "?RegisterUserTexture@ImGui@@YAXPEAUImTextureData@@@Z";
UnregisterUserTexture :: (tex: *TextureData) -> void #foreign ImGui "?UnregisterUserTexture@ImGui@@YAXPEAUImTextureData@@@Z";
RegisterFontAtlas :: (atlas: *FontAtlas) -> void #foreign ImGui "?RegisterFontAtlas@ImGui@@YAXPEAUImFontAtlas@@@Z";
UnregisterFontAtlas :: (atlas: *FontAtlas) -> void #foreign ImGui "?UnregisterFontAtlas@ImGui@@YAXPEAUImFontAtlas@@@Z";
SetCurrentFont :: (font: *Font, font_size_before_scaling: float, font_size_after_scaling: float) -> void #foreign ImGui "?SetCurrentFont@ImGui@@YAXPEAUImFont@@MM@Z";
UpdateCurrentFontSize :: (restore_font_size_after_scaling: float) -> void #foreign ImGui "?UpdateCurrentFontSize@ImGui@@YAXM@Z";
SetFontRasterizerDensity :: (rasterizer_density: float) -> void #foreign ImGui "?SetFontRasterizerDensity@ImGui@@YAXM@Z";

GetRoundedFontSize :: (size: float) -> float #foreign ImGui "?GetRoundedFontSize@ImGui@@YAMM@Z";
GetDefaultFont :: () -> *Font #foreign ImGui "?GetDefaultFont@ImGui@@YAPEAUImFont@@XZ";
PushPasswordFont :: () -> void #foreign ImGui "?PushPasswordFont@ImGui@@YAXXZ";
PopPasswordFont :: () -> void #foreign ImGui "?PopPasswordFont@ImGui@@YAXXZ";
GetForegroundDrawList :: (window: *Window) -> *DrawList #foreign ImGui "?GetForegroundDrawList@ImGui@@YAPEAUImDrawList@@PEAUImGuiWindow@@@Z";
AddDrawListToDrawDataEx :: (draw_data: *DrawData, out_list: *Vector(*DrawList), draw_list: *DrawList) -> void #foreign ImGui "?AddDrawListToDrawDataEx@ImGui@@YAXPEAUImDrawData@@PEAU?$ImVector@PEAUImDrawList@@@@PEAUImDrawList@@@Z";

// Init
Initialize :: () -> void #foreign ImGui "?Initialize@ImGui@@YAXXZ";
Shutdown :: () -> void #foreign ImGui "?Shutdown@ImGui@@YAXXZ";

// NewFrame
UpdateInputEvents :: (trickle_fast_inputs: bool) -> void #foreign ImGui "?UpdateInputEvents@ImGui@@YAX_N@Z";
UpdateHoveredWindowAndCaptureFlags :: (mouse_pos: *Vector2) -> void #foreign ImGui "?UpdateHoveredWindowAndCaptureFlags@ImGui@@YAXAEBUImVec2@@@Z";
UpdateHoveredWindowAndCaptureFlags :: (mouse_pos: Vector2) #no_context {
    UpdateHoveredWindowAndCaptureFlags(*mouse_pos);
}
FindHoveredWindowEx :: (pos: *Vector2, find_first_and_in_any_viewport: bool, out_hovered_window: **Window, out_hovered_window_under_moving_window: **Window) -> void #foreign ImGui "?FindHoveredWindowEx@ImGui@@YAXAEBUImVec2@@_NPEAPEAUImGuiWindow@@2@Z";
FindHoveredWindowEx :: (pos: Vector2, find_first_and_in_any_viewport: bool, out_hovered_window: **Window, out_hovered_window_under_moving_window: **Window) #no_context {
    FindHoveredWindowEx(*pos, find_first_and_in_any_viewport, out_hovered_window, out_hovered_window_under_moving_window);
}
StartMouseMovingWindow :: (window: *Window) -> void #foreign ImGui "?StartMouseMovingWindow@ImGui@@YAXPEAUImGuiWindow@@@Z";
StartMouseMovingWindowOrNode :: (window: *Window, node: *DockNode, undock: bool) -> void #foreign ImGui "?StartMouseMovingWindowOrNode@ImGui@@YAXPEAUImGuiWindow@@PEAUImGuiDockNode@@_N@Z";
StopMouseMovingWindow :: () -> void #foreign ImGui "?StopMouseMovingWindow@ImGui@@YAXXZ";
UpdateMouseMovingWindowNewFrame :: () -> void #foreign ImGui "?UpdateMouseMovingWindowNewFrame@ImGui@@YAXXZ";
UpdateMouseMovingWindowEndFrame :: () -> void #foreign ImGui "?UpdateMouseMovingWindowEndFrame@ImGui@@YAXXZ";

// Generic context hooks
AddContextHook :: (_context: *ImGuiContext, hook: *ContextHook) -> ID #foreign ImGui "?AddContextHook@ImGui@@YAIPEAUImGuiContext@@PEBUImGuiContextHook@@@Z";
RemoveContextHook :: (_context: *ImGuiContext, hook_to_remove: ID) -> void #foreign ImGui "?RemoveContextHook@ImGui@@YAXPEAUImGuiContext@@I@Z";
CallContextHooks :: (_context: *ImGuiContext, type: ContextHookType) -> void #foreign ImGui "?CallContextHooks@ImGui@@YAXPEAUImGuiContext@@W4ImGuiContextHookType@@@Z";

// Viewports
TranslateWindowsInViewport :: (viewport: *ViewportP, old_pos: *Vector2, new_pos: *Vector2, old_size: *Vector2, new_size: *Vector2) -> void #foreign ImGui "?TranslateWindowsInViewport@ImGui@@YAXPEAUImGuiViewportP@@AEBUImVec2@@111@Z";
TranslateWindowsInViewport :: (viewport: *ViewportP, old_pos: Vector2, new_pos: Vector2, old_size: Vector2, new_size: Vector2) #no_context {
    TranslateWindowsInViewport(viewport, *old_pos, *new_pos, *old_size, *new_size);
}
ScaleWindowsInViewport :: (viewport: *ViewportP, scale: float) -> void #foreign ImGui "?ScaleWindowsInViewport@ImGui@@YAXPEAUImGuiViewportP@@M@Z";
DestroyPlatformWindow :: (viewport: *ViewportP) -> void #foreign ImGui "?DestroyPlatformWindow@ImGui@@YAXPEAUImGuiViewportP@@@Z";
SetWindowViewport :: (window: *Window, viewport: *ViewportP) -> void #foreign ImGui "?SetWindowViewport@ImGui@@YAXPEAUImGuiWindow@@PEAUImGuiViewportP@@@Z";
SetCurrentViewport :: (window: *Window, viewport: *ViewportP) -> void #foreign ImGui "?SetCurrentViewport@ImGui@@YAXPEAUImGuiWindow@@PEAUImGuiViewportP@@@Z";
GetViewportPlatformMonitor :: (viewport: *Viewport) -> *PlatformMonitor #foreign ImGui "?GetViewportPlatformMonitor@ImGui@@YAPEBUImGuiPlatformMonitor@@PEAUImGuiViewport@@@Z";
FindHoveredViewportFromPlatformWindowStack :: (mouse_platform_pos: *Vector2) -> *ViewportP #foreign ImGui "?FindHoveredViewportFromPlatformWindowStack@ImGui@@YAPEAUImGuiViewportP@@AEBUImVec2@@@Z";
FindHoveredViewportFromPlatformWindowStack :: (mouse_platform_pos: Vector2) -> *ViewportP #no_context {
    return FindHoveredViewportFromPlatformWindowStack(*mouse_platform_pos);
}

// Settings
MarkIniSettingsDirty :: () -> void #foreign ImGui "?MarkIniSettingsDirty@ImGui@@YAXXZ";
MarkIniSettingsDirty :: (window: *Window) -> void #foreign ImGui "?MarkIniSettingsDirty@ImGui@@YAXPEAUImGuiWindow@@@Z";
ClearIniSettings :: () -> void #foreign ImGui "?ClearIniSettings@ImGui@@YAXXZ";
AddSettingsHandler :: (handler: *SettingsHandler) -> void #foreign ImGui "?AddSettingsHandler@ImGui@@YAXPEBUImGuiSettingsHandler@@@Z";
RemoveSettingsHandler :: (type_name: *u8) -> void #foreign ImGui "?RemoveSettingsHandler@ImGui@@YAXPEBD@Z";
FindSettingsHandler :: (type_name: *u8) -> *SettingsHandler #foreign ImGui "?FindSettingsHandler@ImGui@@YAPEAUImGuiSettingsHandler@@PEBD@Z";

// Settings - Windows
CreateNewWindowSettings :: (name: *u8) -> *WindowSettings #foreign ImGui "?CreateNewWindowSettings@ImGui@@YAPEAUImGuiWindowSettings@@PEBD@Z";
FindWindowSettingsByID :: (id: ID) -> *WindowSettings #foreign ImGui "?FindWindowSettingsByID@ImGui@@YAPEAUImGuiWindowSettings@@I@Z";
FindWindowSettingsByWindow :: (window: *Window) -> *WindowSettings #foreign ImGui "?FindWindowSettingsByWindow@ImGui@@YAPEAUImGuiWindowSettings@@PEAUImGuiWindow@@@Z";
ClearWindowSettings :: (name: *u8) -> void #foreign ImGui "?ClearWindowSettings@ImGui@@YAXPEBD@Z";

// Localization
LocalizeRegisterEntries :: (entries: *LocEntry, count: s32) -> void #foreign ImGui "?LocalizeRegisterEntries@ImGui@@YAXPEBUImGuiLocEntry@@H@Z";
LocalizeGetMsg :: (key: LocKey) -> *u8 #foreign ImGui "?LocalizeGetMsg@ImGui@@YAPEBDW4ImGuiLocKey@@@Z";

// Scrolling
SetScrollX :: (window: *Window, scroll_x: float) -> void #foreign ImGui "?SetScrollX@ImGui@@YAXPEAUImGuiWindow@@M@Z";
SetScrollY :: (window: *Window, scroll_y: float) -> void #foreign ImGui "?SetScrollY@ImGui@@YAXPEAUImGuiWindow@@M@Z";
SetScrollFromPosX :: (window: *Window, local_x: float, center_x_ratio: float) -> void #foreign ImGui "?SetScrollFromPosX@ImGui@@YAXPEAUImGuiWindow@@MM@Z";
SetScrollFromPosY :: (window: *Window, local_y: float, center_y_ratio: float) -> void #foreign ImGui "?SetScrollFromPosY@ImGui@@YAXPEAUImGuiWindow@@MM@Z";

// Early work-in-progress API (ScrollToItem() will become public)
ScrollToItem :: (flags: ScrollFlags = 0) -> void #foreign ImGui "?ScrollToItem@ImGui@@YAXH@Z";
ScrollToRect :: (window: *Window, rect: *Rect, flags: ScrollFlags = 0) -> void #foreign ImGui "?ScrollToRect@ImGui@@YAXPEAUImGuiWindow@@AEBUImRect@@H@Z";
ScrollToRect :: (window: *Window, rect: Rect, flags: ScrollFlags = 0) #no_context {
    ScrollToRect(window, *rect, flags);
}
ScrollToRectEx :: (window: *Window, rect: *Rect, flags: ScrollFlags = 0) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ScrollToRectEx@ImGui@@YA?AUImVec2@@PEAUImGuiWindow@@AEBUImRect@@H@Z";
ScrollToRectEx :: (window: *Window, rect: Rect, flags: ScrollFlags = 0) -> Vector2 #no_context {
    return ScrollToRectEx(window, *rect, flags);
}

SetActiveID :: (id: ID, window: *Window) -> void #foreign ImGui "?SetActiveID@ImGui@@YAXIPEAUImGuiWindow@@@Z";
SetFocusID :: (id: ID, window: *Window) -> void #foreign ImGui "?SetFocusID@ImGui@@YAXIPEAUImGuiWindow@@@Z";
ClearActiveID :: () -> void #foreign ImGui "?ClearActiveID@ImGui@@YAXXZ";
GetHoveredID :: () -> ID #foreign ImGui "?GetHoveredID@ImGui@@YAIXZ";
SetHoveredID :: (id: ID) -> void #foreign ImGui "?SetHoveredID@ImGui@@YAXI@Z";
KeepAliveID :: (id: ID) -> void #foreign ImGui "?KeepAliveID@ImGui@@YAXI@Z";
MarkItemEdited :: (id: ID) -> void #foreign ImGui "?MarkItemEdited@ImGui@@YAXI@Z";
PushOverrideID :: (id: ID) -> void #foreign ImGui "?PushOverrideID@ImGui@@YAXI@Z";
GetIDWithSeed :: (str_id_begin: *u8, str_id_end: *u8, seed: ID) -> ID #foreign ImGui "?GetIDWithSeed@ImGui@@YAIPEBD0I@Z";
GetIDWithSeed :: (str_id: string, seed: ID) -> ID #no_context {
    return GetIDWithSeed(str_id.data, str_id.data + str_id.count, seed);
}
GetIDWithSeed :: (n: s32, seed: ID) -> ID #foreign ImGui "?GetIDWithSeed@ImGui@@YAIHI@Z";

// Basic Helpers for widget code
ItemSize :: (size: *Vector2, text_baseline_y: float = -1.0) -> void #foreign ImGui "?ItemSize@ImGui@@YAXAEBUImVec2@@M@Z";
ItemSize :: (size: Vector2, text_baseline_y: float = -1.0) #no_context {
    ItemSize(*size, text_baseline_y);
}
ItemSize :: (bb: *Rect, text_baseline_y: float = -1.0) -> void #foreign ImGui "?ItemSize@ImGui@@YAXAEBUImRect@@M@Z";
ItemSize :: (bb: Rect, text_baseline_y: float = -1.0) #no_context {
    ItemSize(*bb, text_baseline_y);
}
ItemAdd :: (bb: *Rect, id: ID, nav_bb: *Rect = null, extra_flags: ItemFlags = .None) -> bool #foreign ImGui "?ItemAdd@ImGui@@YA_NAEBUImRect@@IPEBU2@H@Z";
ItemAdd :: (bb: Rect, id: ID, nav_bb: *Rect = null, extra_flags: ItemFlags = .None) -> bool #no_context {
    return ItemAdd(*bb, id, nav_bb, extra_flags);
}
ItemHoverable :: (bb: *Rect, id: ID, item_flags: ItemFlags) -> bool #foreign ImGui "?ItemHoverable@ImGui@@YA_NAEBUImRect@@IH@Z";
ItemHoverable :: (bb: Rect, id: ID, item_flags: ItemFlags) -> bool #no_context {
    return ItemHoverable(*bb, id, item_flags);
}
IsWindowContentHoverable :: (window: *Window, flags: HoveredFlags = .None) -> bool #foreign ImGui "?IsWindowContentHoverable@ImGui@@YA_NPEAUImGuiWindow@@H@Z";
IsClippedEx :: (bb: *Rect, id: ID) -> bool #foreign ImGui "?IsClippedEx@ImGui@@YA_NAEBUImRect@@I@Z";
IsClippedEx :: (bb: Rect, id: ID) -> bool #no_context {
    return IsClippedEx(*bb, id);
}
SetLastItemData :: (item_id: ID, item_flags: ItemFlags, status_flags: ItemStatusFlags, item_rect: *Rect) -> void #foreign ImGui "?SetLastItemData@ImGui@@YAXIHHAEBUImRect@@@Z";
SetLastItemData :: (item_id: ID, item_flags: ItemFlags, status_flags: ItemStatusFlags, item_rect: Rect) #no_context {
    SetLastItemData(item_id, item_flags, status_flags, *item_rect);
}
CalcItemSize :: (size: Vector2, default_w: float, default_h: float) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?CalcItemSize@ImGui@@YA?AUImVec2@@U2@MM@Z";
CalcWrapWidthForPos :: (pos: *Vector2, wrap_pos_x: float) -> float #foreign ImGui "?CalcWrapWidthForPos@ImGui@@YAMAEBUImVec2@@M@Z";
CalcWrapWidthForPos :: (pos: Vector2, wrap_pos_x: float) -> float #no_context {
    return CalcWrapWidthForPos(*pos, wrap_pos_x);
}
PushMultiItemsWidths :: (components: s32, width_full: float) -> void #foreign ImGui "?PushMultiItemsWidths@ImGui@@YAXHM@Z";
ShrinkWidths :: (items: *ShrinkWidthItem, count: s32, width_excess: float, width_min: float) -> void #foreign ImGui "?ShrinkWidths@ImGui@@YAXPEAUImGuiShrinkWidthItem@@HMM@Z";

// Parameter stacks (shared)
GetStyleVarInfo :: (idx: StyleVar) -> *StyleVarInfo #foreign ImGui "?GetStyleVarInfo@ImGui@@YAPEBUImGuiStyleVarInfo@@H@Z";
BeginDisabledOverrideReenable :: () -> void #foreign ImGui "?BeginDisabledOverrideReenable@ImGui@@YAXXZ";
EndDisabledOverrideReenable :: () -> void #foreign ImGui "?EndDisabledOverrideReenable@ImGui@@YAXXZ";

// Logging/Capture
LogBegin :: (flags: LogFlags, auto_open_depth: s32) -> void #foreign ImGui "?LogBegin@ImGui@@YAXHH@Z";
LogToBuffer :: (auto_open_depth: s32 = -1) -> void #foreign ImGui "?LogToBuffer@ImGui@@YAXH@Z";
LogRenderedText :: (ref_pos: *Vector2, text: *u8, text_end: *u8 = null) -> void #foreign ImGui "?LogRenderedText@ImGui@@YAXPEBUImVec2@@PEBD1@Z";
LogRenderedText :: (ref_pos: *Vector2, text: string) #no_context {
    LogRenderedText(ref_pos, text.data, text.data + text.count);
}
LogSetNextTextDecoration :: (prefix: *u8, suffix: *u8) -> void #foreign ImGui "?LogSetNextTextDecoration@ImGui@@YAXPEBD0@Z";

// Childs
BeginChildEx :: (name: *u8, id: ID, size_arg: *Vector2, child_flags: ChildFlags, window_flags: WindowFlags) -> bool #foreign ImGui "?BeginChildEx@ImGui@@YA_NPEBDIAEBUImVec2@@HH@Z";
BeginChildEx :: (name: *u8, id: ID, size_arg: Vector2, child_flags: ChildFlags, window_flags: WindowFlags) -> bool #no_context {
    return BeginChildEx(name, id, *size_arg, child_flags, window_flags);
}

// Popups, Modals
BeginPopupEx :: (id: ID, extra_window_flags: WindowFlags) -> bool #foreign ImGui "?BeginPopupEx@ImGui@@YA_NIH@Z";
BeginPopupMenuEx :: (id: ID, label: *u8, extra_window_flags: WindowFlags) -> bool #foreign ImGui "?BeginPopupMenuEx@ImGui@@YA_NIPEBDH@Z";
OpenPopupEx :: (id: ID, popup_flags: PopupFlags = cast(PopupFlags).None) -> void #foreign ImGui "?OpenPopupEx@ImGui@@YAXIH@Z";
ClosePopupToLevel :: (remaining: s32, restore_focus_to_window_under_popup: bool) -> void #foreign ImGui "?ClosePopupToLevel@ImGui@@YAXH_N@Z";
ClosePopupsOverWindow :: (ref_window: *Window, restore_focus_to_window_under_popup: bool) -> void #foreign ImGui "?ClosePopupsOverWindow@ImGui@@YAXPEAUImGuiWindow@@_N@Z";
ClosePopupsExceptModals :: () -> void #foreign ImGui "?ClosePopupsExceptModals@ImGui@@YAXXZ";
IsPopupOpen :: (id: ID, popup_flags: PopupFlags) -> bool #foreign ImGui "?IsPopupOpen@ImGui@@YA_NIH@Z";
GetPopupAllowedExtentRect :: (window: *Window) -> Rect #cpp_return_type_is_non_pod #foreign ImGui "?GetPopupAllowedExtentRect@ImGui@@YA?AUImRect@@PEAUImGuiWindow@@@Z";
GetTopMostPopupModal :: () -> *Window #foreign ImGui "?GetTopMostPopupModal@ImGui@@YAPEAUImGuiWindow@@XZ";
GetTopMostAndVisiblePopupModal :: () -> *Window #foreign ImGui "?GetTopMostAndVisiblePopupModal@ImGui@@YAPEAUImGuiWindow@@XZ";
FindBlockingModal :: (window: *Window) -> *Window #foreign ImGui "?FindBlockingModal@ImGui@@YAPEAUImGuiWindow@@PEAU2@@Z";
FindBestWindowPosForPopup :: (window: *Window) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?FindBestWindowPosForPopup@ImGui@@YA?AUImVec2@@PEAUImGuiWindow@@@Z";
FindBestWindowPosForPopupEx :: (ref_pos: *Vector2, size: *Vector2, last_dir: *Dir, r_outer: *Rect, r_avoid: *Rect, policy: PopupPositionPolicy) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?FindBestWindowPosForPopupEx@ImGui@@YA?AUImVec2@@AEBU2@0PEAW4ImGuiDir@@AEBUImRect@@2W4ImGuiPopupPositionPolicy@@@Z";
FindBestWindowPosForPopupEx :: (ref_pos: Vector2, size: Vector2, last_dir: *Dir, r_outer: Rect, r_avoid: Rect, policy: PopupPositionPolicy) -> Vector2 #no_context {
    return FindBestWindowPosForPopupEx(*ref_pos, *size, last_dir, *r_outer, *r_avoid, policy);
}

// Tooltips
BeginTooltipEx :: (tooltip_flags: TooltipFlags, extra_window_flags: WindowFlags) -> bool #foreign ImGui "?BeginTooltipEx@ImGui@@YA_NHH@Z";
BeginTooltipHidden :: () -> bool #foreign ImGui "?BeginTooltipHidden@ImGui@@YA_NXZ";

// Menus
BeginViewportSideBar :: (name: *u8, viewport: *Viewport, dir: Dir, size: float, window_flags: WindowFlags) -> bool #foreign ImGui "?BeginViewportSideBar@ImGui@@YA_NPEBDPEAUImGuiViewport@@W4ImGuiDir@@MH@Z";
BeginMenuEx :: (label: *u8, icon: *u8, enabled := true) -> bool #foreign ImGui "?BeginMenuEx@ImGui@@YA_NPEBD0_N@Z";
MenuItemEx :: (label: *u8, icon: *u8, shortcut: *u8 = null, selected := false, enabled := true) -> bool #foreign ImGui "?MenuItemEx@ImGui@@YA_NPEBD00_N1@Z";

// Combos
BeginComboPopup :: (popup_id: ID, bb: *Rect, flags: ComboFlags) -> bool #foreign ImGui "?BeginComboPopup@ImGui@@YA_NIAEBUImRect@@H@Z";
BeginComboPopup :: (popup_id: ID, bb: Rect, flags: ComboFlags) -> bool #no_context {
    return BeginComboPopup(popup_id, *bb, flags);
}
BeginComboPreview :: () -> bool #foreign ImGui "?BeginComboPreview@ImGui@@YA_NXZ";
EndComboPreview :: () -> void #foreign ImGui "?EndComboPreview@ImGui@@YAXXZ";

// Keyboard/Gamepad Navigation
NavInitWindow :: (window: *Window, force_reinit: bool) -> void #foreign ImGui "?NavInitWindow@ImGui@@YAXPEAUImGuiWindow@@_N@Z";
NavInitRequestApplyResult :: () -> void #foreign ImGui "?NavInitRequestApplyResult@ImGui@@YAXXZ";
NavMoveRequestButNoResultYet :: () -> bool #foreign ImGui "?NavMoveRequestButNoResultYet@ImGui@@YA_NXZ";
NavMoveRequestSubmit :: (move_dir: Dir, clip_dir: Dir, move_flags: NavMoveFlags, scroll_flags: ScrollFlags) -> void #foreign ImGui "?NavMoveRequestSubmit@ImGui@@YAXW4ImGuiDir@@0HH@Z";
NavMoveRequestForward :: (move_dir: Dir, clip_dir: Dir, move_flags: NavMoveFlags, scroll_flags: ScrollFlags) -> void #foreign ImGui "?NavMoveRequestForward@ImGui@@YAXW4ImGuiDir@@0HH@Z";
NavMoveRequestResolveWithLastItem :: (result: *NavItemData) -> void #foreign ImGui "?NavMoveRequestResolveWithLastItem@ImGui@@YAXPEAUImGuiNavItemData@@@Z";
NavMoveRequestResolveWithPastTreeNode :: (result: *NavItemData, tree_node_data: *TreeNodeStackData) -> void #foreign ImGui "?NavMoveRequestResolveWithPastTreeNode@ImGui@@YAXPEAUImGuiNavItemData@@PEBUImGuiTreeNodeStackData@@@Z";
NavMoveRequestCancel :: () -> void #foreign ImGui "?NavMoveRequestCancel@ImGui@@YAXXZ";
NavMoveRequestApplyResult :: () -> void #foreign ImGui "?NavMoveRequestApplyResult@ImGui@@YAXXZ";
NavMoveRequestTryWrapping :: (window: *Window, move_flags: NavMoveFlags) -> void #foreign ImGui "?NavMoveRequestTryWrapping@ImGui@@YAXPEAUImGuiWindow@@H@Z";
NavHighlightActivated :: (id: ID) -> void #foreign ImGui "?NavHighlightActivated@ImGui@@YAXI@Z";
NavClearPreferredPosForAxis :: (axis: Axis) -> void #foreign ImGui "?NavClearPreferredPosForAxis@ImGui@@YAXW4ImGuiAxis@@@Z";
SetNavCursorVisibleAfterMove :: () -> void #foreign ImGui "?SetNavCursorVisibleAfterMove@ImGui@@YAXXZ";
NavUpdateCurrentWindowIsScrollPushableX :: () -> void #foreign ImGui "?NavUpdateCurrentWindowIsScrollPushableX@ImGui@@YAXXZ";
SetNavWindow :: (window: *Window) -> void #foreign ImGui "?SetNavWindow@ImGui@@YAXPEAUImGuiWindow@@@Z";
SetNavID :: (id: ID, nav_layer: NavLayer, focus_scope_id: ID, rect_rel: *Rect) -> void #foreign ImGui "?SetNavID@ImGui@@YAXIW4ImGuiNavLayer@@IAEBUImRect@@@Z";
SetNavID :: (id: ID, nav_layer: NavLayer, focus_scope_id: ID, rect_rel: Rect) #no_context {
    SetNavID(id, nav_layer, focus_scope_id, *rect_rel);
}
SetNavFocusScope :: (focus_scope_id: ID) -> void #foreign ImGui "?SetNavFocusScope@ImGui@@YAXI@Z";

// Focus/Activation
// This should be part of a larger set of API: FocusItem(offset = -1), FocusItemByID(id), ActivateItem(offset = -1), ActivateItemByID(id) etc. which are
// much harder to design and implement than expected. I have a couple of private branches on this matter but it's not simple. For now implementing the easy ones.
FocusItem :: () -> void #foreign ImGui "?FocusItem@ImGui@@YAXXZ";
ActivateItemByID :: (id: ID) -> void #foreign ImGui "?ActivateItemByID@ImGui@@YAXI@Z";

// Inputs
// FIXME: Eventually we should aim to move e.g. IsActiveIdUsingKey() into IsKeyXXX functions.
IsNamedKey :: (key: Key) -> bool #foreign ImGui "?IsNamedKey@ImGui@@YA_NW4ImGuiKey@@@Z";
IsNamedKeyOrMod :: (key: Key) -> bool #foreign ImGui "?IsNamedKeyOrMod@ImGui@@YA_NW4ImGuiKey@@@Z";
IsLegacyKey :: (key: Key) -> bool #foreign ImGui "?IsLegacyKey@ImGui@@YA_NW4ImGuiKey@@@Z";
IsKeyboardKey :: (key: Key) -> bool #foreign ImGui "?IsKeyboardKey@ImGui@@YA_NW4ImGuiKey@@@Z";
IsGamepadKey :: (key: Key) -> bool #foreign ImGui "?IsGamepadKey@ImGui@@YA_NW4ImGuiKey@@@Z";
IsMouseKey :: (key: Key) -> bool #foreign ImGui "?IsMouseKey@ImGui@@YA_NW4ImGuiKey@@@Z";
IsAliasKey :: (key: Key) -> bool #foreign ImGui "?IsAliasKey@ImGui@@YA_NW4ImGuiKey@@@Z";
IsLRModKey :: (key: Key) -> bool #foreign ImGui "?IsLRModKey@ImGui@@YA_NW4ImGuiKey@@@Z";
FixupKeyChord :: (key_chord: KeyChord) -> KeyChord #foreign ImGui "?FixupKeyChord@ImGui@@YAHH@Z";
ConvertSingleModFlagToKey :: (key: Key) -> Key #foreign ImGui "?ConvertSingleModFlagToKey@ImGui@@YA?AW4ImGuiKey@@W42@@Z";

GetKeyData :: (ctx: *ImGuiContext, key: Key) -> *KeyData #foreign ImGui "?GetKeyData@ImGui@@YAPEAUImGuiKeyData@@PEAUImGuiContext@@W4ImGuiKey@@@Z";
GetKeyData :: (key: Key) -> *KeyData #foreign ImGui "?GetKeyData@ImGui@@YAPEAUImGuiKeyData@@W4ImGuiKey@@@Z";
GetKeyChordName :: (key_chord: KeyChord) -> *u8 #foreign ImGui "?GetKeyChordName@ImGui@@YAPEBDH@Z";
MouseButtonToKey :: (button: MouseButton) -> Key #foreign ImGui "?MouseButtonToKey@ImGui@@YA?AW4ImGuiKey@@H@Z";
IsMouseDragPastThreshold :: (button: MouseButton, lock_threshold: float = -1.0) -> bool #foreign ImGui "?IsMouseDragPastThreshold@ImGui@@YA_NHM@Z";
GetKeyMagnitude2d :: (key_left: Key, key_right: Key, key_up: Key, key_down: Key) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?GetKeyMagnitude2d@ImGui@@YA?AUImVec2@@W4ImGuiKey@@000@Z";
GetNavTweakPressedAmount :: (axis: Axis) -> float #foreign ImGui "?GetNavTweakPressedAmount@ImGui@@YAMW4ImGuiAxis@@@Z";
CalcTypematicRepeatAmount :: (t0: float, t1: float, repeat_delay: float, repeat_rate: float) -> s32 #foreign ImGui "?CalcTypematicRepeatAmount@ImGui@@YAHMMMM@Z";
GetTypematicRepeatRate :: (flags: InputFlags, repeat_delay: *float, repeat_rate: *float) -> void #foreign ImGui "?GetTypematicRepeatRate@ImGui@@YAXHPEAM0@Z";
TeleportMousePos :: (pos: *Vector2) -> void #foreign ImGui "?TeleportMousePos@ImGui@@YAXAEBUImVec2@@@Z";
TeleportMousePos :: (pos: Vector2) #no_context {
    TeleportMousePos(*pos);
}
SetActiveIdUsingAllKeyboardKeys :: () -> void #foreign ImGui "?SetActiveIdUsingAllKeyboardKeys@ImGui@@YAXXZ";
IsActiveIdUsingNavDir :: (dir: Dir) -> bool #foreign ImGui "?IsActiveIdUsingNavDir@ImGui@@YA_NW4ImGuiDir@@@Z";

// [EXPERIMENTAL] Low-Level: Key/Input Ownership
// - The idea is that instead of "eating" a given input, we can link to an owner id.
// - Ownership is most often claimed as a result of reacting to a press/down event (but occasionally may be claimed ahead).
// - Input queries can then read input by specifying ImGuiKeyOwner_Any (== 0), ImGuiKeyOwner_NoOwner (== -1) or a custom ID.
// - Legacy input queries (without specifying an owner or _Any or _None) are equivalent to using ImGuiKeyOwner_Any (== 0).
// - Input ownership is automatically released on the frame after a key is released. Therefore:
//   - for ownership registration happening as a result of a down/press event, the SetKeyOwner() call may be done once (common case).
//   - for ownership registration happening ahead of a down/press event, the SetKeyOwner() call needs to be made every frame (happens if e.g. claiming ownership on hover).
// - SetItemKeyOwner() is a shortcut for common simple case. A custom widget will probably want to call SetKeyOwner() multiple times directly based on its interaction state.
// - This is marked experimental because not all widgets are fully honoring the Set/Test idioms. We will need to move forward step by step.
//   Please open a GitHub Issue to submit your usage scenario or if there's a use case you need solved.
GetKeyOwner :: (key: Key) -> ID #foreign ImGui "?GetKeyOwner@ImGui@@YAIW4ImGuiKey@@@Z";
SetKeyOwner :: (key: Key, owner_id: ID, flags: InputFlags = .None) -> void #foreign ImGui "?SetKeyOwner@ImGui@@YAXW4ImGuiKey@@IH@Z";
SetKeyOwnersForKeyChord :: (key: KeyChord, owner_id: ID, flags: InputFlags = .None) -> void #foreign ImGui "?SetKeyOwnersForKeyChord@ImGui@@YAXHIH@Z";
SetItemKeyOwner :: (key: Key, flags: InputFlags) -> void #foreign ImGui "?SetItemKeyOwner@ImGui@@YAXW4ImGuiKey@@H@Z";
TestKeyOwner :: (key: Key, owner_id: ID) -> bool #foreign ImGui "?TestKeyOwner@ImGui@@YA_NW4ImGuiKey@@I@Z";
GetKeyOwnerData :: (ctx: *ImGuiContext, key: Key) -> *KeyOwnerData #foreign ImGui "?GetKeyOwnerData@ImGui@@YAPEAUImGuiKeyOwnerData@@PEAUImGuiContext@@W4ImGuiKey@@@Z";

// [EXPERIMENTAL] High-Level: Input Access functions w/ support for Key/Input Ownership
// - Important: legacy IsKeyPressed(ImGuiKey, bool repeat=true) _DEFAULTS_ to repeat, new IsKeyPressed() requires _EXPLICIT_ ImGuiInputFlags_Repeat flag.
// - Expected to be later promoted to public API, the prototypes are designed to replace existing ones (since owner_id can default to Any == 0)
// - Specifying a value for 'ImGuiID owner' will test that EITHER the key is NOT owned (UNLESS locked), EITHER the key is owned by 'owner'.
//   Legacy functions use ImGuiKeyOwner_Any meaning that they typically ignore ownership, unless a call to SetKeyOwner() explicitly used ImGuiInputFlags_LockThisFrame or ImGuiInputFlags_LockUntilRelease.
// - Binding generators may want to ignore those for now, or suffix them with Ex() until we decide if this gets moved into public API.
IsKeyDown :: (key: Key, owner_id: ID) -> bool #foreign ImGui "?IsKeyDown@ImGui@@YA_NW4ImGuiKey@@I@Z";
IsKeyPressed :: (key: Key, flags: InputFlags, owner_id: ID = 0) -> bool #foreign ImGui "?IsKeyPressed@ImGui@@YA_NW4ImGuiKey@@HI@Z";
IsKeyReleased :: (key: Key, owner_id: ID) -> bool #foreign ImGui "?IsKeyReleased@ImGui@@YA_NW4ImGuiKey@@I@Z";
IsKeyChordPressed :: (key_chord: KeyChord, flags: InputFlags, owner_id: ID = 0) -> bool #foreign ImGui "?IsKeyChordPressed@ImGui@@YA_NHHI@Z";
IsMouseDown :: (button: MouseButton, owner_id: ID) -> bool #foreign ImGui "?IsMouseDown@ImGui@@YA_NHI@Z";
IsMouseClicked :: (button: MouseButton, flags: InputFlags, owner_id: ID = 0) -> bool #foreign ImGui "?IsMouseClicked@ImGui@@YA_NHHI@Z";
IsMouseReleased :: (button: MouseButton, owner_id: ID) -> bool #foreign ImGui "?IsMouseReleased@ImGui@@YA_NHI@Z";
IsMouseDoubleClicked :: (button: MouseButton, owner_id: ID) -> bool #foreign ImGui "?IsMouseDoubleClicked@ImGui@@YA_NHI@Z";

// Shortcut Testing & Routing
// - Set Shortcut() and SetNextItemShortcut() in imgui.h
// - When a policy (except for ImGuiInputFlags_RouteAlways *) is set, Shortcut() will register itself with SetShortcutRouting(),
//   allowing the system to decide where to route the input among other route-aware calls.
//   (* using ImGuiInputFlags_RouteAlways is roughly equivalent to calling IsKeyChordPressed(key) and bypassing route registration and check)
// - When using one of the routing option:
//   - The default route is ImGuiInputFlags_RouteFocused (accept inputs if window is in focus stack. Deep-most focused window takes inputs. ActiveId takes inputs over deep-most focused window.)
//   - Routes are requested given a chord (key + modifiers) and a routing policy.
//   - Routes are resolved during NewFrame(): if keyboard modifiers are matching current ones: SetKeyOwner() is called + route is granted for the frame.
//   - Each route may be granted to a single owner. When multiple requests are made we have policies to select the winning route (e.g. deep most window).
//   - Multiple read sites may use the same owner id can all access the granted route.
//   - When owner_id is 0 we use the current Focus Scope ID as a owner ID in order to identify our location.
// - You can chain two unrelated windows in the focus stack using SetWindowParentWindowForFocusRoute()
//   e.g. if you have a tool window associated to a document, and you want document shortcuts to run when the tool is focused.
Shortcut :: (key_chord: KeyChord, flags: InputFlags, owner_id: ID) -> bool #foreign ImGui "?Shortcut@ImGui@@YA_NHHI@Z";
SetShortcutRouting :: (key_chord: KeyChord, flags: InputFlags, owner_id: ID) -> bool #foreign ImGui "?SetShortcutRouting@ImGui@@YA_NHHI@Z";
TestShortcutRouting :: (key_chord: KeyChord, owner_id: ID) -> bool #foreign ImGui "?TestShortcutRouting@ImGui@@YA_NHI@Z";
GetShortcutRoutingData :: (key_chord: KeyChord) -> *KeyRoutingData #foreign ImGui "?GetShortcutRoutingData@ImGui@@YAPEAUImGuiKeyRoutingData@@H@Z";

// Docking
// (some functions are only declared in imgui.cpp, see Docking section)
DockContextInitialize :: (ctx: *ImGuiContext) -> void #foreign ImGui "?DockContextInitialize@ImGui@@YAXPEAUImGuiContext@@@Z";
DockContextShutdown :: (ctx: *ImGuiContext) -> void #foreign ImGui "?DockContextShutdown@ImGui@@YAXPEAUImGuiContext@@@Z";
DockContextClearNodes :: (ctx: *ImGuiContext, root_id: ID, clear_settings_refs: bool) -> void #foreign ImGui "?DockContextClearNodes@ImGui@@YAXPEAUImGuiContext@@I_N@Z";
DockContextRebuildNodes :: (ctx: *ImGuiContext) -> void #foreign ImGui "?DockContextRebuildNodes@ImGui@@YAXPEAUImGuiContext@@@Z";
DockContextNewFrameUpdateUndocking :: (ctx: *ImGuiContext) -> void #foreign ImGui "?DockContextNewFrameUpdateUndocking@ImGui@@YAXPEAUImGuiContext@@@Z";
DockContextNewFrameUpdateDocking :: (ctx: *ImGuiContext) -> void #foreign ImGui "?DockContextNewFrameUpdateDocking@ImGui@@YAXPEAUImGuiContext@@@Z";
DockContextEndFrame :: (ctx: *ImGuiContext) -> void #foreign ImGui "?DockContextEndFrame@ImGui@@YAXPEAUImGuiContext@@@Z";
DockContextGenNodeID :: (ctx: *ImGuiContext) -> ID #foreign ImGui "?DockContextGenNodeID@ImGui@@YAIPEAUImGuiContext@@@Z";
DockContextQueueDock :: (ctx: *ImGuiContext, target: *Window, target_node: *DockNode, payload: *Window, split_dir: Dir, split_ratio: float, split_outer: bool) -> void #foreign ImGui "?DockContextQueueDock@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiWindow@@PEAUImGuiDockNode@@1W4ImGuiDir@@M_N@Z";
DockContextQueueUndockWindow :: (ctx: *ImGuiContext, window: *Window) -> void #foreign ImGui "?DockContextQueueUndockWindow@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiWindow@@@Z";
DockContextQueueUndockNode :: (ctx: *ImGuiContext, node: *DockNode) -> void #foreign ImGui "?DockContextQueueUndockNode@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiDockNode@@@Z";
DockContextProcessUndockWindow :: (ctx: *ImGuiContext, window: *Window, clear_persistent_docking_ref := true) -> void #foreign ImGui "?DockContextProcessUndockWindow@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiWindow@@_N@Z";
DockContextProcessUndockNode :: (ctx: *ImGuiContext, node: *DockNode) -> void #foreign ImGui "?DockContextProcessUndockNode@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiDockNode@@@Z";
DockContextCalcDropPosForDocking :: (target: *Window, target_node: *DockNode, payload_window: *Window, payload_node: *DockNode, split_dir: Dir, split_outer: bool, out_pos: *Vector2) -> bool #foreign ImGui "?DockContextCalcDropPosForDocking@ImGui@@YA_NPEAUImGuiWindow@@PEAUImGuiDockNode@@01W4ImGuiDir@@_NPEAUImVec2@@@Z";
DockContextFindNodeByID :: (ctx: *ImGuiContext, id: ID) -> *DockNode #foreign ImGui "?DockContextFindNodeByID@ImGui@@YAPEAUImGuiDockNode@@PEAUImGuiContext@@I@Z";
DockNodeWindowMenuHandler_Default :: (ctx: *ImGuiContext, node: *DockNode, tab_bar: *TabBar) -> void #foreign ImGui "?DockNodeWindowMenuHandler_Default@ImGui@@YAXPEAUImGuiContext@@PEAUImGuiDockNode@@PEAUImGuiTabBar@@@Z";
DockNodeBeginAmendTabBar :: (node: *DockNode) -> bool #foreign ImGui "?DockNodeBeginAmendTabBar@ImGui@@YA_NPEAUImGuiDockNode@@@Z";
DockNodeEndAmendTabBar :: () -> void #foreign ImGui "?DockNodeEndAmendTabBar@ImGui@@YAXXZ";
DockNodeGetRootNode :: (node: *DockNode) -> *DockNode #foreign ImGui "?DockNodeGetRootNode@ImGui@@YAPEAUImGuiDockNode@@PEAU2@@Z";
DockNodeIsInHierarchyOf :: (node: *DockNode, parent: *DockNode) -> bool #foreign ImGui "?DockNodeIsInHierarchyOf@ImGui@@YA_NPEAUImGuiDockNode@@0@Z";
DockNodeGetDepth :: (node: *DockNode) -> s32 #foreign ImGui "?DockNodeGetDepth@ImGui@@YAHPEBUImGuiDockNode@@@Z";

GetWindowAlwaysWantOwnTabBar :: (window: *Window) -> bool #foreign ImGui "?GetWindowAlwaysWantOwnTabBar@ImGui@@YA_NPEAUImGuiWindow@@@Z";
BeginDocked :: (window: *Window, p_open: *bool) -> void #foreign ImGui "?BeginDocked@ImGui@@YAXPEAUImGuiWindow@@PEA_N@Z";
BeginDockableDragDropSource :: (window: *Window) -> void #foreign ImGui "?BeginDockableDragDropSource@ImGui@@YAXPEAUImGuiWindow@@@Z";
BeginDockableDragDropTarget :: (window: *Window) -> void #foreign ImGui "?BeginDockableDragDropTarget@ImGui@@YAXPEAUImGuiWindow@@@Z";
SetWindowDock :: (window: *Window, dock_id: ID, cond: Cond) -> void #foreign ImGui "?SetWindowDock@ImGui@@YAXPEAUImGuiWindow@@IH@Z";

// Docking - Builder function needs to be generally called before the node is used/submitted.
// - The DockBuilderXXX functions are designed to _eventually_ become a public API, but it is too early to expose it and guarantee stability.
// - Do not hold on ImGuiDockNode* pointers! They may be invalidated by any split/merge/remove operation and every frame.
// - To create a DockSpace() node, make sure to set the ImGuiDockNodeFlags_DockSpace flag when calling DockBuilderAddNode().
//   You can create dockspace nodes (attached to a window) _or_ floating nodes (carry its own window) with this API.
// - DockBuilderSplitNode() create 2 child nodes within 1 node. The initial node becomes a parent node.
// - If you intend to split the node immediately after creation using DockBuilderSplitNode(), make sure
//   to call DockBuilderSetNodeSize() beforehand. If you don't, the resulting split sizes may not be reliable.
// - Call DockBuilderFinish() after you are done.
DockBuilderDockWindow :: (window_name: *u8, node_id: ID) -> void #foreign ImGui "?DockBuilderDockWindow@ImGui@@YAXPEBDI@Z";
DockBuilderGetNode :: (node_id: ID) -> *DockNode #foreign ImGui "?DockBuilderGetNode@ImGui@@YAPEAUImGuiDockNode@@I@Z";

DockBuilderAddNode :: (node_id: ID = 0, flags: DockNodeFlags = .None) -> ID #foreign ImGui "?DockBuilderAddNode@ImGui@@YAIIH@Z";
DockBuilderRemoveNode :: (node_id: ID) -> void #foreign ImGui "?DockBuilderRemoveNode@ImGui@@YAXI@Z";
DockBuilderRemoveNodeDockedWindows :: (node_id: ID, clear_settings_refs := true) -> void #foreign ImGui "?DockBuilderRemoveNodeDockedWindows@ImGui@@YAXI_N@Z";
DockBuilderRemoveNodeChildNodes :: (node_id: ID) -> void #foreign ImGui "?DockBuilderRemoveNodeChildNodes@ImGui@@YAXI@Z";
DockBuilderSetNodePos :: (node_id: ID, pos: Vector2) -> void #foreign ImGui "?DockBuilderSetNodePos@ImGui@@YAXIUImVec2@@@Z";
DockBuilderSetNodeSize :: (node_id: ID, size: Vector2) -> void #foreign ImGui "?DockBuilderSetNodeSize@ImGui@@YAXIUImVec2@@@Z";
DockBuilderSplitNode :: (node_id: ID, split_dir: Dir, size_ratio_for_node_at_dir: float, out_id_at_dir: *ID, out_id_at_opposite_dir: *ID) -> ID #foreign ImGui "?DockBuilderSplitNode@ImGui@@YAIIW4ImGuiDir@@MPEAI1@Z";
DockBuilderCopyDockSpace :: (src_dockspace_id: ID, dst_dockspace_id: ID, in_window_remap_pairs: *Vector(*u8)) -> void #foreign ImGui "?DockBuilderCopyDockSpace@ImGui@@YAXIIPEAU?$ImVector@PEBD@@@Z";
DockBuilderCopyNode :: (src_node_id: ID, dst_node_id: ID, out_node_remap_pairs: *Vector(ID)) -> void #foreign ImGui "?DockBuilderCopyNode@ImGui@@YAXIIPEAU?$ImVector@I@@@Z";
DockBuilderCopyWindowSettings :: (src_name: *u8, dst_name: *u8) -> void #foreign ImGui "?DockBuilderCopyWindowSettings@ImGui@@YAXPEBD0@Z";
DockBuilderFinish :: (node_id: ID) -> void #foreign ImGui "?DockBuilderFinish@ImGui@@YAXI@Z";

// [EXPERIMENTAL] Focus Scope
// This is generally used to identify a unique input location (for e.g. a selection set)
// There is one per window (automatically set in Begin), but:
// - Selection patterns generally need to react (e.g. clear a selection) when landing on one item of the set.
//   So in order to identify a set multiple lists in same window may each need a focus scope.
//   If you imagine an hypothetical BeginSelectionGroup()/EndSelectionGroup() api, it would likely call PushFocusScope()/EndFocusScope()
// - Shortcut routing also use focus scope as a default location identifier if an owner is not provided.
// We don't use the ID Stack for this as it is common to want them separate.
PushFocusScope :: (id: ID) -> void #foreign ImGui "?PushFocusScope@ImGui@@YAXI@Z";
PopFocusScope :: () -> void #foreign ImGui "?PopFocusScope@ImGui@@YAXXZ";

// Drag and Drop
IsDragDropActive :: () -> bool #foreign ImGui "?IsDragDropActive@ImGui@@YA_NXZ";
BeginDragDropTargetCustom :: (bb: *Rect, id: ID) -> bool #foreign ImGui "?BeginDragDropTargetCustom@ImGui@@YA_NAEBUImRect@@I@Z";
BeginDragDropTargetCustom :: (bb: Rect, id: ID) -> bool #no_context {
    return BeginDragDropTargetCustom(*bb, id);
}
ClearDragDrop :: () -> void #foreign ImGui "?ClearDragDrop@ImGui@@YAXXZ";
IsDragDropPayloadBeingAccepted :: () -> bool #foreign ImGui "?IsDragDropPayloadBeingAccepted@ImGui@@YA_NXZ";
RenderDragDropTargetRect :: (bb: *Rect, item_clip_rect: *Rect) -> void #foreign ImGui "?RenderDragDropTargetRect@ImGui@@YAXAEBUImRect@@0@Z";
RenderDragDropTargetRect :: (bb: Rect, item_clip_rect: Rect) #no_context {
    RenderDragDropTargetRect(*bb, *item_clip_rect);
}

// Typing-Select API
// (provide Windows Explorer style "select items by typing partial name" + "cycle through items by typing same letter" feature)
// (this is currently not documented nor used by main library, but should work. See "widgets_typingselect" in imgui_test_suite for usage code. Please let us know if you use this!)
GetTypingSelectRequest :: (flags: TypingSelectFlags = xx TypingSelectFlags.None) -> *TypingSelectRequest #foreign ImGui "?GetTypingSelectRequest@ImGui@@YAPEAUImGuiTypingSelectRequest@@H@Z";
TypingSelectFindMatch :: (req: *TypingSelectRequest, items_count: s32, get_item_name_func: #type (unknown0: *void, unknown1: s32) -> *u8 #c_call, user_data: *void, nav_item_idx: s32) -> s32 #foreign ImGui "?TypingSelectFindMatch@ImGui@@YAHPEAUImGuiTypingSelectRequest@@HP6APEBDPEAXH@Z1H@Z";
TypingSelectFindNextSingleCharMatch :: (req: *TypingSelectRequest, items_count: s32, get_item_name_func: #type (unknown0: *void, unknown1: s32) -> *u8 #c_call, user_data: *void, nav_item_idx: s32) -> s32 #foreign ImGui "?TypingSelectFindNextSingleCharMatch@ImGui@@YAHPEAUImGuiTypingSelectRequest@@HP6APEBDPEAXH@Z1H@Z";
TypingSelectFindBestLeadingMatch :: (req: *TypingSelectRequest, items_count: s32, get_item_name_func: #type (unknown0: *void, unknown1: s32) -> *u8 #c_call, user_data: *void) -> s32 #foreign ImGui "?TypingSelectFindBestLeadingMatch@ImGui@@YAHPEAUImGuiTypingSelectRequest@@HP6APEBDPEAXH@Z1@Z";

// Box-Select API
BeginBoxSelect :: (scope_rect: *Rect, window: *Window, box_select_id: ID, ms_flags: MultiSelectFlags) -> bool #foreign ImGui "?BeginBoxSelect@ImGui@@YA_NAEBUImRect@@PEAUImGuiWindow@@IH@Z";
BeginBoxSelect :: (scope_rect: Rect, window: *Window, box_select_id: ID, ms_flags: MultiSelectFlags) -> bool #no_context {
    return BeginBoxSelect(*scope_rect, window, box_select_id, ms_flags);
}
EndBoxSelect :: (scope_rect: *Rect, ms_flags: MultiSelectFlags) -> void #foreign ImGui "?EndBoxSelect@ImGui@@YAXAEBUImRect@@H@Z";
EndBoxSelect :: (scope_rect: Rect, ms_flags: MultiSelectFlags) #no_context {
    EndBoxSelect(*scope_rect, ms_flags);
}

// Multi-Select API
MultiSelectItemHeader :: (id: ID, p_selected: *bool, p_button_flags: *ButtonFlags) -> void #foreign ImGui "?MultiSelectItemHeader@ImGui@@YAXIPEA_NPEAH@Z";
MultiSelectItemFooter :: (id: ID, p_selected: *bool, p_pressed: *bool) -> void #foreign ImGui "?MultiSelectItemFooter@ImGui@@YAXIPEA_N0@Z";
MultiSelectAddSetAll :: (ms: *MultiSelectTempData, selected: bool) -> void #foreign ImGui "?MultiSelectAddSetAll@ImGui@@YAXPEAUImGuiMultiSelectTempData@@_N@Z";
MultiSelectAddSetRange :: (ms: *MultiSelectTempData, selected: bool, range_dir: s32, first_item: SelectionUserData, last_item: SelectionUserData) -> void #foreign ImGui "?MultiSelectAddSetRange@ImGui@@YAXPEAUImGuiMultiSelectTempData@@_NH_J2@Z";
GetBoxSelectState :: (id: ID) -> *BoxSelectState #foreign ImGui "?GetBoxSelectState@ImGui@@YAPEAUImGuiBoxSelectState@@I@Z";

// Internal Columns API (this is not exposed because we will encourage transitioning to the Tables API)
SetWindowClipRectBeforeSetChannel :: (window: *Window, clip_rect: *Rect) -> void #foreign ImGui "?SetWindowClipRectBeforeSetChannel@ImGui@@YAXPEAUImGuiWindow@@AEBUImRect@@@Z";
SetWindowClipRectBeforeSetChannel :: (window: *Window, clip_rect: Rect) #no_context {
    SetWindowClipRectBeforeSetChannel(window, *clip_rect);
}
BeginColumns :: (str_id: *u8, count: s32, flags: OldColumnFlags = 0) -> void #foreign ImGui "?BeginColumns@ImGui@@YAXPEBDHH@Z";
EndColumns :: () -> void #foreign ImGui "?EndColumns@ImGui@@YAXXZ";
PushColumnClipRect :: (column_index: s32) -> void #foreign ImGui "?PushColumnClipRect@ImGui@@YAXH@Z";
PushColumnsBackground :: () -> void #foreign ImGui "?PushColumnsBackground@ImGui@@YAXXZ";
PopColumnsBackground :: () -> void #foreign ImGui "?PopColumnsBackground@ImGui@@YAXXZ";
GetColumnsID :: (str_id: *u8, count: s32) -> ID #foreign ImGui "?GetColumnsID@ImGui@@YAIPEBDH@Z";
FindOrCreateColumns :: (window: *Window, id: ID) -> *OldColumns #foreign ImGui "?FindOrCreateColumns@ImGui@@YAPEAUImGuiOldColumns@@PEAUImGuiWindow@@I@Z";
GetColumnOffsetFromNorm :: (columns: *OldColumns, offset_norm: float) -> float #foreign ImGui "?GetColumnOffsetFromNorm@ImGui@@YAMPEBUImGuiOldColumns@@M@Z";
GetColumnNormFromOffset :: (columns: *OldColumns, offset: float) -> float #foreign ImGui "?GetColumnNormFromOffset@ImGui@@YAMPEBUImGuiOldColumns@@M@Z";

// Tables: Candidates for public API
TableOpenContextMenu :: (column_n: s32 = -1) -> void #foreign ImGui "?TableOpenContextMenu@ImGui@@YAXH@Z";
TableSetColumnWidth :: (column_n: s32, width: float) -> void #foreign ImGui "?TableSetColumnWidth@ImGui@@YAXHM@Z";
TableSetColumnSortDirection :: (column_n: s32, sort_direction: SortDirection, append_to_sort_specs: bool) -> void #foreign ImGui "?TableSetColumnSortDirection@ImGui@@YAXHW4ImGuiSortDirection@@_N@Z";
TableGetHoveredRow :: () -> s32 #foreign ImGui "?TableGetHoveredRow@ImGui@@YAHXZ";
TableGetHeaderRowHeight :: () -> float #foreign ImGui "?TableGetHeaderRowHeight@ImGui@@YAMXZ";
TableGetHeaderAngledMaxLabelWidth :: () -> float #foreign ImGui "?TableGetHeaderAngledMaxLabelWidth@ImGui@@YAMXZ";
TablePushBackgroundChannel :: () -> void #foreign ImGui "?TablePushBackgroundChannel@ImGui@@YAXXZ";
TablePopBackgroundChannel :: () -> void #foreign ImGui "?TablePopBackgroundChannel@ImGui@@YAXXZ";
TablePushColumnChannel :: (column_n: s32) -> void #foreign ImGui "?TablePushColumnChannel@ImGui@@YAXH@Z";
TablePopColumnChannel :: () -> void #foreign ImGui "?TablePopColumnChannel@ImGui@@YAXXZ";
TableAngledHeadersRowEx :: (row_id: ID, angle: float, max_label_width: float, data: *TableHeaderData, data_count: s32) -> void #foreign ImGui "?TableAngledHeadersRowEx@ImGui@@YAXIMMPEBUImGuiTableHeaderData@@H@Z";

TableFindByID :: (id: ID) -> *Table #foreign ImGui "?TableFindByID@ImGui@@YAPEAUImGuiTable@@I@Z";
BeginTableEx :: (name: *u8, id: ID, columns_count: s32, flags: TableFlags = .None, outer_size: *Vector2, inner_width: float = 0.0) -> bool #foreign ImGui "?BeginTableEx@ImGui@@YA_NPEBDIHHAEBUImVec2@@M@Z";
BeginTableEx :: (name: *u8, id: ID, columns_count: s32, flags: TableFlags = .None, outer_size: Vector2 = .{0, 0}, inner_width: float = 0.0) -> bool #no_context {
    return BeginTableEx(name, id, columns_count, flags, *outer_size, inner_width);
}
TableBeginInitMemory :: (table: *Table, columns_count: s32) -> void #foreign ImGui "?TableBeginInitMemory@ImGui@@YAXPEAUImGuiTable@@H@Z";
TableBeginApplyRequests :: (table: *Table) -> void #foreign ImGui "?TableBeginApplyRequests@ImGui@@YAXPEAUImGuiTable@@@Z";
TableSetupDrawChannels :: (table: *Table) -> void #foreign ImGui "?TableSetupDrawChannels@ImGui@@YAXPEAUImGuiTable@@@Z";
TableUpdateLayout :: (table: *Table) -> void #foreign ImGui "?TableUpdateLayout@ImGui@@YAXPEAUImGuiTable@@@Z";
TableUpdateBorders :: (table: *Table) -> void #foreign ImGui "?TableUpdateBorders@ImGui@@YAXPEAUImGuiTable@@@Z";
TableUpdateColumnsWeightFromWidth :: (table: *Table) -> void #foreign ImGui "?TableUpdateColumnsWeightFromWidth@ImGui@@YAXPEAUImGuiTable@@@Z";
TableDrawBorders :: (table: *Table) -> void #foreign ImGui "?TableDrawBorders@ImGui@@YAXPEAUImGuiTable@@@Z";
TableDrawDefaultContextMenu :: (table: *Table, flags_for_section_to_display: TableFlags) -> void #foreign ImGui "?TableDrawDefaultContextMenu@ImGui@@YAXPEAUImGuiTable@@H@Z";
TableBeginContextMenuPopup :: (table: *Table) -> bool #foreign ImGui "?TableBeginContextMenuPopup@ImGui@@YA_NPEAUImGuiTable@@@Z";
TableMergeDrawChannels :: (table: *Table) -> void #foreign ImGui "?TableMergeDrawChannels@ImGui@@YAXPEAUImGuiTable@@@Z";
TableGetInstanceData :: (table: *Table, instance_no: s32) -> *TableInstanceData #foreign ImGui "?TableGetInstanceData@ImGui@@YAPEAUImGuiTableInstanceData@@PEAUImGuiTable@@H@Z";
TableGetInstanceID :: (table: *Table, instance_no: s32) -> ID #foreign ImGui "?TableGetInstanceID@ImGui@@YAIPEAUImGuiTable@@H@Z";
TableSortSpecsSanitize :: (table: *Table) -> void #foreign ImGui "?TableSortSpecsSanitize@ImGui@@YAXPEAUImGuiTable@@@Z";
TableSortSpecsBuild :: (table: *Table) -> void #foreign ImGui "?TableSortSpecsBuild@ImGui@@YAXPEAUImGuiTable@@@Z";
TableGetColumnNextSortDirection :: (column: *TableColumn) -> SortDirection #foreign ImGui "?TableGetColumnNextSortDirection@ImGui@@YA?AW4ImGuiSortDirection@@PEAUImGuiTableColumn@@@Z";
TableFixColumnSortDirection :: (table: *Table, column: *TableColumn) -> void #foreign ImGui "?TableFixColumnSortDirection@ImGui@@YAXPEAUImGuiTable@@PEAUImGuiTableColumn@@@Z";
TableGetColumnWidthAuto :: (table: *Table, column: *TableColumn) -> float #foreign ImGui "?TableGetColumnWidthAuto@ImGui@@YAMPEAUImGuiTable@@PEAUImGuiTableColumn@@@Z";
TableBeginRow :: (table: *Table) -> void #foreign ImGui "?TableBeginRow@ImGui@@YAXPEAUImGuiTable@@@Z";
TableEndRow :: (table: *Table) -> void #foreign ImGui "?TableEndRow@ImGui@@YAXPEAUImGuiTable@@@Z";
TableBeginCell :: (table: *Table, column_n: s32) -> void #foreign ImGui "?TableBeginCell@ImGui@@YAXPEAUImGuiTable@@H@Z";
TableEndCell :: (table: *Table) -> void #foreign ImGui "?TableEndCell@ImGui@@YAXPEAUImGuiTable@@@Z";
TableGetCellBgRect :: (table: *Table, column_n: s32) -> Rect #cpp_return_type_is_non_pod #foreign ImGui "?TableGetCellBgRect@ImGui@@YA?AUImRect@@PEBUImGuiTable@@H@Z";
TableGetColumnName :: (table: *Table, column_n: s32) -> *u8 #foreign ImGui "?TableGetColumnName@ImGui@@YAPEBDPEBUImGuiTable@@H@Z";
TableGetColumnResizeID :: (table: *Table, column_n: s32, instance_no: s32 = 0) -> ID #foreign ImGui "?TableGetColumnResizeID@ImGui@@YAIPEAUImGuiTable@@HH@Z";
TableCalcMaxColumnWidth :: (table: *Table, column_n: s32) -> float #foreign ImGui "?TableCalcMaxColumnWidth@ImGui@@YAMPEBUImGuiTable@@H@Z";
TableSetColumnWidthAutoSingle :: (table: *Table, column_n: s32) -> void #foreign ImGui "?TableSetColumnWidthAutoSingle@ImGui@@YAXPEAUImGuiTable@@H@Z";
TableSetColumnWidthAutoAll :: (table: *Table) -> void #foreign ImGui "?TableSetColumnWidthAutoAll@ImGui@@YAXPEAUImGuiTable@@@Z";
TableRemove :: (table: *Table) -> void #foreign ImGui "?TableRemove@ImGui@@YAXPEAUImGuiTable@@@Z";
TableGcCompactTransientBuffers :: (table: *Table) -> void #foreign ImGui "?TableGcCompactTransientBuffers@ImGui@@YAXPEAUImGuiTable@@@Z";
TableGcCompactTransientBuffers :: (table: *TableTempData) -> void #foreign ImGui "?TableGcCompactTransientBuffers@ImGui@@YAXPEAUImGuiTableTempData@@@Z";
TableGcCompactSettings :: () -> void #foreign ImGui "?TableGcCompactSettings@ImGui@@YAXXZ";

// Tables: Settings
TableLoadSettings :: (table: *Table) -> void #foreign ImGui "?TableLoadSettings@ImGui@@YAXPEAUImGuiTable@@@Z";
TableSaveSettings :: (table: *Table) -> void #foreign ImGui "?TableSaveSettings@ImGui@@YAXPEAUImGuiTable@@@Z";
TableResetSettings :: (table: *Table) -> void #foreign ImGui "?TableResetSettings@ImGui@@YAXPEAUImGuiTable@@@Z";
TableGetBoundSettings :: (table: *Table) -> *TableSettings #foreign ImGui "?TableGetBoundSettings@ImGui@@YAPEAUImGuiTableSettings@@PEAUImGuiTable@@@Z";
TableSettingsAddSettingsHandler :: () -> void #foreign ImGui "?TableSettingsAddSettingsHandler@ImGui@@YAXXZ";
TableSettingsCreate :: (id: ID, columns_count: s32) -> *TableSettings #foreign ImGui "?TableSettingsCreate@ImGui@@YAPEAUImGuiTableSettings@@IH@Z";
TableSettingsFindByID :: (id: ID) -> *TableSettings #foreign ImGui "?TableSettingsFindByID@ImGui@@YAPEAUImGuiTableSettings@@I@Z";

BeginTabBarEx :: (tab_bar: *TabBar, bb: *Rect, flags: TabBarFlags) -> bool #foreign ImGui "?BeginTabBarEx@ImGui@@YA_NPEAUImGuiTabBar@@AEBUImRect@@H@Z";
BeginTabBarEx :: (tab_bar: *TabBar, bb: Rect, flags: TabBarFlags) -> bool #no_context {
    return BeginTabBarEx(tab_bar, *bb, flags);
}
TabBarFindTabByID :: (tab_bar: *TabBar, tab_id: ID) -> *TabItem #foreign ImGui "?TabBarFindTabByID@ImGui@@YAPEAUImGuiTabItem@@PEAUImGuiTabBar@@I@Z";
TabBarFindTabByOrder :: (tab_bar: *TabBar, order: s32) -> *TabItem #foreign ImGui "?TabBarFindTabByOrder@ImGui@@YAPEAUImGuiTabItem@@PEAUImGuiTabBar@@H@Z";
TabBarFindMostRecentlySelectedTabForActiveWindow :: (tab_bar: *TabBar) -> *TabItem #foreign ImGui "?TabBarFindMostRecentlySelectedTabForActiveWindow@ImGui@@YAPEAUImGuiTabItem@@PEAUImGuiTabBar@@@Z";
TabBarGetCurrentTab :: (tab_bar: *TabBar) -> *TabItem #foreign ImGui "?TabBarGetCurrentTab@ImGui@@YAPEAUImGuiTabItem@@PEAUImGuiTabBar@@@Z";
TabBarGetTabOrder :: (tab_bar: *TabBar, tab: *TabItem) -> s32 #foreign ImGui "?TabBarGetTabOrder@ImGui@@YAHPEAUImGuiTabBar@@PEAUImGuiTabItem@@@Z";
TabBarGetTabName :: (tab_bar: *TabBar, tab: *TabItem) -> *u8 #foreign ImGui "?TabBarGetTabName@ImGui@@YAPEBDPEAUImGuiTabBar@@PEAUImGuiTabItem@@@Z";
TabBarAddTab :: (tab_bar: *TabBar, tab_flags: TabItemFlags, window: *Window) -> void #foreign ImGui "?TabBarAddTab@ImGui@@YAXPEAUImGuiTabBar@@HPEAUImGuiWindow@@@Z";
TabBarRemoveTab :: (tab_bar: *TabBar, tab_id: ID) -> void #foreign ImGui "?TabBarRemoveTab@ImGui@@YAXPEAUImGuiTabBar@@I@Z";
TabBarCloseTab :: (tab_bar: *TabBar, tab: *TabItem) -> void #foreign ImGui "?TabBarCloseTab@ImGui@@YAXPEAUImGuiTabBar@@PEAUImGuiTabItem@@@Z";
TabBarQueueFocus :: (tab_bar: *TabBar, tab: *TabItem) -> void #foreign ImGui "?TabBarQueueFocus@ImGui@@YAXPEAUImGuiTabBar@@PEAUImGuiTabItem@@@Z";
TabBarQueueFocus :: (tab_bar: *TabBar, tab_name: *u8) -> void #foreign ImGui "?TabBarQueueFocus@ImGui@@YAXPEAUImGuiTabBar@@PEBD@Z";
TabBarQueueReorder :: (tab_bar: *TabBar, tab: *TabItem, offset: s32) -> void #foreign ImGui "?TabBarQueueReorder@ImGui@@YAXPEAUImGuiTabBar@@PEAUImGuiTabItem@@H@Z";
TabBarQueueReorderFromMousePos :: (tab_bar: *TabBar, tab: *TabItem, mouse_pos: Vector2) -> void #foreign ImGui "?TabBarQueueReorderFromMousePos@ImGui@@YAXPEAUImGuiTabBar@@PEAUImGuiTabItem@@UImVec2@@@Z";
TabBarProcessReorder :: (tab_bar: *TabBar) -> bool #foreign ImGui "?TabBarProcessReorder@ImGui@@YA_NPEAUImGuiTabBar@@@Z";
TabItemEx :: (tab_bar: *TabBar, label: *u8, p_open: *bool, flags: TabItemFlags, docked_window: *Window) -> bool #foreign ImGui "?TabItemEx@ImGui@@YA_NPEAUImGuiTabBar@@PEBDPEA_NHPEAUImGuiWindow@@@Z";
TabItemSpacing :: (str_id: *u8, flags: TabItemFlags, width: float) -> void #foreign ImGui "?TabItemSpacing@ImGui@@YAXPEBDHM@Z";
TabItemCalcSize :: (label: *u8, has_close_button_or_unsaved_marker: bool) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?TabItemCalcSize@ImGui@@YA?AUImVec2@@PEBD_N@Z";
TabItemCalcSize :: (window: *Window) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?TabItemCalcSize@ImGui@@YA?AUImVec2@@PEAUImGuiWindow@@@Z";
TabItemBackground :: (draw_list: *DrawList, bb: *Rect, flags: TabItemFlags, col: U32) -> void #foreign ImGui "?TabItemBackground@ImGui@@YAXPEAUImDrawList@@AEBUImRect@@HI@Z";
TabItemBackground :: (draw_list: *DrawList, bb: Rect, flags: TabItemFlags, col: U32) #no_context {
    TabItemBackground(draw_list, *bb, flags, col);
}
TabItemLabelAndCloseButton :: (draw_list: *DrawList, bb: *Rect, flags: TabItemFlags, frame_padding: Vector2, label: *u8, tab_id: ID, close_button_id: ID, is_contents_visible: bool, out_just_closed: *bool, out_text_clipped: *bool) -> void #foreign ImGui "?TabItemLabelAndCloseButton@ImGui@@YAXPEAUImDrawList@@AEBUImRect@@HUImVec2@@PEBDII_NPEA_N5@Z";
TabItemLabelAndCloseButton :: (draw_list: *DrawList, bb: Rect, flags: TabItemFlags, frame_padding: Vector2, label: *u8, tab_id: ID, close_button_id: ID, is_contents_visible: bool, out_just_closed: *bool, out_text_clipped: *bool) #no_context {
    TabItemLabelAndCloseButton(draw_list, *bb, flags, frame_padding, label, tab_id, close_button_id, is_contents_visible, out_just_closed, out_text_clipped);
}

// Render helpers
// AVOID USING OUTSIDE OF IMGUI.CPP! NOT FOR PUBLIC CONSUMPTION. THOSE FUNCTIONS ARE A MESS. THEIR SIGNATURE AND BEHAVIOR WILL CHANGE, THEY NEED TO BE REFACTORED INTO SOMETHING DECENT.
// NB: All position are in absolute pixels coordinates (we are never using window coordinates internally)
RenderText :: (pos: Vector2, text: *u8, text_end: *u8 = null, hide_text_after_hash := true) -> void #foreign ImGui "?RenderText@ImGui@@YAXUImVec2@@PEBD1_N@Z";
RenderText :: (pos: Vector2, text: string, hide_text_after_hash := true) #no_context {
    RenderText(pos, text.data, text.data + text.count, hide_text_after_hash);
}
RenderTextWrapped :: (pos: Vector2, text: *u8, text_end: *u8, wrap_width: float) -> void #foreign ImGui "?RenderTextWrapped@ImGui@@YAXUImVec2@@PEBD1M@Z";
RenderTextWrapped :: (pos: Vector2, text: string, wrap_width: float) #no_context {
    RenderTextWrapped(pos, text.data, text.data + text.count, wrap_width);
}
RenderTextClipped :: (pos_min: *Vector2, pos_max: *Vector2, text: *u8, text_end: *u8, text_size_if_known: *Vector2, align: *Vector2, clip_rect: *Rect = null) -> void #foreign ImGui "?RenderTextClipped@ImGui@@YAXAEBUImVec2@@0PEBD1PEBU2@0PEBUImRect@@@Z";
RenderTextClipped :: (pos_min: Vector2, pos_max: Vector2, text: string, text_size_if_known: *Vector2, align: Vector2 = .{0, 0}, clip_rect: *Rect = null) #no_context {
    RenderTextClipped(*pos_min, *pos_max, text.data, text.data + text.count, text_size_if_known, *align, clip_rect);
}
RenderTextClippedEx :: (draw_list: *DrawList, pos_min: *Vector2, pos_max: *Vector2, text: *u8, text_end: *u8, text_size_if_known: *Vector2, align: *Vector2, clip_rect: *Rect = null) -> void #foreign ImGui "?RenderTextClippedEx@ImGui@@YAXPEAUImDrawList@@AEBUImVec2@@1PEBD2PEBU3@1PEBUImRect@@@Z";
RenderTextClippedEx :: (draw_list: *DrawList, pos_min: Vector2, pos_max: Vector2, text: string, text_size_if_known: *Vector2, align: Vector2 = .{0, 0}, clip_rect: *Rect = null) #no_context {
    RenderTextClippedEx(draw_list, *pos_min, *pos_max, text.data, text.data + text.count, text_size_if_known, *align, clip_rect);
}
RenderTextEllipsis :: (draw_list: *DrawList, pos_min: *Vector2, pos_max: *Vector2, ellipsis_max_x: float, text: *u8, text_end: *u8, text_size_if_known: *Vector2) -> void #foreign ImGui "?RenderTextEllipsis@ImGui@@YAXPEAUImDrawList@@AEBUImVec2@@1MPEBD2PEBU3@@Z";
RenderTextEllipsis :: (draw_list: *DrawList, pos_min: Vector2, pos_max: Vector2, ellipsis_max_x: float, text: string, text_size_if_known: *Vector2) #no_context {
    RenderTextEllipsis(draw_list, *pos_min, *pos_max, ellipsis_max_x, text.data, text.data + text.count, text_size_if_known);
}
RenderFrame :: (p_min: Vector2, p_max: Vector2, fill_col: U32, borders := true, rounding: float = 0.0) -> void #foreign ImGui "?RenderFrame@ImGui@@YAXUImVec2@@0I_NM@Z";
RenderFrameBorder :: (p_min: Vector2, p_max: Vector2, rounding: float = 0.0) -> void #foreign ImGui "?RenderFrameBorder@ImGui@@YAXUImVec2@@0M@Z";
RenderColorRectWithAlphaCheckerboard :: (draw_list: *DrawList, p_min: Vector2, p_max: Vector2, fill_col: U32, grid_step: float, grid_off: Vector2, rounding: float = 0.0, flags: DrawFlags = .None) -> void #foreign ImGui "?RenderColorRectWithAlphaCheckerboard@ImGui@@YAXPEAUImDrawList@@UImVec2@@1IM1MH@Z";
RenderNavCursor :: (bb: *Rect, id: ID, flags: NavRenderCursorFlags = xx NavRenderCursorFlags.None) -> void #foreign ImGui "?RenderNavCursor@ImGui@@YAXAEBUImRect@@IH@Z";
RenderNavCursor :: (bb: Rect, id: ID, flags: NavRenderCursorFlags = xx NavRenderCursorFlags.None) #no_context {
    RenderNavCursor(*bb, id, flags);
}

FindRenderedTextEnd :: (text: *u8, text_end: *u8 = null) -> *u8 #foreign ImGui "?FindRenderedTextEnd@ImGui@@YAPEBDPEBD0@Z";
FindRenderedTextEnd :: (text: string) -> *u8 #no_context {
    return FindRenderedTextEnd(text.data, text.data + text.count);
}
RenderMouseCursor :: (pos: Vector2, scale: float, mouse_cursor: MouseCursor, col_fill: U32, col_border: U32, col_shadow: U32) -> void #foreign ImGui "?RenderMouseCursor@ImGui@@YAXUImVec2@@MHIII@Z";

// Render helpers (those functions don't access any ImGui state!)
RenderArrow :: (draw_list: *DrawList, pos: Vector2, col: U32, dir: Dir, scale: float = 1.0) -> void #foreign ImGui "?RenderArrow@ImGui@@YAXPEAUImDrawList@@UImVec2@@IW4ImGuiDir@@M@Z";
RenderBullet :: (draw_list: *DrawList, pos: Vector2, col: U32) -> void #foreign ImGui "?RenderBullet@ImGui@@YAXPEAUImDrawList@@UImVec2@@I@Z";
RenderCheckMark :: (draw_list: *DrawList, pos: Vector2, col: U32, sz: float) -> void #foreign ImGui "?RenderCheckMark@ImGui@@YAXPEAUImDrawList@@UImVec2@@IM@Z";
RenderArrowPointingAt :: (draw_list: *DrawList, pos: Vector2, half_sz: Vector2, direction: Dir, col: U32) -> void #foreign ImGui "?RenderArrowPointingAt@ImGui@@YAXPEAUImDrawList@@UImVec2@@1W4ImGuiDir@@I@Z";
RenderArrowDockMenu :: (draw_list: *DrawList, p_min: Vector2, sz: float, col: U32) -> void #foreign ImGui "?RenderArrowDockMenu@ImGui@@YAXPEAUImDrawList@@UImVec2@@MI@Z";
RenderRectFilledRangeH :: (draw_list: *DrawList, rect: *Rect, col: U32, x_start_norm: float, x_end_norm: float, rounding: float) -> void #foreign ImGui "?RenderRectFilledRangeH@ImGui@@YAXPEAUImDrawList@@AEBUImRect@@IMMM@Z";
RenderRectFilledRangeH :: (draw_list: *DrawList, rect: Rect, col: U32, x_start_norm: float, x_end_norm: float, rounding: float) #no_context {
    RenderRectFilledRangeH(draw_list, *rect, col, x_start_norm, x_end_norm, rounding);
}
RenderRectFilledWithHole :: (draw_list: *DrawList, outer: *Rect, inner: *Rect, col: U32, rounding: float) -> void #foreign ImGui "?RenderRectFilledWithHole@ImGui@@YAXPEAUImDrawList@@AEBUImRect@@1IM@Z";
RenderRectFilledWithHole :: (draw_list: *DrawList, outer: Rect, inner: Rect, col: U32, rounding: float) #no_context {
    RenderRectFilledWithHole(draw_list, *outer, *inner, col, rounding);
}
CalcRoundingFlagsForRectInRect :: (r_in: *Rect, r_outer: *Rect, threshold: float) -> DrawFlags #foreign ImGui "?CalcRoundingFlagsForRectInRect@ImGui@@YAHAEBUImRect@@0M@Z";
CalcRoundingFlagsForRectInRect :: (r_in: Rect, r_outer: Rect, threshold: float) -> DrawFlags #no_context {
    return CalcRoundingFlagsForRectInRect(*r_in, *r_outer, threshold);
}

// Widgets: Text
TextEx :: (text: *u8, text_end: *u8 = null, flags: TextFlags = 0) -> void #foreign ImGui "?TextEx@ImGui@@YAXPEBD0H@Z";
TextEx :: (text: string, flags: TextFlags = 0) #no_context {
    TextEx(text.data, text.data + text.count, flags);
}
TextAligned_CFormat :: (align_x: float, size_x: float, fmt: *u8, __args: ..Any) -> void #foreign ImGui "?TextAligned@ImGui@@YAXMMPEBDZZ";
TextAligned :: (align_x: float, size_x: float, fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    TextAligned_CFormat(align_x, size_x, "%s", formatted_text.data);
} @PrintLike

// Widgets
ButtonEx :: (label: *u8, size_arg: *Vector2, flags: ButtonFlags = .None) -> bool #foreign ImGui "?ButtonEx@ImGui@@YA_NPEBDAEBUImVec2@@H@Z";
ButtonEx :: (label: *u8, size_arg: Vector2 = .{0, 0}, flags: ButtonFlags = .None) -> bool #no_context {
    return ButtonEx(label, *size_arg, flags);
}
ArrowButtonEx :: (str_id: *u8, dir: Dir, size_arg: Vector2, flags: ButtonFlags = .None) -> bool #foreign ImGui "?ArrowButtonEx@ImGui@@YA_NPEBDW4ImGuiDir@@UImVec2@@H@Z";
ImageButtonEx :: (id: ID, tex_ref: TextureRef, image_size: *Vector2, uv0: *Vector2, uv1: *Vector2, bg_col: *Vector4, tint_col: *Vector4, flags: ButtonFlags = .None) -> bool #foreign ImGui "?ImageButtonEx@ImGui@@YA_NIUImTextureRef@@AEBUImVec2@@11AEBUImVec4@@2H@Z";
ImageButtonEx :: (id: ID, tex_ref: TextureRef, image_size: Vector2, uv0: Vector2, uv1: Vector2, bg_col: Vector4, tint_col: Vector4, flags: ButtonFlags = .None) -> bool #no_context {
    return ImageButtonEx(id, tex_ref, *image_size, *uv0, *uv1, *bg_col, *tint_col, flags);
}
SeparatorEx :: (flags: SeparatorFlags, thickness: float = 1.0) -> void #foreign ImGui "?SeparatorEx@ImGui@@YAXHM@Z";
SeparatorTextEx :: (id: ID, label: *u8, label_end: *u8, extra_width: float) -> void #foreign ImGui "?SeparatorTextEx@ImGui@@YAXIPEBD0M@Z";
SeparatorTextEx :: (id: ID, label: string, extra_width: float) #no_context {
    SeparatorTextEx(id, label.data, label.data + label.count, extra_width);
}
CheckboxFlags :: (label: *u8, flags: *S64, flags_value: S64) -> bool #foreign ImGui "?CheckboxFlags@ImGui@@YA_NPEBDPEA_J_J@Z";
CheckboxFlags :: (label: *u8, flags: *U64, flags_value: U64) -> bool #foreign ImGui "?CheckboxFlags@ImGui@@YA_NPEBDPEA_K_K@Z";

// Widgets: Window Decorations
CloseButton :: (id: ID, pos: *Vector2) -> bool #foreign ImGui "?CloseButton@ImGui@@YA_NIAEBUImVec2@@@Z";
CloseButton :: (id: ID, pos: Vector2) -> bool #no_context {
    return CloseButton(id, *pos);
}
CollapseButton :: (id: ID, pos: *Vector2, dock_node: *DockNode) -> bool #foreign ImGui "?CollapseButton@ImGui@@YA_NIAEBUImVec2@@PEAUImGuiDockNode@@@Z";
CollapseButton :: (id: ID, pos: Vector2, dock_node: *DockNode) -> bool #no_context {
    return CollapseButton(id, *pos, dock_node);
}
Scrollbar :: (axis: Axis) -> void #foreign ImGui "?Scrollbar@ImGui@@YAXW4ImGuiAxis@@@Z";
ScrollbarEx :: (bb: *Rect, id: ID, axis: Axis, p_scroll_v: *S64, avail_v: S64, contents_v: S64, draw_rounding_flags: DrawFlags = .None) -> bool #foreign ImGui "?ScrollbarEx@ImGui@@YA_NAEBUImRect@@IW4ImGuiAxis@@PEA_J_J3H@Z";
ScrollbarEx :: (bb: Rect, id: ID, axis: Axis, p_scroll_v: *S64, avail_v: S64, contents_v: S64, draw_rounding_flags: DrawFlags = .None) -> bool #no_context {
    return ScrollbarEx(*bb, id, axis, p_scroll_v, avail_v, contents_v, draw_rounding_flags);
}
GetWindowScrollbarRect :: (window: *Window, axis: Axis) -> Rect #cpp_return_type_is_non_pod #foreign ImGui "?GetWindowScrollbarRect@ImGui@@YA?AUImRect@@PEAUImGuiWindow@@W4ImGuiAxis@@@Z";
GetWindowScrollbarID :: (window: *Window, axis: Axis) -> ID #foreign ImGui "?GetWindowScrollbarID@ImGui@@YAIPEAUImGuiWindow@@W4ImGuiAxis@@@Z";
GetWindowResizeCornerID :: (window: *Window, n: s32) -> ID #foreign ImGui "?GetWindowResizeCornerID@ImGui@@YAIPEAUImGuiWindow@@H@Z";
GetWindowResizeBorderID :: (window: *Window, dir: Dir) -> ID #foreign ImGui "?GetWindowResizeBorderID@ImGui@@YAIPEAUImGuiWindow@@W4ImGuiDir@@@Z";

// Widgets low-level behaviors
ButtonBehavior :: (bb: *Rect, id: ID, out_hovered: *bool, out_held: *bool, flags: ButtonFlags = .None) -> bool #foreign ImGui "?ButtonBehavior@ImGui@@YA_NAEBUImRect@@IPEA_N1H@Z";
ButtonBehavior :: (bb: Rect, id: ID, out_hovered: *bool, out_held: *bool, flags: ButtonFlags = .None) -> bool #no_context {
    return ButtonBehavior(*bb, id, out_hovered, out_held, flags);
}
DragBehavior :: (id: ID, data_type: DataType, p_v: *void, v_speed: float, p_min: *void, p_max: *void, format: *u8, flags: SliderFlags) -> bool #foreign ImGui "?DragBehavior@ImGui@@YA_NIHPEAXMPEBX1PEBDH@Z";
SliderBehavior :: (bb: *Rect, id: ID, data_type: DataType, p_v: *void, p_min: *void, p_max: *void, format: *u8, flags: SliderFlags, out_grab_bb: *Rect) -> bool #foreign ImGui "?SliderBehavior@ImGui@@YA_NAEBUImRect@@IHPEAXPEBX2PEBDHPEAU2@@Z";
SliderBehavior :: (bb: Rect, id: ID, data_type: DataType, p_v: *void, p_min: *void, p_max: *void, format: *u8, flags: SliderFlags, out_grab_bb: *Rect) -> bool #no_context {
    return SliderBehavior(*bb, id, data_type, p_v, p_min, p_max, format, flags, out_grab_bb);
}
SplitterBehavior :: (bb: *Rect, id: ID, axis: Axis, size1: *float, size2: *float, min_size1: float, min_size2: float, hover_extend: float = 0.0, hover_visibility_delay: float = 0.0, bg_col: U32 = 0) -> bool #foreign ImGui "?SplitterBehavior@ImGui@@YA_NAEBUImRect@@IW4ImGuiAxis@@PEAM2MMMMI@Z";
SplitterBehavior :: (bb: Rect, id: ID, axis: Axis, size1: *float, size2: *float, min_size1: float, min_size2: float, hover_extend: float = 0.0, hover_visibility_delay: float = 0.0, bg_col: U32 = 0) -> bool #no_context {
    return SplitterBehavior(*bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay, bg_col);
}

// Widgets: Tree Nodes
TreeNodeBehavior :: (id: ID, flags: TreeNodeFlags, label: *u8, label_end: *u8 = null) -> bool #foreign ImGui "?TreeNodeBehavior@ImGui@@YA_NIHPEBD0@Z";
TreeNodeBehavior :: (id: ID, flags: TreeNodeFlags, label: string) -> bool #no_context {
    return TreeNodeBehavior(id, flags, label.data, label.data + label.count);
}
TreeNodeDrawLineToChildNode :: (target_pos: *Vector2) -> void #foreign ImGui "?TreeNodeDrawLineToChildNode@ImGui@@YAXAEBUImVec2@@@Z";
TreeNodeDrawLineToChildNode :: (target_pos: Vector2) #no_context {
    TreeNodeDrawLineToChildNode(*target_pos);
}
TreeNodeDrawLineToTreePop :: (data: *TreeNodeStackData) -> void #foreign ImGui "?TreeNodeDrawLineToTreePop@ImGui@@YAXPEBUImGuiTreeNodeStackData@@@Z";
TreePushOverrideID :: (id: ID) -> void #foreign ImGui "?TreePushOverrideID@ImGui@@YAXI@Z";
TreeNodeGetOpen :: (storage_id: ID) -> bool #foreign ImGui "?TreeNodeGetOpen@ImGui@@YA_NI@Z";
TreeNodeSetOpen :: (storage_id: ID, open: bool) -> void #foreign ImGui "?TreeNodeSetOpen@ImGui@@YAXI_N@Z";
TreeNodeUpdateNextOpen :: (storage_id: ID, flags: TreeNodeFlags) -> bool #foreign ImGui "?TreeNodeUpdateNextOpen@ImGui@@YA_NIH@Z";

// Data type helpers
DataTypeGetInfo :: (data_type: DataType) -> *DataTypeInfo #foreign ImGui "?DataTypeGetInfo@ImGui@@YAPEBUImGuiDataTypeInfo@@H@Z";
DataTypeFormatString :: (buf: *u8, buf_size: s32, data_type: DataType, p_data: *void, format: *u8) -> s32 #foreign ImGui "?DataTypeFormatString@ImGui@@YAHPEADHHPEBXPEBD@Z";
DataTypeApplyOp :: (data_type: DataType, op: s32, output: *void, arg_1: *void, arg_2: *void) -> void #foreign ImGui "?DataTypeApplyOp@ImGui@@YAXHHPEAXPEBX1@Z";
DataTypeApplyFromText :: (buf: *u8, data_type: DataType, p_data: *void, format: *u8, p_data_when_empty: *void = null) -> bool #foreign ImGui "?DataTypeApplyFromText@ImGui@@YA_NPEBDHPEAX01@Z";
DataTypeCompare :: (data_type: DataType, arg_1: *void, arg_2: *void) -> s32 #foreign ImGui "?DataTypeCompare@ImGui@@YAHHPEBX0@Z";
DataTypeClamp :: (data_type: DataType, p_data: *void, p_min: *void, p_max: *void) -> bool #foreign ImGui "?DataTypeClamp@ImGui@@YA_NHPEAXPEBX1@Z";
DataTypeIsZero :: (data_type: DataType, p_data: *void) -> bool #foreign ImGui "?DataTypeIsZero@ImGui@@YA_NHPEBX@Z";

// InputText
InputTextEx :: (label: *u8, hint: *u8, buf: *u8, buf_size: s32, size_arg: *Vector2, flags: InputTextFlags, callback: InputTextCallback = null, user_data: *void = null) -> bool #foreign ImGui "?InputTextEx@ImGui@@YA_NPEBD0PEADHAEBUImVec2@@HP6AHPEAUImGuiInputTextCallbackData@@@ZPEAX@Z";
InputTextEx :: (label: *u8, hint: *u8, buf: *u8, buf_size: s32, size_arg: Vector2, flags: InputTextFlags, callback: InputTextCallback = null, user_data: *void = null) -> bool #no_context {
    return InputTextEx(label, hint, buf, buf_size, *size_arg, flags, callback, user_data);
}
InputTextDeactivateHook :: (id: ID) -> void #foreign ImGui "?InputTextDeactivateHook@ImGui@@YAXI@Z";
TempInputText :: (bb: *Rect, id: ID, label: *u8, buf: *u8, buf_size: s32, flags: InputTextFlags) -> bool #foreign ImGui "?TempInputText@ImGui@@YA_NAEBUImRect@@IPEBDPEADHH@Z";
TempInputText :: (bb: Rect, id: ID, label: *u8, buf: *u8, buf_size: s32, flags: InputTextFlags) -> bool #no_context {
    return TempInputText(*bb, id, label, buf, buf_size, flags);
}
TempInputScalar :: (bb: *Rect, id: ID, label: *u8, data_type: DataType, p_data: *void, format: *u8, p_clamp_min: *void = null, p_clamp_max: *void = null) -> bool #foreign ImGui "?TempInputScalar@ImGui@@YA_NAEBUImRect@@IPEBDHPEAX1PEBX3@Z";
TempInputScalar :: (bb: Rect, id: ID, label: *u8, data_type: DataType, p_data: *void, format: *u8, p_clamp_min: *void = null, p_clamp_max: *void = null) -> bool #no_context {
    return TempInputScalar(*bb, id, label, data_type, p_data, format, p_clamp_min, p_clamp_max);
}
TempInputIsActive :: (id: ID) -> bool #foreign ImGui "?TempInputIsActive@ImGui@@YA_NI@Z";
GetInputTextState :: (id: ID) -> *InputTextState #foreign ImGui "?GetInputTextState@ImGui@@YAPEAUImGuiInputTextState@@I@Z";
SetNextItemRefVal :: (data_type: DataType, p_data: *void) -> void #foreign ImGui "?SetNextItemRefVal@ImGui@@YAXHPEAX@Z";

// Color
ColorTooltip :: (text: *u8, col: *float, flags: ColorEditFlags) -> void #foreign ImGui "?ColorTooltip@ImGui@@YAXPEBDPEBMH@Z";
ColorEditOptionsPopup :: (col: *float, flags: ColorEditFlags) -> void #foreign ImGui "?ColorEditOptionsPopup@ImGui@@YAXPEBMH@Z";
ColorPickerOptionsPopup :: (ref_col: *float, flags: ColorEditFlags) -> void #foreign ImGui "?ColorPickerOptionsPopup@ImGui@@YAXPEBMH@Z";

// Plot
PlotEx :: (plot_type: PlotType, label: *u8, values_getter: #type (data: *void, idx: s32) -> float #c_call, data: *void, values_count: s32, values_offset: s32, overlay_text: *u8, scale_min: float, scale_max: float, size_arg: *Vector2) -> s32 #foreign ImGui "?PlotEx@ImGui@@YAHW4ImGuiPlotType@@PEBDP6AMPEAXH@Z2HH1MMAEBUImVec2@@@Z";
PlotEx :: (plot_type: PlotType, label: *u8, values_getter: #type (data: *void, idx: s32) -> float #c_call, data: *void, values_count: s32, values_offset: s32, overlay_text: *u8, scale_min: float, scale_max: float, size_arg: Vector2) -> s32 #no_context {
    return PlotEx(plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, *size_arg);
}

// Shade functions (write over already created vertices)
ShadeVertsLinearColorGradientKeepAlpha :: (draw_list: *DrawList, vert_start_idx: s32, vert_end_idx: s32, gradient_p0: Vector2, gradient_p1: Vector2, col0: U32, col1: U32) -> void #foreign ImGui "?ShadeVertsLinearColorGradientKeepAlpha@ImGui@@YAXPEAUImDrawList@@HHUImVec2@@1II@Z";
ShadeVertsLinearUV :: (draw_list: *DrawList, vert_start_idx: s32, vert_end_idx: s32, a: *Vector2, b: *Vector2, uv_a: *Vector2, uv_b: *Vector2, clamp: bool) -> void #foreign ImGui "?ShadeVertsLinearUV@ImGui@@YAXPEAUImDrawList@@HHAEBUImVec2@@111_N@Z";
ShadeVertsLinearUV :: (draw_list: *DrawList, vert_start_idx: s32, vert_end_idx: s32, a: Vector2, b: Vector2, uv_a: Vector2, uv_b: Vector2, clamp: bool) #no_context {
    ShadeVertsLinearUV(draw_list, vert_start_idx, vert_end_idx, *a, *b, *uv_a, *uv_b, clamp);
}
ShadeVertsTransformPos :: (draw_list: *DrawList, vert_start_idx: s32, vert_end_idx: s32, pivot_in: *Vector2, cos_a: float, sin_a: float, pivot_out: *Vector2) -> void #foreign ImGui "?ShadeVertsTransformPos@ImGui@@YAXPEAUImDrawList@@HHAEBUImVec2@@MM1@Z";
ShadeVertsTransformPos :: (draw_list: *DrawList, vert_start_idx: s32, vert_end_idx: s32, pivot_in: Vector2, cos_a: float, sin_a: float, pivot_out: Vector2) #no_context {
    ShadeVertsTransformPos(draw_list, vert_start_idx, vert_end_idx, *pivot_in, cos_a, sin_a, *pivot_out);
}

// Garbage collection
GcCompactTransientMiscBuffers :: () -> void #foreign ImGui "?GcCompactTransientMiscBuffers@ImGui@@YAXXZ";
GcCompactTransientWindowBuffers :: (window: *Window) -> void #foreign ImGui "?GcCompactTransientWindowBuffers@ImGui@@YAXPEAUImGuiWindow@@@Z";
GcAwakeTransientWindowBuffers :: (window: *Window) -> void #foreign ImGui "?GcAwakeTransientWindowBuffers@ImGui@@YAXPEAUImGuiWindow@@@Z";

// Error handling, State Recovery
ErrorLog :: (msg: *u8) -> bool #foreign ImGui "?ErrorLog@ImGui@@YA_NPEBD@Z";
ErrorRecoveryStoreState :: (state_out: *ErrorRecoveryState) -> void #foreign ImGui "?ErrorRecoveryStoreState@ImGui@@YAXPEAUImGuiErrorRecoveryState@@@Z";
ErrorRecoveryTryToRecoverState :: (state_in: *ErrorRecoveryState) -> void #foreign ImGui "?ErrorRecoveryTryToRecoverState@ImGui@@YAXPEBUImGuiErrorRecoveryState@@@Z";
ErrorRecoveryTryToRecoverWindowState :: (state_in: *ErrorRecoveryState) -> void #foreign ImGui "?ErrorRecoveryTryToRecoverWindowState@ImGui@@YAXPEBUImGuiErrorRecoveryState@@@Z";
ErrorCheckUsingSetCursorPosToExtendParentBoundaries :: () -> void #foreign ImGui "?ErrorCheckUsingSetCursorPosToExtendParentBoundaries@ImGui@@YAXXZ";
ErrorCheckEndFrameFinalizeErrorTooltip :: () -> void #foreign ImGui "?ErrorCheckEndFrameFinalizeErrorTooltip@ImGui@@YAXXZ";
BeginErrorTooltip :: () -> bool #foreign ImGui "?BeginErrorTooltip@ImGui@@YA_NXZ";
EndErrorTooltip :: () -> void #foreign ImGui "?EndErrorTooltip@ImGui@@YAXXZ";

// Debug Tools
DebugAllocHook :: (info: *DebugAllocInfo, frame_count: s32, ptr: *void, size: u64) -> void #foreign ImGui "?DebugAllocHook@ImGui@@YAXPEAUImGuiDebugAllocInfo@@HPEAX_K@Z";
DebugDrawCursorPos :: (col: U32 = 4278190335) -> void #foreign ImGui "?DebugDrawCursorPos@ImGui@@YAXI@Z";
DebugDrawLineExtents :: (col: U32 = 4278190335) -> void #foreign ImGui "?DebugDrawLineExtents@ImGui@@YAXI@Z";
DebugDrawItemRect :: (col: U32 = 4278190335) -> void #foreign ImGui "?DebugDrawItemRect@ImGui@@YAXI@Z";
DebugTextUnformattedWithLocateItem :: (line_begin: *u8, line_end: *u8) -> void #foreign ImGui "?DebugTextUnformattedWithLocateItem@ImGui@@YAXPEBD0@Z";
DebugTextUnformattedWithLocateItem :: (line: string) #no_context {
    DebugTextUnformattedWithLocateItem(line.data, line.data + line.count);
}
DebugLocateItem :: (target_id: ID) -> void #foreign ImGui "?DebugLocateItem@ImGui@@YAXI@Z";
DebugLocateItemOnHover :: (target_id: ID) -> void #foreign ImGui "?DebugLocateItemOnHover@ImGui@@YAXI@Z";
DebugLocateItemResolveWithLastItem :: () -> void #foreign ImGui "?DebugLocateItemResolveWithLastItem@ImGui@@YAXXZ";
DebugBreakClearData :: () -> void #foreign ImGui "?DebugBreakClearData@ImGui@@YAXXZ";
DebugBreakButton :: (label: *u8, description_of_location: *u8) -> bool #foreign ImGui "?DebugBreakButton@ImGui@@YA_NPEBD0@Z";
DebugBreakButtonTooltip :: (keyboard_only: bool, description_of_location: *u8) -> void #foreign ImGui "?DebugBreakButtonTooltip@ImGui@@YAX_NPEBD@Z";
ShowFontAtlas :: (atlas: *FontAtlas) -> void #foreign ImGui "?ShowFontAtlas@ImGui@@YAXPEAUImFontAtlas@@@Z";
DebugHookIdInfo :: (id: ID, data_type: DataType, data_id: *void, data_id_end: *void) -> void #foreign ImGui "?DebugHookIdInfo@ImGui@@YAXIHPEBX0@Z";
DebugNodeColumns :: (columns: *OldColumns) -> void #foreign ImGui "?DebugNodeColumns@ImGui@@YAXPEAUImGuiOldColumns@@@Z";
DebugNodeDockNode :: (node: *DockNode, label: *u8) -> void #foreign ImGui "?DebugNodeDockNode@ImGui@@YAXPEAUImGuiDockNode@@PEBD@Z";
DebugNodeDrawList :: (window: *Window, viewport: *ViewportP, draw_list: *DrawList, label: *u8) -> void #foreign ImGui "?DebugNodeDrawList@ImGui@@YAXPEAUImGuiWindow@@PEAUImGuiViewportP@@PEBUImDrawList@@PEBD@Z";
DebugNodeDrawCmdShowMeshAndBoundingBox :: (out_draw_list: *DrawList, draw_list: *DrawList, draw_cmd: *DrawCmd, show_mesh: bool, show_aabb: bool) -> void #foreign ImGui "?DebugNodeDrawCmdShowMeshAndBoundingBox@ImGui@@YAXPEAUImDrawList@@PEBU2@PEBUImDrawCmd@@_N3@Z";
DebugNodeFont :: (font: *Font) -> void #foreign ImGui "?DebugNodeFont@ImGui@@YAXPEAUImFont@@@Z";
DebugNodeFontGlyphesForSrcMask :: (font: *Font, baked: *FontBaked, src_mask: s32) -> void #foreign ImGui "?DebugNodeFontGlyphesForSrcMask@ImGui@@YAXPEAUImFont@@PEAUImFontBaked@@H@Z";
DebugNodeFontGlyph :: (font: *Font, glyph: *FontGlyph) -> void #foreign ImGui "?DebugNodeFontGlyph@ImGui@@YAXPEAUImFont@@PEBUImFontGlyph@@@Z";
DebugNodeTexture :: (tex: *TextureData, int_id: s32, highlight_rect: *FontAtlasRect = null) -> void #foreign ImGui "?DebugNodeTexture@ImGui@@YAXPEAUImTextureData@@HPEBUImFontAtlasRect@@@Z";
DebugNodeStorage :: (storage: *Storage, label: *u8) -> void #foreign ImGui "?DebugNodeStorage@ImGui@@YAXPEAUImGuiStorage@@PEBD@Z";
DebugNodeTabBar :: (tab_bar: *TabBar, label: *u8) -> void #foreign ImGui "?DebugNodeTabBar@ImGui@@YAXPEAUImGuiTabBar@@PEBD@Z";
DebugNodeTable :: (table: *Table) -> void #foreign ImGui "?DebugNodeTable@ImGui@@YAXPEAUImGuiTable@@@Z";
DebugNodeTableSettings :: (settings: *TableSettings) -> void #foreign ImGui "?DebugNodeTableSettings@ImGui@@YAXPEAUImGuiTableSettings@@@Z";
DebugNodeInputTextState :: (state: *InputTextState) -> void #foreign ImGui "?DebugNodeInputTextState@ImGui@@YAXPEAUImGuiInputTextState@@@Z";
DebugNodeTypingSelectState :: (state: *TypingSelectState) -> void #foreign ImGui "?DebugNodeTypingSelectState@ImGui@@YAXPEAUImGuiTypingSelectState@@@Z";
DebugNodeMultiSelectState :: (state: *MultiSelectState) -> void #foreign ImGui "?DebugNodeMultiSelectState@ImGui@@YAXPEAUImGuiMultiSelectState@@@Z";
DebugNodeWindow :: (window: *Window, label: *u8) -> void #foreign ImGui "?DebugNodeWindow@ImGui@@YAXPEAUImGuiWindow@@PEBD@Z";
DebugNodeWindowSettings :: (settings: *WindowSettings) -> void #foreign ImGui "?DebugNodeWindowSettings@ImGui@@YAXPEAUImGuiWindowSettings@@@Z";
DebugNodeWindowsList :: (windows: *Vector(*Window), label: *u8) -> void #foreign ImGui "?DebugNodeWindowsList@ImGui@@YAXPEAU?$ImVector@PEAUImGuiWindow@@@@PEBD@Z";
DebugNodeWindowsListByBeginStackParent :: (windows: **Window, windows_size: s32, parent_in_begin_stack: *Window) -> void #foreign ImGui "?DebugNodeWindowsListByBeginStackParent@ImGui@@YAXPEAPEAUImGuiWindow@@HPEAU2@@Z";
DebugNodeViewport :: (viewport: *ViewportP) -> void #foreign ImGui "?DebugNodeViewport@ImGui@@YAXPEAUImGuiViewportP@@@Z";
DebugNodePlatformMonitor :: (monitor: *PlatformMonitor, label: *u8, idx: s32) -> void #foreign ImGui "?DebugNodePlatformMonitor@ImGui@@YAXPEAUImGuiPlatformMonitor@@PEBDH@Z";
DebugRenderKeyboardPreview :: (draw_list: *DrawList) -> void #foreign ImGui "?DebugRenderKeyboardPreview@ImGui@@YAXPEAUImDrawList@@@Z";
DebugRenderViewportThumbnail :: (draw_list: *DrawList, viewport: *ViewportP, bb: *Rect) -> void #foreign ImGui "?DebugRenderViewportThumbnail@ImGui@@YAXPEAUImDrawList@@PEAUImGuiViewportP@@AEBUImRect@@@Z";
DebugRenderViewportThumbnail :: (draw_list: *DrawList, viewport: *ViewportP, bb: Rect) #no_context {
    DebugRenderViewportThumbnail(draw_list, viewport, *bb);
}

// Flags for ImGui::Begin()
// (Those are per-window flags. There are shared flags in ImGuiIO: io.ConfigWindowsResizeFromEdges and io.ConfigWindowsMoveFromTitleBarOnly)
WindowFlags :: enum_flags s32 {
    None                      :: 0x0;
    NoTitleBar                :: 0x1;
    NoResize                  :: 0x2;
    NoMove                    :: 0x4;
    NoScrollbar               :: 0x8;
    NoScrollWithMouse         :: 0x10;
    NoCollapse                :: 0x20;
    AlwaysAutoResize          :: 0x40;
    NoBackground              :: 0x80;
    NoSavedSettings           :: 0x100;
    NoMouseInputs             :: 0x200;
    MenuBar                   :: 0x400;
    HorizontalScrollbar       :: 0x800;
    NoFocusOnAppearing        :: 0x1000;
    NoBringToFrontOnFocus     :: 0x2000;
    AlwaysVerticalScrollbar   :: 0x4000;
    AlwaysHorizontalScrollbar :: 0x8000;
    NoNavInputs               :: 0x10000;
    NoNavFocus                :: 0x20000;
    UnsavedDocument           :: 0x40000;
    NoDocking                 :: 0x80000;
    NoNav                     :: 0x30000;
    NoDecoration              :: 0x2b;
    NoInputs                  :: 0x30200;

    DockNodeHost              :: 0x800000;
    ChildWindow               :: 0x1000000;
    Tooltip                   :: 0x2000000;
    Popup                     :: 0x4000000;
    Modal                     :: 0x8000000;
    ChildMenu                 :: 0x10000000;
}

// Flags for ImGui::BeginChild()
// (Legacy: bit 0 must always correspond to ImGuiChildFlags_Borders to be backward compatible with old API using 'bool border = false'.)
// About using AutoResizeX/AutoResizeY flags:
// - May be combined with SetNextWindowSizeConstraints() to set a min/max size for each axis (see "Demo->Child->Auto-resize with Constraints").
// - Size measurement for a given axis is only performed when the child window is within visible boundaries, or is just appearing.
//   - This allows BeginChild() to return false when not within boundaries (e.g. when scrolling), which is more optimal. BUT it won't update its auto-size while clipped.
//     While not perfect, it is a better default behavior as the always-on performance gain is more valuable than the occasional "resizing after becoming visible again" glitch.
//   - You may also use ImGuiChildFlags_AlwaysAutoResize to force an update even when child window is not in view.
//     HOWEVER PLEASE UNDERSTAND THAT DOING SO WILL PREVENT BeginChild() FROM EVER RETURNING FALSE, disabling benefits of coarse clipping.
ChildFlags :: enum_flags s32 {
    None                   :: 0x0;
    Borders                :: 0x1;
    AlwaysUseWindowPadding :: 0x2;
    ResizeX                :: 0x4;
    ResizeY                :: 0x8;
    AutoResizeX            :: 0x10;
    AutoResizeY            :: 0x20;
    AlwaysAutoResize       :: 0x40;
    FrameStyle             :: 0x80;
    NavFlattened           :: 0x100;
}

// Flags for ImGui::PushItemFlag()
// (Those are shared by all items)
ItemFlags :: enum_flags s32 {
    None              :: 0x0;
    NoTabStop         :: 0x1;
    NoNav             :: 0x2;
    NoNavDefaultFocus :: 0x4;
    ButtonRepeat      :: 0x8;
    AutoClosePopups   :: 0x10;
    AllowDuplicateId  :: 0x20;
}

// Flags for ImGui::InputText()
// (Those are per-item flags. There are shared flags in ImGuiIO: io.ConfigInputTextCursorBlink and io.ConfigInputTextEnterKeepActive)
InputTextFlags :: enum_flags s32 {
    None                :: 0x0;
    CharsDecimal        :: 0x1;
    CharsHexadecimal    :: 0x2;
    CharsScientific     :: 0x4;
    CharsUppercase      :: 0x8;
    CharsNoBlank        :: 0x10;

    AllowTabInput       :: 0x20;
    EnterReturnsTrue    :: 0x40;
    EscapeClearsAll     :: 0x80;
    CtrlEnterForNewLine :: 0x100;

    ReadOnly            :: 0x200;
    Password            :: 0x400;
    AlwaysOverwrite     :: 0x800;
    AutoSelectAll       :: 0x1000;
    ParseEmptyRefVal    :: 0x2000;
    DisplayEmptyRefVal  :: 0x4000;
    NoHorizontalScroll  :: 0x8000;
    NoUndoRedo          :: 0x10000;

    ElideLeft           :: 0x20000;

    CallbackCompletion  :: 0x40000;
    CallbackHistory     :: 0x80000;
    CallbackAlways      :: 0x100000;
    CallbackCharFilter  :: 0x200000;
    CallbackResize      :: 0x400000;
    CallbackEdit        :: 0x800000;
}

// Flags for ImGui::TreeNodeEx(), ImGui::CollapsingHeader*()
TreeNodeFlags :: enum_flags s32 {
    None                 :: 0x0;
    Selected             :: 0x1;
    Framed               :: 0x2;
    AllowOverlap         :: 0x4;
    NoTreePushOnOpen     :: 0x8;
    NoAutoOpenOnLog      :: 0x10;
    DefaultOpen          :: 0x20;
    OpenOnDoubleClick    :: 0x40;
    OpenOnArrow          :: 0x80;
    Leaf                 :: 0x100;
    Bullet               :: 0x200;
    FramePadding         :: 0x400;
    SpanAvailWidth       :: 0x800;
    SpanFullWidth        :: 0x1000;
    SpanLabelWidth       :: 0x2000;
    SpanAllColumns       :: 0x4000;
    LabelSpanAllColumns  :: 0x8000;

    NavLeftJumpsToParent :: 0x20000;
    CollapsingHeader     :: 0x1a;

    DrawLinesNone        :: 0x40000;
    DrawLinesFull        :: 0x80000;
    DrawLinesToNodes     :: 0x100000;
}

// Flags for OpenPopup*(), BeginPopupContext*(), IsPopupOpen() functions.
// - To be backward compatible with older API which took an 'int mouse_button = 1' argument instead of 'ImGuiPopupFlags flags',
//   we need to treat small flags values as a mouse button index, so we encode the mouse button in the first few bits of the flags.
//   It is therefore guaranteed to be legal to pass a mouse button index in ImGuiPopupFlags.
// - For the same reason, we exceptionally default the ImGuiPopupFlags argument of BeginPopupContextXXX functions to 1 instead of 0.
//   IMPORTANT: because the default parameter is 1 (==ImGuiPopupFlags_MouseButtonRight), if you rely on the default parameter
//   and want to use another flag, you need to pass in the ImGuiPopupFlags_MouseButtonRight flag explicitly.
// - Multiple buttons currently cannot be combined/or-ed in those functions (we could allow it later).
PopupFlags :: enum_flags s32 {
    None                    :: 0x0;
    MouseButtonLeft         :: 0x0;
    MouseButtonRight        :: 0x1;
    MouseButtonMiddle       :: 0x2;
    MouseButtonMask_        :: 0x1f;
    MouseButtonDefault_     :: 0x1;
    NoReopen                :: 0x20;

    NoOpenOverExistingPopup :: 0x80;
    NoOpenOverItems         :: 0x100;
    AnyPopupId              :: 0x400;
    AnyPopupLevel           :: 0x800;
    AnyPopup                :: 0xc00;
}

// Flags for ImGui::Selectable()
SelectableFlags :: enum_flags s32 {
    None              :: 0x0;
    NoAutoClosePopups :: 0x1;
    SpanAllColumns    :: 0x2;
    AllowDoubleClick  :: 0x4;
    Disabled          :: 0x8;
    AllowOverlap      :: 0x10;
    Highlight         :: 0x20;
}

// Flags for ImGui::BeginCombo()
ComboFlags :: enum_flags s32 {
    None            :: 0x0;
    PopupAlignLeft  :: 0x1;
    HeightSmall     :: 0x2;
    HeightRegular   :: 0x4;
    HeightLarge     :: 0x8;
    HeightLargest   :: 0x10;
    NoArrowButton   :: 0x20;
    NoPreview       :: 0x40;
    WidthFitPreview :: 0x80;
    HeightMask_     :: 0x1e;
}

// Flags for ImGui::BeginTabBar()
TabBarFlags :: enum_flags s32 {
    None                         :: 0x0;
    Reorderable                  :: 0x1;
    AutoSelectNewTabs            :: 0x2;
    TabListPopupButton           :: 0x4;
    NoCloseWithMiddleMouseButton :: 0x8;
    NoTabListScrollingButtons    :: 0x10;
    NoTooltip                    :: 0x20;
    DrawSelectedOverline         :: 0x40;

    FittingPolicyMixed           :: 0x80;
    FittingPolicyShrink          :: 0x100;
    FittingPolicyScroll          :: 0x200;
    FittingPolicyMask_           :: 0x380;
    FittingPolicyDefault_        :: 0x80;
}

// Flags for ImGui::BeginTabItem()
TabItemFlags :: enum_flags s32 {
    None                         :: 0x0;
    UnsavedDocument              :: 0x1;
    SetSelected                  :: 0x2;
    NoCloseWithMiddleMouseButton :: 0x4;
    NoPushId                     :: 0x8;
    NoTooltip                    :: 0x10;
    NoReorder                    :: 0x20;
    Leading                      :: 0x40;
    Trailing                     :: 0x80;
    NoAssumedClosure             :: 0x100;
}

// Flags for ImGui::IsWindowFocused()
FocusedFlags :: enum_flags s32 {
    None                :: 0x0;
    ChildWindows        :: 0x1;
    RootWindow          :: 0x2;
    AnyWindow           :: 0x4;
    NoPopupHierarchy    :: 0x8;
    DockHierarchy       :: 0x10;
    RootAndChildWindows :: 0x3;
}

// Flags for ImGui::IsItemHovered(), ImGui::IsWindowHovered()
// Note: if you are trying to check whether your mouse should be dispatched to Dear ImGui or to your app, you should use 'io.WantCaptureMouse' instead! Please read the FAQ!
// Note: windows with the ImGuiWindowFlags_NoInputs flag are ignored by IsWindowHovered() calls.
HoveredFlags :: enum_flags s32 {
    None                         :: 0x0;
    ChildWindows                 :: 0x1;
    RootWindow                   :: 0x2;
    AnyWindow                    :: 0x4;
    NoPopupHierarchy             :: 0x8;
    DockHierarchy                :: 0x10;
    AllowWhenBlockedByPopup      :: 0x20;

    AllowWhenBlockedByActiveItem :: 0x80;
    AllowWhenOverlappedByItem    :: 0x100;
    AllowWhenOverlappedByWindow  :: 0x200;
    AllowWhenDisabled            :: 0x400;
    NoNavOverride                :: 0x800;
    AllowWhenOverlapped          :: 0x300;
    RectOnly                     :: 0x3a0;
    RootAndChildWindows          :: 0x3;

    ForTooltip                   :: 0x1000;

    Stationary                   :: 0x2000;
    DelayNone                    :: 0x4000;
    DelayShort                   :: 0x8000;
    DelayNormal                  :: 0x10000;
    NoSharedDelay                :: 0x20000;
}

// Flags for ImGui::DockSpace(), shared/inherited by child nodes.
// (Some flags can be applied to individual nodes directly)
// FIXME-DOCK: Also see ImGuiDockNodeFlagsPrivate_ which may involve using the WIP and internal DockBuilder api.
DockNodeFlags :: enum_flags s32 {
    None                     :: 0x0;
    KeepAliveOnly            :: 0x1;

    NoDockingOverCentralNode :: 0x4;
    PassthruCentralNode      :: 0x8;
    NoDockingSplit           :: 0x10;
    NoResize                 :: 0x20;
    AutoHideTabBar           :: 0x40;
    NoUndocking              :: 0x80;
}

// Flags for ImGui::BeginDragDropSource(), ImGui::AcceptDragDropPayload()
DragDropFlags :: enum_flags s32 {
    None                     :: 0x0;

    SourceNoPreviewTooltip   :: 0x1;
    SourceNoDisableHover     :: 0x2;
    SourceNoHoldToOpenOthers :: 0x4;
    SourceAllowNullID        :: 0x8;
    SourceExtern             :: 0x10;
    PayloadAutoExpire        :: 0x20;
    PayloadNoCrossContext    :: 0x40;
    PayloadNoCrossProcess    :: 0x80;

    AcceptBeforeDelivery     :: 0x400;
    AcceptNoDrawDefaultRect  :: 0x800;
    AcceptNoPreviewTooltip   :: 0x1000;
    AcceptPeekOnly           :: 0xc00;
}

// A primary data type
DataType :: enum s32 {
    S8     :: 0;
    U8     :: 1;
    S16    :: 2;
    U16    :: 3;
    S32    :: 4;
    U32    :: 5;
    S64    :: 6;
    U64    :: 7;
    Float  :: 8;
    Double :: 9;
    Bool   :: 10;
    String :: 11;
    COUNT  :: 12;
}

// Flags for Shortcut(), SetNextItemShortcut(),
// (and for upcoming extended versions of IsKeyPressed(), IsMouseClicked(), Shortcut(), SetKeyOwner(), SetItemKeyOwner() that are still in imgui_internal.h)
// Don't mistake with ImGuiInputTextFlags! (which is for ImGui::InputText() function)
InputFlags :: enum_flags s32 {
    None                 :: 0x0;
    Repeat               :: 0x1;

    RouteActive          :: 0x400;
    RouteFocused         :: 0x800;
    RouteGlobal          :: 0x1000;
    RouteAlways          :: 0x2000;

    RouteOverFocused     :: 0x4000;
    RouteOverActive      :: 0x8000;
    RouteUnlessBgFocused :: 0x10000;
    RouteFromRootWindow  :: 0x20000;

    Tooltip              :: 0x40000;
}

// Configuration flags stored in io.ConfigFlags. Set by user/application.
ConfigFlags :: enum_flags s32 {
    None                :: 0x0;
    NavEnableKeyboard   :: 0x1;
    NavEnableGamepad    :: 0x2;
    NoMouse             :: 0x10;
    NoMouseCursorChange :: 0x20;
    NoKeyboard          :: 0x40;

    DockingEnable       :: 0x80;

    ViewportsEnable     :: 0x400;

    IsSRGB              :: 0x100000;
    IsTouchScreen       :: 0x200000;
}

// Backend capabilities flags stored in io.BackendFlags. Set by imgui_impl_xxx or custom backend.
BackendFlags :: enum_flags s32 {
    None                    :: 0x0;
    HasGamepad              :: 0x1;
    HasMouseCursors         :: 0x2;
    HasSetMousePos          :: 0x4;
    RendererHasVtxOffset    :: 0x8;
    RendererHasTextures     :: 0x10;

    PlatformHasViewports    :: 0x400;
    HasMouseHoveredViewport :: 0x800;
    RendererHasViewports    :: 0x1000;
}

// Enumeration for PushStyleColor() / PopStyleColor()
Col :: enum s32 {
    Text                      :: 0;
    TextDisabled              :: 1;
    WindowBg                  :: 2;
    ChildBg                   :: 3;
    PopupBg                   :: 4;
    Border                    :: 5;
    BorderShadow              :: 6;
    FrameBg                   :: 7;
    FrameBgHovered            :: 8;
    FrameBgActive             :: 9;
    TitleBg                   :: 10;
    TitleBgActive             :: 11;
    TitleBgCollapsed          :: 12;
    MenuBarBg                 :: 13;
    ScrollbarBg               :: 14;
    ScrollbarGrab             :: 15;
    ScrollbarGrabHovered      :: 16;
    ScrollbarGrabActive       :: 17;
    CheckMark                 :: 18;
    SliderGrab                :: 19;
    SliderGrabActive          :: 20;
    Button                    :: 21;
    ButtonHovered             :: 22;
    ButtonActive              :: 23;
    Header                    :: 24;
    HeaderHovered             :: 25;
    HeaderActive              :: 26;
    Separator                 :: 27;
    SeparatorHovered          :: 28;
    SeparatorActive           :: 29;
    ResizeGrip                :: 30;
    ResizeGripHovered         :: 31;
    ResizeGripActive          :: 32;
    InputTextCursor           :: 33;
    TabHovered                :: 34;
    Tab                       :: 35;
    TabSelected               :: 36;
    TabSelectedOverline       :: 37;
    TabDimmed                 :: 38;
    TabDimmedSelected         :: 39;
    TabDimmedSelectedOverline :: 40;
    DockingPreview            :: 41;
    DockingEmptyBg            :: 42;
    PlotLines                 :: 43;
    PlotLinesHovered          :: 44;
    PlotHistogram             :: 45;
    PlotHistogramHovered      :: 46;
    TableHeaderBg             :: 47;
    TableBorderStrong         :: 48;
    TableBorderLight          :: 49;
    TableRowBg                :: 50;
    TableRowBgAlt             :: 51;
    TextLink                  :: 52;
    TextSelectedBg            :: 53;
    TreeLines                 :: 54;
    DragDropTarget            :: 55;
    NavCursor                 :: 56;
    NavWindowingHighlight     :: 57;
    NavWindowingDimBg         :: 58;
    ModalWindowDimBg          :: 59;
    COUNT                     :: 60;
}

// Enumeration for PushStyleVar() / PopStyleVar() to temporarily modify the ImGuiStyle structure.
// - The enum only refers to fields of ImGuiStyle which makes sense to be pushed/popped inside UI code.
//   During initialization or between frames, feel free to just poke into ImGuiStyle directly.
// - Tip: Use your programming IDE navigation facilities on the names in the _second column_ below to find the actual members and their description.
//   - In Visual Studio: CTRL+comma ("Edit.GoToAll") can follow symbols inside comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
//   - In Visual Studio w/ Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols inside comments.
//   - In VS Code, CLion, etc.: CTRL+click can follow symbols inside comments.
// - When changing this enum, you need to update the associated internal table GStyleVarInfo[] accordingly. This is where we link enum values to members offset/type.
StyleVar :: enum s32 {
    Alpha                       :: 0;
    DisabledAlpha               :: 1;
    WindowPadding               :: 2;
    WindowRounding              :: 3;
    WindowBorderSize            :: 4;
    WindowMinSize               :: 5;
    WindowTitleAlign            :: 6;
    ChildRounding               :: 7;
    ChildBorderSize             :: 8;
    PopupRounding               :: 9;
    PopupBorderSize             :: 10;
    FramePadding                :: 11;
    FrameRounding               :: 12;
    FrameBorderSize             :: 13;
    ItemSpacing                 :: 14;
    ItemInnerSpacing            :: 15;
    IndentSpacing               :: 16;
    CellPadding                 :: 17;
    ScrollbarSize               :: 18;
    ScrollbarRounding           :: 19;
    ScrollbarPadding            :: 20;
    GrabMinSize                 :: 21;
    GrabRounding                :: 22;
    ImageBorderSize             :: 23;
    TabRounding                 :: 24;
    TabBorderSize               :: 25;
    TabMinWidthBase             :: 26;
    TabMinWidthShrink           :: 27;
    TabBarBorderSize            :: 28;
    TabBarOverlineSize          :: 29;
    TableAngledHeadersAngle     :: 30;
    TableAngledHeadersTextAlign :: 31;
    TreeLinesSize               :: 32;
    TreeLinesRounding           :: 33;
    ButtonTextAlign             :: 34;
    SelectableTextAlign         :: 35;
    SeparatorTextBorderSize     :: 36;
    SeparatorTextAlign          :: 37;
    SeparatorTextPadding        :: 38;
    DockingSeparatorSize        :: 39;
    COUNT                       :: 40;
}

// Flags for InvisibleButton() [extended in imgui_internal.h]
ButtonFlags :: enum_flags s32 {
    None              :: 0x0;
    MouseButtonLeft   :: 0x1;
    MouseButtonRight  :: 0x2;
    MouseButtonMiddle :: 0x4;
    MouseButtonMask_  :: 0x7;
    EnableNav         :: 0x8;
}

// Flags for ColorEdit3() / ColorEdit4() / ColorPicker3() / ColorPicker4() / ColorButton()
ColorEditFlags :: enum_flags s32 {
    None             :: 0x0;
    NoAlpha          :: 0x2;
    NoPicker         :: 0x4;
    NoOptions        :: 0x8;
    NoSmallPreview   :: 0x10;
    NoInputs         :: 0x20;
    NoTooltip        :: 0x40;
    NoLabel          :: 0x80;
    NoSidePreview    :: 0x100;
    NoDragDrop       :: 0x200;
    NoBorder         :: 0x400;

    AlphaOpaque      :: 0x800;
    AlphaNoBg        :: 0x1000;
    AlphaPreviewHalf :: 0x2000;

    AlphaBar         :: 0x10000;
    HDR              :: 0x80000;
    DisplayRGB       :: 0x100000;
    DisplayHSV       :: 0x200000;
    DisplayHex       :: 0x400000;
    Uint8            :: 0x800000;
    Float            :: 0x1000000;
    PickerHueBar     :: 0x2000000;
    PickerHueWheel   :: 0x4000000;
    InputRGB         :: 0x8000000;
    InputHSV         :: 0x10000000;

    DefaultOptions_  :: 0xa900000;

    AlphaMask_       :: 0x3802;
    DisplayMask_     :: 0x700000;
    DataTypeMask_    :: 0x1800000;
    PickerMask_      :: 0x6000000;
    InputMask_       :: 0x18000000;
}

// Flags for DragFloat(), DragInt(), SliderFloat(), SliderInt() etc.
// We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
// (Those are per-item flags. There is shared behavior flag too: ImGuiIO: io.ConfigDragClickToInputText)
SliderFlags :: enum_flags s32 {
    None            :: 0x0;
    Logarithmic     :: 0x20;
    NoRoundToFormat :: 0x40;
    NoInput         :: 0x80;
    WrapAround      :: 0x100;
    ClampOnInput    :: 0x200;
    ClampZeroRange  :: 0x400;
    NoSpeedTweaks   :: 0x800;
    AlwaysClamp     :: 0x600;
    InvalidMask_    :: 0x7000000f;
}

// Identify a mouse button.
// Those values are guaranteed to be stable and we frequently use 0/1 directly. Named enums provided for convenience.
MouseButton :: enum s32 {
    Left   :: 0;
    Right  :: 1;
    Middle :: 2;
    COUNT  :: 5;
}

// Enumeration for GetMouseCursor()
// User code may request backend to display given cursor by calling SetMouseCursor(), which is why we have some cursors that are marked unused here
MouseCursor :: enum s32 {
    None       :: -1;
    Arrow      :: 0;
    TextInput  :: 1;
    ResizeAll  :: 2;
    ResizeNS   :: 3;
    ResizeEW   :: 4;
    ResizeNESW :: 5;
    ResizeNWSE :: 6;
    Hand       :: 7;
    Wait       :: 8;
    Progress   :: 9;
    NotAllowed :: 10;
    COUNT      :: 11;
}

// Enumeration for ImGui::SetNextWindow***(), SetWindow***(), SetNextItem***() functions
// Represent a condition.
// Important: Treat as a regular enum! Do NOT combine multiple values using binary operators! All the functions above treat 0 as a shortcut to ImGuiCond_Always.
Cond :: enum s32 {
    None         :: 0;
    Always       :: 1;
    Once         :: 2;
    FirstUseEver :: 4;
    Appearing    :: 8;
}

// Flags for ImGui::BeginTable()
// - Important! Sizing policies have complex and subtle side effects, much more so than you would expect.
//   Read comments/demos carefully + experiment with live demos to get acquainted with them.
// - The DEFAULT sizing policies are:
//    - Default to ImGuiTableFlags_SizingFixedFit    if ScrollX is on, or if host window has ImGuiWindowFlags_AlwaysAutoResize.
//    - Default to ImGuiTableFlags_SizingStretchSame if ScrollX is off.
// - When ScrollX is off:
//    - Table defaults to ImGuiTableFlags_SizingStretchSame -> all Columns defaults to ImGuiTableColumnFlags_WidthStretch with same weight.
//    - Columns sizing policy allowed: Stretch (default), Fixed/Auto.
//    - Fixed Columns (if any) will generally obtain their requested width (unless the table cannot fit them all).
//    - Stretch Columns will share the remaining width according to their respective weight.
//    - Mixed Fixed/Stretch columns is possible but has various side-effects on resizing behaviors.
//      The typical use of mixing sizing policies is: any number of LEADING Fixed columns, followed by one or two TRAILING Stretch columns.
//      (this is because the visible order of columns have subtle but necessary effects on how they react to manual resizing).
// - When ScrollX is on:
//    - Table defaults to ImGuiTableFlags_SizingFixedFit -> all Columns defaults to ImGuiTableColumnFlags_WidthFixed
//    - Columns sizing policy allowed: Fixed/Auto mostly.
//    - Fixed Columns can be enlarged as needed. Table will show a horizontal scrollbar if needed.
//    - When using auto-resizing (non-resizable) fixed columns, querying the content width to use item right-alignment e.g. SetNextItemWidth(-FLT_MIN) doesn't make sense, would create a feedback loop.
//    - Using Stretch columns OFTEN DOES NOT MAKE SENSE if ScrollX is on, UNLESS you have specified a value for 'inner_width' in BeginTable().
//      If you specify a value for 'inner_width' then effectively the scrolling space is known and Stretch or mixed Fixed/Stretch columns become meaningful again.
// - Read on documentation at the top of imgui_tables.cpp for details.
TableFlags :: enum_flags s32 {
    None                       :: 0x0;
    Resizable                  :: 0x1;
    Reorderable                :: 0x2;
    Hideable                   :: 0x4;
    Sortable                   :: 0x8;
    NoSavedSettings            :: 0x10;
    ContextMenuInBody          :: 0x20;

    RowBg                      :: 0x40;
    BordersInnerH              :: 0x80;
    BordersOuterH              :: 0x100;
    BordersInnerV              :: 0x200;
    BordersOuterV              :: 0x400;
    BordersH                   :: 0x180;
    BordersV                   :: 0x600;
    BordersInner               :: 0x280;
    BordersOuter               :: 0x500;
    Borders                    :: 0x780;
    NoBordersInBody            :: 0x800;
    NoBordersInBodyUntilResize :: 0x1000;

    SizingFixedFit             :: 0x2000;
    SizingFixedSame            :: 0x4000;
    SizingStretchProp          :: 0x6000;
    SizingStretchSame          :: 0x8000;

    NoHostExtendX              :: 0x10000;
    NoHostExtendY              :: 0x20000;
    NoKeepColumnsVisible       :: 0x40000;
    PreciseWidths              :: 0x80000;

    NoClip                     :: 0x100000;

    PadOuterX                  :: 0x200000;
    NoPadOuterX                :: 0x400000;
    NoPadInnerX                :: 0x800000;

    ScrollX                    :: 0x1000000;
    ScrollY                    :: 0x2000000;

    SortMulti                  :: 0x4000000;
    SortTristate               :: 0x8000000;

    HighlightHoveredColumn     :: 0x10000000;

    SizingMask_                :: 0xe000;
}

// Flags for ImGui::TableSetupColumn()
TableColumnFlags :: enum_flags s32 {
    None                 :: 0x0;
    Disabled             :: 0x1;
    DefaultHide          :: 0x2;
    DefaultSort          :: 0x4;
    WidthStretch         :: 0x8;
    WidthFixed           :: 0x10;
    NoResize             :: 0x20;
    NoReorder            :: 0x40;
    NoHide               :: 0x80;
    NoClip               :: 0x100;
    NoSort               :: 0x200;
    NoSortAscending      :: 0x400;
    NoSortDescending     :: 0x800;
    NoHeaderLabel        :: 0x1000;
    NoHeaderWidth        :: 0x2000;
    PreferSortAscending  :: 0x4000;
    PreferSortDescending :: 0x8000;
    IndentEnable         :: 0x10000;
    IndentDisable        :: 0x20000;
    AngledHeader         :: 0x40000;

    IsEnabled            :: 0x1000000;
    IsVisible            :: 0x2000000;
    IsSorted             :: 0x4000000;
    IsHovered            :: 0x8000000;

    WidthMask_           :: 0x18;
    IndentMask_          :: 0x30000;
    StatusMask_          :: 0xf000000;
    NoDirectResize_      :: 0x40000000;
}

// Flags for ImGui::TableNextRow()
TableRowFlags :: enum_flags s32 {
    None    :: 0x0;
    Headers :: 0x1;
}

// Enum for ImGui::TableSetBgColor()
// Background colors are rendering in 3 layers:
//  - Layer 0: draw with RowBg0 color if set, otherwise draw with ColumnBg0 if set.
//  - Layer 1: draw with RowBg1 color if set, otherwise draw with ColumnBg1 if set.
//  - Layer 2: draw with CellBg color if set.
// The purpose of the two row/columns layers is to let you decide if a background color change should override or blend with the existing color.
// When using ImGuiTableFlags_RowBg on the table, each row has the RowBg0 color automatically set for odd/even rows.
// If you set the color of RowBg0 target, your color will override the existing RowBg0 color.
// If you set the color of RowBg1 or ColumnBg1 target, your color will blend over the RowBg0 color.
TableBgTarget :: enum s32 {
    None   :: 0;
    RowBg0 :: 1;
    RowBg1 :: 2;
    CellBg :: 3;
}

// Sorting specifications for a table (often handling sort specs for a single column, occasionally more)
// Obtained by calling TableGetSortSpecs().
// When 'SpecsDirty == true' you can sort your data. It will be true with sorting specs have changed since last call, or the first time.
// Make sure to set 'SpecsDirty = false' after sorting, else you may wastefully sort your data every frame!
TableSortSpecs :: struct {
    Specs:      *TableColumnSortSpecs; // Pointer to sort spec array.
    SpecsCount: s32; // Sort spec count. Most often 1. May be > 1 when ImGuiTableFlags_SortMulti is enabled. May be == 0 when ImGuiTableFlags_SortTristate is enabled.
    SpecsDirty: bool; // Set to true when specs have changed since last time! Use this to sort again, then clear the flag.

    Constructor :: (this: *TableSortSpecs) -> void #cpp_method #foreign ImGui "??0ImGuiTableSortSpecs@@QEAA@XZ";
}

// Sorting specification for one column of a table (sizeof == 12 bytes)
TableColumnSortSpecs :: struct {
    ColumnUserID:   ID; // User id of the column (if specified by a TableSetupColumn() call)
    ColumnIndex:    S16; // Index of the column
    SortOrder:      S16; // Index within parent ImGuiTableSortSpecs (always stored in order starting from 0, tables sorted on a single criteria will always have a 0 here)
    SortDirection_: SortDirection; // ImGuiSortDirection_Ascending or ImGuiSortDirection_Descending

    Constructor :: (this: *TableColumnSortSpecs) -> void #cpp_method #foreign ImGui "??0ImGuiTableColumnSortSpecs@@QEAA@XZ";
}

//-----------------------------------------------------------------------------
// IM_MALLOC(), IM_FREE(), IM_NEW(), IM_PLACEMENT_NEW(), IM_DELETE()
// We call C++ constructor on own allocated memory via the placement "new(ptr) Type()" syntax.
// Defining a custom placement new() with a custom parameter allows us to bypass including <new> which on some platforms complains when user has disabled exceptions.
//-----------------------------------------------------------------------------
NewWrapper :: struct {
    using newwrapper__raw:  NewWrapper__RAW;
    __empty_struct_padding: u8; // C++ makes empty structs have length 1
}
// NewWrapper without empty struct padding. Needed to generate a C++-equivalent struct layout when "inheriting" from NewWrapper
NewWrapper__RAW :: struct {}
operatornew :: (unknown0: u64, unknown1: NewWrapper, ptr: *void) -> *void #foreign ImGui "??2@YAPEAX_KUImNewWrapper@@PEAX@Z";

//-----------------------------------------------------------------------------
// [SECTION] ImGuiStyle
//-----------------------------------------------------------------------------
// You may modify the ImGui::GetStyle() main instance during initialization and before NewFrame().
// During the frame, use ImGui::PushStyleVar(ImGuiStyleVar_XXXX)/PopStyleVar() to alter the main style values,
// and ImGui::PushStyleColor(ImGuiCol_XXX)/PopStyleColor() for colors.
//-----------------------------------------------------------------------------
Style :: struct {
    FontSizeBase:                     float; // Current base font size before external global factors are applied. Use PushFont(NULL, size) to modify. Use ImGui::GetFontSize() to obtain scaled value.
    FontScaleMain:                    float; // Main global scale factor. May be set by application once, or exposed to end-user.
    FontScaleDpi:                     float; // Additional global scale factor from viewport/monitor contents scale. When io.ConfigDpiScaleFonts is enabled, this is automatically overwritten when changing monitor DPI.

    Alpha:                            float; // Global alpha applies to everything in Dear ImGui.
    DisabledAlpha:                    float; // Additional alpha multiplier applied by BeginDisabled(). Multiply over current value of Alpha.
    WindowPadding:                    Vector2; // Padding within a window.
    WindowRounding:                   float; // Radius of window corners rounding. Set to 0.0f to have rectangular windows. Large values tend to lead to variety of artifacts and are not recommended.
    WindowBorderSize:                 float; // Thickness of border around windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    WindowBorderHoverPadding:         float; // Hit-testing extent outside/inside resizing border. Also extend determination of hovered window. Generally meaningfully larger than WindowBorderSize to make it easy to reach borders.
    WindowMinSize:                    Vector2; // Minimum window size. This is a global setting. If you want to constrain individual windows, use SetNextWindowSizeConstraints().
    WindowTitleAlign:                 Vector2; // Alignment for title bar text. Defaults to (0.0f,0.5f) for left-aligned,vertically centered.
    WindowMenuButtonPosition:         Dir; // Side of the collapsing/docking button in the title bar (None/Left/Right). Defaults to ImGuiDir_Left.
    ChildRounding:                    float; // Radius of child window corners rounding. Set to 0.0f to have rectangular windows.
    ChildBorderSize:                  float; // Thickness of border around child windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    PopupRounding:                    float; // Radius of popup window corners rounding. (Note that tooltip windows use WindowRounding)
    PopupBorderSize:                  float; // Thickness of border around popup/tooltip windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    FramePadding:                     Vector2; // Padding within a framed rectangle (used by most widgets).
    FrameRounding:                    float; // Radius of frame corners rounding. Set to 0.0f to have rectangular frame (used by most widgets).
    FrameBorderSize:                  float; // Thickness of border around frames. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    ItemSpacing:                      Vector2; // Horizontal and vertical spacing between widgets/lines.
    ItemInnerSpacing:                 Vector2; // Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
    CellPadding:                      Vector2; // Padding within a table cell. Cellpadding.x is locked for entire table. CellPadding.y may be altered between different rows.
    TouchExtraPadding:                Vector2; // Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
    IndentSpacing:                    float; // Horizontal indentation when e.g. entering a tree node. Generally == (FontSize + FramePadding.x*2).
    ColumnsMinSpacing:                float; // Minimum horizontal spacing between two columns. Preferably > (FramePadding.x + 1).
    ScrollbarSize:                    float; // Width of the vertical scrollbar, Height of the horizontal scrollbar.
    ScrollbarRounding:                float; // Radius of grab corners for scrollbar.
    ScrollbarPadding:                 float; // Padding of scrollbar grab within its frame (same for both axises).
    GrabMinSize:                      float; // Minimum width/height of a grab box for slider/scrollbar.
    GrabRounding:                     float; // Radius of grabs corners rounding. Set to 0.0f to have rectangular slider grabs.
    LogSliderDeadzone:                float; // The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
    ImageBorderSize:                  float; // Thickness of border around Image() calls.
    TabRounding:                      float; // Radius of upper corners of a tab. Set to 0.0f to have rectangular tabs.
    TabBorderSize:                    float; // Thickness of border around tabs.
    TabMinWidthBase:                  float; // Minimum tab width, to make tabs larger than their contents. TabBar buttons are not affected.
    TabMinWidthShrink:                float; // Minimum tab width after shrinking, when using ImGuiTabBarFlags_FittingPolicyMixed policy.
    TabCloseButtonMinWidthSelected:   float; // -1: always visible. 0.0f: visible when hovered. >0.0f: visible when hovered if minimum width.
    TabCloseButtonMinWidthUnselected: float; // -1: always visible. 0.0f: visible when hovered. >0.0f: visible when hovered if minimum width. FLT_MAX: never show close button when unselected.
    TabBarBorderSize:                 float; // Thickness of tab-bar separator, which takes on the tab active color to denote focus.
    TabBarOverlineSize:               float; // Thickness of tab-bar overline, which highlights the selected tab-bar.
    TableAngledHeadersAngle:          float; // Angle of angled headers (supported values range from -50.0f degrees to +50.0f degrees).
    TableAngledHeadersTextAlign:      Vector2; // Alignment of angled headers within the cell
    TreeLinesFlags:                   TreeNodeFlags; // Default way to draw lines connecting TreeNode hierarchy. ImGuiTreeNodeFlags_DrawLinesNone or ImGuiTreeNodeFlags_DrawLinesFull or ImGuiTreeNodeFlags_DrawLinesToNodes.
    TreeLinesSize:                    float; // Thickness of outlines when using ImGuiTreeNodeFlags_DrawLines.
    TreeLinesRounding:                float; // Radius of lines connecting child nodes to the vertical line.
    ColorButtonPosition:              Dir; // Side of the color button in the ColorEdit4 widget (left/right). Defaults to ImGuiDir_Right.
    ButtonTextAlign:                  Vector2; // Alignment of button text when button is larger than text. Defaults to (0.5f, 0.5f) (centered).
    SelectableTextAlign:              Vector2; // Alignment of selectable text. Defaults to (0.0f, 0.0f) (top-left aligned). It's generally important to keep this left-aligned if you want to lay multiple items on a same line.
    SeparatorTextBorderSize:          float; // Thickness of border in SeparatorText()
    SeparatorTextAlign:               Vector2; // Alignment of text within the separator. Defaults to (0.0f, 0.5f) (left aligned, center).
    SeparatorTextPadding:             Vector2; // Horizontal offset of text from each edge of the separator + spacing on other axis. Generally small values. .y is recommended to be == FramePadding.y.
    DisplayWindowPadding:             Vector2; // Apply to regular windows: amount which we enforce to keep visible when moving near edges of your screen.
    DisplaySafeAreaPadding:           Vector2; // Apply to every windows, menus, popups, tooltips: amount where we avoid displaying contents. Adjust if you cannot see the edges of your screen (e.g. on a TV where scaling has not been configured).
    DockingSeparatorSize:             float; // Thickness of resizing border between docked windows
    MouseCursorScale:                 float; // Scale software rendered mouse cursor (when io.MouseDrawCursor is enabled). We apply per-monitor DPI scaling over this scale. May be removed later.
    AntiAliasedLines:                 bool; // Enable anti-aliased lines/borders. Disable if you are really tight on CPU/GPU. Latched at the beginning of the frame (copied to ImDrawList).
    AntiAliasedLinesUseTex:           bool; // Enable anti-aliased lines/borders using textures where possible. Require backend to render with bilinear filtering (NOT point/nearest filtering). Latched at the beginning of the frame (copied to ImDrawList).
    AntiAliasedFill:                  bool; // Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). Disable if you are really tight on CPU/GPU. Latched at the beginning of the frame (copied to ImDrawList).
    CurveTessellationTol:             float; // Tessellation tolerance when using PathBezierCurveTo() without a specific number of segments. Decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
    CircleTessellationMaxError:       float; // Maximum error (in pixels) allowed when using AddCircle()/AddCircleFilled() or drawing rounded corner rectangles with no explicit segment count specified. Decrease for higher quality but more geometry.

    // Colors
    Colors:                           [60] Vector4;

    HoverStationaryDelay:             float; // Delay for IsItemHovered(ImGuiHoveredFlags_Stationary). Time required to consider mouse stationary.
    HoverDelayShort:                  float; // Delay for IsItemHovered(ImGuiHoveredFlags_DelayShort). Usually used along with HoverStationaryDelay.
    HoverDelayNormal:                 float; // Delay for IsItemHovered(ImGuiHoveredFlags_DelayNormal). "
    HoverFlagsForTooltipMouse:        HoveredFlags; // Default flags when using IsItemHovered(ImGuiHoveredFlags_ForTooltip) or BeginItemTooltip()/SetItemTooltip() while using mouse.
    HoverFlagsForTooltipNav:          HoveredFlags; // Default flags when using IsItemHovered(ImGuiHoveredFlags_ForTooltip) or BeginItemTooltip()/SetItemTooltip() while using keyboard/gamepad.

    _MainScale:                       float; // FIXME-WIP: Reference scale, as applied by ScaleAllSizes().
    _NextFrameFontSizeBase:           float; // FIXME: Temporary hack until we finish remaining work.

    // Functions
    Constructor :: (this: *Style) -> void #cpp_method #foreign ImGui "??0ImGuiStyle@@QEAA@XZ";
    ScaleAllSizes :: (this: *Style, scale_factor: float) -> void #cpp_method #foreign ImGui "?ScaleAllSizes@ImGuiStyle@@QEAAXM@Z";
}

// [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
// If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
KeyData :: struct {
    Down:             bool; // True for if key is down
    DownDuration:     float; // Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
    DownDurationPrev: float; // Last frame duration the key has been down
    AnalogValue:      float; // 0.0f..1.0f for gamepad values
}

IO :: struct {
    ConfigFlags_:                                  ConfigFlags; // = 0              // See ImGuiConfigFlags_ enum. Set by user/application. Keyboard/Gamepad navigation options, etc.
    BackendFlags_:                                 BackendFlags; // = 0              // See ImGuiBackendFlags_ enum. Set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
    DisplaySize:                                   Vector2; // <unset>          // Main display size, in pixels (== GetMainViewport()->Size). May change every frame.
    DisplayFramebufferScale:                       Vector2; // = (1, 1)         // Main display density. For retina display where window coordinates are different from framebuffer coordinates. This will affect font density + will end up in ImDrawData::FramebufferScale.
    DeltaTime:                                     float; // = 1.0f/60.0f     // Time elapsed since last frame, in seconds. May change every frame.
    IniSavingRate:                                 float; // = 5.0f           // Minimum time between saving positions/sizes to .ini file, in seconds.
    IniFilename:                                   *u8; // = "imgui.ini"    // Path to .ini file (important: default "imgui.ini" is relative to current working dir!). Set NULL to disable automatic .ini loading/saving or if you want to manually call LoadIniSettingsXXX() / SaveIniSettingsXXX() functions.
    LogFilename:                                   *u8; // = "imgui_log.txt"// Path to .log file (default parameter to ImGui::LogToFile when no file is specified).
    UserData:                                      *void; // = NULL           // Store your own data.

    Fonts:                                         *FontAtlas; // <auto>           // Font atlas: load, rasterize and pack one or more fonts into a single texture.
    FontDefault:                                   *Font; // = NULL           // Font to use on NewFrame(). Use NULL to uses Fonts->Fonts[0].
    FontAllowUserScaling:                          bool; // = false          // [OBSOLETE] Allow user scaling text of individual window with CTRL+Wheel.

    ConfigNavSwapGamepadButtons:                   bool; // = false          // Swap Activate<>Cancel (A<>B) buttons, matching typical "Nintendo/Japanese style" gamepad layout.
    ConfigNavMoveSetMousePos:                      bool; // = false          // Directional/tabbing navigation teleports the mouse cursor. May be useful on TV/console systems where moving a virtual mouse is difficult. Will update io.MousePos and set io.WantSetMousePos=true.
    ConfigNavCaptureKeyboard:                      bool; // = true           // Sets io.WantCaptureKeyboard when io.NavActive is set.
    ConfigNavEscapeClearFocusItem:                 bool; // = true           // Pressing Escape can clear focused item + navigation id/highlight. Set to false if you want to always keep highlight on.
    ConfigNavEscapeClearFocusWindow:               bool; // = false          // Pressing Escape can clear focused window as well (super set of io.ConfigNavEscapeClearFocusItem).
    ConfigNavCursorVisibleAuto:                    bool; // = true           // Using directional navigation key makes the cursor visible. Mouse click hides the cursor.
    ConfigNavCursorVisibleAlways:                  bool; // = false          // Navigation cursor is always visible.

    ConfigDockingNoSplit:                          bool; // = false          // Simplified docking mode: disable window splitting, so docking is limited to merging multiple windows together into tab-bars.
    ConfigDockingWithShift:                        bool; // = false          // Enable docking with holding Shift key (reduce visual noise, allows dropping in wider space)
    ConfigDockingAlwaysTabBar:                     bool; // = false          // [BETA] [FIXME: This currently creates regression with auto-sizing and general overhead] Make every single floating window display within a docking node.
    ConfigDockingTransparentPayload:               bool; // = false          // [BETA] Make window or viewport transparent when docking and only display docking boxes on the target viewport. Useful if rendering of multiple viewport cannot be synced. Best used with ConfigViewportsNoAutoMerge.

    ConfigViewportsNoAutoMerge:                    bool; // = false;         // Set to make all floating imgui windows always create their own viewport. Otherwise, they are merged into the main host viewports when overlapping it. May also set ImGuiViewportFlags_NoAutoMerge on individual viewport.
    ConfigViewportsNoTaskBarIcon:                  bool; // = false          // Disable default OS task bar icon flag for secondary viewports. When a viewport doesn't want a task bar icon, ImGuiViewportFlags_NoTaskBarIcon will be set on it.
    ConfigViewportsNoDecoration:                   bool; // = true           // Disable default OS window decoration flag for secondary viewports. When a viewport doesn't want window decorations, ImGuiViewportFlags_NoDecoration will be set on it. Enabling decoration can create subsequent issues at OS levels (e.g. minimum window size).
    ConfigViewportsNoDefaultParent:                bool; // = false          // Disable default OS parenting to main viewport for secondary viewports. By default, viewports are marked with ParentViewportId = <main_viewport>, expecting the platform backend to setup a parent/child relationship between the OS windows (some backend may ignore this). Set to true if you want the default to be 0, then all viewports will be top-level OS windows.
    ConfigViewportPlatformFocusSetsImGuiFocus:     bool; //= true // When a platform window is focused (e.g. using Alt+Tab, clicking Platform Title Bar), apply corresponding focus on imgui windows (may clear focus/active id from imgui windows location in other platform windows). In principle this is better enabled but we provide an opt-out, because some Linux window managers tend to eagerly focus windows (e.g. on mouse hover, or even a simple window pos/size change).

    ConfigDpiScaleFonts:                           bool; // = false          // [EXPERIMENTAL] Automatically overwrite style.FontScaleDpi when Monitor DPI changes. This will scale fonts but _NOT_ scale sizes/padding for now.
    ConfigDpiScaleViewports:                       bool; // = false          // [EXPERIMENTAL] Scale Dear ImGui and Platform Windows when Monitor DPI changes.

    MouseDrawCursor:                               bool; // = false          // Request ImGui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). Cannot be easily renamed to 'io.ConfigXXX' because this is frequently used by backend implementations.
    ConfigMacOSXBehaviors:                         bool; // = defined(__APPLE__) // Swap Cmd<>Ctrl keys + OS X style text editing cursor movement using Alt instead of Ctrl, Shortcuts using Cmd/Super instead of Ctrl, Line/Text Start and End using Cmd+Arrows instead of Home/End, Double click selects by word instead of selecting whole text, Multi-selection in lists uses Cmd/Super instead of Ctrl.
    ConfigInputTrickleEventQueue:                  bool; // = true           // Enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
    ConfigInputTextCursorBlink:                    bool; // = true           // Enable blinking cursor (optional as some users consider it to be distracting).
    ConfigInputTextEnterKeepActive:                bool; // = false          // [BETA] Pressing Enter will keep item active and select contents (single-line only).
    ConfigDragClickToInputText:                    bool; // = false          // [BETA] Enable turning DragXXX widgets into text input with a simple mouse click-release (without moving). Not desirable on devices without a keyboard.
    ConfigWindowsResizeFromEdges:                  bool; // = true           // Enable resizing of windows from their edges and from the lower-left corner. This requires ImGuiBackendFlags_HasMouseCursors for better mouse cursor feedback. (This used to be a per-window ImGuiWindowFlags_ResizeFromAnySide flag)
    ConfigWindowsMoveFromTitleBarOnly:             bool; // = false      // Enable allowing to move windows only when clicking on their title bar. Does not apply to windows without a title bar.
    ConfigWindowsCopyContentsWithCtrlC:            bool; // = false      // [EXPERIMENTAL] CTRL+C copy the contents of focused window into the clipboard. Experimental because: (1) has known issues with nested Begin/End pairs (2) text output quality varies (3) text output is in submission order rather than spatial order.
    ConfigScrollbarScrollByPage:                   bool; // = true           // Enable scrolling page by page when clicking outside the scrollbar grab. When disabled, always scroll to clicked location. When enabled, Shift+Click scrolls to clicked location.
    ConfigMemoryCompactTimer:                      float; // = 60.0f          // Timer (in seconds) to free transient windows/tables memory buffers when unused. Set to -1.0f to disable.

    MouseDoubleClickTime:                          float; // = 0.30f          // Time for a double-click, in seconds.
    MouseDoubleClickMaxDist:                       float; // = 6.0f           // Distance threshold to stay in to validate a double-click, in pixels.
    MouseDragThreshold:                            float; // = 6.0f           // Distance threshold before considering we are dragging.
    KeyRepeatDelay:                                float; // = 0.275f         // When holding a key/button, time before it starts repeating, in seconds (for buttons in Repeat mode, etc.).
    KeyRepeatRate:                                 float; // = 0.050f         // When holding a key/button, rate at which it repeats, in seconds.

    ConfigErrorRecovery:                           bool; // = true       // Enable error recovery support. Some errors won't be detected and lead to direct crashes if recovery is disabled.
    ConfigErrorRecoveryEnableAssert:               bool; // = true       // Enable asserts on recoverable error. By default call IM_ASSERT() when returning from a failing IM_ASSERT_USER_ERROR()
    ConfigErrorRecoveryEnableDebugLog:             bool; // = true       // Enable debug log output on recoverable errors.
    ConfigErrorRecoveryEnableTooltip:              bool; // = true       // Enable tooltip on recoverable errors. The tooltip include a way to enable asserts if they were disabled.

    ConfigDebugIsDebuggerPresent:                  bool; // = false          // Enable various tools calling IM_DEBUG_BREAK().

    ConfigDebugHighlightIdConflicts:               bool; // = true           // Highlight and show an error message popup when multiple items have conflicting identifiers.
    ConfigDebugHighlightIdConflictsShowItemPicker: bool; //=true // Show "Item Picker" button in aforementioned popup.

    ConfigDebugBeginReturnValueOnce:               bool; // = false          // First-time calls to Begin()/BeginChild() will return false. NEEDS TO BE SET AT APPLICATION BOOT TIME if you don't want to miss windows.
    ConfigDebugBeginReturnValueLoop:               bool; // = false          // Some calls to Begin()/BeginChild() will return false. Will cycle through window depths then repeat. Suggested use: add "io.ConfigDebugBeginReturnValue = io.KeyShift" in your main loop then occasionally press SHIFT. Windows should be flickering while running.

    ConfigDebugIgnoreFocusLoss:                    bool; // = false          // Ignore io.AddFocusEvent(false), consequently not calling io.ClearInputKeys()/io.ClearInputMouse() in input processing.

    ConfigDebugIniSettings:                        bool; // = false          // Save .ini data with extra comments (particularly helpful for Docking, but makes saving slower)

    BackendPlatformName:                           *u8; // = NULL
    BackendRendererName:                           *u8; // = NULL
    BackendPlatformUserData:                       *void; // = NULL           // User data for platform backend
    BackendRendererUserData:                       *void; // = NULL           // User data for renderer backend
    BackendLanguageUserData:                       *void; // = NULL           // User data for non C++ programming language backend

    // Input Functions
    AddKeyEvent :: (this: *IO, key: Key, down: bool) -> void #cpp_method #foreign ImGui "?AddKeyEvent@ImGuiIO@@QEAAXW4ImGuiKey@@_N@Z";
    AddKeyAnalogEvent :: (this: *IO, key: Key, down: bool, v: float) -> void #cpp_method #foreign ImGui "?AddKeyAnalogEvent@ImGuiIO@@QEAAXW4ImGuiKey@@_NM@Z";
    AddMousePosEvent :: (this: *IO, x: float, y: float) -> void #cpp_method #foreign ImGui "?AddMousePosEvent@ImGuiIO@@QEAAXMM@Z";
    AddMouseButtonEvent :: (this: *IO, button: s32, down: bool) -> void #cpp_method #foreign ImGui "?AddMouseButtonEvent@ImGuiIO@@QEAAXH_N@Z";
    AddMouseWheelEvent :: (this: *IO, wheel_x: float, wheel_y: float) -> void #cpp_method #foreign ImGui "?AddMouseWheelEvent@ImGuiIO@@QEAAXMM@Z";
    AddMouseSourceEvent :: (this: *IO, source: MouseSource) -> void #cpp_method #foreign ImGui "?AddMouseSourceEvent@ImGuiIO@@QEAAXW4ImGuiMouseSource@@@Z";
    AddMouseViewportEvent :: (this: *IO, id: ID) -> void #cpp_method #foreign ImGui "?AddMouseViewportEvent@ImGuiIO@@QEAAXI@Z";
    AddFocusEvent :: (this: *IO, focused: bool) -> void #cpp_method #foreign ImGui "?AddFocusEvent@ImGuiIO@@QEAAX_N@Z";
    AddInputCharacter :: (this: *IO, c: u32) -> void #cpp_method #foreign ImGui "?AddInputCharacter@ImGuiIO@@QEAAXI@Z";
    AddInputCharacterUTF16 :: (this: *IO, c: Wchar16) -> void #cpp_method #foreign ImGui "?AddInputCharacterUTF16@ImGuiIO@@QEAAXG@Z";
    AddInputCharactersUTF8 :: (this: *IO, str: *u8) -> void #cpp_method #foreign ImGui "?AddInputCharactersUTF8@ImGuiIO@@QEAAXPEBD@Z";

    SetKeyEventNativeData :: (this: *IO, key: Key, native_keycode: s32, native_scancode: s32, native_legacy_index: s32 = -1) -> void #cpp_method #foreign ImGui "?SetKeyEventNativeData@ImGuiIO@@QEAAXW4ImGuiKey@@HHH@Z";
    SetAppAcceptingEvents :: (this: *IO, accepting_events: bool) -> void #cpp_method #foreign ImGui "?SetAppAcceptingEvents@ImGuiIO@@QEAAX_N@Z";
    ClearEventsQueue :: (this: *IO) -> void #cpp_method #foreign ImGui "?ClearEventsQueue@ImGuiIO@@QEAAXXZ";
    ClearInputKeys :: (this: *IO) -> void #cpp_method #foreign ImGui "?ClearInputKeys@ImGuiIO@@QEAAXXZ";
    ClearInputMouse :: (this: *IO) -> void #cpp_method #foreign ImGui "?ClearInputMouse@ImGuiIO@@QEAAXXZ";

    WantCaptureMouse:                              bool; // Set when Dear ImGui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
    WantCaptureKeyboard:                           bool; // Set when Dear ImGui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. InputText active, or an imgui window is focused and navigation is enabled, etc.).
    WantTextInput:                                 bool; // Mobile/console: when set, you may display an on-screen keyboard. This is set by Dear ImGui when it wants textual keyboard input to happen (e.g. when a InputText widget is active).
    WantSetMousePos:                               bool; // MousePos has been altered, backend should reposition mouse on next frame. Rarely used! Set only when io.ConfigNavMoveSetMousePos is enabled.
    WantSaveIniSettings:                           bool; // When manual .ini load/save is active (io.IniFilename == NULL), this will be set to notify your application that you can call SaveIniSettingsToMemory() and save yourself. Important: clear io.WantSaveIniSettings yourself after saving!
    NavActive:                                     bool; // Keyboard/Gamepad navigation is currently allowed (will handle ImGuiKey_NavXXX events) = a window is focused and it doesn't use the ImGuiWindowFlags_NoNavInputs flag.
    NavVisible:                                    bool; // Keyboard/Gamepad navigation highlight is visible and allowed (will handle ImGuiKey_NavXXX events).
    Framerate:                                     float; // Estimate of application framerate (rolling average over 60 frames, based on io.DeltaTime), in frame per second. Solely for convenience. Slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
    MetricsRenderVertices:                         s32; // Vertices output during last call to Render()
    MetricsRenderIndices:                          s32; // Indices output during last call to Render() = number of triangles * 3
    MetricsRenderWindows:                          s32; // Number of visible windows
    MetricsActiveWindows:                          s32; // Number of active windows
    MouseDelta:                                    Vector2; // Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.

    Ctx:                                           *ImGuiContext; // Parent UI context (needs to be set explicitly by parent).

    MousePos:                                      Vector2; // Mouse position, in pixels. Set to ImVec2(-FLT_MAX, -FLT_MAX) if mouse is unavailable (on another screen, etc.)
    MouseDown:                                     [5] bool; // Mouse buttons: 0=left, 1=right, 2=middle + extras (ImGuiMouseButton_COUNT == 5). Dear ImGui mostly uses left and right buttons. Other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via IsMouse** API.
    MouseWheel:                                    float; // Mouse wheel Vertical: 1 unit scrolls about 5 lines text. >0 scrolls Up, <0 scrolls Down. Hold SHIFT to turn vertical scroll into horizontal scroll.
    MouseWheelH:                                   float; // Mouse wheel Horizontal. >0 scrolls Left, <0 scrolls Right. Most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
    MouseSource_:                                  MouseSource; // Mouse actual input peripheral (Mouse/TouchScreen/Pen).
    MouseHoveredViewport:                          ID; // (Optional) Modify using io.AddMouseViewportEvent(). With multi-viewports: viewport the OS mouse is hovering. If possible _IGNORING_ viewports with the ImGuiViewportFlags_NoInputs flag is much better (few backends can handle that). Set io.BackendFlags |= ImGuiBackendFlags_HasMouseHoveredViewport if you can provide this info. If you don't imgui will infer the value using the rectangles and last focused time of the viewports it knows about (ignoring other OS windows).
    KeyCtrl:                                       bool; // Keyboard modifier down: Ctrl (non-macOS), Cmd (macOS)
    KeyShift:                                      bool; // Keyboard modifier down: Shift
    KeyAlt:                                        bool; // Keyboard modifier down: Alt
    KeySuper:                                      bool; // Keyboard modifier down: Windows/Super (non-macOS), Ctrl (macOS)

    KeyMods:                                       KeyChord; // Key mods flags (any of ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Alt/ImGuiMod_Super flags, same as io.KeyCtrl/KeyShift/KeyAlt/KeySuper but merged into flags). Read-only, updated by NewFrame()
    KeysData:                                      [155] KeyData; // Key state for all known keys. MUST use 'key - ImGuiKey_NamedKey_BEGIN' as index. Use IsKeyXXX() functions to access this.
    WantCaptureMouseUnlessPopupClose:              bool; // Alternative to WantCaptureMouse: (WantCaptureMouse == true && WantCaptureMouseUnlessPopupClose == false) when a click over void is expected to close a popup.
    MousePosPrev:                                  Vector2; // Previous mouse position (note that MouseDelta is not necessary == MousePos-MousePosPrev, in case either position is invalid)
    MouseClickedPos:                               [5] Vector2; // Position at time of clicking
    MouseClickedTime:                              [5] float64; // Time of last click (used to figure out double-click)
    MouseClicked:                                  [5] bool; // Mouse button went from !Down to Down (same as MouseClickedCount[x] != 0)
    MouseDoubleClicked:                            [5] bool; // Has mouse button been double-clicked? (same as MouseClickedCount[x] == 2)
    MouseClickedCount:                             [5] U16; // == 0 (not clicked), == 1 (same as MouseClicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !Down to Down
    MouseClickedLastCount:                         [5] U16; // Count successive number of clicks. Stays valid after mouse release. Reset after another click is done.
    MouseReleased:                                 [5] bool; // Mouse button went from Down to !Down
    MouseReleasedTime:                             [5] float64; // Time of last released (rarely used! but useful to handle delayed single-click when trying to disambiguate them from double-click).
    MouseDownOwned:                                [5] bool; // Track if button was clicked inside a dear imgui window or over void blocked by a popup. We don't request mouse capture from the application if click started outside ImGui bounds.
    MouseDownOwnedUnlessPopupClose:                [5] bool; // Track if button was clicked inside a dear imgui window.
    MouseWheelRequestAxisSwap:                     bool; // On a non-Mac system, holding SHIFT requests WheelY to perform the equivalent of a WheelX event. On a Mac system this is already enforced by the system.
    MouseCtrlLeftAsRightClick:                     bool; // (OSX) Set to true when the current click was a Ctrl+click that spawned a simulated right click
    MouseDownDuration:                             [5] float; // Duration the mouse button has been down (0.0f == just clicked)
    MouseDownDurationPrev:                         [5] float; // Previous time the mouse button has been down
    MouseDragMaxDistanceAbs:                       [5] Vector2; // Maximum distance, absolute, on each axis, of how much mouse has traveled from the clicking point
    MouseDragMaxDistanceSqr:                       [5] float; // Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
    PenPressure:                                   float; // Touch/Pen pressure (0.0f to 1.0f, should be >0.0f only when MouseDown[0] == true). Helper storage currently unused by Dear ImGui.
    AppFocusLost:                                  bool; // Only modify via AddFocusEvent()
    AppAcceptingEvents:                            bool; // Only modify via SetAppAcceptingEvents()
    InputQueueSurrogate:                           Wchar16; // For AddInputCharacterUTF16()
    InputQueueCharacters:                          Vector(Wchar); // Queue of _characters_ input (obtained by platform backend). Fill using AddInputCharacter() helper.

    Constructor :: (this: *IO) -> void #cpp_method #foreign ImGui "??0ImGuiIO@@QEAA@XZ";
}

// Shared state of InputText(), passed as an argument to your callback when a ImGuiInputTextFlags_Callback* flag is used.
// The callback function should return 0 by default.
// Callbacks (follow a flag name and see comments in ImGuiInputTextFlags_ declarations for more details)
// - ImGuiInputTextFlags_CallbackEdit:        Callback on buffer edit. Note that InputText() already returns true on edit + you can always use IsItemEdited(). The callback is useful to manipulate the underlying buffer while focus is active.
// - ImGuiInputTextFlags_CallbackAlways:      Callback on each iteration
// - ImGuiInputTextFlags_CallbackCompletion:  Callback on pressing TAB
// - ImGuiInputTextFlags_CallbackHistory:     Callback on pressing Up/Down arrows
// - ImGuiInputTextFlags_CallbackCharFilter:  Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
// - ImGuiInputTextFlags_CallbackResize:      Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow.
InputTextCallbackData :: struct {
    Ctx:            *ImGuiContext; // Parent UI context
    EventFlag:      InputTextFlags; // One ImGuiInputTextFlags_Callback*    // Read-only
    Flags:          InputTextFlags; // What user passed to InputText()      // Read-only
    UserData:       *void; // What user passed to InputText()      // Read-only

    EventChar:      Wchar; // Character input                      // Read-write   // [CharFilter] Replace character with another one, or set to zero to drop. return 1 is equivalent to setting EventChar=0;
    EventKey:       Key; // Key pressed (Up/Down/TAB)            // Read-only    // [Completion,History]
    Buf:            *u8; // Text buffer                          // Read-write   // [Resize] Can replace pointer / [Completion,History,Always] Only write to pointed data, don't replace the actual pointer!
    BufTextLen:     s32; // Text length (in bytes)               // Read-write   // [Resize,Completion,History,Always] Exclude zero-terminator storage. In C land: == strlen(some_text), in C++ land: string.length()
    BufSize:        s32; // Buffer size (in bytes) = capacity+1  // Read-only    // [Resize,Completion,History,Always] Include zero-terminator storage. In C land: == ARRAYSIZE(my_char_array), in C++ land: string.capacity()+1
    BufDirty:       bool; // Set if you modify Buf/BufTextLen!    // Write        // [Completion,History,Always]
    CursorPos:      s32; //                                      // Read-write   // [Completion,History,Always]
    SelectionStart: s32; //                                      // Read-write   // [Completion,History,Always] == to SelectionEnd when no selection
    SelectionEnd:   s32; //                                      // Read-write   // [Completion,History,Always]

    // Helper functions for text manipulation.
    // Use those function to benefit from the CallbackResize behaviors. Calling those function reset the selection.
    Constructor :: (this: *InputTextCallbackData) -> void #cpp_method #foreign ImGui "??0ImGuiInputTextCallbackData@@QEAA@XZ";
    DeleteChars :: (this: *InputTextCallbackData, pos: s32, bytes_count: s32) -> void #cpp_method #foreign ImGui "?DeleteChars@ImGuiInputTextCallbackData@@QEAAXHH@Z";
    InsertChars :: (this: *InputTextCallbackData, pos: s32, text: *u8, text_end: *u8 = null) -> void #cpp_method #foreign ImGui "?InsertChars@ImGuiInputTextCallbackData@@QEAAXHPEBD0@Z";
    InsertChars :: (this: *InputTextCallbackData, pos: s32, text: string) #no_context {
        InsertChars(this, pos, text.data, text.data + text.count);
    }
    SelectAll :: (this: *InputTextCallbackData) -> void #cpp_method #foreign ImGui "?SelectAll@ImGuiInputTextCallbackData@@QEAAXXZ";
}

// Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
// NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
SizeCallbackData :: struct {
    UserData:    *void; // Read-only.   What user passed to SetNextWindowSizeConstraints(). Generally store an integer or float in here (need reinterpret_cast<>).
    Pos:         Vector2; // Read-only.   Window position, for reference.
    CurrentSize: Vector2; // Read-only.   Current window size.
    DesiredSize: Vector2; // Read-write.  Desired size, based on user's mouse position. Write to this field to restrain resizing.
}

// [ALPHA] Rarely used / very advanced uses only. Use with SetNextWindowClass() and DockSpace() functions.
// Important: the content of this class is still highly WIP and likely to change and be refactored
// before we stabilize Docking features. Please be mindful if using this.
// Provide hints:
// - To the platform backend via altered viewport flags (enable/disable OS decoration, OS task bar icons, etc.)
// - To the platform backend for OS level parent/child relationships of viewport.
// - To the docking system for various options and filtering.
WindowClass :: struct {
    ClassId:                    ID; // User data. 0 = Default class (unclassed). Windows of different classes cannot be docked with each others.
    ParentViewportId:           ID; // Hint for the platform backend. -1: use default. 0: request platform backend to not parent the platform. != 0: request platform backend to create a parent<>child relationship between the platform windows. Not conforming backends are free to e.g. parent every viewport to the main viewport or not.
    FocusRouteParentWindowId:   ID; // ID of parent window for shortcut focus route evaluation, e.g. Shortcut() call from Parent Window will succeed when this window is focused.
    ViewportFlagsOverrideSet:   ViewportFlags; // Viewport flags to set when a window of this class owns a viewport. This allows you to enforce OS decoration or task bar icon, override the defaults on a per-window basis.
    ViewportFlagsOverrideClear: ViewportFlags; // Viewport flags to clear when a window of this class owns a viewport. This allows you to enforce OS decoration or task bar icon, override the defaults on a per-window basis.
    TabItemFlagsOverrideSet:    TabItemFlags; // [EXPERIMENTAL] TabItem flags to set when a window of this class gets submitted into a dock node tab bar. May use with ImGuiTabItemFlags_Leading or ImGuiTabItemFlags_Trailing.
    DockNodeFlagsOverrideSet:   DockNodeFlags; // [EXPERIMENTAL] Dock node flags to set when a window of this class is hosted by a dock node (it doesn't have to be selected!)
    DockingAlwaysTabBar:        bool; // Set to true to enforce single floating windows of this class always having their own docking node (equivalent of setting the global io.ConfigDockingAlwaysTabBar)
    DockingAllowUnclassed:      bool; // Set to true to allow windows of this class to be docked/merged with an unclassed window. // FIXME-DOCK: Move to DockNodeFlags override?

    Constructor :: (this: *WindowClass) -> void #cpp_method #foreign ImGui "??0ImGuiWindowClass@@QEAA@XZ";
}

// Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
Payload :: struct {
    Data:           *void; // Data (copied and owned by dear imgui)
    DataSize:       s32; // Data size

    SourceId:       ID; // Source item id
    SourceParentId: ID; // Source parent id (if available)
    DataFrameCount: s32; // Data timestamp
    DataType:       [33] u8; // Data type tag (short user-supplied string, 32 characters max)
    Preview:        bool; // Set when AcceptDragDropPayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
    Delivery:       bool; // Set when AcceptDragDropPayload() was called and mouse button is released over the target item.

    Constructor :: (this: *Payload) -> void #cpp_method #foreign ImGui "??0ImGuiPayload@@QEAA@XZ";
    Clear :: (this: *Payload) -> void #cpp_method #foreign ImGui "?Clear@ImGuiPayload@@QEAAXXZ";
    IsDataType :: (this: *Payload, type: *u8) -> bool #cpp_method #foreign ImGui "?IsDataType@ImGuiPayload@@QEBA_NPEBD@Z";
    IsPreview :: (this: *Payload) -> bool #cpp_method #foreign ImGui "?IsPreview@ImGuiPayload@@QEBA_NXZ";
    IsDelivery :: (this: *Payload) -> bool #cpp_method #foreign ImGui "?IsDelivery@ImGuiPayload@@QEBA_NXZ";
}

// Helper: Execute a block of code at maximum once a frame. Convenient if you want to quickly create a UI within deep-nested code that runs multiple times every frame.
// Usage: static ImGuiOnceUponAFrame oaf; if (oaf) ImGui::Text("This will be called only once per frame");
OnceUponAFrame :: struct {
    RefFrame: s32;
}

// Helper: Parse and apply text filters. In format "aaaaa[,bbbb][,ccccc]"
TextFilter :: struct {
    Constructor :: (this: *TextFilter, default_filter: *u8 = "") -> void #cpp_method #foreign ImGui "??0ImGuiTextFilter@@QEAA@PEBD@Z";
    Draw :: (this: *TextFilter, label: *u8 = "Filter (inc,-exc)", width: float = 0.0) -> bool #cpp_method #foreign ImGui "?Draw@ImGuiTextFilter@@QEAA_NPEBDM@Z";
    PassFilter :: (this: *TextFilter, text: *u8, text_end: *u8 = null) -> bool #cpp_method #foreign ImGui "?PassFilter@ImGuiTextFilter@@QEBA_NPEBD0@Z";
    PassFilter :: (this: *TextFilter, text: string) -> bool #no_context {
        return PassFilter(this, text.data, text.data + text.count);
    }
    Build :: (this: *TextFilter) -> void #cpp_method #foreign ImGui "?Build@ImGuiTextFilter@@QEAAXXZ";
    Clear :: (this: *TextFilter) -> void #cpp_method #foreign ImGui "?Clear@ImGuiTextFilter@@QEAAXXZ";
    IsActive :: (this: *TextFilter) -> bool #cpp_method #foreign ImGui "?IsActive@ImGuiTextFilter@@QEBA_NXZ";

    // [Internal]
    ImGuiTextRange :: struct {
        b: *u8;
        e: *u8;

        Constructor :: (this: *ImGuiTextRange, _b: *u8, _e: *u8) -> void #cpp_method #foreign ImGui "??0ImGuiTextRange@ImGuiTextFilter@@QEAA@PEBD0@Z";
        empty :: (this: *ImGuiTextRange) -> bool #cpp_method #foreign ImGui "?empty@ImGuiTextRange@ImGuiTextFilter@@QEBA_NXZ";
        split :: (this: *ImGuiTextRange, separator: u8, out: *Vector(ImGuiTextRange)) -> void #cpp_method #foreign ImGui "?split@ImGuiTextRange@ImGuiTextFilter@@QEBAXDPEAU?$ImVector@UImGuiTextRange@ImGuiTextFilter@@@@@Z";
    }

    InputBuf:  [256] u8;
    Filters:   Vector(ImGuiTextRange);
    CountGrep: s32;
}

// Helper: Growable text buffer for logging/accumulating text
// (this could be called 'ImGuiTextBuilder' / 'ImGuiStringBuilder')
TextBuffer :: struct {
    Buf: Vector(u8);

    Constructor :: (this: *TextBuffer) -> void #cpp_method #foreign ImGui "??0ImGuiTextBuffer@@QEAA@XZ";

    begin :: (this: *TextBuffer) -> *u8 #cpp_method #foreign ImGui "?begin@ImGuiTextBuffer@@QEBAPEBDXZ";
    end :: (this: *TextBuffer) -> *u8 #cpp_method #foreign ImGui "?end@ImGuiTextBuffer@@QEBAPEBDXZ";
    size :: (this: *TextBuffer) -> s32 #cpp_method #foreign ImGui "?size@ImGuiTextBuffer@@QEBAHXZ";
    empty :: (this: *TextBuffer) -> bool #cpp_method #foreign ImGui "?empty@ImGuiTextBuffer@@QEBA_NXZ";
    clear :: (this: *TextBuffer) -> void #cpp_method #foreign ImGui "?clear@ImGuiTextBuffer@@QEAAXXZ";
    resize :: (this: *TextBuffer, size: s32) -> void #cpp_method #foreign ImGui "?resize@ImGuiTextBuffer@@QEAAXH@Z";
    reserve :: (this: *TextBuffer, capacity: s32) -> void #cpp_method #foreign ImGui "?reserve@ImGuiTextBuffer@@QEAAXH@Z";
    c_str :: (this: *TextBuffer) -> *u8 #cpp_method #foreign ImGui "?c_str@ImGuiTextBuffer@@QEBAPEBDXZ";
    append :: (this: *TextBuffer, str: *u8, str_end: *u8 = null) -> void #cpp_method #foreign ImGui "?append@ImGuiTextBuffer@@QEAAXPEBD0@Z";
    append :: (this: *TextBuffer, str: string) #no_context {
        append(this, str.data, str.data + str.count);
    }
    appendf_CFormat :: (this: *TextBuffer, fmt: *u8, __args: ..Any) -> void #cpp_method #foreign ImGui "?appendf@ImGuiTextBuffer@@QEAAXPEBDZZ";
    appendf :: (this: *TextBuffer, fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        appendf_CFormat(this, "%s", formatted_text.data);
    } @PrintLike
}

operator[] :: (this: *TextBuffer, i: s32) -> u8 #cpp_method #foreign ImGui "??AImGuiTextBuffer@@QEBADH@Z";
operator[] :: (this: TextBuffer, i: s32) -> u8 #no_context {
    return operator[](*this, i);
}

// [Internal] Key+Value for ImGuiStorage
StoragePair :: struct {
    key: ID;
    union {
        val_i: s32;
        val_f: float;
        val_p: *void;
    }
    Constructor :: (this: *StoragePair, _key: ID, _val: s32) -> void #cpp_method #foreign ImGui "??0ImGuiStoragePair@@QEAA@IH@Z";
    Constructor :: (this: *StoragePair, _key: ID, _val: float) -> void #cpp_method #foreign ImGui "??0ImGuiStoragePair@@QEAA@IM@Z";
    Constructor :: (this: *StoragePair, _key: ID, _val: *void) -> void #cpp_method #foreign ImGui "??0ImGuiStoragePair@@QEAA@IPEAX@Z";
}

// Helper: Key->Value storage
// Typically you don't have to worry about this since a storage is held within each Window.
// We use it to e.g. store collapse state for a tree (Int 0/1)
// This is optimized for efficient lookup (dichotomy into a contiguous buffer) and rare insertion (typically tied to user interactions aka max once a frame)
// You can use it as custom user storage for temporary values. Declare your own storage if, for example:
// - You want to manipulate the open/close state of a particular sub-tree in your interface (tree node uses Int 0/1 to store their state).
// - You want to store custom debug data easily without adding or editing structures in your code (probably not efficient, but convenient)
// Types are NOT stored, so it is up to you to make sure your Key don't collide with different types.
Storage :: struct {
    // [Internal]
    Data: Vector(StoragePair);

    // - Get***() functions find pair, never add/allocate. Pairs are sorted so a query is O(log N)
    // - Set***() functions find pair, insertion on demand if missing.
    // - Sorted insertion is costly, paid once. A typical frame shouldn't need to insert any new pair.
    Clear :: (this: *Storage) -> void #cpp_method #foreign ImGui "?Clear@ImGuiStorage@@QEAAXXZ";
    GetInt :: (this: *Storage, key: ID, default_val: s32 = 0) -> s32 #cpp_method #foreign ImGui "?GetInt@ImGuiStorage@@QEBAHIH@Z";
    SetInt :: (this: *Storage, key: ID, val: s32) -> void #cpp_method #foreign ImGui "?SetInt@ImGuiStorage@@QEAAXIH@Z";
    GetBool :: (this: *Storage, key: ID, default_val := false) -> bool #cpp_method #foreign ImGui "?GetBool@ImGuiStorage@@QEBA_NI_N@Z";
    SetBool :: (this: *Storage, key: ID, val: bool) -> void #cpp_method #foreign ImGui "?SetBool@ImGuiStorage@@QEAAXI_N@Z";
    GetFloat :: (this: *Storage, key: ID, default_val: float = 0.0) -> float #cpp_method #foreign ImGui "?GetFloat@ImGuiStorage@@QEBAMIM@Z";
    SetFloat :: (this: *Storage, key: ID, val: float) -> void #cpp_method #foreign ImGui "?SetFloat@ImGuiStorage@@QEAAXIM@Z";
    GetVoidPtr :: (this: *Storage, key: ID) -> *void #cpp_method #foreign ImGui "?GetVoidPtr@ImGuiStorage@@QEBAPEAXI@Z";
    SetVoidPtr :: (this: *Storage, key: ID, val: *void) -> void #cpp_method #foreign ImGui "?SetVoidPtr@ImGuiStorage@@QEAAXIPEAX@Z";

    // - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    // - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    // - A typical use case where this is convenient for quick hacking (e.g. add storage during a live Edit&Continue session if you can't modify existing struct)
    //      float* pvar = ImGui::GetFloatRef(key); ImGui::SliderFloat("var", pvar, 0, 100.0f); some_var += *pvar;
    GetIntRef :: (this: *Storage, key: ID, default_val: s32 = 0) -> *s32 #cpp_method #foreign ImGui "?GetIntRef@ImGuiStorage@@QEAAPEAHIH@Z";
    GetBoolRef :: (this: *Storage, key: ID, default_val := false) -> *bool #cpp_method #foreign ImGui "?GetBoolRef@ImGuiStorage@@QEAAPEA_NI_N@Z";
    GetFloatRef :: (this: *Storage, key: ID, default_val: float = 0.0) -> *float #cpp_method #foreign ImGui "?GetFloatRef@ImGuiStorage@@QEAAPEAMIM@Z";
    GetVoidPtrRef :: (this: *Storage, key: ID, default_val: *void = null) -> **void #cpp_method #foreign ImGui "?GetVoidPtrRef@ImGuiStorage@@QEAAPEAPEAXIPEAX@Z";

    // Advanced: for quicker full rebuild of a storage (instead of an incremental one), you may add all your contents and then sort once.
    BuildSortByKey :: (this: *Storage) -> void #cpp_method #foreign ImGui "?BuildSortByKey@ImGuiStorage@@QEAAXXZ";

    // Obsolete: use on your own storage if you know only integer are being stored (open/close all tree nodes)
    SetAllInt :: (this: *Storage, val: s32) -> void #cpp_method #foreign ImGui "?SetAllInt@ImGuiStorage@@QEAAXH@Z";
}

// Flags for ImGuiListClipper (currently not fully exposed in function calls: a future refactor will likely add this to ImGuiListClipper::Begin function equivalent)
ListClipperFlags :: enum_flags s32 {
    None                  :: 0x0;
    NoSetTableRowCounters :: 0x1;
}

// Helper: Manually clip large list of items.
// If you have lots evenly spaced items and you have random access to the list, you can perform coarse
// clipping based on visibility to only submit items that are in view.
// The clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped.
// (Dear ImGui already clip items based on their bounds but: it needs to first layout the item to do so, and generally
//  fetching/submitting your own data incurs additional cost. Coarse clipping using ImGuiListClipper allows you to easily
//  scale using lists with tens of thousands of items without a problem)
// Usage:
//   ImGuiListClipper clipper;
//   clipper.Begin(1000);         // We have 1000 elements, evenly spaced.
//   while (clipper.Step())
//       for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
//           ImGui::Text("line number %d", i);
// Generally what happens is:
// - Clipper lets you process the first element (DisplayStart = 0, DisplayEnd = 1) regardless of it being visible or not.
// - User code submit that one element.
// - Clipper can measure the height of the first element
// - Clipper calculate the actual range of elements to display based on the current clipping rectangle, position the cursor before the first visible element.
// - User code submit visible elements.
// - The clipper also handles various subtleties related to keyboard/gamepad navigation, wrapping etc.
ListClipper :: struct {
    Ctx:              *ImGuiContext; // Parent UI context
    DisplayStart:     s32; // First item to display, updated by each call to Step()
    DisplayEnd:       s32; // End of items to display (exclusive)
    ItemsCount:       s32; // [Internal] Number of items
    ItemsHeight:      float; // [Internal] Height of item after a first step and item submission can calculate it
    StartPosY:        float64; // [Internal] Cursor position at the time of Begin() or after table frozen rows are all processed
    StartSeekOffsetY: float64; // [Internal] Account for frozen rows in a table and initial loss of precision in very large windows.
    TempData:         *void; // [Internal] Internal data
    Flags:            ListClipperFlags; // [Internal] Flags, currently not yet well exposed.

    // items_count: Use INT_MAX if you don't know how many items you have (in which case the cursor won't be advanced in the final step, and you can call SeekCursorForItem() manually if you need)
    // items_height: Use -1.0f to be calculated automatically on first step. Otherwise pass in the distance between your items, typically GetTextLineHeightWithSpacing() or GetFrameHeightWithSpacing().
    Constructor :: (this: *ListClipper) -> void #cpp_method #foreign ImGui "??0ImGuiListClipper@@QEAA@XZ";
    Destructor :: (this: *ListClipper) -> void #cpp_method #foreign ImGui "??1ImGuiListClipper@@QEAA@XZ";
    Begin :: (this: *ListClipper, items_count: s32, items_height: float = -1.0) -> void #cpp_method #foreign ImGui "?Begin@ImGuiListClipper@@QEAAXHM@Z";
    End :: (this: *ListClipper) -> void #cpp_method #foreign ImGui "?End@ImGuiListClipper@@QEAAXXZ";
    Step :: (this: *ListClipper) -> bool #cpp_method #foreign ImGui "?Step@ImGuiListClipper@@QEAA_NXZ";

    // Call IncludeItemByIndex() or IncludeItemsByIndex() *BEFORE* first call to Step() if you need a range of items to not be clipped, regardless of their visibility.
    // (Due to alignment / padding of certain items it is possible that an extra item may be included on either end of the display range).
    IncludeItemByIndex :: (this: *ListClipper, item_index: s32) -> void #cpp_method #foreign ImGui "?IncludeItemByIndex@ImGuiListClipper@@QEAAXH@Z";
    IncludeItemsByIndex :: (this: *ListClipper, item_begin: s32, item_end: s32) -> void #cpp_method #foreign ImGui "?IncludeItemsByIndex@ImGuiListClipper@@QEAAXHH@Z";

    // Seek cursor toward given item. This is automatically called while stepping.
    // - The only reason to call this is: you can use ImGuiListClipper::Begin(INT_MAX) if you don't know item count ahead of time.
    // - In this case, after all steps are done, you'll want to call SeekCursorForItem(item_count).
    SeekCursorForItem :: (this: *ListClipper, item_index: s32) -> void #cpp_method #foreign ImGui "?SeekCursorForItem@ImGuiListClipper@@QEAAXH@Z";
}

// Flags for BeginMultiSelect()
MultiSelectFlags :: enum_flags s32 {
    None                  :: 0x0;
    SingleSelect          :: 0x1;
    NoSelectAll           :: 0x2;
    NoRangeSelect         :: 0x4;
    NoAutoSelect          :: 0x8;
    NoAutoClear           :: 0x10;
    NoAutoClearOnReselect :: 0x20;
    BoxSelect1d           :: 0x40;
    BoxSelect2d           :: 0x80;
    BoxSelectNoScroll     :: 0x100;
    ClearOnEscape         :: 0x200;
    ClearOnClickVoid      :: 0x400;
    ScopeWindow           :: 0x800;
    ScopeRect             :: 0x1000;
    SelectOnClick         :: 0x2000;
    SelectOnClickRelease  :: 0x4000;

    NavWrapX              :: 0x10000;
}

// Main IO structure returned by BeginMultiSelect()/EndMultiSelect().
// This mainly contains a list of selection requests.
// - Use 'Demo->Tools->Debug Log->Selection' to see requests as they happen.
// - Some fields are only useful if your list is dynamic and allows deletion (getting post-deletion focus/state right is shown in the demo)
// - Below: who reads/writes each fields? 'r'=read, 'w'=write, 'ms'=multi-select code, 'app'=application/user code.
MultiSelectIO :: struct {
    Requests:      Vector(SelectionRequest); //  ms:w, app:r     /  ms:w  app:r   // Requests to apply to your selection data.
    RangeSrcItem:  SelectionUserData; //  ms:w  app:r     /                // (If using clipper) Begin: Source item (often the first selected item) must never be clipped: use clipper.IncludeItemByIndex() to ensure it is submitted.
    NavIdItem:     SelectionUserData; //  ms:w, app:r     /                // (If using deletion) Last known SetNextItemSelectionUserData() value for NavId (if part of submitted items).
    NavIdSelected: bool; //  ms:w, app:r     /        app:r   // (If using deletion) Last known selection state for NavId (if part of submitted items).
    RangeSrcReset: bool; //        app:w     /  ms:r          // (If using deletion) Set before EndMultiSelect() to reset ResetSrcItem (e.g. if deleted selection).
    ItemsCount:    s32; //  ms:w, app:r     /        app:r   // 'int items_count' parameter to BeginMultiSelect() is copied here for convenience, allowing simpler calls to your ApplyRequests handler. Not used internally.
}

// Selection request type
SelectionRequestType :: enum s32 {
    None     :: 0;
    SetAll   :: 1;
    SetRange :: 2;
}

// Selection request item
SelectionRequest :: struct {
    Type:           SelectionRequestType; //  ms:w, app:r     /  ms:w, app:r   // Request type. You'll most often receive 1 Clear + 1 SetRange with a single-item range.
    Selected:       bool; //  ms:w, app:r     /  ms:w, app:r   // Parameter for SetAll/SetRange requests (true = select, false = unselect)
    RangeDirection: S8; //                  /  ms:w  app:r   // Parameter for SetRange request: +1 when RangeFirstItem comes before RangeLastItem, -1 otherwise. Useful if you want to preserve selection order on a backward Shift+Click.
    RangeFirstItem: SelectionUserData; //                  /  ms:w, app:r   // Parameter for SetRange request (this is generally == RangeSrcItem when shift selecting from top to bottom).
    RangeLastItem:  SelectionUserData; //                  /  ms:w, app:r   // Parameter for SetRange request (this is generally == RangeSrcItem when shift selecting from bottom to top). Inclusive!
}

// Optional helper to store multi-selection state + apply multi-selection requests.
// - Used by our demos and provided as a convenience to easily implement basic multi-selection.
// - Iterate selection with 'void* it = NULL; ImGuiID id; while (selection.GetNextSelectedItem(&it, &id)) { ... }'
//   Or you can check 'if (Contains(id)) { ... }' for each possible object if their number is not too high to iterate.
// - USING THIS IS NOT MANDATORY. This is only a helper and not a required API.
// To store a multi-selection, in your application you could:
// - Use this helper as a convenience. We use our simple key->value ImGuiStorage as a std::set<ImGuiID> replacement.
// - Use your own external storage: e.g. std::set<MyObjectId>, std::vector<MyObjectId>, interval trees, intrusively stored selection etc.
// In ImGuiSelectionBasicStorage we:
// - always use indices in the multi-selection API (passed to SetNextItemSelectionUserData(), retrieved in ImGuiMultiSelectIO)
// - use the AdapterIndexToStorageId() indirection layer to abstract how persistent selection data is derived from an index.
// - use decently optimized logic to allow queries and insertion of very large selection sets.
// - do not preserve selection order.
// Many combinations are possible depending on how you prefer to store your items and how you prefer to store your selection.
// Large applications are likely to eventually want to get rid of this indirection layer and do their own thing.
// See https://github.com/ocornut/imgui/wiki/Multi-Select for details and pseudo-code using this helper.
SelectionBasicStorage :: struct {
    Size:                    s32; //          // Number of selected items, maintained by this helper.
    PreserveOrder:           bool; // = false  // GetNextSelectedItem() will return ordered selection (currently implemented by two additional sorts of selection. Could be improved)
    UserData:                *void; // = NULL   // User data for use by adapter function        // e.g. selection.UserData = (void*)my_items;
    AdapterIndexToStorageId: #type (self: *SelectionBasicStorage, idx: s32) -> ID #c_call; // e.g. selection.AdapterIndexToStorageId = [](ImGuiSelectionBasicStorage* self, int idx) { return ((MyItems**)self->UserData)[idx]->ID; };
    _SelectionOrder:         s32; // [Internal] Increasing counter to store selection order
    _Storage:                Storage; // [Internal] Selection set. Think of this as similar to e.g. std::set<ImGuiID>. Prefer not accessing directly: iterate with GetNextSelectedItem().

    // Methods
    Constructor :: (this: *SelectionBasicStorage) -> void #cpp_method #foreign ImGui "??0ImGuiSelectionBasicStorage@@QEAA@XZ";
    ApplyRequests :: (this: *SelectionBasicStorage, ms_io: *MultiSelectIO) -> void #cpp_method #foreign ImGui "?ApplyRequests@ImGuiSelectionBasicStorage@@QEAAXPEAUImGuiMultiSelectIO@@@Z";
    Contains :: (this: *SelectionBasicStorage, id: ID) -> bool #cpp_method #foreign ImGui "?Contains@ImGuiSelectionBasicStorage@@QEBA_NI@Z";
    Clear :: (this: *SelectionBasicStorage) -> void #cpp_method #foreign ImGui "?Clear@ImGuiSelectionBasicStorage@@QEAAXXZ";
    Swap :: (this: *SelectionBasicStorage, r: *SelectionBasicStorage) -> void #cpp_method #foreign ImGui "?Swap@ImGuiSelectionBasicStorage@@QEAAXAEAU1@@Z";
    SetItemSelected :: (this: *SelectionBasicStorage, id: ID, selected: bool) -> void #cpp_method #foreign ImGui "?SetItemSelected@ImGuiSelectionBasicStorage@@QEAAXI_N@Z";
    GetNextSelectedItem :: (this: *SelectionBasicStorage, opaque_it: **void, out_id: *ID) -> bool #cpp_method #foreign ImGui "?GetNextSelectedItem@ImGuiSelectionBasicStorage@@QEAA_NPEAPEAXPEAI@Z";
    GetStorageIdFromIndex :: (this: *SelectionBasicStorage, idx: s32) -> ID #cpp_method #foreign ImGui "?GetStorageIdFromIndex@ImGuiSelectionBasicStorage@@QEAAIH@Z";
}

// Optional helper to apply multi-selection requests to existing randomly accessible storage.
// Convenient if you want to quickly wire multi-select API on e.g. an array of bool or items storing their own selection state.
SelectionExternalStorage :: struct {
    UserData:               *void; // User data for use by adapter function                                // e.g. selection.UserData = (void*)my_items;
    AdapterSetItemSelected: #type (self: *SelectionExternalStorage, idx: s32, selected: bool) -> void #c_call; // e.g. AdapterSetItemSelected = [](ImGuiSelectionExternalStorage* self, int idx, bool selected) { ((MyItems**)self->UserData)[idx]->Selected = selected; }

    // Methods
    Constructor :: (this: *SelectionExternalStorage) -> void #cpp_method #foreign ImGui "??0ImGuiSelectionExternalStorage@@QEAA@XZ";
    ApplyRequests :: (this: *SelectionExternalStorage, ms_io: *MultiSelectIO) -> void #cpp_method #foreign ImGui "?ApplyRequests@ImGuiSelectionExternalStorage@@QEAAXPEAUImGuiMultiSelectIO@@@Z";
}

DrawIdx :: u16;

// Typically, 1 command = 1 GPU draw call (unless command is a callback)
// - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
//   this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
//   Backends made for <1.71. will typically ignore the VtxOffset fields.
// - The ClipRect/TexRef/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
DrawCmd :: struct {
    ClipRect:               Vector4; // 4*4  // Clipping rectangle (x1, y1, x2, y2). Subtract ImDrawData->DisplayPos to get clipping rectangle in "viewport" coordinates
    TexRef:                 TextureRef; // 16   // Reference to a font/texture atlas (where backend called ImTextureData::SetTexID()) or to a user-provided texture ID (via e.g. ImGui::Image() calls). Both will lead to a ImTextureID value.
    VtxOffset:              u32; // 4    // Start offset in vertex buffer. ImGuiBackendFlags_RendererHasVtxOffset: always 0, otherwise may be >0 to support meshes larger than 64K vertices with 16-bit indices.
    IdxOffset:              u32; // 4    // Start offset in index buffer.
    ElemCount:              u32; // 4    // Number of indices (multiple of 3) to be rendered as triangles. Vertices are stored in the callee ImDrawList's vtx_buffer[] array, indices in idx_buffer[].
    UserCallback:           DrawCallback; // 4-8  // If != NULL, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
    UserCallbackData:       *void; // 4-8  // Callback user data (when UserCallback != NULL). If called AddCallback() with size == 0, this is a copy of the AddCallback() argument. If called AddCallback() with size > 0, this is pointing to a buffer where data is stored.
    UserCallbackDataSize:   s32; // 4 // Size of callback user data when using storage, otherwise 0.
    UserCallbackDataOffset: s32; // 4 // [Internal] Offset of callback user data when using storage, otherwise -1.

    Constructor :: (this: *DrawCmd) -> void #cpp_method #foreign ImGui "??0ImDrawCmd@@QEAA@XZ";
}

DrawVert :: struct {
    pos: Vector2;
    uv:  Vector2;
    col: U32;
}

// [Internal] For use by ImDrawList
DrawCmdHeader :: struct {
    ClipRect:  Vector4;
    TexRef:    TextureRef;
    VtxOffset: u32;
}

// Forward declarations: ImDrawList, ImFontAtlas layer
DrawChannel :: struct {
    _CmdBuffer: Vector(DrawCmd);
    _IdxBuffer: Vector(DrawIdx);
}

// Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
// This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
DrawListSplitter :: struct {
    _Current:  s32; // Current channel number (0)
    _Count:    s32; // Number of active channels (1+)
    _Channels: Vector(DrawChannel); // Draw channels (not resized down so _Count might be < Channels.Size)

    Constructor :: (this: *DrawListSplitter) -> void #cpp_method #foreign ImGui "??0ImDrawListSplitter@@QEAA@XZ";
    Destructor :: (this: *DrawListSplitter) -> void #cpp_method #foreign ImGui "??1ImDrawListSplitter@@QEAA@XZ";
    Clear :: (this: *DrawListSplitter) -> void #cpp_method #foreign ImGui "?Clear@ImDrawListSplitter@@QEAAXXZ";
    ClearFreeMemory :: (this: *DrawListSplitter) -> void #cpp_method #foreign ImGui "?ClearFreeMemory@ImDrawListSplitter@@QEAAXXZ";
    Split :: (this: *DrawListSplitter, draw_list: *DrawList, count: s32) -> void #cpp_method #foreign ImGui "?Split@ImDrawListSplitter@@QEAAXPEAUImDrawList@@H@Z";
    Merge :: (this: *DrawListSplitter, draw_list: *DrawList) -> void #cpp_method #foreign ImGui "?Merge@ImDrawListSplitter@@QEAAXPEAUImDrawList@@@Z";
    SetCurrentChannel :: (this: *DrawListSplitter, draw_list: *DrawList, channel_idx: s32) -> void #cpp_method #foreign ImGui "?SetCurrentChannel@ImDrawListSplitter@@QEAAXPEAUImDrawList@@H@Z";
}

// Flags for ImDrawList functions
// (Legacy: bit 0 must always correspond to ImDrawFlags_Closed to be backward compatible with old API using a bool. Bits 1..3 must be unused)
DrawFlags :: enum_flags s32 {
    None                    :: 0x0;
    Closed                  :: 0x1;
    RoundCornersTopLeft     :: 0x10;
    RoundCornersTopRight    :: 0x20;
    RoundCornersBottomLeft  :: 0x40;
    RoundCornersBottomRight :: 0x80;
    RoundCornersNone        :: 0x100;
    RoundCornersTop         :: 0x30;
    RoundCornersBottom      :: 0xc0;
    RoundCornersLeft        :: 0x50;
    RoundCornersRight       :: 0xa0;
    RoundCornersAll         :: 0xf0;
    RoundCornersDefault_    :: 0xf0;
    RoundCornersMask_       :: 0x1f0;
}

// Flags for ImDrawList instance. Those are set automatically by ImGui:: functions from ImGuiIO settings, and generally not manipulated directly.
// It is however possible to temporarily alter flags between calls to ImDrawList:: functions.
DrawListFlags :: enum_flags s32 {
    None                   :: 0x0;
    AntiAliasedLines       :: 0x1;
    AntiAliasedLinesUseTex :: 0x2;
    AntiAliasedFill        :: 0x4;
    AllowVtxOffset         :: 0x8;
}

// Draw command list
// This is the low-level list of polygons that ImGui:: functions are filling. At the end of the frame,
// all command lists are passed to your ImGuiIO::RenderDrawListFn function for rendering.
// Each dear imgui window contains its own ImDrawList. You can use ImGui::GetWindowDrawList() to
// access the current window draw list and draw custom primitives.
// You can interleave normal ImGui:: calls and adding primitives to the current draw list.
// In single viewport mode, top-left is == GetMainViewport()->Pos (generally 0,0), bottom-right is == GetMainViewport()->Pos+Size (generally io.DisplaySize).
// You are totally free to apply whatever transformation matrix you want to the data (depending on the use of the transformation you may want to apply it to ClipRect as well!)
// Important: Primitives are always added to the list and not culled (culling is done at higher-level by ImGui:: functions), if you use this API a lot consider coarse culling your drawn objects.
DrawList :: struct {
    CmdBuffer:         Vector(DrawCmd); // Draw commands. Typically 1 command = 1 GPU draw call, unless the command is a callback.
    IdxBuffer:         Vector(DrawIdx); // Index buffer. Each command consume ImDrawCmd::ElemCount of those
    VtxBuffer:         Vector(DrawVert); // Vertex buffer.
    Flags:             DrawListFlags; // Flags, you may poke into these to adjust anti-aliasing settings per-primitive.

    _VtxCurrentIdx:    u32; // [Internal] generally == VtxBuffer.Size unless we are past 64K vertices, in which case this gets reset to 0.
    _Data:             *DrawListSharedData; // Pointer to shared draw data (you can use ImGui::GetDrawListSharedData() to get the one from current ImGui context)
    _VtxWritePtr:      *DrawVert; // [Internal] point within VtxBuffer.Data after each add command (to avoid using the ImVector<> operators too much)
    _IdxWritePtr:      *DrawIdx; // [Internal] point within IdxBuffer.Data after each add command (to avoid using the ImVector<> operators too much)
    _Path:             Vector(Vector2); // [Internal] current path building
    _CmdHeader:        DrawCmdHeader; // [Internal] template of active commands. Fields should match those of CmdBuffer.back().
    _Splitter:         DrawListSplitter; // [Internal] for channels api (note: prefer using your own persistent instance of ImDrawListSplitter!)
    _ClipRectStack:    Vector(Vector4); // [Internal]
    _TextureStack:     Vector(TextureRef); // [Internal]
    _CallbacksDataBuf: Vector(U8); // [Internal]
    _FringeScale:      float; // [Internal] anti-alias fringe is scaled by this value, this helps to keep things sharp while zooming at vertex buffer content
    _OwnerName:        *u8; // Pointer to owner window's name for debugging

    // If you want to create ImDrawList instances, pass them ImGui::GetDrawListSharedData().
    // (advanced: you may create and use your own ImDrawListSharedData so you can use ImDrawList without ImGui, but that's more involved)
    Constructor :: (this: *DrawList, shared_data: *DrawListSharedData) -> void #cpp_method #foreign ImGui "??0ImDrawList@@QEAA@PEAUImDrawListSharedData@@@Z";
    Destructor :: (this: *DrawList) -> void #cpp_method #foreign ImGui "??1ImDrawList@@QEAA@XZ";

    PushClipRect :: (this: *DrawList, clip_rect_min: *Vector2, clip_rect_max: *Vector2, intersect_with_current_clip_rect := false) -> void #cpp_method #foreign ImGui "?PushClipRect@ImDrawList@@QEAAXAEBUImVec2@@0_N@Z";
    PushClipRect :: (this: *DrawList, clip_rect_min: Vector2, clip_rect_max: Vector2, intersect_with_current_clip_rect := false) #no_context {
        PushClipRect(this, *clip_rect_min, *clip_rect_max, intersect_with_current_clip_rect);
    }
    PushClipRectFullScreen :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?PushClipRectFullScreen@ImDrawList@@QEAAXXZ";
    PopClipRect :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?PopClipRect@ImDrawList@@QEAAXXZ";
    PushTexture :: (this: *DrawList, tex_ref: TextureRef) -> void #cpp_method #foreign ImGui "?PushTexture@ImDrawList@@QEAAXUImTextureRef@@@Z";
    PopTexture :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?PopTexture@ImDrawList@@QEAAXXZ";

    // Primitives
    // - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    // - For rectangular primitives, "p_min" and "p_max" represent the upper-left and lower-right corners.
    // - For circle primitives, use "num_segments == 0" to automatically calculate tessellation (preferred).
    //   In older versions (until Dear ImGui 1.77) the AddCircle functions defaulted to num_segments == 12.
    //   In future versions we will use textures to provide cheaper and higher-quality circles.
    //   Use AddNgon() and AddNgonFilled() functions if you need to guarantee a specific number of sides.
    AddLine :: (this: *DrawList, p1: *Vector2, p2: *Vector2, col: U32, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddLine@ImDrawList@@QEAAXAEBUImVec2@@0IM@Z";
    AddLine :: (this: *DrawList, p1: Vector2, p2: Vector2, col: U32, thickness: float = 1.0) #no_context {
        AddLine(this, *p1, *p2, col, thickness);
    }
    AddRect :: (this: *DrawList, p_min: *Vector2, p_max: *Vector2, col: U32, rounding: float = 0.0, flags: DrawFlags = .None, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddRect@ImDrawList@@QEAAXAEBUImVec2@@0IMHM@Z";
    AddRect :: (this: *DrawList, p_min: Vector2, p_max: Vector2, col: U32, rounding: float = 0.0, flags: DrawFlags = .None, thickness: float = 1.0) #no_context {
        AddRect(this, *p_min, *p_max, col, rounding, flags, thickness);
    }
    AddRectFilled :: (this: *DrawList, p_min: *Vector2, p_max: *Vector2, col: U32, rounding: float = 0.0, flags: DrawFlags = .None) -> void #cpp_method #foreign ImGui "?AddRectFilled@ImDrawList@@QEAAXAEBUImVec2@@0IMH@Z";
    AddRectFilled :: (this: *DrawList, p_min: Vector2, p_max: Vector2, col: U32, rounding: float = 0.0, flags: DrawFlags = .None) #no_context {
        AddRectFilled(this, *p_min, *p_max, col, rounding, flags);
    }
    AddRectFilledMultiColor :: (this: *DrawList, p_min: *Vector2, p_max: *Vector2, col_upr_left: U32, col_upr_right: U32, col_bot_right: U32, col_bot_left: U32) -> void #cpp_method #foreign ImGui "?AddRectFilledMultiColor@ImDrawList@@QEAAXAEBUImVec2@@0IIII@Z";
    AddRectFilledMultiColor :: (this: *DrawList, p_min: Vector2, p_max: Vector2, col_upr_left: U32, col_upr_right: U32, col_bot_right: U32, col_bot_left: U32) #no_context {
        AddRectFilledMultiColor(this, *p_min, *p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left);
    }
    AddQuad :: (this: *DrawList, p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, col: U32, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddQuad@ImDrawList@@QEAAXAEBUImVec2@@000IM@Z";
    AddQuad :: (this: *DrawList, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: U32, thickness: float = 1.0) #no_context {
        AddQuad(this, *p1, *p2, *p3, *p4, col, thickness);
    }
    AddQuadFilled :: (this: *DrawList, p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?AddQuadFilled@ImDrawList@@QEAAXAEBUImVec2@@000I@Z";
    AddQuadFilled :: (this: *DrawList, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: U32) #no_context {
        AddQuadFilled(this, *p1, *p2, *p3, *p4, col);
    }
    AddTriangle :: (this: *DrawList, p1: *Vector2, p2: *Vector2, p3: *Vector2, col: U32, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddTriangle@ImDrawList@@QEAAXAEBUImVec2@@00IM@Z";
    AddTriangle :: (this: *DrawList, p1: Vector2, p2: Vector2, p3: Vector2, col: U32, thickness: float = 1.0) #no_context {
        AddTriangle(this, *p1, *p2, *p3, col, thickness);
    }
    AddTriangleFilled :: (this: *DrawList, p1: *Vector2, p2: *Vector2, p3: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?AddTriangleFilled@ImDrawList@@QEAAXAEBUImVec2@@00I@Z";
    AddTriangleFilled :: (this: *DrawList, p1: Vector2, p2: Vector2, p3: Vector2, col: U32) #no_context {
        AddTriangleFilled(this, *p1, *p2, *p3, col);
    }
    AddCircle :: (this: *DrawList, center: *Vector2, radius: float, col: U32, num_segments: s32 = 0, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddCircle@ImDrawList@@QEAAXAEBUImVec2@@MIHM@Z";
    AddCircle :: (this: *DrawList, center: Vector2, radius: float, col: U32, num_segments: s32 = 0, thickness: float = 1.0) #no_context {
        AddCircle(this, *center, radius, col, num_segments, thickness);
    }
    AddCircleFilled :: (this: *DrawList, center: *Vector2, radius: float, col: U32, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?AddCircleFilled@ImDrawList@@QEAAXAEBUImVec2@@MIH@Z";
    AddCircleFilled :: (this: *DrawList, center: Vector2, radius: float, col: U32, num_segments: s32 = 0) #no_context {
        AddCircleFilled(this, *center, radius, col, num_segments);
    }
    AddNgon :: (this: *DrawList, center: *Vector2, radius: float, col: U32, num_segments: s32, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddNgon@ImDrawList@@QEAAXAEBUImVec2@@MIHM@Z";
    AddNgon :: (this: *DrawList, center: Vector2, radius: float, col: U32, num_segments: s32, thickness: float = 1.0) #no_context {
        AddNgon(this, *center, radius, col, num_segments, thickness);
    }
    AddNgonFilled :: (this: *DrawList, center: *Vector2, radius: float, col: U32, num_segments: s32) -> void #cpp_method #foreign ImGui "?AddNgonFilled@ImDrawList@@QEAAXAEBUImVec2@@MIH@Z";
    AddNgonFilled :: (this: *DrawList, center: Vector2, radius: float, col: U32, num_segments: s32) #no_context {
        AddNgonFilled(this, *center, radius, col, num_segments);
    }
    AddEllipse :: (this: *DrawList, center: *Vector2, radius: *Vector2, col: U32, rot: float = 0.0, num_segments: s32 = 0, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?AddEllipse@ImDrawList@@QEAAXAEBUImVec2@@0IMHM@Z";
    AddEllipse :: (this: *DrawList, center: Vector2, radius: Vector2, col: U32, rot: float = 0.0, num_segments: s32 = 0, thickness: float = 1.0) #no_context {
        AddEllipse(this, *center, *radius, col, rot, num_segments, thickness);
    }
    AddEllipseFilled :: (this: *DrawList, center: *Vector2, radius: *Vector2, col: U32, rot: float = 0.0, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?AddEllipseFilled@ImDrawList@@QEAAXAEBUImVec2@@0IMH@Z";
    AddEllipseFilled :: (this: *DrawList, center: Vector2, radius: Vector2, col: U32, rot: float = 0.0, num_segments: s32 = 0) #no_context {
        AddEllipseFilled(this, *center, *radius, col, rot, num_segments);
    }
    AddText :: (this: *DrawList, pos: *Vector2, col: U32, text_begin: *u8, text_end: *u8 = null) -> void #cpp_method #foreign ImGui "?AddText@ImDrawList@@QEAAXAEBUImVec2@@IPEBD1@Z";
    AddText :: (this: *DrawList, pos: Vector2, col: U32, text: string) #no_context {
        AddText(this, *pos, col, text.data, text.data + text.count);
    }
    AddText :: (this: *DrawList, font: *Font, font_size: float, pos: *Vector2, col: U32, text_begin: *u8, text_end: *u8 = null, wrap_width: float = 0.0, cpu_fine_clip_rect: *Vector4 = null) -> void #cpp_method #foreign ImGui "?AddText@ImDrawList@@QEAAXPEAUImFont@@MAEBUImVec2@@IPEBD2MPEBUImVec4@@@Z";
    AddText :: (this: *DrawList, font: *Font, font_size: float, pos: Vector2, col: U32, text: string, wrap_width: float = 0.0, cpu_fine_clip_rect: *Vector4 = null) #no_context {
        AddText(this, font, font_size, *pos, col, text.data, text.data + text.count, wrap_width, cpu_fine_clip_rect);
    }
    AddBezierCubic :: (this: *DrawList, p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, col: U32, thickness: float, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?AddBezierCubic@ImDrawList@@QEAAXAEBUImVec2@@000IMH@Z";
    AddBezierCubic :: (this: *DrawList, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: U32, thickness: float, num_segments: s32 = 0) #no_context {
        AddBezierCubic(this, *p1, *p2, *p3, *p4, col, thickness, num_segments);
    }
    AddBezierQuadratic :: (this: *DrawList, p1: *Vector2, p2: *Vector2, p3: *Vector2, col: U32, thickness: float, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?AddBezierQuadratic@ImDrawList@@QEAAXAEBUImVec2@@00IMH@Z";
    AddBezierQuadratic :: (this: *DrawList, p1: Vector2, p2: Vector2, p3: Vector2, col: U32, thickness: float, num_segments: s32 = 0) #no_context {
        AddBezierQuadratic(this, *p1, *p2, *p3, col, thickness, num_segments);
    }

    // General polygon
    // - Only simple polygons are supported by filling functions (no self-intersections, no holes).
    // - Concave polygon fill is more expensive than convex one: it has O(N^2) complexity. Provided as a convenience for the user but not used by the main library.
    AddPolyline :: (this: *DrawList, points: *Vector2, num_points: s32, col: U32, flags: DrawFlags, thickness: float) -> void #cpp_method #foreign ImGui "?AddPolyline@ImDrawList@@QEAAXPEBUImVec2@@HIHM@Z";
    AddConvexPolyFilled :: (this: *DrawList, points: *Vector2, num_points: s32, col: U32) -> void #cpp_method #foreign ImGui "?AddConvexPolyFilled@ImDrawList@@QEAAXPEBUImVec2@@HI@Z";
    AddConcavePolyFilled :: (this: *DrawList, points: *Vector2, num_points: s32, col: U32) -> void #cpp_method #foreign ImGui "?AddConcavePolyFilled@ImDrawList@@QEAAXPEBUImVec2@@HI@Z";

    // Image primitives
    // - Read FAQ to understand what ImTextureID/ImTextureRef are.
    // - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
    // - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
    AddImage :: (this: *DrawList, tex_ref: TextureRef, p_min: *Vector2, p_max: *Vector2, uv_min: *Vector2, uv_max: *Vector2, col: U32 = 4294967295) -> void #cpp_method #foreign ImGui "?AddImage@ImDrawList@@QEAAXUImTextureRef@@AEBUImVec2@@111I@Z";
    AddImage :: (this: *DrawList, tex_ref: TextureRef, p_min: Vector2, p_max: Vector2, uv_min: Vector2 = .{0, 0}, uv_max: Vector2 = .{1, 1}, col: U32 = 4294967295) #no_context {
        AddImage(this, tex_ref, *p_min, *p_max, *uv_min, *uv_max, col);
    }
    AddImageQuad :: (this: *DrawList, tex_ref: TextureRef, p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, uv1: *Vector2, uv2: *Vector2, uv3: *Vector2, uv4: *Vector2, col: U32 = 4294967295) -> void #cpp_method #foreign ImGui "?AddImageQuad@ImDrawList@@QEAAXUImTextureRef@@AEBUImVec2@@1111111I@Z";
    AddImageQuad :: (this: *DrawList, tex_ref: TextureRef, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, uv1: Vector2 = .{0, 0}, uv2: Vector2 = .{1, 0}, uv3: Vector2 = .{1, 1}, uv4: Vector2 = .{0, 1}, col: U32 = 4294967295) #no_context {
        AddImageQuad(this, tex_ref, *p1, *p2, *p3, *p4, *uv1, *uv2, *uv3, *uv4, col);
    }
    AddImageRounded :: (this: *DrawList, tex_ref: TextureRef, p_min: *Vector2, p_max: *Vector2, uv_min: *Vector2, uv_max: *Vector2, col: U32, rounding: float, flags: DrawFlags = .None) -> void #cpp_method #foreign ImGui "?AddImageRounded@ImDrawList@@QEAAXUImTextureRef@@AEBUImVec2@@111IMH@Z";
    AddImageRounded :: (this: *DrawList, tex_ref: TextureRef, p_min: Vector2, p_max: Vector2, uv_min: Vector2, uv_max: Vector2, col: U32, rounding: float, flags: DrawFlags = .None) #no_context {
        AddImageRounded(this, tex_ref, *p_min, *p_max, *uv_min, *uv_max, col, rounding, flags);
    }

    PathLineTo :: (this: *DrawList, pos: *Vector2) -> void #cpp_method #foreign ImGui "?PathLineTo@ImDrawList@@QEAAXAEBUImVec2@@@Z";
    PathLineTo :: (this: *DrawList, pos: Vector2) #no_context {
        PathLineTo(this, *pos);
    }

    PathFillConvex :: (this: *DrawList, col: U32) -> void #cpp_method #foreign ImGui "?PathFillConvex@ImDrawList@@QEAAXI@Z";
    PathFillConcave :: (this: *DrawList, col: U32) -> void #cpp_method #foreign ImGui "?PathFillConcave@ImDrawList@@QEAAXI@Z";
    PathStroke :: (this: *DrawList, col: U32, flags: DrawFlags = .None, thickness: float = 1.0) -> void #cpp_method #foreign ImGui "?PathStroke@ImDrawList@@QEAAXIHM@Z";
    PathArcTo :: (this: *DrawList, center: *Vector2, radius: float, a_min: float, a_max: float, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?PathArcTo@ImDrawList@@QEAAXAEBUImVec2@@MMMH@Z";
    PathArcTo :: (this: *DrawList, center: Vector2, radius: float, a_min: float, a_max: float, num_segments: s32 = 0) #no_context {
        PathArcTo(this, *center, radius, a_min, a_max, num_segments);
    }
    PathArcToFast :: (this: *DrawList, center: *Vector2, radius: float, a_min_of_12: s32, a_max_of_12: s32) -> void #cpp_method #foreign ImGui "?PathArcToFast@ImDrawList@@QEAAXAEBUImVec2@@MHH@Z";
    PathArcToFast :: (this: *DrawList, center: Vector2, radius: float, a_min_of_12: s32, a_max_of_12: s32) #no_context {
        PathArcToFast(this, *center, radius, a_min_of_12, a_max_of_12);
    }
    PathEllipticalArcTo :: (this: *DrawList, center: *Vector2, radius: *Vector2, rot: float, a_min: float, a_max: float, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?PathEllipticalArcTo@ImDrawList@@QEAAXAEBUImVec2@@0MMMH@Z";
    PathEllipticalArcTo :: (this: *DrawList, center: Vector2, radius: Vector2, rot: float, a_min: float, a_max: float, num_segments: s32 = 0) #no_context {
        PathEllipticalArcTo(this, *center, *radius, rot, a_min, a_max, num_segments);
    }
    PathBezierCubicCurveTo :: (this: *DrawList, p2: *Vector2, p3: *Vector2, p4: *Vector2, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?PathBezierCubicCurveTo@ImDrawList@@QEAAXAEBUImVec2@@00H@Z";
    PathBezierCubicCurveTo :: (this: *DrawList, p2: Vector2, p3: Vector2, p4: Vector2, num_segments: s32 = 0) #no_context {
        PathBezierCubicCurveTo(this, *p2, *p3, *p4, num_segments);
    }
    PathBezierQuadraticCurveTo :: (this: *DrawList, p2: *Vector2, p3: *Vector2, num_segments: s32 = 0) -> void #cpp_method #foreign ImGui "?PathBezierQuadraticCurveTo@ImDrawList@@QEAAXAEBUImVec2@@0H@Z";
    PathBezierQuadraticCurveTo :: (this: *DrawList, p2: Vector2, p3: Vector2, num_segments: s32 = 0) #no_context {
        PathBezierQuadraticCurveTo(this, *p2, *p3, num_segments);
    }
    PathRect :: (this: *DrawList, rect_min: *Vector2, rect_max: *Vector2, rounding: float = 0.0, flags: DrawFlags = .None) -> void #cpp_method #foreign ImGui "?PathRect@ImDrawList@@QEAAXAEBUImVec2@@0MH@Z";
    PathRect :: (this: *DrawList, rect_min: Vector2, rect_max: Vector2, rounding: float = 0.0, flags: DrawFlags = .None) #no_context {
        PathRect(this, *rect_min, *rect_max, rounding, flags);
    }

    // Advanced: Draw Callbacks
    // - May be used to alter render state (change sampler, blending, current shader). May be used to emit custom rendering commands (difficult to do correctly, but possible).
    // - Use special ImDrawCallback_ResetRenderState callback to instruct backend to reset its render state to the default.
    // - Your rendering loop must check for 'UserCallback' in ImDrawCmd and call the function instead of rendering triangles. All standard backends are honoring this.
    // - For some backends, the callback may access selected render-states exposed by the backend in a ImGui_ImplXXXX_RenderState structure pointed to by platform_io.Renderer_RenderState.
    // - IMPORTANT: please be mindful of the different level of indirection between using size==0 (copying argument) and using size>0 (copying pointed data into a buffer).
    //   - If userdata_size == 0: we copy/store the 'userdata' argument as-is. It will be available unmodified in ImDrawCmd::UserCallbackData during render.
    //   - If userdata_size > 0,  we copy/store 'userdata_size' bytes pointed to by 'userdata'. We store them in a buffer stored inside the drawlist. ImDrawCmd::UserCallbackData will point inside that buffer so you have to retrieve data from there. Your callback may need to use ImDrawCmd::UserCallbackDataSize if you expect dynamically-sized data.
    //   - Support for userdata_size > 0 was added in v1.91.4, October 2024. So earlier code always only allowed to copy/store a simple void*.
    AddCallback :: (this: *DrawList, callback: DrawCallback, userdata: *void, userdata_size: u64 = 0) -> void #cpp_method #foreign ImGui "?AddCallback@ImDrawList@@QEAAXP6AXPEBU1@PEBUImDrawCmd@@@ZPEAX_K@Z";

    // Advanced: Miscellaneous
    AddDrawCmd :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?AddDrawCmd@ImDrawList@@QEAAXXZ";
    CloneOutput :: (this: *DrawList) -> *DrawList #cpp_method #foreign ImGui "?CloneOutput@ImDrawList@@QEBAPEAU1@XZ";

    // Advanced: Channels
    // - Use to split render into layers. By switching channels to can render out-of-order (e.g. submit FG primitives before BG primitives)
    // - Use to minimize draw calls (e.g. if going back-and-forth between multiple clipping rectangles, prefer to append into separate channels then merge at the end)
    // - This API shouldn't have been in ImDrawList in the first place!
    //   Prefer using your own persistent instance of ImDrawListSplitter as you can stack them.
    //   Using the ImDrawList::ChannelsXXXX you cannot stack a split over another.
    ChannelsSplit :: (this: *DrawList, count: s32) -> void #cpp_method #foreign ImGui "?ChannelsSplit@ImDrawList@@QEAAXH@Z";
    ChannelsMerge :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?ChannelsMerge@ImDrawList@@QEAAXXZ";
    ChannelsSetCurrent :: (this: *DrawList, n: s32) -> void #cpp_method #foreign ImGui "?ChannelsSetCurrent@ImDrawList@@QEAAXH@Z";

    // Advanced: Primitives allocations
    // - We render triangles (three vertices)
    // - All primitives needs to be reserved via PrimReserve() beforehand.
    PrimReserve :: (this: *DrawList, idx_count: s32, vtx_count: s32) -> void #cpp_method #foreign ImGui "?PrimReserve@ImDrawList@@QEAAXHH@Z";
    PrimUnreserve :: (this: *DrawList, idx_count: s32, vtx_count: s32) -> void #cpp_method #foreign ImGui "?PrimUnreserve@ImDrawList@@QEAAXHH@Z";
    PrimRect :: (this: *DrawList, a: *Vector2, b: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?PrimRect@ImDrawList@@QEAAXAEBUImVec2@@0I@Z";
    PrimRect :: (this: *DrawList, a: Vector2, b: Vector2, col: U32) #no_context {
        PrimRect(this, *a, *b, col);
    }
    PrimRectUV :: (this: *DrawList, a: *Vector2, b: *Vector2, uv_a: *Vector2, uv_b: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?PrimRectUV@ImDrawList@@QEAAXAEBUImVec2@@000I@Z";
    PrimRectUV :: (this: *DrawList, a: Vector2, b: Vector2, uv_a: Vector2, uv_b: Vector2, col: U32) #no_context {
        PrimRectUV(this, *a, *b, *uv_a, *uv_b, col);
    }
    PrimQuadUV :: (this: *DrawList, a: *Vector2, b: *Vector2, c: *Vector2, d: *Vector2, uv_a: *Vector2, uv_b: *Vector2, uv_c: *Vector2, uv_d: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?PrimQuadUV@ImDrawList@@QEAAXAEBUImVec2@@0000000I@Z";
    PrimQuadUV :: (this: *DrawList, a: Vector2, b: Vector2, c: Vector2, d: Vector2, uv_a: Vector2, uv_b: Vector2, uv_c: Vector2, uv_d: Vector2, col: U32) #no_context {
        PrimQuadUV(this, *a, *b, *c, *d, *uv_a, *uv_b, *uv_c, *uv_d, col);
    }
    PrimWriteVtx :: (this: *DrawList, pos: *Vector2, uv: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?PrimWriteVtx@ImDrawList@@QEAAXAEBUImVec2@@0I@Z";
    PrimWriteVtx :: (this: *DrawList, pos: Vector2, uv: Vector2, col: U32) #no_context {
        PrimWriteVtx(this, *pos, *uv, col);
    }
    PrimWriteIdx :: (this: *DrawList, idx: DrawIdx) -> void #cpp_method #foreign ImGui "?PrimWriteIdx@ImDrawList@@QEAAXG@Z";
    PrimVtx :: (this: *DrawList, pos: *Vector2, uv: *Vector2, col: U32) -> void #cpp_method #foreign ImGui "?PrimVtx@ImDrawList@@QEAAXAEBUImVec2@@0I@Z";
    PrimVtx :: (this: *DrawList, pos: Vector2, uv: Vector2, col: U32) #no_context {
        PrimVtx(this, *pos, *uv, col);
    }

    // [Internal helpers]
    _SetDrawListSharedData :: (this: *DrawList, data: *DrawListSharedData) -> void #cpp_method #foreign ImGui "?_SetDrawListSharedData@ImDrawList@@QEAAXPEAUImDrawListSharedData@@@Z";
    _ResetForNewFrame :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_ResetForNewFrame@ImDrawList@@QEAAXXZ";
    _ClearFreeMemory :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_ClearFreeMemory@ImDrawList@@QEAAXXZ";
    _PopUnusedDrawCmd :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_PopUnusedDrawCmd@ImDrawList@@QEAAXXZ";
    _TryMergeDrawCmds :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_TryMergeDrawCmds@ImDrawList@@QEAAXXZ";
    _OnChangedClipRect :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_OnChangedClipRect@ImDrawList@@QEAAXXZ";
    _OnChangedTexture :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_OnChangedTexture@ImDrawList@@QEAAXXZ";
    _OnChangedVtxOffset :: (this: *DrawList) -> void #cpp_method #foreign ImGui "?_OnChangedVtxOffset@ImDrawList@@QEAAXXZ";
    _SetTexture :: (this: *DrawList, tex_ref: TextureRef) -> void #cpp_method #foreign ImGui "?_SetTexture@ImDrawList@@QEAAXUImTextureRef@@@Z";
    _CalcCircleAutoSegmentCount :: (this: *DrawList, radius: float) -> s32 #cpp_method #foreign ImGui "?_CalcCircleAutoSegmentCount@ImDrawList@@QEBAHM@Z";
    _PathArcToFastEx :: (this: *DrawList, center: *Vector2, radius: float, a_min_sample: s32, a_max_sample: s32, a_step: s32) -> void #cpp_method #foreign ImGui "?_PathArcToFastEx@ImDrawList@@QEAAXAEBUImVec2@@MHHH@Z";
    _PathArcToFastEx :: (this: *DrawList, center: Vector2, radius: float, a_min_sample: s32, a_max_sample: s32, a_step: s32) #no_context {
        _PathArcToFastEx(this, *center, radius, a_min_sample, a_max_sample, a_step);
    }
    _PathArcToN :: (this: *DrawList, center: *Vector2, radius: float, a_min: float, a_max: float, num_segments: s32) -> void #cpp_method #foreign ImGui "?_PathArcToN@ImDrawList@@QEAAXAEBUImVec2@@MMMH@Z";
    _PathArcToN :: (this: *DrawList, center: Vector2, radius: float, a_min: float, a_max: float, num_segments: s32) #no_context {
        _PathArcToN(this, *center, radius, a_min, a_max, num_segments);
    }
}

// All draw data to render a Dear ImGui frame
// (NB: the style and the naming convention here is a little inconsistent, we currently preserve them for backward compatibility purpose,
// as this is one of the oldest structure exposed by the library! Basically, ImDrawList == CmdList)
DrawData :: struct {
    Valid:            bool; // Only valid after Render() is called and before the next NewFrame() is called.
    CmdListsCount:    s32; // == CmdLists.Size. (OBSOLETE: exists for legacy reasons). Number of ImDrawList* to render.
    TotalIdxCount:    s32; // For convenience, sum of all ImDrawList's IdxBuffer.Size
    TotalVtxCount:    s32; // For convenience, sum of all ImDrawList's VtxBuffer.Size
    CmdLists:         Vector(*DrawList); // Array of ImDrawList* to render. The ImDrawLists are owned by ImGuiContext and only pointed to from here.
    DisplayPos:       Vector2; // Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== GetMainViewport()->Pos for the main viewport, == (0.0) in most single-viewport applications)
    DisplaySize:      Vector2; // Size of the viewport to render (== GetMainViewport()->Size for the main viewport, == io.DisplaySize in most single-viewport applications)
    FramebufferScale: Vector2; // Amount of pixels for each unit of DisplaySize. Copied from viewport->FramebufferScale (== io.DisplayFramebufferScale for main viewport). Generally (1,1) on normal display, (2,2) on OSX with Retina display.
    OwnerViewport:    *Viewport; // Viewport carrying the ImDrawData instance, might be of use to the renderer (generally not).
    Textures:         *Vector(*TextureData); // List of textures to update. Most of the times the list is shared by all ImDrawData, has only 1 texture and it doesn't need any update. This almost always points to ImGui::GetPlatformIO().Textures[]. May be overriden or set to NULL if you want to manually update textures.

    // Functions
    Constructor :: (this: *DrawData) -> void #cpp_method #foreign ImGui "??0ImDrawData@@QEAA@XZ";
    Clear :: (this: *DrawData) -> void #cpp_method #foreign ImGui "?Clear@ImDrawData@@QEAAXXZ";
    AddDrawList :: (this: *DrawData, draw_list: *DrawList) -> void #cpp_method #foreign ImGui "?AddDrawList@ImDrawData@@QEAAXPEAUImDrawList@@@Z";
    DeIndexAllBuffers :: (this: *DrawData) -> void #cpp_method #foreign ImGui "?DeIndexAllBuffers@ImDrawData@@QEAAXXZ";
    ScaleClipRects :: (this: *DrawData, fb_scale: *Vector2) -> void #cpp_method #foreign ImGui "?ScaleClipRects@ImDrawData@@QEAAXAEBUImVec2@@@Z";
    ScaleClipRects :: (this: *DrawData, fb_scale: Vector2) #no_context {
        ScaleClipRects(this, *fb_scale);
    }
}

// We intentionally support a limited amount of texture formats to limit burden on CPU-side code and extension.
// Most standard backends only support RGBA32 but we provide a single channel option for low-resource/embedded systems.
TextureFormat :: enum s32 {
    RGBA32 :: 0;
    Alpha8 :: 1;
}

// Status of a texture to communicate with Renderer Backend.
TextureStatus :: enum s32 {
    OK          :: 0;
    Destroyed   :: 1;
    WantCreate  :: 2;
    WantUpdates :: 3;
    WantDestroy :: 4;
}

// Coordinates of a rectangle within a texture.
// When a texture is in ImTextureStatus_WantUpdates state, we provide a list of individual rectangles to copy to the graphics system.
// You may use ImTextureData::Updates[] for the list, or ImTextureData::UpdateBox for a single bounding box.
TextureRect :: struct {
    x: u16; // Upper-left coordinates of rectangle to update
    y: u16; // Upper-left coordinates of rectangle to update
    w: u16; // Size of rectangle to update (in pixels)
    h: u16; // Size of rectangle to update (in pixels)
}

// Specs and pixel storage for a texture used by Dear ImGui.
// This is only useful for (1) core library and (2) backends. End-user/applications do not need to care about this.
// Renderer Backends will create a GPU-side version of this.
// Why does we store two identifiers: TexID and BackendUserData?
// - ImTextureID    TexID           = lower-level identifier stored in ImDrawCmd. ImDrawCmd can refer to textures not created by the backend, and for which there's no ImTextureData.
// - void*          BackendUserData = higher-level opaque storage for backend own book-keeping. Some backends may have enough with TexID and not need both.
// In columns below: who reads/writes each fields? 'r'=read, 'w'=write, 'core'=main library, 'backend'=renderer backend
TextureData :: struct {
    UniqueID:             s32; // w    -   // [DEBUG] Sequential index to facilitate identifying a texture when debugging/printing. Unique per atlas.
    Status:               TextureStatus; // rw   rw  // ImTextureStatus_OK/_WantCreate/_WantUpdates/_WantDestroy. Always use SetStatus() to modify!
    BackendUserData:      *void; // -    rw  // Convenience storage for backend. Some backends may have enough with TexID.
    TexID:                TextureID; // r    w   // Backend-specific texture identifier. Always use SetTexID() to modify! The identifier will stored in ImDrawCmd::GetTexID() and passed to backend's RenderDrawData function.
    Format:               TextureFormat; // w    r   // ImTextureFormat_RGBA32 (default) or ImTextureFormat_Alpha8
    Width:                s32; // w    r   // Texture width
    Height:               s32; // w    r   // Texture height
    BytesPerPixel:        s32; // w    r   // 4 or 1
    Pixels:               *u8; // w    r   // Pointer to buffer holding 'Width*Height' pixels and 'Width*Height*BytesPerPixels' bytes.
    UsedRect:             TextureRect; // w    r   // Bounding box encompassing all past and queued Updates[].
    UpdateRect:           TextureRect; // w    r   // Bounding box encompassing all queued Updates[].
    Updates:              Vector(TextureRect); // w    r   // Array of individual updates.
    UnusedFrames:         s32; // w    r   // In order to facilitate handling Status==WantDestroy in some backend: this is a count successive frames where the texture was not used. Always >0 when Status==WantDestroy.
    RefCount:             u16; // w    r   // Number of contexts using this texture. Used during backend shutdown.
    UseColors:            bool; // w    r   // Tell whether our texture data is known to use colors (rather than just white + alpha).
    WantDestroyNextFrame: bool; // rw   -   // [Internal] Queued to set ImTextureStatus_WantDestroy next frame. May still be used in the current frame.

    // Functions
    Constructor :: (this: *TextureData) -> void #cpp_method #foreign ImGui "??0ImTextureData@@QEAA@XZ";
    Destructor :: (this: *TextureData) -> void #cpp_method #foreign ImGui "??1ImTextureData@@QEAA@XZ";
    Create :: (this: *TextureData, format: TextureFormat, w: s32, h: s32) -> void #cpp_method #foreign ImGui "?Create@ImTextureData@@QEAAXW4ImTextureFormat@@HH@Z";
    DestroyPixels :: (this: *TextureData) -> void #cpp_method #foreign ImGui "?DestroyPixels@ImTextureData@@QEAAXXZ";

    GetPixelsAt :: (this: *TextureData, x: s32, y: s32) -> *void #cpp_method #foreign ImGui "?GetPixelsAt@ImTextureData@@QEAAPEAXHH@Z";

    GetPitch :: (this: *TextureData) -> s32 #cpp_method #foreign ImGui "?GetPitch@ImTextureData@@QEBAHXZ";
    GetTexRef :: (this: *TextureData) -> TextureRef #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetTexRef@ImTextureData@@QEAA?AUImTextureRef@@XZ";
}

// A font input/source (we may rename this to ImFontSource in the future)
FontConfig :: struct {
    Name:                 [40] u8; // <auto>   // Name (strictly to ease debugging, hence limited size buffer)
    FontData:             *void; //          // TTF/OTF data
    FontDataSize:         s32; //          // TTF/OTF data size
    FontDataOwnedByAtlas: bool; // true     // TTF/OTF data ownership taken by the container ImFontAtlas (will delete memory itself).

    MergeMode:            bool; // false    // Merge into previous ImFont, so you can combine multiple inputs font into one ImFont (e.g. ASCII font + icons + Japanese glyphs). You may want to use GlyphOffset.y when merge font of different heights.
    PixelSnapH:           bool; // false    // Align every glyph AdvanceX to pixel boundaries. Useful e.g. if you are merging a non-pixel aligned font with the default font. If enabled, you can set OversampleH/V to 1.
    PixelSnapV:           bool; // true     // Align Scaled GlyphOffset.y to pixel boundaries.
    OversampleH:          S8; // 0 (2)    // Rasterize at higher quality for sub-pixel positioning. 0 == auto == 1 or 2 depending on size. Note the difference between 2 and 3 is minimal. You can reduce this to 1 for large glyphs save memory. Read https://github.com/nothings/stb/blob/master/tests/oversample/README.md for details.
    OversampleV:          S8; // 0 (1)    // Rasterize at higher quality for sub-pixel positioning. 0 == auto == 1. This is not really useful as we don't use sub-pixel positions on the Y axis.
    EllipsisChar:         Wchar; // 0        // Explicitly specify Unicode codepoint of ellipsis character. When fonts are being merged first specified ellipsis will be used.
    SizePixels:           float; //          // Size in pixels for rasterizer (more or less maps to the resulting font height).
    GlyphRanges:          *Wchar; // NULL     // *LEGACY* THE ARRAY DATA NEEDS TO PERSIST AS LONG AS THE FONT IS ALIVE. Pointer to a user-provided list of Unicode range (2 value per range, values are inclusive, zero-terminated list).
    GlyphExcludeRanges:   *Wchar; // NULL     // Pointer to a small user-provided list of Unicode ranges (2 value per range, values are inclusive, zero-terminated list). This is very close to GlyphRanges[] but designed to exclude ranges from a font source, when merging fonts with overlapping glyphs. Use "Input Glyphs Overlap Detection Tool" to find about your overlapping ranges.

    GlyphOffset:          Vector2; // 0, 0     // Offset (in pixels) all glyphs from this font input. Absolute value for default size, other sizes will scale this value.
    GlyphMinAdvanceX:     float; // 0        // Minimum AdvanceX for glyphs, set Min to align font icons, set both Min/Max to enforce mono-space font. Absolute value for default size, other sizes will scale this value.
    GlyphMaxAdvanceX:     float; // FLT_MAX  // Maximum AdvanceX for glyphs
    GlyphExtraAdvanceX:   float; // 0        // Extra spacing (in pixels) between glyphs. Please contact us if you are using this. // FIXME-NEWATLAS: Intentionally unscaled
    FontNo:               U32; // 0        // Index of font within TTF/OTF file
    FontLoaderFlags:      u32; // 0        // Settings for custom font builder. THIS IS BUILDER IMPLEMENTATION DEPENDENT. Leave as zero if unsure.

    RasterizerMultiply:   float; // 1.0f     // Linearly brighten (>1.0f) or darken (<1.0f) font output. Brightening small fonts may be a good workaround to make them more readable. This is a silly thing we may remove in the future.
    RasterizerDensity:    float; // 1.0f     // [LEGACY: this only makes sense when ImGuiBackendFlags_RendererHasTextures is not supported] DPI scale multiplier for rasterization. Not altering other font metrics: makes it easy to swap between e.g. a 100% and a 400% fonts for a zooming display, or handle Retina screen. IMPORTANT: If you change this it is expected that you increase/decrease font scale roughly to the inverse of this, otherwise quality may look lowered.

    Flags:                FontFlags; // Font flags (don't use just yet, will be exposed in upcoming 1.92.X updates)
    DstFont:              *Font; // Target font (as we merging fonts, multiple ImFontConfig may target the same font)
    FontLoader_:          *FontLoader; // Custom font backend for this source (default source is the one stored in ImFontAtlas)
    FontLoaderData:       *void; // Font loader opaque storage (per font config)

    Constructor :: (this: *FontConfig) -> void #cpp_method #foreign ImGui "??0ImFontConfig@@QEAA@XZ";
}

// Hold rendering data for one glyph.
// (Note: some language parsers may fail to convert the bitfield members, in this case maybe drop store a single u32 or we can rework this)
FontGlyph :: struct {
    __bitfield: u32;
    /* 
        Colored: u32; /* 1 bits */ // Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
        Visible: u32; /* 1 bits */ // Flag to indicate glyph has no visible pixels (e.g. space). Allow early out when rendering.
        SourceIdx: u32; /* 4 bits */ // Index of source in parent font
        Codepoint: u32; /* 26 bits */ // 0x0000..0x10FFFF;
    */

    AdvanceX:   float; // Horizontal distance to advance cursor/layout position.
    X0:         float; // Glyph corners. Offsets from current cursor/layout position.
    Y0:         float; // Glyph corners. Offsets from current cursor/layout position.
    X1:         float; // Glyph corners. Offsets from current cursor/layout position.
    Y1:         float; // Glyph corners. Offsets from current cursor/layout position.
    U0:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    V0:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    U1:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    V1:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    PackId:     s32; // [Internal] ImFontAtlasRectId value (FIXME: Cold data, could be moved elsewhere?)

    Constructor :: (this: *FontGlyph) -> void #cpp_method #foreign ImGui "??0ImFontGlyph@@QEAA@XZ";
}

// Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
// This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
FontGlyphRangesBuilder :: struct {
    UsedChars: Vector(U32); // Store 1-bit per Unicode code point (0=unused, 1=used)

    GetBit :: (this: *FontGlyphRangesBuilder, n: u64) -> bool #cpp_method #foreign ImGui "?GetBit@ImFontGlyphRangesBuilder@@QEBA_N_K@Z";
    SetBit :: (this: *FontGlyphRangesBuilder, n: u64) -> void #cpp_method #foreign ImGui "?SetBit@ImFontGlyphRangesBuilder@@QEAAX_K@Z";
    AddChar :: (this: *FontGlyphRangesBuilder, c: Wchar) -> void #cpp_method #foreign ImGui "?AddChar@ImFontGlyphRangesBuilder@@QEAAXG@Z";
    AddText :: (this: *FontGlyphRangesBuilder, text: *u8, text_end: *u8 = null) -> void #cpp_method #foreign ImGui "?AddText@ImFontGlyphRangesBuilder@@QEAAXPEBD0@Z";
    AddText :: (this: *FontGlyphRangesBuilder, text: string) #no_context {
        AddText(this, text.data, text.data + text.count);
    }
    AddRanges :: (this: *FontGlyphRangesBuilder, ranges: *Wchar) -> void #cpp_method #foreign ImGui "?AddRanges@ImFontGlyphRangesBuilder@@QEAAXPEBG@Z";
    BuildRanges :: (this: *FontGlyphRangesBuilder, out_ranges: *Vector(Wchar)) -> void #cpp_method #foreign ImGui "?BuildRanges@ImFontGlyphRangesBuilder@@QEAAXPEAU?$ImVector@G@@@Z";
}

// An opaque identifier to a rectangle in the atlas. -1 when invalid.
// The rectangle may move and UV may be invalidated, use GetCustomRect() to retrieve it.
FontAtlasRectId :: s32;

// Output of ImFontAtlas::GetCustomRect() when using custom rectangles.
// Those values may not be cached/stored as they are only valid for the current value of atlas->TexRef
// (this is in theory derived from ImTextureRect but we use separate structures for reasons)
FontAtlasRect :: struct {
    x:   u16; // Position (in current texture)
    y:   u16; // Position (in current texture)
    w:   u16; // Size
    h:   u16; // Size
    uv0: Vector2; // UV coordinates (in current texture)
    uv1: Vector2; // UV coordinates (in current texture)

    Constructor :: (this: *FontAtlasRect) -> void #cpp_method #foreign ImGui "??0ImFontAtlasRect@@QEAA@XZ";
}

// Flags for ImFontAtlas build
FontAtlasFlags :: enum_flags s32 {
    None               :: 0x0;
    NoPowerOfTwoHeight :: 0x1;
    NoMouseCursors     :: 0x2;
    NoBakedLines       :: 0x4;
}

// Load and rasterize multiple TTF/OTF fonts into a same texture. The font atlas will build a single texture holding:
//  - One or more fonts.
//  - Custom graphics data needed to render the shapes needed by Dear ImGui.
//  - Mouse cursor shapes for software cursor rendering (unless setting 'Flags |= ImFontAtlasFlags_NoMouseCursors' in the font atlas).
//  - If you don't call any AddFont*** functions, the default font embedded in the code will be loaded for you.
// It is the rendering backend responsibility to upload texture into your graphics API:
//  - ImGui_ImplXXXX_RenderDrawData() functions generally iterate platform_io->Textures[] to create/update/destroy each ImTextureData instance.
//  - Backend then set ImTextureData's TexID and BackendUserData.
//  - Texture id are passed back to you during rendering to identify the texture. Read FAQ entry about ImTextureID/ImTextureRef for more details.
// Legacy path:
//  - Call Build() + GetTexDataAsAlpha8() or GetTexDataAsRGBA32() to build and retrieve pixels data.
//  - Call SetTexID(my_tex_id); and pass the pointer/identifier to your texture in a format natural to your graphics API.
// Common pitfalls:
// - If you pass a 'glyph_ranges' array to AddFont*** functions, you need to make sure that your array persist up until the
//   atlas is build (when calling GetTexData*** or Build()). We only copy the pointer, not the data.
// - Important: By default, AddFontFromMemoryTTF() takes ownership of the data. Even though we are not writing to it, we will free the pointer on destruction.
//   You can set font_cfg->FontDataOwnedByAtlas=false to keep ownership of your data and it won't be freed,
// - Even though many functions are suffixed with "TTF", OTF data is supported just as well.
// - This is an old API and it is currently awkward for those and various other reasons! We will address them in the future!
FontAtlas :: struct {
    Constructor :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "??0ImFontAtlas@@QEAA@XZ";
    Destructor :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "??1ImFontAtlas@@QEAA@XZ";
    AddFont :: (this: *FontAtlas, font_cfg: *FontConfig) -> *Font #cpp_method #foreign ImGui "?AddFont@ImFontAtlas@@QEAAPEAUImFont@@PEBUImFontConfig@@@Z";
    AddFontDefault :: (this: *FontAtlas, font_cfg: *FontConfig = null) -> *Font #cpp_method #foreign ImGui "?AddFontDefault@ImFontAtlas@@QEAAPEAUImFont@@PEBUImFontConfig@@@Z";
    AddFontFromFileTTF :: (this: *FontAtlas, filename: *u8, size_pixels: float = 0.0, font_cfg: *FontConfig = null, glyph_ranges: *Wchar = null) -> *Font #cpp_method #foreign ImGui "?AddFontFromFileTTF@ImFontAtlas@@QEAAPEAUImFont@@PEBDMPEBUImFontConfig@@PEBG@Z";
    AddFontFromMemoryTTF :: (this: *FontAtlas, font_data: *void, font_data_size: s32, size_pixels: float = 0.0, font_cfg: *FontConfig = null, glyph_ranges: *Wchar = null) -> *Font #cpp_method #foreign ImGui "?AddFontFromMemoryTTF@ImFontAtlas@@QEAAPEAUImFont@@PEAXHMPEBUImFontConfig@@PEBG@Z";
    AddFontFromMemoryCompressedTTF :: (this: *FontAtlas, compressed_font_data: *void, compressed_font_data_size: s32, size_pixels: float = 0.0, font_cfg: *FontConfig = null, glyph_ranges: *Wchar = null) -> *Font #cpp_method #foreign ImGui "?AddFontFromMemoryCompressedTTF@ImFontAtlas@@QEAAPEAUImFont@@PEBXHMPEBUImFontConfig@@PEBG@Z";
    AddFontFromMemoryCompressedBase85TTF :: (this: *FontAtlas, compressed_font_data_base85: *u8, size_pixels: float = 0.0, font_cfg: *FontConfig = null, glyph_ranges: *Wchar = null) -> *Font #cpp_method #foreign ImGui "?AddFontFromMemoryCompressedBase85TTF@ImFontAtlas@@QEAAPEAUImFont@@PEBDMPEBUImFontConfig@@PEBG@Z";
    RemoveFont :: (this: *FontAtlas, font: *Font) -> void #cpp_method #foreign ImGui "?RemoveFont@ImFontAtlas@@QEAAXPEAUImFont@@@Z";

    Clear :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "?Clear@ImFontAtlas@@QEAAXXZ";
    CompactCache :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "?CompactCache@ImFontAtlas@@QEAAXXZ";
    SetFontLoader :: (this: *FontAtlas, font_loader: *FontLoader) -> void #cpp_method #foreign ImGui "?SetFontLoader@ImFontAtlas@@QEAAXPEBUImFontLoader@@@Z";

    // As we are transitioning toward a new font system, we expect to obsolete those soon:
    ClearInputData :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "?ClearInputData@ImFontAtlas@@QEAAXXZ";
    ClearFonts :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "?ClearFonts@ImFontAtlas@@QEAAXXZ";
    ClearTexData :: (this: *FontAtlas) -> void #cpp_method #foreign ImGui "?ClearTexData@ImFontAtlas@@QEAAXXZ";

    // Since 1.92: specifying glyph ranges is only useful/necessary if your backend doesn't support ImGuiBackendFlags_RendererHasTextures!
    GetGlyphRangesDefault :: (this: *FontAtlas) -> *Wchar #cpp_method #foreign ImGui "?GetGlyphRangesDefault@ImFontAtlas@@QEAAPEBGXZ";

    // Register and retrieve custom rectangles
    // - You can request arbitrary rectangles to be packed into the atlas, for your own purpose.
    // - Since 1.92.X, packing is done immediately in the function call (previously packing was done during the Build call)
    // - You can render your pixels into the texture right after calling the AddCustomRect() functions.
    // - VERY IMPORTANT:
    //   - Texture may be created/resized at any time when calling ImGui or ImFontAtlas functions.
    //   - IT WILL INVALIDATE RECTANGLE DATA SUCH AS UV COORDINATES. Always use latest values from GetCustomRect().
    //   - UV coordinates are associated to the current texture identifier aka 'atlas->TexRef'. Both TexRef and UV coordinates are typically changed at the same time.
    // - If you render colored output into your custom rectangles: set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of preferred texture format.
    // - Read docs/FONTS.md for more details about using colorful icons.
    // - Note: this API may be reworked further in order to facilitate supporting e.g. multi-monitor, varying DPI settings.
    // - (Pre-1.92 names) ------------> (1.92 names)
    //   - GetCustomRectByIndex()   --> Use GetCustomRect()
    //   - CalcCustomRectUV()       --> Use GetCustomRect() and read uv0, uv1 fields.
    //   - AddCustomRectRegular()   --> Renamed to AddCustomRect()
    //   - AddCustomRectFontGlyph() --> Prefer using custom ImFontLoader inside ImFontConfig
    //   - ImFontAtlasCustomRect    --> Renamed to ImFontAtlasRect
    AddCustomRect :: (this: *FontAtlas, width: s32, height: s32, out_r: *FontAtlasRect = null) -> FontAtlasRectId #cpp_method #foreign ImGui "?AddCustomRect@ImFontAtlas@@QEAAHHHPEAUImFontAtlasRect@@@Z";
    RemoveCustomRect :: (this: *FontAtlas, id: FontAtlasRectId) -> void #cpp_method #foreign ImGui "?RemoveCustomRect@ImFontAtlas@@QEAAXH@Z";
    GetCustomRect :: (this: *FontAtlas, id: FontAtlasRectId, out_r: *FontAtlasRect) -> bool #cpp_method #foreign ImGui "?GetCustomRect@ImFontAtlas@@QEBA_NHPEAUImFontAtlasRect@@@Z";

    Flags:               FontAtlasFlags; // Build flags (see ImFontAtlasFlags_)
    TexDesiredFormat:    TextureFormat; // Desired texture format (default to ImTextureFormat_RGBA32 but may be changed to ImTextureFormat_Alpha8).
    TexGlyphPadding:     s32; // FIXME: Should be called "TexPackPadding". Padding between glyphs within texture in pixels. Defaults to 1. If your rendering method doesn't rely on bilinear filtering you may set this to 0 (will also need to set AntiAliasedLinesUseTex = false).
    TexMinWidth:         s32; // Minimum desired texture width. Must be a power of two. Default to 512.
    TexMinHeight:        s32; // Minimum desired texture height. Must be a power of two. Default to 128.
    TexMaxWidth:         s32; // Maximum desired texture width. Must be a power of two. Default to 8192.
    TexMaxHeight:        s32; // Maximum desired texture height. Must be a power of two. Default to 8192.
    UserData:            *void; // Store your own atlas related user-data (if e.g. you have multiple font atlas).

    TexRef:              TextureRef; // Latest texture identifier == TexData->GetTexRef().

    TexData:             *TextureData; // Latest texture.

    TexList:             Vector(*TextureData); // Texture list (most often TexList.Size == 1). TexData is always == TexList.back(). DO NOT USE DIRECTLY, USE GetDrawData().Textures[]/GetPlatformIO().Textures[] instead!
    Locked:              bool; // Marked as locked during ImGui::NewFrame()..EndFrame() scope if TexUpdates are not supported. Any attempt to modify the atlas will assert.
    RendererHasTextures: bool; // Copy of (BackendFlags & ImGuiBackendFlags_RendererHasTextures) from supporting context.
    TexIsBuilt:          bool; // Set when texture was built matching current font input. Mostly useful for legacy IsBuilt() call.
    TexPixelsUseColors:  bool; // Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format or conversion process.
    TexUvScale:          Vector2; // = (1.0f/TexData->TexWidth, 1.0f/TexData->TexHeight). May change as new texture gets created.
    TexUvWhitePixel:     Vector2; // Texture coordinates to a white pixel. May change as new texture gets created.
    Fonts:               Vector(*Font); // Hold all the fonts returned by AddFont*. Fonts[0] is the default font upon calling ImGui::NewFrame(), use ImGui::PushFont()/PopFont() to change the current font.
    Sources:             Vector(FontConfig); // Source/configuration data
    TexUvLines:          [33] Vector4; // UVs for baked anti-aliased lines
    TexNextUniqueID:     s32; // Next value to be stored in TexData->UniqueID
    FontNextUniqueID:    s32; // Next value to be stored in ImFont->FontID
    DrawListSharedDatas: Vector(*DrawListSharedData); // List of users for this atlas. Typically one per Dear ImGui context.
    Builder:             *FontAtlasBuilder; // Opaque interface to our data that doesn't need to be public and may be discarded when rebuilding.
    FontLoader_:         *FontLoader; // Font loader opaque interface (default to use FreeType when IMGUI_ENABLE_FREETYPE is defined, otherwise default to use stb_truetype). Use SetFontLoader() to change this at runtime.
    FontLoaderName:      *u8; // Font loader name (for display e.g. in About box) == FontLoader->Name
    FontLoaderData:      *void; // Font backend opaque storage
    FontLoaderFlags:     u32; // Shared flags (for all fonts) for font loader. THIS IS BUILD IMPLEMENTATION DEPENDENT (e.g. Per-font override is also available in ImFontConfig).
    RefCount:            s32; // Number of contexts using this atlas
    OwnerContext:        *ImGuiContext; // Context which own the atlas will be in charge of updating and destroying it.
}

// Font runtime data for a given size
// Important: pointers to ImFontBaked are only valid for the current frame.
FontBaked :: struct {
    IndexAdvanceX:      Vector(float); // 12-16 // out // Sparse. Glyphs->AdvanceX in a directly indexable way (cache-friendly for CalcTextSize functions which only this info, and are often bottleneck in large UI).
    FallbackAdvanceX:   float; // 4     // out // FindGlyph(FallbackChar)->AdvanceX
    Size:               float; // 4     // in  // Height of characters/line, set during loading (doesn't change after loading)
    RasterizerDensity:  float; // 4     // in  // Density this is baked at

    IndexLookup:        Vector(U16); // 12-16 // out // Sparse. Index glyphs by Unicode code-point.
    Glyphs:             Vector(FontGlyph); // 12-16 // out // All glyphs.
    FallbackGlyphIndex: s32; // 4     // out // Index of FontFallbackChar

    Ascent:             float; // 4+4   // out // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize] (unscaled)
    Descent:            float; // 4+4   // out // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize] (unscaled)
    __bitfield:         u32;
    /* 
        MetricsTotalSurface: u32; /* 26 bits */ // 3  // out // Total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
        WantDestroy: u32; /* 1 bits */ // 0  //     // Queued for destroy
        LoadNoFallback: u32; /* 1 bits */ // 0  //     // Disable loading fallback in lower-level calls.
        LoadNoRenderOnLayout: u32; /* 1 bits */ // 0  //     // Enable a two-steps mode where CalcTextSize() calls will load AdvanceX *without* rendering/packing glyphs. Only advantagous if you know that the glyph is unlikely to actually be rendered, otherwise it is slower because we'd do one query on the first CalcTextSize and one query on the first Draw.;
    */

    LastUsedFrame:      s32; // 4  //     // Record of that time this was bounds
    BakedId:            ID; // 4     //     // Unique ID for this baked storage
    ContainerFont:      *Font; // 4-8   // in  // Parent font
    FontLoaderDatas:    *void; // 4-8   //     // Font loader opaque storage (per baked font * sources): single contiguous buffer allocated by imgui, passed to loader.

    // Functions
    Constructor :: (this: *FontBaked) -> void #cpp_method #foreign ImGui "??0ImFontBaked@@QEAA@XZ";
    ClearOutputData :: (this: *FontBaked) -> void #cpp_method #foreign ImGui "?ClearOutputData@ImFontBaked@@QEAAXXZ";
    FindGlyph :: (this: *FontBaked, c: Wchar) -> *FontGlyph #cpp_method #foreign ImGui "?FindGlyph@ImFontBaked@@QEAAPEAUImFontGlyph@@G@Z";
    FindGlyphNoFallback :: (this: *FontBaked, c: Wchar) -> *FontGlyph #cpp_method #foreign ImGui "?FindGlyphNoFallback@ImFontBaked@@QEAAPEAUImFontGlyph@@G@Z";
    GetCharAdvance :: (this: *FontBaked, c: Wchar) -> float #cpp_method #foreign ImGui "?GetCharAdvance@ImFontBaked@@QEAAMG@Z";
    IsGlyphLoaded :: (this: *FontBaked, c: Wchar) -> bool #cpp_method #foreign ImGui "?IsGlyphLoaded@ImFontBaked@@QEAA_NG@Z";
}

// Font flags
// (in future versions as we redesign font loading API, this will become more important and better documented. for now please consider this as internal/advanced use)
FontFlags :: enum_flags s32 {
    None           :: 0x0;
    NoLoadError    :: 0x2;
    NoLoadGlyphs   :: 0x4;
    LockBakedSizes :: 0x8;
}

// Font runtime data and rendering
// - ImFontAtlas automatically loads a default embedded font for you if you didn't load one manually.
// - Since 1.92.X a font may be rendered as any size! Therefore a font doesn't have one specific size.
// - Use 'font->GetFontBaked(size)' to retrieve the ImFontBaked* corresponding to a given size.
// - If you used g.Font + g.FontSize (which is frequent from the ImGui layer), you can use g.FontBaked as a shortcut, as g.FontBaked == g.Font->GetFontBaked(g.FontSize).
Font :: struct {
    LastBaked:                *FontBaked; // 4-8   // Cache last bound baked. NEVER USE DIRECTLY. Use GetFontBaked().
    ContainerAtlas:           *FontAtlas; // 4-8   // What we have been loaded into.
    Flags:                    FontFlags; // 4     // Font flags.
    CurrentRasterizerDensity: float; // Current rasterizer density. This is a varying state of the font.

    FontId:                   ID; // Unique identifier for the font
    LegacySize:               float; // 4     // in  // Font size passed to AddFont(). Use for old code calling PushFont() expecting to use that size. (use ImGui::GetFontBaked() to get font baked at current bound size).
    Sources:                  Vector(*FontConfig); // 16    // in  // List of sources. Pointers within ContainerAtlas->Sources[]
    EllipsisChar:             Wchar; // 2-4   // out // Character used for ellipsis rendering ('...').
    FallbackChar:             Wchar; // 2-4   // out // Character used if a glyph isn't found (U+FFFD, '?')
    Used8kPagesMap:           [1] U8; // 1 bytes if ImWchar=ImWchar16, 16 bytes if ImWchar==ImWchar32. Store 1-bit for each block of 4K codepoints that has one active glyph. This is mainly used to facilitate iterations across all used codepoints.
    EllipsisAutoBake:         bool; // 1     //     // Mark when the "..." glyph needs to be generated.
    RemapPairs:               Storage; // 16    //     // Remapping pairs when using AddRemapChar(), otherwise empty.

    // Methods
    Constructor :: (this: *Font) -> void #cpp_method #foreign ImGui "??0ImFont@@QEAA@XZ";
    Destructor :: (this: *Font) -> void #cpp_method #foreign ImGui "??1ImFont@@QEAA@XZ";
    IsGlyphInFont :: (this: *Font, c: Wchar) -> bool #cpp_method #foreign ImGui "?IsGlyphInFont@ImFont@@QEAA_NG@Z";
    IsLoaded :: (this: *Font) -> bool #cpp_method #foreign ImGui "?IsLoaded@ImFont@@QEBA_NXZ";
    GetDebugName :: (this: *Font) -> *u8 #cpp_method #foreign ImGui "?GetDebugName@ImFont@@QEBAPEBDXZ";

    // [Internal] Don't use!
    // 'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    // 'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    GetFontBaked :: (this: *Font, font_size: float, density: float = -1.0) -> *FontBaked #cpp_method #foreign ImGui "?GetFontBaked@ImFont@@QEAAPEAUImFontBaked@@MM@Z";
    CalcTextSizeA :: (this: *Font, size: float, max_width: float, wrap_width: float, text_begin: *u8, text_end: *u8 = null, out_remaining: **u8 = null) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?CalcTextSizeA@ImFont@@QEAA?AUImVec2@@MMMPEBD0PEAPEBD@Z";
    CalcTextSizeA :: (this: *Font, size: float, max_width: float, wrap_width: float, text: string, out_remaining: **u8 = null) -> Vector2 #no_context {
        return CalcTextSizeA(this, size, max_width, wrap_width, text.data, text.data + text.count, out_remaining);
    }
    CalcWordWrapPosition :: (this: *Font, size: float, text: *u8, text_end: *u8, wrap_width: float) -> *u8 #cpp_method #foreign ImGui "?CalcWordWrapPosition@ImFont@@QEAAPEBDMPEBD0M@Z";
    CalcWordWrapPosition :: (this: *Font, size: float, text: string, wrap_width: float) -> *u8 #no_context {
        return CalcWordWrapPosition(this, size, text.data, text.data + text.count, wrap_width);
    }
    RenderChar :: (this: *Font, draw_list: *DrawList, size: float, pos: *Vector2, col: U32, c: Wchar, cpu_fine_clip: *Vector4 = null) -> void #cpp_method #foreign ImGui "?RenderChar@ImFont@@QEAAXPEAUImDrawList@@MAEBUImVec2@@IGPEBUImVec4@@@Z";
    RenderChar :: (this: *Font, draw_list: *DrawList, size: float, pos: Vector2, col: U32, c: Wchar, cpu_fine_clip: *Vector4 = null) #no_context {
        RenderChar(this, draw_list, size, *pos, col, c, cpu_fine_clip);
    }
    RenderText :: (this: *Font, draw_list: *DrawList, size: float, pos: *Vector2, col: U32, clip_rect: *Vector4, text_begin: *u8, text_end: *u8, wrap_width: float = 0.0, flags: DrawTextFlags = .None) -> void #cpp_method #foreign ImGui "?RenderText@ImFont@@QEAAXPEAUImDrawList@@MAEBUImVec2@@IAEBUImVec4@@PEBD3MH@Z";
    RenderText :: (this: *Font, draw_list: *DrawList, size: float, pos: Vector2, col: U32, clip_rect: Vector4, text: string, wrap_width: float = 0.0, flags: DrawTextFlags = .None) #no_context {
        RenderText(this, draw_list, size, *pos, col, *clip_rect, text.data, text.data + text.count, wrap_width, flags);
    }

    // [Internal] Don't use!
    ClearOutputData :: (this: *Font) -> void #cpp_method #foreign ImGui "?ClearOutputData@ImFont@@QEAAXXZ";
    AddRemapChar :: (this: *Font, from_codepoint: Wchar, to_codepoint: Wchar) -> void #cpp_method #foreign ImGui "?AddRemapChar@ImFont@@QEAAXGG@Z";
    IsGlyphRangeUnused :: (this: *Font, c_begin: u32, c_last: u32) -> bool #cpp_method #foreign ImGui "?IsGlyphRangeUnused@ImFont@@QEAA_NII@Z";
}

// Flags stored in ImGuiViewport::Flags, giving indications to the platform backends.
ViewportFlags :: enum_flags s32 {
    None                :: 0x0;
    IsPlatformWindow    :: 0x1;
    IsPlatformMonitor   :: 0x2;
    OwnedByApp          :: 0x4;
    NoDecoration        :: 0x8;
    NoTaskBarIcon       :: 0x10;
    NoFocusOnAppearing  :: 0x20;
    NoFocusOnClick      :: 0x40;
    NoInputs            :: 0x80;
    NoRendererClear     :: 0x100;
    NoAutoMerge         :: 0x200;
    TopMost             :: 0x400;
    CanHostOtherWindows :: 0x800;

    IsMinimized         :: 0x1000;
    IsFocused           :: 0x2000;
}

// - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
// - With multi-viewport enabled, we extend this concept to have multiple active viewports.
// - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
// - About Main Area vs Work Area:
//   - Main Area = entire viewport.
//   - Work Area = entire viewport minus sections used by main menu bars (for platform windows), or by task bar (for platform monitor).
//   - Windows are generally trying to stay within the Work Area of their host viewport.
Viewport :: struct {
    ID_:                   ID; // Unique identifier for the viewport
    Flags:                 ViewportFlags; // See ImGuiViewportFlags_
    Pos:                   Vector2; // Main Area: Position of the viewport (Dear ImGui coordinates are the same as OS desktop/native coordinates)
    Size:                  Vector2; // Main Area: Size of the viewport.
    FramebufferScale:      Vector2; // Density of the viewport for Retina display (always 1,1 on Windows, may be 2,2 etc on macOS/iOS). This will affect font rasterizer density.
    WorkPos:               Vector2; // Work Area: Position of the viewport minus task bars, menus bars, status bars (>= Pos)
    WorkSize:              Vector2; // Work Area: Size of the viewport minus task bars, menu bars, status bars (<= Size)
    DpiScale:              float; // 1.0f = 96 DPI = No extra scale.
    ParentViewportId:      ID; // (Advanced) 0: no parent. Instruct the platform backend to setup a parent/child relationship between platform windows.
    DrawData_:             *DrawData; // The ImDrawData corresponding to this viewport. Valid after Render() and until the next call to NewFrame().

    RendererUserData:      *void; // void* to hold custom data structure for the renderer (e.g. swap chain, framebuffers etc.). generally set by your Renderer_CreateWindow function.
    PlatformUserData:      *void; // void* to hold custom data structure for the OS / platform (e.g. windowing info, render context). generally set by your Platform_CreateWindow function.
    PlatformHandle:        *void; // void* to hold higher-level, platform window handle (e.g. HWND for Win32 backend, Uint32 WindowID for SDL, GLFWWindow* for GLFW), for FindViewportByPlatformHandle().
    PlatformHandleRaw:     *void; // void* to hold lower-level, platform-native window handle (always HWND on Win32 platform, unused for other platforms).
    PlatformWindowCreated: bool; // Platform window has been created (Platform_CreateWindow() has been called). This is false during the first frame where a viewport is being created.
    PlatformRequestMove:   bool; // Platform window requested move (e.g. window was moved by the OS / host window manager, authoritative position will be OS window position)
    PlatformRequestResize: bool; // Platform window requested resize (e.g. window was resized by the OS / host window manager, authoritative size will be OS window size)
    PlatformRequestClose:  bool; // Platform window requested closure (e.g. window was moved by the OS / host window manager, e.g. pressing ALT-F4)

    Constructor :: (this: *Viewport) -> void #cpp_method #foreign ImGui "??0ImGuiViewport@@QEAA@XZ";
    Destructor :: (this: *Viewport) -> void #cpp_method #foreign ImGui "??1ImGuiViewport@@QEAA@XZ";

    // Helpers
    GetCenter :: (this: *Viewport) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetCenter@ImGuiViewport@@QEBA?AUImVec2@@XZ";
}

// Access via ImGui::GetPlatformIO()
PlatformIO :: struct {
    Constructor :: (this: *PlatformIO) -> void #cpp_method #foreign ImGui "??0ImGuiPlatformIO@@QEAA@XZ";

    // Optional: Access OS clipboard
    // (default to use native Win32 clipboard on Windows, otherwise uses a private clipboard. Override to access OS clipboard on other architectures)
    Platform_GetClipboardTextFn:        #type (ctx: *ImGuiContext) -> *u8 #c_call;
    Platform_SetClipboardTextFn:        #type (ctx: *ImGuiContext, text: *u8) -> void #c_call;
    Platform_ClipboardUserData:         *void;

    // Optional: Open link/folder/file in OS Shell
    // (default to use ShellExecuteW() on Windows, system() on Linux/Mac)
    Platform_OpenInShellFn:             #type (ctx: *ImGuiContext, path: *u8) -> bool #c_call;
    Platform_OpenInShellUserData:       *void;

    // Optional: Notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME on Windows)
    // (default to use native imm32 api on Windows)
    Platform_SetImeDataFn:              #type (ctx: *ImGuiContext, viewport: *Viewport, data: *PlatformImeData) -> void #c_call;
    Platform_ImeUserData:               *void;

    Platform_LocaleDecimalPoint:        Wchar; // '.'

    // Optional: Maximum texture size supported by renderer (used to adjust how we size textures). 0 if not known.
    Renderer_TextureMaxWidth:           s32;
    Renderer_TextureMaxHeight:          s32;

    // Written by some backends during ImGui_ImplXXXX_RenderDrawData() call to point backend_specific ImGui_ImplXXXX_RenderState* structure.
    Renderer_RenderState:               *void;

    Platform_CreateWindow:              #type (vp: *Viewport) -> void #c_call; // . . U . .  // Create a new platform window for the given viewport
    Platform_DestroyWindow:             #type (vp: *Viewport) -> void #c_call; // N . U . D  //
    Platform_ShowWindow:                #type (vp: *Viewport) -> void #c_call; // . . U . .  // Newly created windows are initially hidden so SetWindowPos/Size/Title can be called on them before showing the window
    Platform_SetWindowPos:              #type (vp: *Viewport, pos: Vector2) -> void #c_call; // . . U . .  // Set platform window position (given the upper-left corner of client area)
    Platform_GetWindowPos:              #type (vp: *Viewport) -> Vector2 #c_call #cpp_return_type_is_non_pod; // N . . . .  //
    Platform_SetWindowSize:             #type (vp: *Viewport, size: Vector2) -> void #c_call; // . . U . .  // Set platform window client area size (ignoring OS decorations such as OS title bar etc.)
    Platform_GetWindowSize:             #type (vp: *Viewport) -> Vector2 #c_call #cpp_return_type_is_non_pod; // N . . . .  // Get platform window client area size
    Platform_GetWindowFramebufferScale: #type (vp: *Viewport) -> Vector2 #c_call #cpp_return_type_is_non_pod; // N . . . .  // Return viewport density. Always 1,1 on Windows, often 2,2 on Retina display on macOS/iOS. MUST BE INTEGER VALUES.
    Platform_SetWindowFocus:            #type (vp: *Viewport) -> void #c_call; // N . . . .  // Move window to front and set input focus
    Platform_GetWindowFocus:            #type (vp: *Viewport) -> bool #c_call; // . . U . .  //
    Platform_GetWindowMinimized:        #type (vp: *Viewport) -> bool #c_call; // N . . . .  // Get platform window minimized state. When minimized, we generally won't attempt to get/set size and contents will be culled more easily
    Platform_SetWindowTitle:            #type (vp: *Viewport, str: *u8) -> void #c_call; // . . U . .  // Set platform window title (given an UTF-8 string)
    Platform_SetWindowAlpha:            #type (vp: *Viewport, alpha: float) -> void #c_call; // . . U . .  // (Optional) Setup global transparency (not per-pixel transparency)
    Platform_UpdateWindow:              #type (vp: *Viewport) -> void #c_call; // . . U . .  // (Optional) Called by UpdatePlatformWindows(). Optional hook to allow the platform backend from doing general book-keeping every frame.
    Platform_RenderWindow:              #type (vp: *Viewport, render_arg: *void) -> void #c_call; // . . . R .  // (Optional) Main rendering (platform side! This is often unused, or just setting a "current" context for OpenGL bindings). 'render_arg' is the value passed to RenderPlatformWindowsDefault().
    Platform_SwapBuffers:               #type (vp: *Viewport, render_arg: *void) -> void #c_call; // . . . R .  // (Optional) Call Present/SwapBuffers (platform side! This is often unused!). 'render_arg' is the value passed to RenderPlatformWindowsDefault().
    Platform_GetWindowDpiScale:         #type (vp: *Viewport) -> float #c_call; // N . . . .  // (Optional) [BETA] FIXME-DPI: DPI handling: Return DPI scale for this viewport. 1.0f = 96 DPI.
    Platform_OnChangedViewport:         #type (vp: *Viewport) -> void #c_call; // . F . . .  // (Optional) [BETA] FIXME-DPI: DPI handling: Called during Begin() every time the viewport we are outputting into changes, so backend has a chance to swap fonts to adjust style.
    Platform_GetWindowWorkAreaInsets:   #type (vp: *Viewport) -> Vector4 #c_call #cpp_return_type_is_non_pod; // N . . . .  // (Optional) [BETA] Get initial work area inset for the viewport (won't be covered by main menu bar, dockspace over viewport etc.). Default to (0,0),(0,0). 'safeAreaInsets' in iOS land, 'DisplayCutout' in Android land.
    Platform_CreateVkSurface:           #type (vp: *Viewport, vk_inst: U64, vk_allocators: *void, out_vk_surface: *U64) -> s32 #c_call; // (Optional) For a Vulkan Renderer to call into Platform code (since the surface creation needs to tie them both).

    Renderer_CreateWindow:              #type (vp: *Viewport) -> void #c_call; // . . U . .  // Create swap chain, frame buffers etc. (called after Platform_CreateWindow)
    Renderer_DestroyWindow:             #type (vp: *Viewport) -> void #c_call; // N . U . D  // Destroy swap chain, frame buffers etc. (called before Platform_DestroyWindow)
    Renderer_SetWindowSize:             #type (vp: *Viewport, size: Vector2) -> void #c_call; // . . U . .  // Resize swap chain, frame buffers etc. (called after Platform_SetWindowSize)
    Renderer_RenderWindow:              #type (vp: *Viewport, render_arg: *void) -> void #c_call; // . . . R .  // (Optional) Clear framebuffer, setup render target, then render the viewport->DrawData. 'render_arg' is the value passed to RenderPlatformWindowsDefault().
    Renderer_SwapBuffers:               #type (vp: *Viewport, render_arg: *void) -> void #c_call; // . . . R .  // (Optional) Call Present/SwapBuffers. 'render_arg' is the value passed to RenderPlatformWindowsDefault().

    // (Optional) Monitor list
    // - Updated by: app/backend. Update every frame to dynamically support changing monitor or DPI configuration.
    // - Used by: dear imgui to query DPI info, clamp popups/tooltips within same monitor and not have them straddle monitors.
    Monitors:                           Vector(PlatformMonitor);

    Textures:                           Vector(*TextureData); // List of textures used by Dear ImGui (most often 1) + contents of external texture list is automatically appended into this.

    Viewports:                          Vector(*Viewport); // Main viewports, followed by all secondary viewports.
}

// (Optional) This is required when enabling multi-viewport. Represent the bounds of each connected monitor/display and their DPI.
// We use this information for multiple DPI support + clamping the position of popups and tooltips so they don't straddle multiple monitors.
PlatformMonitor :: struct {
    MainPos:        Vector2; // Coordinates of the area displayed on this monitor (Min = upper left, Max = bottom right)
    MainSize:       Vector2; // Coordinates of the area displayed on this monitor (Min = upper left, Max = bottom right)
    WorkPos:        Vector2; // Coordinates without task bars / side bars / menu bars. Used to avoid positioning popups/tooltips inside this region. If you don't have this info, please copy the value for MainPos/MainSize.
    WorkSize:       Vector2; // Coordinates without task bars / side bars / menu bars. Used to avoid positioning popups/tooltips inside this region. If you don't have this info, please copy the value for MainPos/MainSize.
    DpiScale:       float; // 1.0f = 96 DPI
    PlatformHandle: *void; // Backend dependant data (e.g. HMONITOR, GLFWmonitor*, SDL Display Index, NSScreen*)
    Constructor :: (this: *PlatformMonitor) -> void #cpp_method #foreign ImGui "??0ImGuiPlatformMonitor@@QEAA@XZ";
}

// (Optional) Support for IME (Input Method Editor) via the platform_io.Platform_SetImeDataFn() function. Handler is called during EndFrame().
PlatformImeData :: struct {
    WantVisible:     bool; // A widget wants the IME to be visible.
    WantTextInput:   bool; // A widget wants text input, not necessarily IME to be visible. This is automatically set to the upcoming value of io.WantTextInput.
    InputPos:        Vector2; // Position of input cursor (for IME).
    InputLineHeight: float; // Line height (for IME).
    ViewportId:      ID; // ID of platform window/viewport.

    Constructor :: (this: *PlatformImeData) -> void #cpp_method #foreign ImGui "??0ImGuiPlatformImeData@@QEAA@XZ";
}

DockRequest :: struct {}

DockNodeSettings :: struct {}

InputTextDeactivateData :: struct {}

TableColumnsSettings :: struct {}

// Enumerations
// Use your programming IDE "Go to definition" facility on the names of the center columns to find the actual flags/enum lists.
LocKey :: enum s32 {
    VersionStr                    :: 0;
    TableSizeOne                  :: 1;
    TableSizeAllFit               :: 2;
    TableSizeAllDefault           :: 3;
    TableResetOrder               :: 4;
    WindowingMainMenuBar          :: 5;
    WindowingPopup                :: 6;
    WindowingUntitled             :: 7;
    OpenLink_s                    :: 8;
    CopyLink                      :: 9;
    DockingHideTabBar             :: 10;
    DockingHoldShiftToDock        :: 11;
    DockingDragToUndockOrMoveNode :: 12;
    COUNT                         :: 13;
}

// Table column indexing
TableColumnIdx :: S16;
TableDrawChannelIdx :: U16;

GImGui: *ImGuiContext #elsewhere ImGui "?GImGui@@3PEAUImGuiContext@@EA"; // Current implicit context pointer

// Helpers: Hashing
HashData :: (data: *void, data_size: u64, seed: ID = 0) -> ID #foreign ImGui "?ImHashData@@YAIPEBX_KI@Z";
HashStr :: (data: *u8, data_size: u64 = 0, seed: ID = 0) -> ID #foreign ImGui "?ImHashStr@@YAIPEBD_KI@Z";
HashSkipUncontributingPrefix :: (label: *u8) -> *u8 #foreign ImGui "?ImHashSkipUncontributingPrefix@@YAPEBDPEBD@Z";

Qsort :: (base: *void, count: u64, size_of_element: u64, compare_func: #type (unknown0: *void, unknown1: *void) -> s32 #c_call) -> void #foreign ImGui "?ImQsort@@YAXPEAX_K1P6AHPEBX2@Z@Z";

// Helpers: Color Blending
AlphaBlendColors :: (col_a: U32, col_b: U32) -> U32 #foreign ImGui "?ImAlphaBlendColors@@YAIII@Z";

// Helpers: Bit manipulation
IsPowerOfTwo :: (v: s32) -> bool #foreign ImGui "?ImIsPowerOfTwo@@YA_NH@Z";

UpperPowerOfTwo :: (v: s32) -> s32 #foreign ImGui "?ImUpperPowerOfTwo@@YAHH@Z";
CountSetBits :: (v: u32) -> u32 #foreign ImGui "?ImCountSetBits@@YAII@Z";

Stricmp :: (str1: *u8, str2: *u8) -> s32 #foreign ImGui "?ImStricmp@@YAHPEBD0@Z";
Strnicmp :: (str1: *u8, str2: *u8, count: u64) -> s32 #foreign ImGui "?ImStrnicmp@@YAHPEBD0_K@Z";
Strncpy :: (dst: *u8, src: *u8, count: u64) -> void #foreign ImGui "?ImStrncpy@@YAXPEADPEBD_K@Z";
Strdup :: (str: *u8) -> *u8 #foreign ImGui "?ImStrdup@@YAPEADPEBD@Z";
Memdup :: (src: *void, size: u64) -> *void #foreign ImGui "?ImMemdup@@YAPEAXPEBX_K@Z";
Strdupcpy :: (dst: *u8, p_dst_size: *u64, str: *u8) -> *u8 #foreign ImGui "?ImStrdupcpy@@YAPEADPEADPEA_KPEBD@Z";
StrchrRange :: (str_begin: *u8, str_end: *u8, c: u8) -> *u8 #foreign ImGui "?ImStrchrRange@@YAPEBDPEBD0D@Z";
StrchrRange :: (str: string, c: u8) -> *u8 #no_context {
    return StrchrRange(str.data, str.data + str.count, c);
}
StreolRange :: (str: *u8, str_end: *u8) -> *u8 #foreign ImGui "?ImStreolRange@@YAPEBDPEBD0@Z";
StreolRange :: (str: string) -> *u8 #no_context {
    return StreolRange(str.data, str.data + str.count);
}
Stristr :: (haystack: *u8, haystack_end: *u8, needle: *u8, needle_end: *u8) -> *u8 #foreign ImGui "?ImStristr@@YAPEBDPEBD000@Z";
Stristr :: (haystack: string, needle: string) -> *u8 #no_context {
    return Stristr(haystack.data, haystack.data + haystack.count, needle.data, needle.data + needle.count);
}
StrTrimBlanks :: (str: *u8) -> void #foreign ImGui "?ImStrTrimBlanks@@YAXPEAD@Z";
StrSkipBlank :: (str: *u8) -> *u8 #foreign ImGui "?ImStrSkipBlank@@YAPEBDPEBD@Z";
StrlenW :: (str: *Wchar) -> s32 #foreign ImGui "?ImStrlenW@@YAHPEBG@Z";
Strbol :: (buf_mid_line: *u8, buf_begin: *u8) -> *u8 #foreign ImGui "?ImStrbol@@YAPEBDPEBD0@Z";

ToUpper :: (c: u8) -> u8 #foreign ImGui "?ImToUpper@@YADD@Z";
CharIsBlankA :: (c: u8) -> bool #foreign ImGui "?ImCharIsBlankA@@YA_ND@Z";
CharIsBlankW :: (c: u32) -> bool #foreign ImGui "?ImCharIsBlankW@@YA_NI@Z";
CharIsXdigitA :: (c: u8) -> bool #foreign ImGui "?ImCharIsXdigitA@@YA_ND@Z";

// Helpers: Formatting
FormatString_CFormat :: (buf: *u8, buf_size: u64, fmt: *u8, __args: ..Any) -> s32 #foreign ImGui "?ImFormatString@@YAHPEAD_KPEBDZZ";
FormatString :: (buf: *u8, buf_size: u64, fmt: string, __args: ..Any) -> s32 {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    return FormatString_CFormat(buf, buf_size, "%s", formatted_text.data);
} @PrintLike

FormatStringToTempBuffer_CFormat :: (out_buf: **u8, out_buf_end: **u8, fmt: *u8, __args: ..Any) -> void #foreign ImGui "?ImFormatStringToTempBuffer@@YAXPEAPEBD0PEBDZZ";
FormatStringToTempBuffer :: (out_buf: **u8, out_buf_end: **u8, fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    FormatStringToTempBuffer_CFormat(out_buf, out_buf_end, "%s", formatted_text.data);
} @PrintLike

ParseFormatFindStart :: (format: *u8) -> *u8 #foreign ImGui "?ImParseFormatFindStart@@YAPEBDPEBD@Z";
ParseFormatFindEnd :: (format: *u8) -> *u8 #foreign ImGui "?ImParseFormatFindEnd@@YAPEBDPEBD@Z";
ParseFormatTrimDecorations :: (format: *u8, buf: *u8, buf_size: u64) -> *u8 #foreign ImGui "?ImParseFormatTrimDecorations@@YAPEBDPEBDPEAD_K@Z";
ParseFormatSanitizeForPrinting :: (fmt_in: *u8, fmt_out: *u8, fmt_out_size: u64) -> void #foreign ImGui "?ImParseFormatSanitizeForPrinting@@YAXPEBDPEAD_K@Z";
ParseFormatSanitizeForScanning :: (fmt_in: *u8, fmt_out: *u8, fmt_out_size: u64) -> *u8 #foreign ImGui "?ImParseFormatSanitizeForScanning@@YAPEBDPEBDPEAD_K@Z";
ParseFormatPrecision :: (format: *u8, default_value: s32) -> s32 #foreign ImGui "?ImParseFormatPrecision@@YAHPEBDH@Z";

// Helpers: UTF-8 <> wchar conversions
TextCharToUtf8 :: (out_buf: *[5] u8, c: u32) -> s32 #foreign ImGui "?ImTextCharToUtf8@@YAHQEADI@Z";
TextStrToUtf8 :: (out_buf: *u8, out_buf_size: s32, in_text: *Wchar, in_text_end: *Wchar) -> s32 #foreign ImGui "?ImTextStrToUtf8@@YAHPEADHPEBG1@Z";
TextCharFromUtf8 :: (out_char: *u32, in_text: *u8, in_text_end: *u8) -> s32 #foreign ImGui "?ImTextCharFromUtf8@@YAHPEAIPEBD1@Z";
TextCharFromUtf8 :: (out_char: *u32, in_text: string) -> s32 #no_context {
    return TextCharFromUtf8(out_char, in_text.data, in_text.data + in_text.count);
}
TextStrFromUtf8 :: (out_buf: *Wchar, out_buf_size: s32, in_text: *u8, in_text_end: *u8, in_remaining: **u8 = null) -> s32 #foreign ImGui "?ImTextStrFromUtf8@@YAHPEAGHPEBD1PEAPEBD@Z";
TextStrFromUtf8 :: (out_buf: *Wchar, out_buf_size: s32, in_text: string, in_remaining: **u8 = null) -> s32 #no_context {
    return TextStrFromUtf8(out_buf, out_buf_size, in_text.data, in_text.data + in_text.count, in_remaining);
}
TextCountCharsFromUtf8 :: (in_text: *u8, in_text_end: *u8) -> s32 #foreign ImGui "?ImTextCountCharsFromUtf8@@YAHPEBD0@Z";
TextCountCharsFromUtf8 :: (in_text: string) -> s32 #no_context {
    return TextCountCharsFromUtf8(in_text.data, in_text.data + in_text.count);
}
TextCountUtf8BytesFromChar :: (in_text: *u8, in_text_end: *u8) -> s32 #foreign ImGui "?ImTextCountUtf8BytesFromChar@@YAHPEBD0@Z";
TextCountUtf8BytesFromChar :: (in_text: string) -> s32 #no_context {
    return TextCountUtf8BytesFromChar(in_text.data, in_text.data + in_text.count);
}
TextCountUtf8BytesFromStr :: (in_text: *Wchar, in_text_end: *Wchar) -> s32 #foreign ImGui "?ImTextCountUtf8BytesFromStr@@YAHPEBG0@Z";
TextFindPreviousUtf8Codepoint :: (in_text_start: *u8, in_text_curr: *u8) -> *u8 #foreign ImGui "?ImTextFindPreviousUtf8Codepoint@@YAPEBDPEBD0@Z";
TextCountLines :: (in_text: *u8, in_text_end: *u8) -> s32 #foreign ImGui "?ImTextCountLines@@YAHPEBD0@Z";
TextCountLines :: (in_text: string) -> s32 #no_context {
    return TextCountLines(in_text.data, in_text.data + in_text.count);
}

// Helpers: High-level text functions (DO NOT USE!!! THIS IS A MINIMAL SUBSET OF LARGER UPCOMING CHANGES)
DrawTextFlags :: enum_flags s32 {
    None           :: 0x0;
    CpuFineClip    :: 0x1;
    WrapKeepBlanks :: 0x2;
    StopOnNewLine  :: 0x4;
}

FontCalcTextSizeEx :: (font: *Font, size: float, max_width: float, wrap_width: float, text_begin: *u8, text_end_display: *u8, text_end: *u8, out_remaining: **u8, out_offset: *Vector2, flags: DrawTextFlags) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImFontCalcTextSizeEx@@YA?AUImVec2@@PEAUImFont@@MMMPEBD11PEAPEBDPEAU1@H@Z";
FontCalcWordWrapPositionEx :: (font: *Font, size: float, text: *u8, text_end: *u8, wrap_width: float, flags: DrawTextFlags = .None) -> *u8 #foreign ImGui "?ImFontCalcWordWrapPositionEx@@YAPEBDPEAUImFont@@MPEBD1MH@Z";
FontCalcWordWrapPositionEx :: (font: *Font, size: float, text: string, wrap_width: float, flags: DrawTextFlags = .None) -> *u8 #no_context {
    return FontCalcWordWrapPositionEx(font, size, text.data, text.data + text.count, wrap_width, flags);
}
TextCalcWordWrapNextLineStart :: (text: *u8, text_end: *u8, flags: DrawTextFlags = .None) -> *u8 #foreign ImGui "?ImTextCalcWordWrapNextLineStart@@YAPEBDPEBD0H@Z";
TextCalcWordWrapNextLineStart :: (text: string, flags: DrawTextFlags = .None) -> *u8 #no_context {
    return TextCalcWordWrapNextLineStart(text.data, text.data + text.count, flags);
}

//FileHandle :: *FILE;
//FileOpen :: (filename: *u8, mode: *u8) -> FileHandle #foreign ImGui "?ImFileOpen@@YAPEAU_iobuf@@PEBD0@Z";
//FileClose :: (file: FileHandle) -> bool #foreign ImGui "?ImFileClose@@YA_NPEAU_iobuf@@@Z";
//FileGetSize :: (file: FileHandle) -> U64 #foreign ImGui "?ImFileGetSize@@YA_KPEAU_iobuf@@@Z";
//FileRead :: (data: *void, size: U64, count: U64, file: FileHandle) -> U64 #foreign ImGui "?ImFileRead@@YA_KPEAX_K1PEAU_iobuf@@@Z";
//FileWrite :: (data: *void, size: U64, count: U64, file: FileHandle) -> U64 #foreign ImGui "?ImFileWrite@@YA_KPEBX_K1PEAU_iobuf@@@Z";

FileLoadToMemory :: (filename: *u8, mode: *u8, out_file_size: *u64 = null, padding_bytes: s32 = 0) -> *void #foreign ImGui "?ImFileLoadToMemory@@YAPEAXPEBD0PEA_KH@Z";

Pow :: (x: float, y: float) -> float #foreign ImGui "?ImPow@@YAMMM@Z";
Pow :: (x: float64, y: float64) -> float64 #foreign ImGui "?ImPow@@YANNN@Z";
Log :: (x: float) -> float #foreign ImGui "?ImLog@@YAMM@Z";
Log :: (x: float64) -> float64 #foreign ImGui "?ImLog@@YANN@Z";
Abs :: (x: s32) -> s32 #foreign ImGui "?ImAbs@@YAHH@Z";
Abs :: (x: float) -> float #foreign ImGui "?ImAbs@@YAMM@Z";
Abs :: (x: float64) -> float64 #foreign ImGui "?ImAbs@@YANN@Z";
Sign :: (x: float) -> float #foreign ImGui "?ImSign@@YAMM@Z";

Rsqrt :: (x: float) -> float #foreign ImGui "?ImRsqrt@@YAMM@Z";

// - Misc maths helpers
Min :: (lhs: *Vector2, rhs: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImMin@@YA?AUImVec2@@AEBU1@0@Z";
Min :: (lhs: Vector2, rhs: Vector2) -> Vector2 #no_context {
    return Min(*lhs, *rhs);
}
Max :: (lhs: *Vector2, rhs: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImMax@@YA?AUImVec2@@AEBU1@0@Z";
Max :: (lhs: Vector2, rhs: Vector2) -> Vector2 #no_context {
    return Max(*lhs, *rhs);
}
Clamp :: (v: *Vector2, mn: *Vector2, mx: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImClamp@@YA?AUImVec2@@AEBU1@00@Z";
Clamp :: (v: Vector2, mn: Vector2, mx: Vector2) -> Vector2 #no_context {
    return Clamp(*v, *mn, *mx);
}
Lerp :: (a: *Vector2, b: *Vector2, t: float) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImLerp@@YA?AUImVec2@@AEBU1@0M@Z";
Lerp :: (a: Vector2, b: Vector2, t: float) -> Vector2 #no_context {
    return Lerp(*a, *b, t);
}
Lerp :: (a: *Vector2, b: *Vector2, t: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImLerp@@YA?AUImVec2@@AEBU1@00@Z";
Lerp :: (a: Vector2, b: Vector2, t: Vector2) -> Vector2 #no_context {
    return Lerp(*a, *b, *t);
}
Lerp :: (a: *Vector4, b: *Vector4, t: float) -> Vector4 #cpp_return_type_is_non_pod #foreign ImGui "?ImLerp@@YA?AUImVec4@@AEBU1@0M@Z";
Lerp :: (a: Vector4, b: Vector4, t: float) -> Vector4 #no_context {
    return Lerp(*a, *b, t);
}
Saturate :: (f: float) -> float #foreign ImGui "?ImSaturate@@YAMM@Z";
LengthSqr :: (lhs: *Vector2) -> float #foreign ImGui "?ImLengthSqr@@YAMAEBUImVec2@@@Z";
LengthSqr :: (lhs: Vector2) -> float #no_context {
    return LengthSqr(*lhs);
}

Trunc :: (f: float) -> float #foreign ImGui "?ImTrunc@@YAMM@Z";
Trunc :: (v: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImTrunc@@YA?AUImVec2@@AEBU1@@Z";
Trunc :: (v: Vector2) -> Vector2 #no_context {
    return Trunc(*v);
}
Floor :: (f: float) -> float #foreign ImGui "?ImFloor@@YAMM@Z";
Floor :: (v: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImFloor@@YA?AUImVec2@@AEBU1@@Z";
Floor :: (v: Vector2) -> Vector2 #no_context {
    return Floor(*v);
}
Trunc64 :: (f: float) -> float #foreign ImGui "?ImTrunc64@@YAMM@Z";
Round64 :: (f: float) -> float #foreign ImGui "?ImRound64@@YAMM@Z";

Dot :: (a: *Vector2, b: *Vector2) -> float #foreign ImGui "?ImDot@@YAMAEBUImVec2@@0@Z";
Dot :: (a: Vector2, b: Vector2) -> float #no_context {
    return Dot(*a, *b);
}
Rotate :: (v: *Vector2, cos_a: float, sin_a: float) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImRotate@@YA?AUImVec2@@AEBU1@MM@Z";
Rotate :: (v: Vector2, cos_a: float, sin_a: float) -> Vector2 #no_context {
    return Rotate(*v, cos_a, sin_a);
}
LinearSweep :: (current: float, target: float, speed: float) -> float #foreign ImGui "?ImLinearSweep@@YAMMMM@Z";
LinearRemapClamp :: (s0: float, s1: float, d0: float, d1: float, x: float) -> float #foreign ImGui "?ImLinearRemapClamp@@YAMMMMMM@Z";
Mul :: (lhs: *Vector2, rhs: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImMul@@YA?AUImVec2@@AEBU1@0@Z";
Mul :: (lhs: Vector2, rhs: Vector2) -> Vector2 #no_context {
    return Mul(*lhs, *rhs);
}
IsFloatAboveGuaranteedIntegerPrecision :: (f: float) -> bool #foreign ImGui "?ImIsFloatAboveGuaranteedIntegerPrecision@@YA_NM@Z";
ExponentialMovingAverage :: (avg: float, sample: float, n: s32) -> float #foreign ImGui "?ImExponentialMovingAverage@@YAMMMH@Z";

// Helpers: Geometry
BezierCubicCalc :: (p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, t: float) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImBezierCubicCalc@@YA?AUImVec2@@AEBU1@000M@Z";
BezierCubicCalc :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: float) -> Vector2 #no_context {
    return BezierCubicCalc(*p1, *p2, *p3, *p4, t);
}
BezierCubicClosestPoint :: (p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, p: *Vector2, num_segments: s32) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImBezierCubicClosestPoint@@YA?AUImVec2@@AEBU1@0000H@Z";
BezierCubicClosestPoint :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, p: Vector2, num_segments: s32) -> Vector2 #no_context {
    return BezierCubicClosestPoint(*p1, *p2, *p3, *p4, *p, num_segments);
}
BezierCubicClosestPointCasteljau :: (p1: *Vector2, p2: *Vector2, p3: *Vector2, p4: *Vector2, p: *Vector2, tess_tol: float) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImBezierCubicClosestPointCasteljau@@YA?AUImVec2@@AEBU1@0000M@Z";
BezierCubicClosestPointCasteljau :: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, p: Vector2, tess_tol: float) -> Vector2 #no_context {
    return BezierCubicClosestPointCasteljau(*p1, *p2, *p3, *p4, *p, tess_tol);
}
BezierQuadraticCalc :: (p1: *Vector2, p2: *Vector2, p3: *Vector2, t: float) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImBezierQuadraticCalc@@YA?AUImVec2@@AEBU1@00M@Z";
BezierQuadraticCalc :: (p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2 #no_context {
    return BezierQuadraticCalc(*p1, *p2, *p3, t);
}
LineClosestPoint :: (a: *Vector2, b: *Vector2, p: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImLineClosestPoint@@YA?AUImVec2@@AEBU1@00@Z";
LineClosestPoint :: (a: Vector2, b: Vector2, p: Vector2) -> Vector2 #no_context {
    return LineClosestPoint(*a, *b, *p);
}
TriangleContainsPoint :: (a: *Vector2, b: *Vector2, c: *Vector2, p: *Vector2) -> bool #foreign ImGui "?ImTriangleContainsPoint@@YA_NAEBUImVec2@@000@Z";
TriangleContainsPoint :: (a: Vector2, b: Vector2, c: Vector2, p: Vector2) -> bool #no_context {
    return TriangleContainsPoint(*a, *b, *c, *p);
}
TriangleClosestPoint :: (a: *Vector2, b: *Vector2, c: *Vector2, p: *Vector2) -> Vector2 #cpp_return_type_is_non_pod #foreign ImGui "?ImTriangleClosestPoint@@YA?AUImVec2@@AEBU1@000@Z";
TriangleClosestPoint :: (a: Vector2, b: Vector2, c: Vector2, p: Vector2) -> Vector2 #no_context {
    return TriangleClosestPoint(*a, *b, *c, *p);
}
TriangleBarycentricCoords :: (a: *Vector2, b: *Vector2, c: *Vector2, p: *Vector2, out_u: *float, out_v: *float, out_w: *float) -> void #foreign ImGui "?ImTriangleBarycentricCoords@@YAXAEBUImVec2@@000AEAM11@Z";
TriangleBarycentricCoords :: (a: Vector2, b: Vector2, c: Vector2, p: Vector2, out_u: *float, out_v: *float, out_w: *float) #no_context {
    TriangleBarycentricCoords(*a, *b, *c, *p, out_u, out_v, out_w);
}
TriangleArea :: (a: *Vector2, b: *Vector2, c: *Vector2) -> float #foreign ImGui "?ImTriangleArea@@YAMAEBUImVec2@@00@Z";
TriangleArea :: (a: Vector2, b: Vector2, c: Vector2) -> float #no_context {
    return TriangleArea(*a, *b, *c);
}
TriangleIsClockwise :: (a: *Vector2, b: *Vector2, c: *Vector2) -> bool #foreign ImGui "?ImTriangleIsClockwise@@YA_NAEBUImVec2@@00@Z";
TriangleIsClockwise :: (a: Vector2, b: Vector2, c: Vector2) -> bool #no_context {
    return TriangleIsClockwise(*a, *b, *c);
}

// Helper: ImVec1 (1D vector)
// (this odd construct is used to facilitate the transition between 1D and 2D, and the maintenance of some branches/patches)
Vec1 :: struct {
    x: float;
    Constructor :: (this: *Vec1) -> void #cpp_method #foreign ImGui "??0ImVec1@@QEAA@XZ";
}

// Helper: ImVec2i (2D vector, integer)
Vec2i :: struct {
    x: s32;
    y: s32;
    Constructor :: (this: *Vec2i) -> void #cpp_method #foreign ImGui "??0ImVec2i@@QEAA@XZ";
    Constructor :: (this: *Vec2i, _x: s32, _y: s32) -> void #cpp_method #foreign ImGui "??0ImVec2i@@QEAA@HH@Z";
}

// Helper: ImVec2ih (2D vector, half-size integer, for long-term packed storage)
Vec2ih :: struct {
    x: s16;
    y: s16;
    Constructor :: (this: *Vec2ih) -> void #cpp_method #foreign ImGui "??0ImVec2ih@@QEAA@XZ";
    Constructor :: (this: *Vec2ih, _x: s16, _y: s16) -> void #cpp_method #foreign ImGui "??0ImVec2ih@@QEAA@FF@Z";
    Constructor :: (this: *Vec2ih, rhs: *Vector2) -> void #cpp_method #foreign ImGui "??0ImVec2ih@@QEAA@AEBUImVec2@@@Z";
    Constructor :: (this: *Vec2ih, rhs: Vector2) #no_context {
        Constructor(this, *rhs);
    }
}

// Helper: ImRect (2D axis aligned bounding-box)
// NB: we can't rely on ImVec2 math operators being available here!
Rect :: struct {
    Min: Vector2; // Upper-left
    Max: Vector2; // Lower-right

    Constructor :: (this: *Rect) -> void #cpp_method #foreign ImGui "??0ImRect@@QEAA@XZ";
    Constructor :: (this: *Rect, min: *Vector2, max: *Vector2) -> void #cpp_method #foreign ImGui "??0ImRect@@QEAA@AEBUImVec2@@0@Z";
    Constructor :: (this: *Rect, min: Vector2, max: Vector2) #no_context {
        Constructor(this, *min, *max);
    }
    Constructor :: (this: *Rect, v: *Vector4) -> void #cpp_method #foreign ImGui "??0ImRect@@QEAA@AEBUImVec4@@@Z";
    Constructor :: (this: *Rect, v: Vector4) #no_context {
        Constructor(this, *v);
    }
    Constructor :: (this: *Rect, x1: float, y1: float, x2: float, y2: float) -> void #cpp_method #foreign ImGui "??0ImRect@@QEAA@MMMM@Z";

    GetCenter :: (this: *Rect) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetCenter@ImRect@@QEBA?AUImVec2@@XZ";
    GetSize :: (this: *Rect) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetSize@ImRect@@QEBA?AUImVec2@@XZ";
    GetWidth :: (this: *Rect) -> float #cpp_method #foreign ImGui "?GetWidth@ImRect@@QEBAMXZ";
    GetHeight :: (this: *Rect) -> float #cpp_method #foreign ImGui "?GetHeight@ImRect@@QEBAMXZ";
    GetArea :: (this: *Rect) -> float #cpp_method #foreign ImGui "?GetArea@ImRect@@QEBAMXZ";
    GetTL :: (this: *Rect) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetTL@ImRect@@QEBA?AUImVec2@@XZ";
    GetTR :: (this: *Rect) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetTR@ImRect@@QEBA?AUImVec2@@XZ";
    GetBL :: (this: *Rect) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetBL@ImRect@@QEBA?AUImVec2@@XZ";
    GetBR :: (this: *Rect) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetBR@ImRect@@QEBA?AUImVec2@@XZ";
    Contains :: (this: *Rect, p: *Vector2) -> bool #cpp_method #foreign ImGui "?Contains@ImRect@@QEBA_NAEBUImVec2@@@Z";
    Contains :: (this: *Rect, p: Vector2) -> bool #no_context {
        return Contains(this, *p);
    }
    Contains :: (this: *Rect, r: *Rect) -> bool #cpp_method #foreign ImGui "?Contains@ImRect@@QEBA_NAEBU1@@Z";
    Contains :: (this: *Rect, r: Rect) -> bool #no_context {
        return Contains(this, *r);
    }
    ContainsWithPad :: (this: *Rect, p: *Vector2, pad: *Vector2) -> bool #cpp_method #foreign ImGui "?ContainsWithPad@ImRect@@QEBA_NAEBUImVec2@@0@Z";
    ContainsWithPad :: (this: *Rect, p: Vector2, pad: Vector2) -> bool #no_context {
        return ContainsWithPad(this, *p, *pad);
    }
    Overlaps :: (this: *Rect, r: *Rect) -> bool #cpp_method #foreign ImGui "?Overlaps@ImRect@@QEBA_NAEBU1@@Z";
    Overlaps :: (this: *Rect, r: Rect) -> bool #no_context {
        return Overlaps(this, *r);
    }
    Add :: (this: *Rect, p: *Vector2) -> void #cpp_method #foreign ImGui "?Add@ImRect@@QEAAXAEBUImVec2@@@Z";
    Add :: (this: *Rect, p: Vector2) #no_context {
        Add(this, *p);
    }
    Add :: (this: *Rect, r: *Rect) -> void #cpp_method #foreign ImGui "?Add@ImRect@@QEAAXAEBU1@@Z";
    Add :: (this: *Rect, r: Rect) #no_context {
        Add(this, *r);
    }
    Expand :: (this: *Rect, amount: float) -> void #cpp_method #foreign ImGui "?Expand@ImRect@@QEAAXM@Z";
    Expand :: (this: *Rect, amount: *Vector2) -> void #cpp_method #foreign ImGui "?Expand@ImRect@@QEAAXAEBUImVec2@@@Z";
    Expand :: (this: *Rect, amount: Vector2) #no_context {
        Expand(this, *amount);
    }
    Translate :: (this: *Rect, d: *Vector2) -> void #cpp_method #foreign ImGui "?Translate@ImRect@@QEAAXAEBUImVec2@@@Z";
    Translate :: (this: *Rect, d: Vector2) #no_context {
        Translate(this, *d);
    }
    TranslateX :: (this: *Rect, dx: float) -> void #cpp_method #foreign ImGui "?TranslateX@ImRect@@QEAAXM@Z";
    TranslateY :: (this: *Rect, dy: float) -> void #cpp_method #foreign ImGui "?TranslateY@ImRect@@QEAAXM@Z";
    ClipWith :: (this: *Rect, r: *Rect) -> void #cpp_method #foreign ImGui "?ClipWith@ImRect@@QEAAXAEBU1@@Z";
    ClipWith :: (this: *Rect, r: Rect) #no_context {
        ClipWith(this, *r);
    }
    ClipWithFull :: (this: *Rect, r: *Rect) -> void #cpp_method #foreign ImGui "?ClipWithFull@ImRect@@QEAAXAEBU1@@Z";
    ClipWithFull :: (this: *Rect, r: Rect) #no_context {
        ClipWithFull(this, *r);
    }

    IsInverted :: (this: *Rect) -> bool #cpp_method #foreign ImGui "?IsInverted@ImRect@@QEBA_NXZ";
    ToVec4 :: (this: *Rect) -> Vector4 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?ToVec4@ImRect@@QEBA?AUImVec4@@XZ";
    AsVec4 :: (this: *Rect) -> *Vector4 #cpp_method #foreign ImGui "?AsVec4@ImRect@@QEBAAEBUImVec4@@XZ";
}

BitArrayGetStorageSizeInBytes :: (bitcount: s32) -> u64 #foreign ImGui "?ImBitArrayGetStorageSizeInBytes@@YA_KH@Z";
BitArrayClearAllBits :: (arr: *U32, bitcount: s32) -> void #foreign ImGui "?ImBitArrayClearAllBits@@YAXPEAIH@Z";

BitArrayClearBit :: (arr: *U32, n: s32) -> void #foreign ImGui "?ImBitArrayClearBit@@YAXPEAIH@Z";
BitArraySetBit :: (arr: *U32, n: s32) -> void #foreign ImGui "?ImBitArraySetBit@@YAXPEAIH@Z";
BitArraySetBitRange :: (arr: *U32, n: s32, n2: s32) -> void #foreign ImGui "?ImBitArraySetBitRange@@YAXPEAIHH@Z";

BitArrayPtr :: *U32;

// Helper: ImBitArray class (wrapper over ImBitArray functions)
// Store 1-bit per value.
BitArray :: struct(BITCOUNT: s32, OFFSET: s32 = 0) {
    Storage: [(BITCOUNT + 31) >> 5] U32;
}

// Utilities
// (other types which are not forwarded declared are: ImBitArray<>, ImSpan<>, ImSpanAllocator<>, ImStableVector<>, ImPool<>, ImChunkStream<>)
BitVector :: struct {
    Storage: Vector(U32);
}

// Helper: ImSpan<>
// Pointing to a span of data we don't own.
Span :: struct(T: Type) {
    Data:    *T;
    DataEnd: *T;
}

// Helper: ImSpanAllocator<>
// Facilitate storing multiple chunks into a single large block (the "arena")
// - Usage: call Reserve() N times, allocate GetArenaSizeInBytes() worth, pass it to SetArenaBasePtr(), call GetSpan() N times to retrieve the aligned ranges.
SpanAllocator :: struct(CHUNKS: s32) {
    BasePtr: *u8;
    CurrOff: s32;
    CurrIdx: s32;
    Offsets: [CHUNKS] s32;
    Sizes:   [CHUNKS] s32;
}

// Helper: ImStableVector<>
// Allocating chunks of BLOCK_SIZE items. Objects pointers are never invalidated when growing, only by clear().
// Important: does not destruct anything!
// Implemented only the minimum set of functions we need for it.
StableVector :: struct(T: Type, BLOCK_SIZE: s32) {
    Size:     s32 = 0;
    Capacity: s32 = 0;
    Blocks:   Vector(*T);
}

// Helper: ImPool<>
// Basic keyed storage for contiguous instances, slow/amortized insertion, O(1) indexable, O(Log N) queries by ID over a dense/hot buffer,
// Honor constructor/destructor. Add/remove invalidate all pointers. Indexes have the same lifetime as the associated object.
PoolIdx :: s32;

Pool :: struct(T: Type) {
    Buf:        Vector(T); // Contiguous data
    Map:        Storage; // ID->Index
    FreeIdx:    PoolIdx; // Next free idx to use
    AliveCount: PoolIdx; // Number of active/alive items (for display purpose)
}

// Helper: ImChunkStream<>
// Build and iterate a contiguous stream of variable-sized structures.
// This is used by Settings to store persistent data while reducing allocation count.
// We store the chunk size first, and align the final size on 4 bytes boundaries.
// The tedious/zealous amount of casting is to avoid -Wcast-align warnings.
ChunkStream :: struct(T: Type) {
    Buf: Vector(u8);
}

// Helper: ImGuiTextIndex
// Maintain a line index for a text buffer. This is a strong candidate to be moved into the public API.
TextIndex :: struct {
    LineOffsets: Vector(s32);
    EndOffset:   s32 = 0; // Because we don't own text buffer we need to maintain EndOffset (may bake in LineOffsets?)

    clear :: (this: *TextIndex) -> void #cpp_method #foreign ImGui "?clear@ImGuiTextIndex@@QEAAXXZ";
    size :: (this: *TextIndex) -> s32 #cpp_method #foreign ImGui "?size@ImGuiTextIndex@@QEAAHXZ";
    get_line_begin :: (this: *TextIndex, base: *u8, n: s32) -> *u8 #cpp_method #foreign ImGui "?get_line_begin@ImGuiTextIndex@@QEAAPEBDPEBDH@Z";
    get_line_end :: (this: *TextIndex, base: *u8, n: s32) -> *u8 #cpp_method #foreign ImGui "?get_line_end@ImGuiTextIndex@@QEAAPEBDPEBDH@Z";
    append :: (this: *TextIndex, base: *u8, old_size: s32, new_size: s32) -> void #cpp_method #foreign ImGui "?append@ImGuiTextIndex@@QEAAXPEBDHH@Z";
}

// Helper: ImGuiStorage
LowerBound :: (in_begin: *StoragePair, in_end: *StoragePair, key: ID) -> *StoragePair #foreign ImGui "?ImLowerBound@@YAPEAUImGuiStoragePair@@PEAU1@0I@Z";

// Data shared between all ImDrawList instances
// Conceptually this could have been called e.g. ImDrawListSharedContext
// Typically one ImGui context would create and maintain one of this.
// You may want to create your own instance of you try to ImDrawList completely without ImGui. In that case, watch out for future changes to this structure.
DrawListSharedData :: struct {
    TexUvWhitePixel:       Vector2; // UV of white pixel in the atlas (== FontAtlas->TexUvWhitePixel)
    TexUvLines:            *Vector4; // UV of anti-aliased lines in the atlas (== FontAtlas->TexUvLines)
    FontAtlas_:            *FontAtlas; // Current font atlas
    Font_:                 *Font; // Current font (used for simplified AddText overload)
    FontSize:              float; // Current font size (used for for simplified AddText overload)
    FontScale:             float; // Current font scale (== FontSize / Font->FontSize)
    CurveTessellationTol:  float; // Tessellation tolerance when using PathBezierCurveTo()
    CircleSegmentMaxError: float; // Number of circle segments to use per pixel of radius for AddCircle() etc
    InitialFringeScale:    float; // Initial scale to apply to AA fringe
    InitialFlags:          DrawListFlags; // Initial flags at the beginning of the frame (it is possible to alter flags on a per-drawlist basis afterwards)
    ClipRectFullscreen:    Vector4; // Value for PushClipRectFullscreen()
    TempBuffer:            Vector(Vector2); // Temporary write buffer
    DrawLists:             Vector(*DrawList); // All draw lists associated to this ImDrawListSharedData
    Context:               *ImGuiContext; // [OPTIONAL] Link to Dear ImGui context. 99% of ImDrawList/ImFontAtlas can function without an ImGui context, but this facilitate handling one legacy edge case.

    ArcFastVtx:            [48] Vector2; // Sample points on the quarter of the circle.
    ArcFastRadiusCutoff:   float; // Cutoff radius after which arc drawing will fallback to slower PathArcTo()
    CircleSegmentCounts:   [64] U8; // Precomputed segment count for given radius before we calculate it dynamically (to avoid calculation overhead)

    Constructor :: (this: *DrawListSharedData) -> void #cpp_method #foreign ImGui "??0ImDrawListSharedData@@QEAA@XZ";
    Destructor :: (this: *DrawListSharedData) -> void #cpp_method #foreign ImGui "??1ImDrawListSharedData@@QEAA@XZ";
    SetCircleTessellationMaxError :: (this: *DrawListSharedData, max_error: float) -> void #cpp_method #foreign ImGui "?SetCircleTessellationMaxError@ImDrawListSharedData@@QEAAXM@Z";
}

// ImDrawList/ImFontAtlas
DrawDataBuilder :: struct {
    Layers:     [2] *Vector(*DrawList); // Pointers to global layers for: regular, tooltip. LayersP[0] is owned by DrawData.
    LayerData1: Vector(*DrawList);

    Constructor :: (this: *DrawDataBuilder) -> void #cpp_method #foreign ImGui "??0ImDrawDataBuilder@@QEAA@XZ";
}

FontStackData :: struct {
    Font_:                 *Font;
    FontSizeBeforeScaling: float; // ~~ style.FontSizeBase
    FontSizeAfterScaling:  float; // ~~ g.FontSize
}

//-----------------------------------------------------------------------------
// [SECTION] Style support
//-----------------------------------------------------------------------------
StyleVarInfo :: struct {
    Count:     U32; /* 8 bits */ // 1+
    DataType_: DataType #align 1; /* 8 bits */
    Offset:    U32 #align 2; /* 16 bits */ // Offset in parent structure
    GetVarPtr :: (this: *StyleVarInfo, parent: *void) -> *void #cpp_method #foreign ImGui "?GetVarPtr@ImGuiStyleVarInfo@@QEBAPEAXPEAX@Z";
}

// Stacked color modifier, backup of modified data so we can restore it
ColorMod :: struct {
    Col_:        Col;
    BackupValue: Vector4;
}

// Stacked style modifier, backup of modified data so we can restore it. Data type inferred from the variable.
StyleMod :: struct {
    VarIdx: StyleVar;
    union {
        BackupInt:   [2] s32;
        BackupFloat: [2] float;
    }

    Constructor :: (this: *StyleMod, idx: StyleVar, v: float) -> void #cpp_method #foreign ImGui "??0ImGuiStyleMod@@QEAA@HM@Z";
    Constructor :: (this: *StyleMod, idx: StyleVar, v: Vector2) -> void #cpp_method #foreign ImGui "??0ImGuiStyleMod@@QEAA@HUImVec2@@@Z";
}

//-----------------------------------------------------------------------------
// [SECTION] Data types support
//-----------------------------------------------------------------------------
DataTypeStorage :: struct {
    Data: [8] U8; // Opaque storage to fit any data up to ImGuiDataType_COUNT
}

// Type information associated to one ImGuiDataType. Retrieve with DataTypeGetInfo().
DataTypeInfo :: struct {
    Size:     u64; // Size in bytes
    Name:     *u8; // Short descriptive name for the type, for debugging
    PrintFmt: *u8; // Default printf format for the type
    ScanFmt:  *u8; // Default scanf format for the type
}

// Extend ImGuiDataType_
DataTypePrivate :: enum s32 {
    ImGuiDataType_Pointer :: 12;
    ImGuiDataType_ID      :: 13;
}

// Extend ImGuiItemFlags
// - input: PushItemFlag() manipulates g.CurrentItemFlags, g.NextItemData.ItemFlags, ItemAdd() calls may add extra flags too.
// - output: stored in g.LastItemData.ItemFlags
ItemFlagsPrivate :: enum s32 {
    ImGuiItemFlags_Disabled               :: 1024;
    ImGuiItemFlags_ReadOnly               :: 2048;
    ImGuiItemFlags_MixedValue             :: 4096;
    ImGuiItemFlags_NoWindowHoverableCheck :: 8192;
    ImGuiItemFlags_AllowOverlap           :: 16384;
    ImGuiItemFlags_NoNavDisableMouseHover :: 32768;
    ImGuiItemFlags_NoMarkEdited           :: 65536;
    ImGuiItemFlags_NoFocus                :: 131072;

    ImGuiItemFlags_Inputable              :: 1048576;
    ImGuiItemFlags_HasSelectionUserData   :: 2097152;
    ImGuiItemFlags_IsMultiSelect          :: 4194304;

    ImGuiItemFlags_Default_               :: 16;
}

// Status flags for an already submitted item
// - output: stored in g.LastItemData.StatusFlags
ItemStatusFlags :: enum_flags s32 {
    None             :: 0x0;
    HoveredRect      :: 0x1;
    HasDisplayRect   :: 0x2;
    Edited           :: 0x4;
    ToggledSelection :: 0x8;
    ToggledOpen      :: 0x10;
    HasDeactivated   :: 0x20;
    Deactivated      :: 0x40;
    HoveredWindow    :: 0x80;
    Visible          :: 0x100;
    HasClipRect      :: 0x200;
    HasShortcut      :: 0x400;
}

// Extend ImGuiHoveredFlags_
HoveredFlagsPrivate :: enum s32 {
    ImGuiHoveredFlags_DelayMask_                    :: 245760;
    ImGuiHoveredFlags_AllowedMaskForIsWindowHovered :: 12479;
    ImGuiHoveredFlags_AllowedMaskForIsItemHovered   :: 262048;
}

// Extend ImGuiInputTextFlags_
InputTextFlagsPrivate :: enum s32 {
    ImGuiInputTextFlags_WordWrap             :: 16777216;

    ImGuiInputTextFlags_Multiline            :: 67108864;
    ImGuiInputTextFlags_MergedItem           :: 134217728;
    ImGuiInputTextFlags_LocalizeDecimalPoint :: 268435456;
}

// Extend ImGuiButtonFlags_
ButtonFlagsPrivate :: enum s32 {
    ImGuiButtonFlags_PressedOnClick                :: 16;
    ImGuiButtonFlags_PressedOnClickRelease         :: 32;
    ImGuiButtonFlags_PressedOnClickReleaseAnywhere :: 64;
    ImGuiButtonFlags_PressedOnRelease              :: 128;
    ImGuiButtonFlags_PressedOnDoubleClick          :: 256;
    ImGuiButtonFlags_PressedOnDragDropHold         :: 512;

    ImGuiButtonFlags_FlattenChildren               :: 2048;
    ImGuiButtonFlags_AllowOverlap                  :: 4096;

    ImGuiButtonFlags_AlignTextBaseLine             :: 32768;
    ImGuiButtonFlags_NoKeyModsAllowed              :: 65536;
    ImGuiButtonFlags_NoHoldingActiveId             :: 131072;
    ImGuiButtonFlags_NoNavFocus                    :: 262144;
    ImGuiButtonFlags_NoHoveredOnFocus              :: 524288;
    ImGuiButtonFlags_NoSetKeyOwner                 :: 1048576;
    ImGuiButtonFlags_NoTestKeyOwner                :: 2097152;
    ImGuiButtonFlags_NoFocus                       :: 4194304;
    ImGuiButtonFlags_PressedOnMask_                :: 1008;
    ImGuiButtonFlags_PressedOnDefault_             :: 32;
}

// Extend ImGuiComboFlags_
ComboFlagsPrivate :: enum s32 {
    ImGuiComboFlags_CustomPreview :: 1048576;
}

// Extend ImGuiSliderFlags_
SliderFlagsPrivate :: enum s32 {
    ImGuiSliderFlags_Vertical :: 1048576;
    ImGuiSliderFlags_ReadOnly :: 2097152;
}

// Extend ImGuiSelectableFlags_
SelectableFlagsPrivate :: enum s32 {
    ImGuiSelectableFlags_NoHoldingActiveID    :: 1048576;
    ImGuiSelectableFlags_SelectOnNav          :: 2097152;
    ImGuiSelectableFlags_SelectOnClick        :: 4194304;
    ImGuiSelectableFlags_SelectOnRelease      :: 8388608;
    ImGuiSelectableFlags_SpanAvailWidth       :: 16777216;
    ImGuiSelectableFlags_SetNavIdOnHover      :: 33554432;
    ImGuiSelectableFlags_NoPadWithHalfSpacing :: 67108864;
    ImGuiSelectableFlags_NoSetKeyOwner        :: 134217728;
}

// Extend ImGuiTreeNodeFlags_
TreeNodeFlagsPrivate :: enum s32 {
    ImGuiTreeNodeFlags_NoNavFocus                 :: 134217728;
    ImGuiTreeNodeFlags_ClipLabelForTrailingButton :: 268435456;
    ImGuiTreeNodeFlags_UpsideDownArrow            :: 536870912;
    ImGuiTreeNodeFlags_OpenOnMask_                :: 192;
    ImGuiTreeNodeFlags_DrawLinesMask_             :: 1835008;
}

SeparatorFlags :: enum_flags s32 {
    None           :: 0x0;
    Horizontal     :: 0x1;
    Vertical       :: 0x2;
    SpanAllColumns :: 0x4;
}

// Flags for FocusWindow(). This is not called ImGuiFocusFlags to avoid confusion with public-facing ImGuiFocusedFlags.
// FIXME: Once we finishing replacing more uses of GetTopMostPopupModal()+IsWindowWithinBeginStackOf()
// and FindBlockingModal() with this, we may want to change the flag to be opt-out instead of opt-in.
FocusRequestFlags :: enum_flags s32 {
    None                :: 0x0;
    RestoreFocusedChild :: 0x1;
    UnlessBelowModal    :: 0x2;
}

TextFlags :: enum_flags s32 {
    None                       :: 0x0;
    NoWidthForLargeClippedText :: 0x1;
}

TooltipFlags :: enum_flags s32 {
    None             :: 0x0;
    OverridePrevious :: 0x2;
}

// FIXME: this is in development, not exposed/functional as a generic feature yet.
// Horizontal/Vertical enums are fixed to 0/1 so they may be used to index ImVec2
LayoutType :: enum s32 {
    Horizontal :: 0;
    Vertical   :: 1;
}

// Flags for LogBegin() text capturing function
LogFlags :: enum_flags s32 {
    None            :: 0x0;

    OutputTTY       :: 0x1;
    OutputFile      :: 0x2;
    OutputBuffer    :: 0x4;
    OutputClipboard :: 0x8;
    OutputMask_     :: 0xf;
}

// X/Y enums are fixed to 0/1 so they may be used to index ImVec2
Axis :: enum s32 {
    None :: -1;
    X    :: 0;
    Y    :: 1;
}

PlotType :: enum s32 {
    Lines     :: 0;
    Histogram :: 1;
}

// Storage data for BeginComboPreview()/EndComboPreview()
ComboPreviewData :: struct {
    PreviewRect:                  Rect;
    BackupCursorPos:              Vector2;
    BackupCursorMaxPos:           Vector2;
    BackupCursorPosPrevLine:      Vector2;
    BackupPrevLineTextBaseOffset: float;
    BackupLayout:                 LayoutType;

    Constructor :: (this: *ComboPreviewData) -> void #cpp_method #foreign ImGui "??0ImGuiComboPreviewData@@QEAA@XZ";
}

// Stacked storage data for BeginGroup()/EndGroup()
GroupData :: struct {
    WindowID:                     ID;
    BackupCursorPos:              Vector2;
    BackupCursorMaxPos:           Vector2;
    BackupCursorPosPrevLine:      Vector2;
    BackupIndent:                 Vec1;
    BackupGroupOffset:            Vec1;
    BackupCurrLineSize:           Vector2;
    BackupCurrLineTextBaseOffset: float;
    BackupActiveIdIsAlive:        ID;
    BackupDeactivatedIdIsAlive:   bool;
    BackupHoveredIdIsAlive:       bool;
    BackupIsSameLine:             bool;
    EmitItem:                     bool;
}

// Simple column measurement, currently used for MenuItem() only.. This is very short-sighted/throw-away code and NOT a generic helper.
MenuColumns :: struct {
    TotalWidth:     U32;
    NextTotalWidth: U32;
    Spacing:        U16;
    OffsetIcon:     U16; // Always zero for now
    OffsetLabel:    U16; // Offsets are locked in Update()
    OffsetShortcut: U16;
    OffsetMark:     U16;
    Widths:         [4] U16; // Width of:   Icon, Label, Shortcut, Mark  (accumulators for current frame)

    Constructor :: (this: *MenuColumns) -> void #cpp_method #foreign ImGui "??0ImGuiMenuColumns@@QEAA@XZ";
    Update :: (this: *MenuColumns, spacing: float, window_reappearing: bool) -> void #cpp_method #foreign ImGui "?Update@ImGuiMenuColumns@@QEAAXM_N@Z";
    DeclColumns :: (this: *MenuColumns, w_icon: float, w_label: float, w_shortcut: float, w_mark: float) -> float #cpp_method #foreign ImGui "?DeclColumns@ImGuiMenuColumns@@QEAAMMMMM@Z";
    CalcNextTotalWidth :: (this: *MenuColumns, update_offsets: bool) -> void #cpp_method #foreign ImGui "?CalcNextTotalWidth@ImGuiMenuColumns@@QEAAX_N@Z";
}

// Internal temporary state for deactivating InputText() instances.
InputTextDeactivatedState :: struct {
    ID_:   ID; // widget id owning the text state (which just got deactivated)
    TextA: Vector(u8); // text buffer

    Constructor :: (this: *InputTextDeactivatedState) -> void #cpp_method #foreign ImGui "??0ImGuiInputTextDeactivatedState@@QEAA@XZ";
    ClearFreeMemory :: (this: *InputTextDeactivatedState) -> void #cpp_method #foreign ImGui "?ClearFreeMemory@ImGuiInputTextDeactivatedState@@QEAAXXZ";
}

Stb :: struct {
    STB_TexteditState :: struct {}
}
StbTexteditState :: Stb.STB_TexteditState;

// Internal state of the currently focused/edited text input box
// For a given item ID, access with ImGui::GetInputTextState()
InputTextState :: struct {
    Ctx:                  *ImGuiContext; // parent UI context (needs to be set explicitly by parent).
    Stb:                  *StbTexteditState; // State for stb_textedit.h
    Flags:                InputTextFlags; // copy of InputText() flags. may be used to check if e.g. ImGuiInputTextFlags_Password is set.
    ID_:                  ID; // widget id owning the text state
    TextLen:              s32; // UTF-8 length of the string in TextA (in bytes)
    TextSrc:              *u8; // == TextA.Data unless read-only, in which case == buf passed to InputText(). Field only set and valid _inside_ the call InputText() call.
    TextA:                Vector(u8); // main UTF8 buffer. TextA.Size is a buffer size! Should always be >= buf_size passed by user (and of course >= CurLenA + 1).
    TextToRevertTo:       Vector(u8); // value to revert to when pressing Escape = backup of end-user buffer at the time of focus (in UTF-8, unaltered)
    CallbackTextBackup:   Vector(u8); // temporary storage for callback to support automatic reconcile of undo-stack
    BufCapacity:          s32; // end-user buffer capacity (include zero terminator)
    Scroll:               Vector2; // horizontal offset (managed manually) + vertical scrolling (pulled from child window's own Scroll.y)
    LineCount:            s32; // last line count (solely for debugging)
    WrapWidth:            float; // word-wrapping width
    CursorAnim:           float; // timer for cursor blink, reset on every user action so the cursor reappears immediately
    CursorFollow:         bool; // set when we want scrolling to follow the current cursor position (not always!)
    CursorCenterY:        bool; // set when we want scrolling to be centered over the cursor position (while resizing a word-wrapping field)
    SelectedAllMouseLock: bool; // after a double-click to select all, we ignore further mouse drags to update selection
    Edited:               bool; // edited this frame
    WantReloadUserBuf:    bool; // force a reload of user buf so it may be modified externally. may be automatic in future version.
    LastMoveDirectionLR:  S8; // ImGuiDir_Left or ImGuiDir_Right. track last movement direction so when cursor cross over a word-wrapping boundaries we can display it on either line depending on last move.s
    ReloadSelectionStart: s32;
    ReloadSelectionEnd:   s32;

    Constructor :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "??0ImGuiInputTextState@@QEAA@XZ";
    Destructor :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "??1ImGuiInputTextState@@QEAA@XZ";

    ClearFreeMemory :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?ClearFreeMemory@ImGuiInputTextState@@QEAAXXZ";
    OnKeyPressed :: (this: *InputTextState, key: s32) -> void #cpp_method #foreign ImGui "?OnKeyPressed@ImGuiInputTextState@@QEAAXH@Z";
    OnCharPressed :: (this: *InputTextState, c: u32) -> void #cpp_method #foreign ImGui "?OnCharPressed@ImGuiInputTextState@@QEAAXI@Z";
    GetPreferredOffsetX :: (this: *InputTextState) -> float #cpp_method #foreign ImGui "?GetPreferredOffsetX@ImGuiInputTextState@@QEBAMXZ";

    // Cursor & Selection
    CursorAnimReset :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?CursorAnimReset@ImGuiInputTextState@@QEAAXXZ";
    CursorClamp :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?CursorClamp@ImGuiInputTextState@@QEAAXXZ";
    HasSelection :: (this: *InputTextState) -> bool #cpp_method #foreign ImGui "?HasSelection@ImGuiInputTextState@@QEBA_NXZ";
    ClearSelection :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?ClearSelection@ImGuiInputTextState@@QEAAXXZ";
    GetCursorPos :: (this: *InputTextState) -> s32 #cpp_method #foreign ImGui "?GetCursorPos@ImGuiInputTextState@@QEBAHXZ";
    GetSelectionStart :: (this: *InputTextState) -> s32 #cpp_method #foreign ImGui "?GetSelectionStart@ImGuiInputTextState@@QEBAHXZ";
    GetSelectionEnd :: (this: *InputTextState) -> s32 #cpp_method #foreign ImGui "?GetSelectionEnd@ImGuiInputTextState@@QEBAHXZ";
    SelectAll :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?SelectAll@ImGuiInputTextState@@QEAAXXZ";

    // Reload user buf (WIP #2890)
    // If you modify underlying user-passed const char* while active you need to call this (InputText V2 may lift this)
    //   strcpy(my_buf, "hello");
    //   if (ImGuiInputTextState* state = ImGui::GetInputTextState(id)) // id may be ImGui::GetItemID() is last item
    //       state->ReloadUserBufAndSelectAll();
    ReloadUserBufAndSelectAll :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?ReloadUserBufAndSelectAll@ImGuiInputTextState@@QEAAXXZ";
    ReloadUserBufAndKeepSelection :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?ReloadUserBufAndKeepSelection@ImGuiInputTextState@@QEAAXXZ";
    ReloadUserBufAndMoveToEnd :: (this: *InputTextState) -> void #cpp_method #foreign ImGui "?ReloadUserBufAndMoveToEnd@ImGuiInputTextState@@QEAAXXZ";
}

WindowRefreshFlags :: enum_flags s32 {
    None              :: 0x0;
    TryToAvoidRefresh :: 0x1;
    RefreshOnHover    :: 0x2;
    RefreshOnFocus    :: 0x4;
}

NextWindowDataFlags :: enum_flags s32 {
    None              :: 0x0;
    HasPos            :: 0x1;
    HasSize           :: 0x2;
    HasContentSize    :: 0x4;
    HasCollapsed      :: 0x8;
    HasSizeConstraint :: 0x10;
    HasFocus          :: 0x20;
    HasBgAlpha        :: 0x40;
    HasScroll         :: 0x80;
    HasWindowFlags    :: 0x100;
    HasChildFlags     :: 0x200;
    HasRefreshPolicy  :: 0x400;
    HasViewport       :: 0x800;
    HasDock           :: 0x1000;
    HasWindowClass    :: 0x2000;
}

// Storage for SetNexWindow** functions
NextWindowData :: struct {
    HasFlags:             NextWindowDataFlags;

    // Members below are NOT cleared. Always rely on HasFlags.
    PosCond:              Cond;
    SizeCond:             Cond;
    CollapsedCond:        Cond;
    DockCond:             Cond;
    PosVal:               Vector2;
    PosPivotVal:          Vector2;
    SizeVal:              Vector2;
    ContentSizeVal:       Vector2;
    ScrollVal:            Vector2;
    WindowFlags_:         WindowFlags; // Only honored by BeginTable()
    ChildFlags_:          ChildFlags;
    PosUndock:            bool;
    CollapsedVal:         bool;
    SizeConstraintRect:   Rect;
    SizeCallback_:        SizeCallback;
    SizeCallbackUserData: *void;
    BgAlphaVal:           float; // Override background alpha
    ViewportId:           ID;
    DockId:               ID;
    WindowClass_:         WindowClass;
    MenuBarOffsetMinVal:  Vector2; // (Always on) This is not exposed publicly, so we don't clear it and it doesn't have a corresponding flag (could we? for consistency?)
    RefreshFlagsVal:      WindowRefreshFlags;

    Constructor :: (this: *NextWindowData) -> void #cpp_method #foreign ImGui "??0ImGuiNextWindowData@@QEAA@XZ";
    ClearFlags :: (this: *NextWindowData) -> void #cpp_method #foreign ImGui "?ClearFlags@ImGuiNextWindowData@@QEAAXXZ";
}

NextItemDataFlags :: enum_flags s32 {
    None         :: 0x0;
    HasWidth     :: 0x1;
    HasOpen      :: 0x2;
    HasShortcut  :: 0x4;
    HasRefVal    :: 0x8;
    HasStorageID :: 0x10;
}

NextItemData :: struct {
    HasFlags:           NextItemDataFlags; // Called HasFlags instead of Flags to avoid mistaking this
    ItemFlags_:         ItemFlags; // Currently only tested/used for ImGuiItemFlags_AllowOverlap and ImGuiItemFlags_HasSelectionUserData.

    FocusScopeId:       ID; // Set by SetNextItemSelectionUserData()
    SelectionUserData_: SelectionUserData; // Set by SetNextItemSelectionUserData() (note that NULL/0 is a valid value, we use -1 == ImGuiSelectionUserData_Invalid to mark invalid values)
    Width:              float; // Set by SetNextItemWidth()
    Shortcut:           KeyChord; // Set by SetNextItemShortcut()
    ShortcutFlags:      InputFlags; // Set by SetNextItemShortcut()
    OpenVal:            bool; // Set by SetNextItemOpen()
    OpenCond:           U8; // Set by SetNextItemOpen()
    RefVal:             DataTypeStorage; // Not exposed yet, for ImGuiInputTextFlags_ParseEmptyAsRefVal
    StorageId:          ID; // Set by SetNextItemStorageID()

    Constructor :: (this: *NextItemData) -> void #cpp_method #foreign ImGui "??0ImGuiNextItemData@@QEAA@XZ";
    ClearFlags :: (this: *NextItemData) -> void #cpp_method #foreign ImGui "?ClearFlags@ImGuiNextItemData@@QEAAXXZ";
}

// Status storage for the last submitted item
LastItemData :: struct {
    ID_:         ID;
    ItemFlags_:  ItemFlags; // See ImGuiItemFlags_ (called 'InFlags' before v1.91.4).
    StatusFlags: ItemStatusFlags; // See ImGuiItemStatusFlags_
    Rect_:       Rect; // Full rectangle
    NavRect:     Rect; // Navigation scoring rectangle (not displayed)

    DisplayRect: Rect; // Display rectangle. ONLY VALID IF (StatusFlags & ImGuiItemStatusFlags_HasDisplayRect) is set.
    ClipRect:    Rect; // Clip rectangle at the time of submitting item. ONLY VALID IF (StatusFlags & ImGuiItemStatusFlags_HasClipRect) is set..
    Shortcut:    KeyChord; // Shortcut at the time of submitting item. ONLY VALID IF (StatusFlags & ImGuiItemStatusFlags_HasShortcut) is set..

    Constructor :: (this: *LastItemData) -> void #cpp_method #foreign ImGui "??0ImGuiLastItemData@@QEAA@XZ";
}

// Store data emitted by TreeNode() for usage by TreePop()
// - To implement ImGuiTreeNodeFlags_NavLeftJumpsToParent: store the minimum amount of data
//   which we can't infer in TreePop(), to perform the equivalent of NavApplyItemToResult().
//   Only stored when the node is a potential candidate for landing on a Left arrow jump.
TreeNodeStackData :: struct {
    ID_:                  ID;
    TreeFlags:            TreeNodeFlags;
    ItemFlags_:           ItemFlags; // Used for nav landing
    NavRect:              Rect; // Used for nav landing
    DrawLinesX1:          float;
    DrawLinesToNodesY2:   float;
    DrawLinesTableColumn: TableColumnIdx;
}

// sizeof() = 20
ErrorRecoveryState :: struct {
    SizeOfWindowStack:     s16;
    SizeOfIDStack:         s16;
    SizeOfTreeStack:       s16;
    SizeOfColorStack:      s16;
    SizeOfStyleVarStack:   s16;
    SizeOfFontStack:       s16;
    SizeOfFocusScopeStack: s16;
    SizeOfGroupStack:      s16;
    SizeOfItemFlagsStack:  s16;
    SizeOfBeginPopupStack: s16;
    SizeOfDisabledStack:   s16;

    Constructor :: (this: *ErrorRecoveryState) -> void #cpp_method #foreign ImGui "??0ImGuiErrorRecoveryState@@QEAA@XZ";
}

// Data saved for each window pushed into the stack
WindowStackData :: struct {
    Window_:                             *Window;
    ParentLastItemDataBackup:            LastItemData;
    StackSizesInBegin:                   ErrorRecoveryState; // Store size of various stacks for asserting
    DisabledOverrideReenable:            bool; // Non-child window override disabled flag
    DisabledOverrideReenableAlphaBackup: float;
}

ShrinkWidthItem :: struct {
    Index:        s32;
    Width:        float;
    InitialWidth: float;
}

PtrOrIndex :: struct {
    Ptr:   *void; // Either field can be set, not both. e.g. Dock node tab bars are loose while BeginTabBar() ones are in a pool.
    Index: s32; // Usually index in a main pool.

    Constructor :: (this: *PtrOrIndex, ptr: *void) -> void #cpp_method #foreign ImGui "??0ImGuiPtrOrIndex@@QEAA@PEAX@Z";
    Constructor :: (this: *PtrOrIndex, index: s32) -> void #cpp_method #foreign ImGui "??0ImGuiPtrOrIndex@@QEAA@H@Z";
}

// Data used by IsItemDeactivated()/IsItemDeactivatedAfterEdit() functions
DeactivatedItemData :: struct {
    ID_:                 ID;
    ElapseFrame:         s32;
    HasBeenEditedBefore: bool;
    IsAlive:             bool;
}

//-----------------------------------------------------------------------------
// [SECTION] Popup support
//-----------------------------------------------------------------------------
PopupPositionPolicy :: enum s32 {
    Default  :: 0;
    ComboBox :: 1;
    Tooltip  :: 2;
}

// Storage for popup stacks (g.OpenPopupStack and g.BeginPopupStack)
PopupData :: struct {
    PopupId:          ID; // Set on OpenPopup()
    Window_:          *Window; // Resolved on BeginPopup() - may stay unresolved if user never calls OpenPopup()
    RestoreNavWindow: *Window; // Set on OpenPopup(), a NavWindow that will be restored on popup close
    ParentNavLayer:   s32; // Resolved on BeginPopup(). Actually a ImGuiNavLayer type (declared down below), initialized to -1 which is not part of an enum, but serves well-enough as "not any of layers" value
    OpenFrameCount:   s32; // Set on OpenPopup()
    OpenParentId:     ID; // Set on OpenPopup(), we need this to differentiate multiple menu sets from each others (e.g. inside menu bar vs loose menu items)
    OpenPopupPos:     Vector2; // Set on OpenPopup(), preferred popup position (typically == OpenMousePos when using mouse)
    OpenMousePos:     Vector2; // Set on OpenPopup(), copy of mouse position at the time of opening popup

    Constructor :: (this: *PopupData) -> void #cpp_method #foreign ImGui "??0ImGuiPopupData@@QEAA@XZ";
}

// Bit array for named keys
BitArrayForNamedKeys :: BitArray(xx Key.NamedKey_COUNT, xx -Key.NamedKey_BEGIN);

InputEventType :: enum s32 {
    None          :: 0;
    MousePos      :: 1;
    MouseWheel    :: 2;
    MouseButton   :: 3;
    MouseViewport :: 4;
    Key           :: 5;
    Text          :: 6;
    Focus         :: 7;
    COUNT         :: 8;
}

InputSource :: enum s32 {
    None     :: 0;
    Mouse    :: 1;
    Keyboard :: 2;
    Gamepad  :: 3;
    COUNT    :: 4;
}

// FIXME: Structures in the union below need to be declared as anonymous unions appears to be an extension?
// Using ImVec2() would fail on Clang 'union member 'MousePos' has a non-trivial default constructor'
InputEventMousePos :: struct {
    PosX:         float;
    PosY:         float;
    MouseSource_: MouseSource;
}
InputEventMouseWheel :: struct {
    WheelX:       float;
    WheelY:       float;
    MouseSource_: MouseSource;
}
InputEventMouseButton :: struct {
    Button:       s32;
    Down:         bool;
    MouseSource_: MouseSource;
}
InputEventMouseViewport :: struct {
    HoveredViewportID: ID;
}
InputEventKey :: struct {
    Key_:        Key;
    Down:        bool;
    AnalogValue: float;
}
InputEventText :: struct {
    Char: u32;
}
InputEventAppFocused :: struct {
    Focused: bool;
}

InputEvent :: struct {
    Type:              InputEventType;
    Source:            InputSource;
    EventId:           U32; // Unique, sequential increasing integer to identify an event (if you need to correlate them to other data).
    union {
        MousePos:      InputEventMousePos; // if Type == ImGuiInputEventType_MousePos
        MouseWheel:    InputEventMouseWheel; // if Type == ImGuiInputEventType_MouseWheel
        MouseButton:   InputEventMouseButton; // if Type == ImGuiInputEventType_MouseButton
        MouseViewport: InputEventMouseViewport; // if Type == ImGuiInputEventType_MouseViewport
        Key:           InputEventKey; // if Type == ImGuiInputEventType_Key
        Text:          InputEventText; // if Type == ImGuiInputEventType_Text
        AppFocused:    InputEventAppFocused; // if Type == ImGuiInputEventType_Focus
    }

    AddedByTestEngine: bool;

    Constructor :: (this: *InputEvent) -> void #cpp_method #foreign ImGui "??0ImGuiInputEvent@@QEAA@XZ";
}

//#define ImGuiKeyOwner_None ImGuiKeyOwner_NoOwner  // We previously called this 'ImGuiKeyOwner_None' but it was inconsistent with our pattern that _None values == 0 and quite dangerous. Also using _NoOwner makes the IsKeyPressed() calls more explicit.
KeyRoutingIndex :: S16;

// Routing table entry (sizeof() == 16 bytes)
KeyRoutingData :: struct {
    NextEntryIndex:   KeyRoutingIndex;
    Mods:             U16; // Technically we'd only need 4-bits but for simplify we store ImGuiMod_ values which need 16-bits.
    RoutingCurrScore: U8; // [DEBUG] For debug display
    RoutingNextScore: U8; // Lower is better (0: perfect score)
    RoutingCurr:      ID;
    RoutingNext:      ID;

    Constructor :: (this: *KeyRoutingData) -> void #cpp_method #foreign ImGui "??0ImGuiKeyRoutingData@@QEAA@XZ";
}

// Routing table: maintain a desired owner for each possible key-chord (key + mods), and setup owner in NewFrame() when mods are matching.
// Stored in main context (1 instance)
KeyRoutingTable :: struct {
    Index:       [155] KeyRoutingIndex; // Index of first entry in Entries[]
    Entries:     Vector(KeyRoutingData);
    EntriesNext: Vector(KeyRoutingData); // Double-buffer to avoid reallocation (could use a shared buffer)

    Constructor :: (this: *KeyRoutingTable) -> void #cpp_method #foreign ImGui "??0ImGuiKeyRoutingTable@@QEAA@XZ";
    Clear :: (this: *KeyRoutingTable) -> void #cpp_method #foreign ImGui "?Clear@ImGuiKeyRoutingTable@@QEAAXXZ";
}

// This extends ImGuiKeyData but only for named keys (legacy keys don't support the new features)
// Stored in main context (1 per named key). In the future it might be merged into ImGuiKeyData.
KeyOwnerData :: struct {
    OwnerCurr:        ID;
    OwnerNext:        ID;
    LockThisFrame:    bool; // Reading this key requires explicit owner id (until end of frame). Set by ImGuiInputFlags_LockThisFrame.
    LockUntilRelease: bool; // Reading this key requires explicit owner id (until key is released). Set by ImGuiInputFlags_LockUntilRelease. When this is true LockThisFrame is always true as well.

    Constructor :: (this: *KeyOwnerData) -> void #cpp_method #foreign ImGui "??0ImGuiKeyOwnerData@@QEAA@XZ";
}

// Extend ImGuiInputFlags_
// Flags for extended versions of IsKeyPressed(), IsMouseClicked(), Shortcut(), SetKeyOwner(), SetItemKeyOwner()
// Don't mistake with ImGuiInputTextFlags! (which is for ImGui::InputText() function)
InputFlagsPrivate :: enum s32 {
    ImGuiInputFlags_RepeatRateDefault                :: 2;
    ImGuiInputFlags_RepeatRateNavMove                :: 4;
    ImGuiInputFlags_RepeatRateNavTweak               :: 8;

    ImGuiInputFlags_RepeatUntilRelease               :: 16;
    ImGuiInputFlags_RepeatUntilKeyModsChange         :: 32;
    ImGuiInputFlags_RepeatUntilKeyModsChangeFromNone :: 64;
    ImGuiInputFlags_RepeatUntilOtherKeyPress         :: 128;

    ImGuiInputFlags_LockThisFrame                    :: 1048576;
    ImGuiInputFlags_LockUntilRelease                 :: 2097152;

    ImGuiInputFlags_CondHovered                      :: 4194304;
    ImGuiInputFlags_CondActive                       :: 8388608;
    ImGuiInputFlags_CondDefault_                     :: 12582912;

    ImGuiInputFlags_RepeatRateMask_                  :: 14;
    ImGuiInputFlags_RepeatUntilMask_                 :: 240;
    ImGuiInputFlags_RepeatMask_                      :: 255;
    ImGuiInputFlags_CondMask_                        :: 12582912;
    ImGuiInputFlags_RouteTypeMask_                   :: 15360;
    ImGuiInputFlags_RouteOptionsMask_                :: 245760;
    ImGuiInputFlags_SupportedByIsKeyPressed          :: 255;
    ImGuiInputFlags_SupportedByIsMouseClicked        :: 1;
    ImGuiInputFlags_SupportedByShortcut              :: 261375;
    ImGuiInputFlags_SupportedBySetNextItemShortcut   :: 523519;
    ImGuiInputFlags_SupportedBySetKeyOwner           :: 3145728;
    ImGuiInputFlags_SupportedBySetItemKeyOwner       :: 15728640;
}

// Note that Max is exclusive, so perhaps should be using a Begin/End convention.
ListClipperRange :: struct {
    Min:                 s32;
    Max:                 s32;
    PosToIndexConvert:   bool; // Begin/End are absolute position (will be converted to indices later)
    PosToIndexOffsetMin: S8; // Add to Min after converting to indices
    PosToIndexOffsetMax: S8; // Add to Min after converting to indices

    FromIndices :: (min: s32, max: s32) -> ListClipperRange #foreign ImGui "?FromIndices@ImGuiListClipperRange@@SA?AU1@HH@Z";
    FromPositions :: (y1: float, y2: float, off_min: s32, off_max: s32) -> ListClipperRange #foreign ImGui "?FromPositions@ImGuiListClipperRange@@SA?AU1@MMHH@Z";
}

// Temporary clipper data, buffers shared/reused between instances
ListClipperData :: struct {
    ListClipper_:    *ListClipper;
    LossynessOffset: float;
    StepNo:          s32;
    ItemsFrozen:     s32;
    Ranges:          Vector(ListClipperRange);

    Constructor :: (this: *ListClipperData) -> void #cpp_method #foreign ImGui "??0ImGuiListClipperData@@QEAA@XZ";
    Reset :: (this: *ListClipperData, clipper: *ListClipper) -> void #cpp_method #foreign ImGui "?Reset@ImGuiListClipperData@@QEAAXPEAUImGuiListClipper@@@Z";
}

//-----------------------------------------------------------------------------
// [SECTION] Navigation support
//-----------------------------------------------------------------------------
ActivateFlags :: enum_flags s32 {
    None               :: 0x0;
    PreferInput        :: 0x1;
    PreferTweak        :: 0x2;
    TryToPreserveState :: 0x4;
    FromTabbing        :: 0x8;
    FromShortcut       :: 0x10;
}

// Early work-in-progress API for ScrollToItem()
ScrollFlags :: enum_flags s32 {
    None               :: 0x0;
    KeepVisibleEdgeX   :: 0x1;
    KeepVisibleEdgeY   :: 0x2;
    KeepVisibleCenterX :: 0x4;
    KeepVisibleCenterY :: 0x8;
    AlwaysCenterX      :: 0x10;
    AlwaysCenterY      :: 0x20;
    NoScrollParent     :: 0x40;
    MaskX_             :: 0x15;
    MaskY_             :: 0x2a;
}

NavRenderCursorFlags :: enum_flags s32 {
    None       :: 0x0;
    Compact    :: 0x2;
    AlwaysDraw :: 0x4;
    NoRounding :: 0x8;
}

NavMoveFlags :: enum_flags s32 {
    None                  :: 0x0;
    LoopX                 :: 0x1;
    LoopY                 :: 0x2;
    WrapX                 :: 0x4;
    WrapY                 :: 0x8;
    WrapMask_             :: 0xf;
    AllowCurrentNavId     :: 0x10;
    AlsoScoreVisibleSet   :: 0x20;
    ScrollToEdgeY         :: 0x40;
    Forwarded             :: 0x80;
    DebugNoResult         :: 0x100;
    FocusApi              :: 0x200;
    IsTabbing             :: 0x400;
    IsPageMove            :: 0x800;
    Activate              :: 0x1000;
    NoSelect              :: 0x2000;
    NoSetNavCursorVisible :: 0x4000;
    NoClearActiveId       :: 0x8000;
}

NavLayer :: enum s32 {
    Main  :: 0;
    Menu  :: 1;
    COUNT :: 2;
}

// Storage for navigation query/results
NavItemData :: struct {
    Window_:            *Window; // Init,Move    // Best candidate window (result->ItemWindow->RootWindowForNav == request->Window)
    ID_:                ID; // Init,Move    // Best candidate item ID
    FocusScopeId:       ID; // Init,Move    // Best candidate focus scope ID
    RectRel:            Rect; // Init,Move    // Best candidate bounding box in window relative space
    ItemFlags_:         ItemFlags; // ????,Move    // Best candidate item flags
    DistBox:            float; //      Move    // Best candidate box distance to current NavId
    DistCenter:         float; //      Move    // Best candidate center distance to current NavId
    DistAxial:          float; //      Move    // Best candidate axial distance to current NavId
    SelectionUserData_: SelectionUserData; //I+Mov    // Best candidate SetNextItemSelectionUserData() value. Valid if (ItemFlags & ImGuiItemFlags_HasSelectionUserData)

    Constructor :: (this: *NavItemData) -> void #cpp_method #foreign ImGui "??0ImGuiNavItemData@@QEAA@XZ";
    Clear :: (this: *NavItemData) -> void #cpp_method #foreign ImGui "?Clear@ImGuiNavItemData@@QEAAXXZ";
}

// Storage for PushFocusScope(), g.FocusScopeStack[], g.NavFocusRoute[]
FocusScopeData :: struct {
    ID_:      ID;
    WindowID: ID;
}

// Flags for GetTypingSelectRequest()
TypingSelectFlags :: enum_flags s32 {
    None                :: 0x0;
    AllowBackspace      :: 0x1;
    AllowSingleCharMode :: 0x2;
}

// Returned by GetTypingSelectRequest(), designed to eventually be public.
TypingSelectRequest :: struct {
    Flags:           TypingSelectFlags; // Flags passed to GetTypingSelectRequest()
    SearchBufferLen: s32;
    SearchBuffer:    *u8; // Search buffer contents (use full string. unless SingleCharMode is set, in which case use SingleCharSize).
    SelectRequest:   bool; // Set when buffer was modified this frame, requesting a selection.
    SingleCharMode:  bool; // Notify when buffer contains same character repeated, to implement special mode. In this situation it preferred to not display any on-screen search indication.
    SingleCharSize:  S8; // Length in bytes of first letter codepoint (1 for ascii, 2-4 for UTF-8). If (SearchBufferLen==RepeatCharSize) only 1 letter has been input.
}

// Storage for GetTypingSelectRequest()
TypingSelectState :: struct {
    Request:            TypingSelectRequest; // User-facing data
    SearchBuffer:       [64] u8; // Search buffer: no need to make dynamic as this search is very transient.
    FocusScope:         ID;
    LastRequestFrame:   s32 = 0;
    LastRequestTime:    float = 0.0;
    SingleCharModeLock  := false; // After a certain single char repeat count we lock into SingleCharMode. Two benefits: 1) buffer never fill, 2) we can provide an immediate SingleChar mode without timer elapsing.

    Constructor :: (this: *TypingSelectState) -> void #cpp_method #foreign ImGui "??0ImGuiTypingSelectState@@QEAA@XZ";
    Clear :: (this: *TypingSelectState) -> void #cpp_method #foreign ImGui "?Clear@ImGuiTypingSelectState@@QEAAXXZ";
}

// Flags for internal's BeginColumns(). This is an obsolete API. Prefer using BeginTable() nowadays!
OldColumnFlags :: enum_flags s32 {
    None                   :: 0x0;
    NoBorder               :: 0x1;
    NoResize               :: 0x2;
    NoPreserveWidths       :: 0x4;
    NoForceWithinWindow    :: 0x8;
    GrowParentContentsSize :: 0x10;
}

OldColumnData :: struct {
    OffsetNorm:             float; // Column start offset, normalized 0.0 (far left) -> 1.0 (far right)
    OffsetNormBeforeResize: float;
    Flags:                  OldColumnFlags; // Not exposed
    ClipRect:               Rect;

    Constructor :: (this: *OldColumnData) -> void #cpp_method #foreign ImGui "??0ImGuiOldColumnData@@QEAA@XZ";
}

OldColumns :: struct {
    ID_:                      ID;
    Flags:                    OldColumnFlags;
    IsFirstFrame:             bool;
    IsBeingResized:           bool;
    Current:                  s32;
    Count:                    s32;
    OffMinX:                  float; // Offsets from HostWorkRect.Min.x
    OffMaxX:                  float; // Offsets from HostWorkRect.Min.x
    LineMinY:                 float;
    LineMaxY:                 float;
    HostCursorPosY:           float; // Backup of CursorPos at the time of BeginColumns()
    HostCursorMaxPosX:        float; // Backup of CursorMaxPos at the time of BeginColumns()
    HostInitialClipRect:      Rect; // Backup of ClipRect at the time of BeginColumns()
    HostBackupClipRect:       Rect; // Backup of ClipRect during PushColumnsBackground()/PopColumnsBackground()
    HostBackupParentWorkRect: Rect; //Backup of WorkRect at the time of BeginColumns()
    Columns:                  Vector(OldColumnData);
    Splitter:                 DrawListSplitter;

    Constructor :: (this: *OldColumns) -> void #cpp_method #foreign ImGui "??0ImGuiOldColumns@@QEAA@XZ";
}

// ImGui
BoxSelectState :: struct {
    // Active box-selection data (persistent, 1 active at a time)
    ID_:                   ID;
    IsActive:              bool;
    IsStarting:            bool;
    IsStartedFromVoid:     bool; // Starting click was not from an item.
    IsStartedSetNavIdOnce: bool;
    RequestClear:          bool;
    KeyMods:               KeyChord; /* 16 bits */ // Latched key-mods for box-select logic.
    StartPosRel:           Vector2; // Start position in window-contents relative space (to support scrolling)
    EndPosRel:             Vector2; // End position in window-contents relative space
    ScrollAccum:           Vector2; // Scrolling accumulator (to behave at high-frame spaces)
    Window_:               *Window;

    UnclipMode:            bool; // (Temp/Transient, here in hot area). Set/cleared by the BeginMultiSelect()/EndMultiSelect() owning active box-select.
    UnclipRect:            Rect; // Rectangle where ItemAdd() clipping may be temporarily disabled. Need support by multi-select supporting widgets.
    BoxSelectRectPrev:     Rect; // Selection rectangle in absolute coordinates (derived every frame from BoxSelectStartPosRel and MousePos)
    BoxSelectRectCurr:     Rect;

    Constructor :: (this: *BoxSelectState) -> void #cpp_method #foreign ImGui "??0ImGuiBoxSelectState@@QEAA@XZ";
}

// Temporary storage for multi-select
MultiSelectTempData :: struct {
    IO:                 MultiSelectIO; // MUST BE FIRST FIELD. Requests are set and returned by BeginMultiSelect()/EndMultiSelect() + written to by user during the loop.
    Storage:            *MultiSelectState;
    FocusScopeId:       ID; // Copied from g.CurrentFocusScopeId (unless another selection scope was pushed manually)
    Flags:              MultiSelectFlags;
    ScopeRectMin:       Vector2;
    BackupCursorMaxPos: Vector2;
    LastSubmittedItem:  SelectionUserData; // Copy of last submitted item data, used to merge output ranges.
    BoxSelectId:        ID;
    KeyMods:            KeyChord;
    LoopRequestSetAll:  S8; // -1: no operation, 0: clear all, 1: select all.
    IsEndIO:            bool; // Set when switching IO from BeginMultiSelect() to EndMultiSelect() state.
    IsFocused:          bool; // Set if currently focusing the selection scope (any item of the selection). May be used if you have custom shortcut associated to selection.
    IsKeyboardSetRange: bool; // Set by BeginMultiSelect() when using Shift+Navigation. Because scrolling may be affected we can't afford a frame of lag with Shift+Navigation.
    NavIdPassedBy:      bool;
    RangeSrcPassedBy:   bool; // Set by the item that matches RangeSrcItem.
    RangeDstPassedBy:   bool; // Set by the item that matches NavJustMovedToId when IsSetRange is set.

    Constructor :: (this: *MultiSelectTempData) -> void #cpp_method #foreign ImGui "??0ImGuiMultiSelectTempData@@QEAA@XZ";
    Clear :: (this: *MultiSelectTempData) -> void #cpp_method #foreign ImGui "?Clear@ImGuiMultiSelectTempData@@QEAAXXZ";
    ClearIO :: (this: *MultiSelectTempData) -> void #cpp_method #foreign ImGui "?ClearIO@ImGuiMultiSelectTempData@@QEAAXXZ";
}

// Persistent storage for multi-select (as long as selection is alive)
MultiSelectState :: struct {
    Window_:           *Window;
    ID_:               ID;
    LastFrameActive:   s32; // Last used frame-count, for GC.
    LastSelectionSize: s32; // Set by BeginMultiSelect() based on optional info provided by user. May be -1 if unknown.
    RangeSelected:     S8; // -1 (don't have) or true/false
    NavIdSelected:     S8; // -1 (don't have) or true/false
    RangeSrcItem:      SelectionUserData; //
    NavIdItem:         SelectionUserData; // SetNextItemSelectionUserData() value for NavId (if part of submitted items)

    Constructor :: (this: *MultiSelectState) -> void #cpp_method #foreign ImGui "??0ImGuiMultiSelectState@@QEAA@XZ";
}

// Extend ImGuiDockNodeFlags_
DockNodeFlagsPrivate :: enum s32 {
    ImGuiDockNodeFlags_DockSpace                 :: 1024;
    ImGuiDockNodeFlags_CentralNode               :: 2048;
    ImGuiDockNodeFlags_NoTabBar                  :: 4096;
    ImGuiDockNodeFlags_HiddenTabBar              :: 8192;
    ImGuiDockNodeFlags_NoWindowMenuButton        :: 16384;
    ImGuiDockNodeFlags_NoCloseButton             :: 32768;
    ImGuiDockNodeFlags_NoResizeX                 :: 65536;
    ImGuiDockNodeFlags_NoResizeY                 :: 131072;
    ImGuiDockNodeFlags_DockedWindowsInFocusRoute :: 262144;

    ImGuiDockNodeFlags_NoDockingSplitOther       :: 524288;
    ImGuiDockNodeFlags_NoDockingOverMe           :: 1048576;
    ImGuiDockNodeFlags_NoDockingOverOther        :: 2097152;
    ImGuiDockNodeFlags_NoDockingOverEmpty        :: 4194304;
    ImGuiDockNodeFlags_NoDocking                 :: 7864336;

    ImGuiDockNodeFlags_SharedFlagsInheritMask_   :: -1;
    ImGuiDockNodeFlags_NoResizeFlagsMask_        :: 196640;

    ImGuiDockNodeFlags_LocalFlagsTransferMask_   :: 260208;
    ImGuiDockNodeFlags_SavedFlagsMask_           :: 261152;
}

// Store the source authority (dock node vs window) of a field
DataAuthority :: enum s32 {
    Auto     :: 0;
    DockNode :: 1;
    Window   :: 2;
}

DockNodeState :: enum s32 {
    Unknown                                   :: 0;
    HostWindowHiddenBecauseSingleWindow       :: 1;
    HostWindowHiddenBecauseWindowsAreResizing :: 2;
    HostWindowVisible                         :: 3;
}

// sizeof() 156~192
DockNode :: struct {
    ID_:                    ID;
    SharedFlags:            DockNodeFlags; // (Write) Flags shared by all nodes of a same dockspace hierarchy (inherited from the root node)
    LocalFlags:             DockNodeFlags; // (Write) Flags specific to this node
    LocalFlagsInWindows:    DockNodeFlags; // (Write) Flags specific to this node, applied from windows
    MergedFlags:            DockNodeFlags; // (Read)  Effective flags (== SharedFlags | LocalFlagsInNode | LocalFlagsInWindows)
    State:                  DockNodeState;
    ParentNode:             *DockNode;
    ChildNodes:             [2] *DockNode; // [Split node only] Child nodes (left/right or top/bottom). Consider switching to an array.
    Windows:                Vector(*Window); // Note: unordered list! Iterate TabBar->Tabs for user-order.
    TabBar_:                *TabBar;
    Pos:                    Vector2; // Current position
    Size:                   Vector2; // Current size
    SizeRef:                Vector2; // [Split node only] Last explicitly written-to size (overridden when using a splitter affecting the node), used to calculate Size.
    SplitAxis:              Axis; // [Split node only] Split axis (X or Y)
    WindowClass_:           WindowClass; // [Root node only]
    LastBgColor:            U32;

    HostWindow:             *Window;
    VisibleWindow:          *Window; // Generally point to window which is ID is == SelectedTabID, but when CTRL+Tabbing this can be a different window.
    CentralNode:            *DockNode; // [Root node only] Pointer to central node.
    OnlyNodeWithWindows:    *DockNode; // [Root node only] Set when there is a single visible node within the hierarchy.
    CountNodeWithWindows:   s32; // [Root node only]
    LastFrameAlive:         s32; // Last frame number the node was updated or kept alive explicitly with DockSpace() + ImGuiDockNodeFlags_KeepAliveOnly
    LastFrameActive:        s32; // Last frame number the node was updated.
    LastFrameFocused:       s32; // Last frame number the node was focused.
    LastFocusedNodeId:      ID; // [Root node only] Which of our child docking node (any ancestor in the hierarchy) was last focused.
    SelectedTabId:          ID; // [Leaf node only] Which of our tab/window is selected.
    WantCloseTabId:         ID; // [Leaf node only] Set when closing a specific tab/window.
    RefViewportId:          ID; // Reference viewport ID from visible window when HostWindow == NULL.
    __bitfield:             DataAuthority;
    /* 
        AuthorityForPos: DataAuthority; /* 3 bits */
        AuthorityForSize: DataAuthority; /* 3 bits */
        AuthorityForViewport: DataAuthority; /* 3 bits */;
    */

    IsVisible:              bool; /* 1 bits */ // Set to false when the node is hidden (usually disabled as it has no active window)
    IsFocused:              bool #align 1; /* 1 bits */
    IsBgDrawnThisFrame:     bool #align 1; /* 1 bits */
    HasCloseButton:         bool #align 1; /* 1 bits */ // Provide space for a close button (if any of the docked window has one). Note that button may be hidden on window without one.
    HasWindowMenuButton:    bool #align 1; /* 1 bits */
    HasCentralNodeChild:    bool #align 1; /* 1 bits */
    WantCloseAll:           bool #align 1; /* 1 bits */ // Set when closing all tabs at once.
    WantLockSizeOnce:       bool #align 1; /* 1 bits */
    WantMouseMove:          bool; /* 1 bits */ // After a node extraction we need to transition toward moving the newly created host window
    WantHiddenTabBarUpdate: bool #align 1; /* 1 bits */
    WantHiddenTabBarToggle: bool #align 1; /* 1 bits */

    Constructor :: (this: *DockNode, id: ID) -> void #cpp_method #foreign ImGui "??0ImGuiDockNode@@QEAA@I@Z";
    Destructor :: (this: *DockNode) -> void #cpp_method #foreign ImGui "??1ImGuiDockNode@@QEAA@XZ";
    IsRootNode :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsRootNode@ImGuiDockNode@@QEBA_NXZ";
    IsDockSpace :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsDockSpace@ImGuiDockNode@@QEBA_NXZ";
    IsFloatingNode :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsFloatingNode@ImGuiDockNode@@QEBA_NXZ";
    IsCentralNode :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsCentralNode@ImGuiDockNode@@QEBA_NXZ";
    IsHiddenTabBar :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsHiddenTabBar@ImGuiDockNode@@QEBA_NXZ";
    IsNoTabBar :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsNoTabBar@ImGuiDockNode@@QEBA_NXZ";
    IsSplitNode :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsSplitNode@ImGuiDockNode@@QEBA_NXZ";
    IsLeafNode :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsLeafNode@ImGuiDockNode@@QEBA_NXZ";
    IsEmpty :: (this: *DockNode) -> bool #cpp_method #foreign ImGui "?IsEmpty@ImGuiDockNode@@QEBA_NXZ";
    Rect_ :: (this: *DockNode) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?Rect@ImGuiDockNode@@QEBA?AUImRect@@XZ";

    SetLocalFlags :: (this: *DockNode, flags: DockNodeFlags) -> void #cpp_method #foreign ImGui "?SetLocalFlags@ImGuiDockNode@@QEAAXH@Z";
    UpdateMergedFlags :: (this: *DockNode) -> void #cpp_method #foreign ImGui "?UpdateMergedFlags@ImGuiDockNode@@QEAAXXZ";
}

// List of colors that are stored at the time of Begin() into Docked Windows.
// We currently store the packed colors in a simple array window->DockStyle.Colors[].
// A better solution may involve appending into a log of colors in ImGuiContext + store offsets into those arrays in ImGuiWindow,
// but it would be more complex as we'd need to double-buffer both as e.g. drop target may refer to window from last frame.
WindowDockStyleCol :: enum s32 {
    Text                      :: 0;
    TabHovered                :: 1;
    TabFocused                :: 2;
    TabSelected               :: 3;
    TabSelectedOverline       :: 4;
    TabDimmed                 :: 5;
    TabDimmedSelected         :: 6;
    TabDimmedSelectedOverline :: 7;
    COUNT                     :: 8;
}

// We don't store style.Alpha: dock_node->LastBgColor embeds it and otherwise it would only affect the docking tab, which intuitively I would say we don't want to.
WindowDockStyle :: struct {
    Colors: [8] U32;
}

DockContext :: struct {
    Nodes:           Storage; // Map ID -> ImGuiDockNode*: Active nodes
    Requests:        Vector(DockRequest);
    NodesSettings:   Vector(DockNodeSettings);
    WantFullRebuild: bool;
    Constructor :: (this: *DockContext) -> void #cpp_method #foreign ImGui "??0ImGuiDockContext@@QEAA@XZ";
}

// ImGuiViewport Private/Internals fields (cardinal sin: we are using inheritance!)
// Every instance of ImGuiViewport is in fact a ImGuiViewportP.
ViewportP :: struct {
    #as using imguiviewport: Viewport;

    Window_:                 *Window; // Set when the viewport is owned by a window (and ImGuiViewportFlags_CanHostOtherWindows is NOT set)
    Idx:                     s32;
    LastFrameActive:         s32; // Last frame number this viewport was activated by a window
    LastFocusedStampCount:   s32; // Last stamp number from when a window hosted by this viewport was focused (by comparing this value between two viewport we have an implicit viewport z-order we use as fallback)
    LastNameHash:            ID;
    LastPos:                 Vector2;
    LastSize:                Vector2;
    Alpha:                   float; // Window opacity (when dragging dockable windows/viewports we make them transparent)
    LastAlpha:               float;
    LastFocusedHadNavWindow: bool; // Instead of maintaining a LastFocusedWindow (which may harder to correctly maintain), we merely store weither NavWindow != NULL last time the viewport was focused.
    PlatformMonitor:         s16;
    BgFgDrawListsLastFrame:  [2] s32; // Last frame number the background (0) and foreground (1) draw lists were used
    BgFgDrawLists:           [2] *DrawList; // Convenience background (0) and foreground (1) draw lists. We use them to draw software mouser cursor when io.MouseDrawCursor is set and to draw most debug overlays.
    DrawDataP:               DrawData;
    DrawDataBuilder_:        DrawDataBuilder; // Temporary data while building final ImDrawData
    LastPlatformPos:         Vector2;
    LastPlatformSize:        Vector2;
    LastRendererSize:        Vector2;

    WorkInsetMin:            Vector2; // Work Area inset locked for the frame. GetWorkRect() always fits within GetMainRect().
    WorkInsetMax:            Vector2; // "
    BuildWorkInsetMin:       Vector2; // Work Area inset accumulator for current frame, to become next frame's WorkInset
    BuildWorkInsetMax:       Vector2; // "

    Constructor :: (this: *ViewportP) -> void #cpp_method #foreign ImGui "??0ImGuiViewportP@@QEAA@XZ";
    Destructor :: (this: *ViewportP) -> void #cpp_method #foreign ImGui "??1ImGuiViewportP@@QEAA@XZ";
    ClearRequestFlags :: (this: *ViewportP) -> void #cpp_method #foreign ImGui "?ClearRequestFlags@ImGuiViewportP@@QEAAXXZ";

    // Calculate work rect pos/size given a set of offset (we have 1 pair of offset for rect locked from last frame data, and 1 pair for currently building rect)
    CalcWorkRectPos :: (this: *ViewportP, inset_min: *Vector2) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?CalcWorkRectPos@ImGuiViewportP@@QEBA?AUImVec2@@AEBU2@@Z";
    CalcWorkRectPos :: (this: *ViewportP, inset_min: Vector2) -> Vector2 #no_context {
        return CalcWorkRectPos(this, *inset_min);
    }
    CalcWorkRectSize :: (this: *ViewportP, inset_min: *Vector2, inset_max: *Vector2) -> Vector2 #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?CalcWorkRectSize@ImGuiViewportP@@QEBA?AUImVec2@@AEBU2@0@Z";
    CalcWorkRectSize :: (this: *ViewportP, inset_min: Vector2, inset_max: Vector2) -> Vector2 #no_context {
        return CalcWorkRectSize(this, *inset_min, *inset_max);
    }
    UpdateWorkRect :: (this: *ViewportP) -> void #cpp_method #foreign ImGui "?UpdateWorkRect@ImGuiViewportP@@QEAAXXZ";

    // Helpers to retrieve ImRect (we don't need to store BuildWorkRect as every access tend to change it, hence the code asymmetry)
    GetMainRect :: (this: *ViewportP) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetMainRect@ImGuiViewportP@@QEBA?AUImRect@@XZ";
    GetWorkRect :: (this: *ViewportP) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetWorkRect@ImGuiViewportP@@QEBA?AUImRect@@XZ";
    GetBuildWorkRect :: (this: *ViewportP) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?GetBuildWorkRect@ImGuiViewportP@@QEBA?AUImRect@@XZ";
}

// Windows data saved in imgui.ini file
// Because we never destroy or rename ImGuiWindowSettings, we can store the names in a separate buffer easily.
// (this is designed to be stored in a ImChunkStream buffer, with the variable-length Name following our structure)
WindowSettings :: struct {
    ID_:         ID;
    Pos:         Vec2ih; // NB: Settings position are stored RELATIVE to the viewport! Whereas runtime ones are absolute positions.
    Size:        Vec2ih;
    ViewportPos: Vec2ih;
    ViewportId:  ID;
    DockId:      ID; // ID of last known DockNode (even if the DockNode is invisible because it has only 1 active window), or 0 if none.
    ClassId:     ID; // ID of window class if specified
    DockOrder:   s16; // Order of the last time the window was visible within its DockNode. This is used to reorder windows that are reappearing on the same frame. Same value between windows that were active and windows that were none are possible.
    Collapsed:   bool;
    IsChild:     bool;
    WantApply:   bool; // Set when loaded from .ini data (to enable merging/loading .ini data into an already running context)
    WantDelete:  bool; // Set to invalidate/delete the settings entry

    Constructor :: (this: *WindowSettings) -> void #cpp_method #foreign ImGui "??0ImGuiWindowSettings@@QEAA@XZ";
    GetName :: (this: *WindowSettings) -> *u8 #cpp_method #foreign ImGui "?GetName@ImGuiWindowSettings@@QEAAPEADXZ";
}

SettingsHandler :: struct {
    TypeName:   *u8; // Short description stored in .ini file. Disallowed characters: '[' ']'
    TypeHash:   ID; // == ImHashStr(TypeName)
    ClearAllFn: #type (ctx: *ImGuiContext, handler: *SettingsHandler) -> void #c_call; // Clear all settings data
    ReadInitFn: #type (ctx: *ImGuiContext, handler: *SettingsHandler) -> void #c_call; // Read: Called before reading (in registration order)
    ReadOpenFn: #type (ctx: *ImGuiContext, handler: *SettingsHandler, name: *u8) -> *void #c_call; // Read: Called when entering into a new ini entry e.g. "[Window][Name]"
    ReadLineFn: #type (ctx: *ImGuiContext, handler: *SettingsHandler, entry: *void, line: *u8) -> void #c_call; // Read: Called for every line of text within an ini entry
    ApplyAllFn: #type (ctx: *ImGuiContext, handler: *SettingsHandler) -> void #c_call; // Read: Called after reading (in registration order)
    WriteAllFn: #type (ctx: *ImGuiContext, handler: *SettingsHandler, out_buf: *TextBuffer) -> void #c_call; // Write: Output every entries into 'out_buf'
    UserData:   *void;

    Constructor :: (this: *SettingsHandler) -> void #cpp_method #foreign ImGui "??0ImGuiSettingsHandler@@QEAA@XZ";
}

LocEntry :: struct {
    Key:  LocKey;
    Text: *u8;
}

// The error callback is currently not public, as it is expected that only advanced users will rely on it.
ErrorCallback :: #type (ctx: *ImGuiContext, user_data: *void, msg: *u8) -> void #c_call;

// See IMGUI_DEBUG_LOG() and IMGUI_DEBUG_LOG_XXX() macros.
DebugLogFlags :: enum_flags s32 {
    None               :: 0x0;
    EventError         :: 0x1;
    EventActiveId      :: 0x2;
    EventFocus         :: 0x4;
    EventPopup         :: 0x8;
    EventNav           :: 0x10;
    EventClipper       :: 0x20;
    EventSelection     :: 0x40;
    EventIO            :: 0x80;
    EventFont          :: 0x100;
    EventInputRouting  :: 0x200;
    EventDocking       :: 0x400;
    EventViewport      :: 0x800;

    EventMask_         :: 0xfff;
    OutputToTTY        :: 0x100000;
    OutputToTestEngine :: 0x200000;
}

DebugAllocEntry :: struct {
    FrameCount: s32;
    AllocCount: S16;
    FreeCount:  S16;
}

DebugAllocInfo :: struct {
    TotalAllocCount: s32; // Number of call to MemAlloc().
    TotalFreeCount:  s32;
    LastEntriesIdx:  S16; // Current index in buffer
    LastEntriesBuf:  [6] DebugAllocEntry; // Track last 6 frames that had allocations

    Constructor :: (this: *DebugAllocInfo) -> void #cpp_method #foreign ImGui "??0ImGuiDebugAllocInfo@@QEAA@XZ";
}

MetricsConfig :: struct {
    ShowDebugLog              := false;
    ShowIDStackTool           := false;
    ShowWindowsRects          := false;
    ShowWindowsBeginOrder     := false;
    ShowTablesRects           := false;
    ShowDrawCmdMesh           := true;
    ShowDrawCmdBoundingBoxes  := true;
    ShowTextEncodingViewer    := false;
    ShowTextureUsedRect       := false;
    ShowDockingNodes          := false;
    ShowWindowsRectsType:     s32 = -1;
    ShowTablesRectsType:      s32 = -1;
    HighlightMonitorIdx:      s32 = -1;
    HighlightViewportID:      ID = 0;
    ShowFontPreview           := true;
}

StackLevelInfo :: struct {
    ID_:             ID;
    QueryFrameCount: S8; // >= 1: Query in progress
    QuerySuccess:    bool; // Obtained result from DebugHookIdInfo()
    DataType:        S8; // ImGuiDataType
    DescOffset:      s32; // -1 or offset into parent's ResultPathsBuf

    Constructor :: (this: *StackLevelInfo) -> void #cpp_method #foreign ImGui "??0ImGuiStackLevelInfo@@QEAA@XZ";
}

// State for ID Stack tool queries
IDStackTool :: struct {
    LastActiveFrame:           s32;
    StackLevel:                s32; // -1: query stack and resize Results, >= 0: individual stack level
    QueryId:                   ID; // ID to query details for
    Results:                   Vector(StackLevelInfo);
    OptHexEncodeNonAsciiChars: bool;
    OptCopyToClipboardOnCtrlC: bool;
    CopyToClipboardLastTime:   float;
    ResultPathsBuf:            TextBuffer;
    ResultTempBuf:             TextBuffer;

    Constructor :: (this: *IDStackTool) -> void #cpp_method #foreign ImGui "??0ImGuiIDStackTool@@QEAA@XZ";
}

//-----------------------------------------------------------------------------
// [SECTION] Generic context hooks
//-----------------------------------------------------------------------------
ContextHookCallback :: #type (ctx: *ImGuiContext, hook: *ContextHook) -> void #c_call;
ContextHookType :: enum s32 {
    NewFramePre     :: 0;
    NewFramePost    :: 1;
    EndFramePre     :: 2;
    EndFramePost    :: 3;
    RenderPre       :: 4;
    RenderPost      :: 5;
    Shutdown        :: 6;
    PendingRemoval_ :: 7;
}

ContextHook :: struct {
    HookId:   ID; // A unique ID assigned by AddContextHook()
    Type:     ContextHookType;
    Owner:    ID;
    Callback: ContextHookCallback;
    UserData: *void;
}

// Forward declarations: ImGui layer
ImGuiContext :: struct #type_info_none {
    Initialized:                        bool;
    IO_:                                IO;
    PlatformIO_:                        PlatformIO;
    Style_:                             Style;
    ConfigFlagsCurrFrame:               ConfigFlags; // = g.IO.ConfigFlags at the time of NewFrame()
    ConfigFlagsLastFrame:               ConfigFlags;
    FontAtlases:                        Vector(*FontAtlas); // List of font atlases used by the context (generally only contains g.IO.Fonts aka the main font atlas)
    Font_:                              *Font; // Currently bound font. (== FontStack.back().Font)
    FontBaked_:                         *FontBaked; // Currently bound font at currently bound size. (== Font->GetFontBaked(FontSize))
    FontSize:                           float; // Currently bound font size == line height (== FontSizeBase + externals scales applied in the UpdateCurrentFontSize() function).
    FontSizeBase:                       float; // Font size before scaling == style.FontSizeBase == value passed to PushFont() when specified.
    FontBakedScale:                     float; // == FontBaked->Size / FontSize. Scale factor over baked size. Rarely used nowadays, very often == 1.0f.
    FontRasterizerDensity:              float; // Current font density. Used by all calls to GetFontBaked().
    CurrentDpiScale:                    float; // Current window/viewport DpiScale == CurrentViewport->DpiScale
    DrawListSharedData_:                DrawListSharedData;
    Time:                               float64;
    FrameCount:                         s32;
    FrameCountEnded:                    s32;
    FrameCountPlatformEnded:            s32;
    FrameCountRendered:                 s32;
    WithinEndChildID:                   ID; // Set within EndChild()
    WithinFrameScope:                   bool; // Set by NewFrame(), cleared by EndFrame()
    WithinFrameScopeWithImplicitWindow: bool; // Set by NewFrame(), cleared by EndFrame() when the implicit debug window has been pushed
    GcCompactAll:                       bool; // Request full GC
    TestEngineHookItems:                bool; // Will call test engine hooks: ImGuiTestEngineHook_ItemAdd(), ImGuiTestEngineHook_ItemInfo(), ImGuiTestEngineHook_Log()
    TestEngine:                         *void; // Test engine user data
    ContextName:                        [16] u8; // Storage for a context name (to facilitate debugging multi-context setups)

    InputEventsQueue:                   Vector(InputEvent); // Input events which will be trickled/written into IO structure.
    InputEventsTrail:                   Vector(InputEvent); // Past input events processed in NewFrame(). This is to allow domain-specific application to access e.g mouse/pen trail.
    InputEventsNextMouseSource:         MouseSource;
    InputEventsNextEventId:             U32;

    Windows:                            Vector(*Window); // Windows, sorted in display order, back to front
    WindowsFocusOrder:                  Vector(*Window); // Root windows, sorted in focus order, back to front.
    WindowsTempSortBuffer:              Vector(*Window); // Temporary buffer used in EndFrame() to reorder windows so parents are kept before their child
    CurrentWindowStack:                 Vector(WindowStackData);
    WindowsById:                        Storage; // Map window's ImGuiID to ImGuiWindow*
    WindowsActiveCount:                 s32; // Number of unique windows submitted by frame
    WindowsBorderHoverPadding:          float; // Padding around resizable windows for which hovering on counts as hovering the window == ImMax(style.TouchExtraPadding, style.WindowBorderHoverPadding). This isn't so multi-dpi friendly.
    DebugBreakInWindow:                 ID; // Set to break in Begin() call.
    CurrentWindow:                      *Window; // Window being drawn into
    HoveredWindow:                      *Window; // Window the mouse is hovering. Will typically catch mouse inputs.
    HoveredWindowUnderMovingWindow:     *Window; // Hovered window ignoring MovingWindow. Only set if MovingWindow is set.
    HoveredWindowBeforeClear:           *Window; // Window the mouse is hovering. Filled even with _NoMouse. This is currently useful for multi-context compositors.
    MovingWindow:                       *Window; // Track the window we clicked on (in order to preserve focus). The actual window that is moved is generally MovingWindow->RootWindowDockTree.
    WheelingWindow:                     *Window; // Track the window we started mouse-wheeling on. Until a timer elapse or mouse has moved, generally keep scrolling the same window even if during the course of scrolling the mouse ends up hovering a child window.
    WheelingWindowRefMousePos:          Vector2;
    WheelingWindowStartFrame:           s32; // This may be set one frame before WheelingWindow is != NULL
    WheelingWindowScrolledFrame:        s32;
    WheelingWindowReleaseTimer:         float;
    WheelingWindowWheelRemainder:       Vector2;
    WheelingAxisAvg:                    Vector2;

    DebugDrawIdConflictsId:             ID; // Set when we detect multiple items with the same identifier
    DebugHookIdInfo:                    ID; // Will call core hooks: DebugHookIdInfo() from GetID functions, used by ID Stack Tool [next HoveredId/ActiveId to not pull in an extra cache-line]
    HoveredId:                          ID; // Hovered widget, filled during the frame
    HoveredIdPreviousFrame:             ID;
    HoveredIdPreviousFrameItemCount:    s32; // Count numbers of items using the same ID as last frame's hovered id
    HoveredIdTimer:                     float; // Measure contiguous hovering time
    HoveredIdNotActiveTimer:            float; // Measure contiguous hovering time where the item has not been active
    HoveredIdAllowOverlap:              bool;
    HoveredIdIsDisabled:                bool; // At least one widget passed the rect test, but has been discarded by disabled flag or popup inhibit. May be true even if HoveredId == 0.
    ItemUnclipByLog:                    bool; // Disable ItemAdd() clipping, essentially a memory-locality friendly copy of LogEnabled
    ActiveId:                           ID; // Active widget
    ActiveIdIsAlive:                    ID; // Active widget has been seen this frame (we can't use a bool as the ActiveId may change within the frame)
    ActiveIdTimer:                      float;
    ActiveIdIsJustActivated:            bool; // Set at the time of activation for one frame
    ActiveIdAllowOverlap:               bool; // Active widget allows another widget to steal active id (generally for overlapping widgets, but not always)
    ActiveIdNoClearOnFocusLoss:         bool; // Disable losing active id if the active id window gets unfocused.
    ActiveIdHasBeenPressedBefore:       bool; // Track whether the active id led to a press (this is to allow changing between PressOnClick and PressOnRelease without pressing twice). Used by range_select branch.
    ActiveIdHasBeenEditedBefore:        bool; // Was the value associated to the widget Edited over the course of the Active state.
    ActiveIdHasBeenEditedThisFrame:     bool;
    ActiveIdFromShortcut:               bool;
    ActiveIdDisabledId:                 ID; // When clicking a disabled item we set ActiveId=window->MoveId to avoid interference with widget code. Actual item ID is stored here.
    ActiveIdMouseButton:                s32; /* 8 bits */
    ActiveIdClickOffset:                Vector2; // Clicked offset from upper-left corner, if applicable (currently only set by ButtonBehavior)
    ActiveIdWindow:                     *Window;
    ActiveIdSource:                     InputSource; // Activating source: ImGuiInputSource_Mouse OR ImGuiInputSource_Keyboard OR ImGuiInputSource_Gamepad
    ActiveIdPreviousFrame:              ID;
    DeactivatedItemData_:               DeactivatedItemData;
    ActiveIdValueOnActivation:          DataTypeStorage; // Backup of initial value at the time of activation. ONLY SET BY SPECIFIC WIDGETS: DragXXX and SliderXXX.
    LastActiveId:                       ID; // Store the last non-zero ActiveId, useful for animation.
    LastActiveIdTimer:                  float; // Store the last non-zero ActiveId timer since the beginning of activation, useful for animation.

    LastKeyModsChangeTime:              float64; // Record the last time key mods changed (affect repeat delay when using shortcut logic)
    LastKeyModsChangeFromNoneTime:      float64; // Record the last time key mods changed away from being 0 (affect repeat delay when using shortcut logic)
    LastKeyboardKeyPressTime:           float64; // Record the last time a keyboard key (ignore mouse/gamepad ones) was pressed.
    KeysMayBeCharInput:                 BitArrayForNamedKeys; // Lookup to tell if a key can emit char input, see IsKeyChordPotentiallyCharInput(). sizeof() = 20 bytes
    KeysOwnerData:                      [155] KeyOwnerData;
    KeysRoutingTable:                   KeyRoutingTable;
    ActiveIdUsingNavDirMask:            U32; // Active widget will want to read those nav move requests (e.g. can activate a button and move away from it)
    ActiveIdUsingAllKeyboardKeys:       bool; // Active widget will want to read all keyboard keys inputs. (this is a shortcut for not taking ownership of 100+ keys, frequently used by drag operations)
    DebugBreakInShortcutRouting:        KeyChord; // Set to break in SetShortcutRouting()/Shortcut() calls.

    CurrentFocusScopeId:                ID; // Value for currently appending items == g.FocusScopeStack.back(). Not to be mistaken with g.NavFocusScopeId.
    CurrentItemFlags:                   ItemFlags; // Value for currently appending items == g.ItemFlagsStack.back()
    DebugLocateId:                      ID; // Storage for DebugLocateItemOnHover() feature: this is read by ItemAdd() so we keep it in a hot/cached location
    NextItemData_:                      NextItemData; // Storage for SetNextItem** functions
    LastItemData_:                      LastItemData; // Storage for last submitted item (setup by ItemAdd)
    NextWindowData_:                    NextWindowData; // Storage for SetNextWindow** functions
    DebugShowGroupRects:                bool;

    DebugFlashStyleColorIdx:            Col; // (Keep close to ColorStack to share cache line)
    ColorStack:                         Vector(ColorMod); // Stack for PushStyleColor()/PopStyleColor() - inherited by Begin()
    StyleVarStack:                      Vector(StyleMod); // Stack for PushStyleVar()/PopStyleVar() - inherited by Begin()
    FontStack:                          Vector(FontStackData); // Stack for PushFont()/PopFont() - inherited by Begin()
    FocusScopeStack:                    Vector(FocusScopeData); // Stack for PushFocusScope()/PopFocusScope() - inherited by BeginChild(), pushed into by Begin()
    ItemFlagsStack:                     Vector(ItemFlags); // Stack for PushItemFlag()/PopItemFlag() - inherited by Begin()
    GroupStack:                         Vector(GroupData); // Stack for BeginGroup()/EndGroup() - not inherited by Begin()
    OpenPopupStack:                     Vector(PopupData); // Which popups are open (persistent)
    BeginPopupStack:                    Vector(PopupData); // Which level of BeginPopup() we are in (reset every frame)
    TreeNodeStack:                      Vector(TreeNodeStackData); // Stack for TreeNode()

    Viewports:                          Vector(*ViewportP); // Active viewports (always 1+, and generally 1 unless multi-viewports are enabled). Each viewports hold their copy of ImDrawData.
    CurrentViewport:                    *ViewportP; // We track changes of viewport (happening in Begin) so we can call Platform_OnChangedViewport()
    MouseViewport:                      *ViewportP;
    MouseLastHoveredViewport:           *ViewportP; // Last known viewport that was hovered by mouse (even if we are not hovering any viewport any more) + honoring the _NoInputs flag.
    PlatformLastFocusedViewportId:      ID;
    FallbackMonitor:                    PlatformMonitor; // Virtual monitor used as fallback if backend doesn't provide monitor information.
    PlatformMonitorsFullWorkRect:       Rect; // Bounding box of all platform monitors
    ViewportCreatedCount:               s32; // Unique sequential creation counter (mostly for testing/debugging)
    PlatformWindowsCreatedCount:        s32; // Unique sequential creation counter (mostly for testing/debugging)
    ViewportFocusedStampCount:          s32; // Every time the front-most window changes, we stamp its viewport with an incrementing counter

    NavCursorVisible:                   bool; // Nav focus cursor/rectangle is visible? We hide it after a mouse click. We show it after a nav move.
    NavHighlightItemUnderNav:           bool; // Disable mouse hovering highlight. Highlight navigation focused item instead of mouse hovered item.

    NavMousePosDirty:                   bool; // When set we will update mouse position if io.ConfigNavMoveSetMousePos is set (not enabled by default)
    NavIdIsAlive:                       bool; // Nav widget has been seen this frame ~~ NavRectRel is valid
    NavId:                              ID; // Focused item for navigation
    NavWindow:                          *Window; // Focused window for navigation. Could be called 'FocusedWindow'
    NavFocusScopeId:                    ID; // Focused focus scope (e.g. selection code often wants to "clear other items" when landing on an item of the same scope)
    NavLayer_:                          NavLayer; // Focused layer (main scrolling layer, or menu/title bar layer)
    NavActivateId:                      ID; // ~~ (g.ActiveId == 0) && (IsKeyPressed(ImGuiKey_Space) || IsKeyDown(ImGuiKey_Enter) || IsKeyPressed(ImGuiKey_NavGamepadActivate)) ? NavId : 0, also set when calling ActivateItemByID()
    NavActivateDownId:                  ID; // ~~ IsKeyDown(ImGuiKey_Space) || IsKeyDown(ImGuiKey_Enter) || IsKeyDown(ImGuiKey_NavGamepadActivate) ? NavId : 0
    NavActivatePressedId:               ID; // ~~ IsKeyPressed(ImGuiKey_Space) || IsKeyPressed(ImGuiKey_Enter) || IsKeyPressed(ImGuiKey_NavGamepadActivate) ? NavId : 0 (no repeat)
    NavActivateFlags:                   ActivateFlags;
    NavFocusRoute:                      Vector(FocusScopeData); // Reversed copy focus scope stack for NavId (should contains NavFocusScopeId). This essentially follow the window->ParentWindowForFocusRoute chain.
    NavHighlightActivatedId:            ID;
    NavHighlightActivatedTimer:         float;
    NavNextActivateId:                  ID; // Set by ActivateItemByID(), queued until next frame.
    NavNextActivateFlags:               ActivateFlags;
    NavInputSource:                     InputSource; // Keyboard or Gamepad mode? THIS CAN ONLY BE ImGuiInputSource_Keyboard or ImGuiInputSource_Mouse
    NavLastValidSelectionUserData:      SelectionUserData; // Last valid data passed to SetNextItemSelectionUser(), or -1. For current window. Not reset when focusing an item that doesn't have selection data.
    NavCursorHideFrames:                S8;

    NavAnyRequest:                      bool; // ~~ NavMoveRequest || NavInitRequest this is to perform early out in ItemAdd()
    NavInitRequest:                     bool; // Init request for appearing window to select first item
    NavInitRequestFromMove:             bool;
    NavInitResult:                      NavItemData; // Init request result (first item of the window, or one for which SetItemDefaultFocus() was called)
    NavMoveSubmitted:                   bool; // Move request submitted, will process result on next NewFrame()
    NavMoveScoringItems:                bool; // Move request submitted, still scoring incoming items
    NavMoveForwardToNextFrame:          bool;
    NavMoveFlags_:                      NavMoveFlags;
    NavMoveScrollFlags:                 ScrollFlags;
    NavMoveKeyMods:                     KeyChord;
    NavMoveDir:                         Dir; // Direction of the move request (left/right/up/down)
    NavMoveDirForDebug:                 Dir;
    NavMoveClipDir:                     Dir; // FIXME-NAV: Describe the purpose of this better. Might want to rename?
    NavScoringRect:                     Rect; // Rectangle used for scoring, in screen space. Based of window->NavRectRel[], modified for directional navigation scoring.
    NavScoringNoClipRect:               Rect; // Some nav operations (such as PageUp/PageDown) enforce a region which clipper will attempt to always keep submitted
    NavScoringDebugCount:               s32; // Metrics for debugging
    NavTabbingDir:                      s32; // Generally -1 or +1, 0 when tabbing without a nav id
    NavTabbingCounter:                  s32; // >0 when counting items for tabbing
    NavMoveResultLocal:                 NavItemData; // Best move request candidate within NavWindow
    NavMoveResultLocalVisible:          NavItemData; // Best move request candidate within NavWindow that are mostly visible (when using ImGuiNavMoveFlags_AlsoScoreVisibleSet flag)
    NavMoveResultOther:                 NavItemData; // Best move request candidate within NavWindow's flattened hierarchy (when using ImGuiWindowFlags_NavFlattened flag)
    NavTabbingResultFirst:              NavItemData; // First tabbing request candidate within NavWindow and flattened hierarchy

    NavJustMovedFromFocusScopeId:       ID; // Just navigated from this focus scope id (result of a successfully MoveRequest).
    NavJustMovedToId:                   ID; // Just navigated to this id (result of a successfully MoveRequest).
    NavJustMovedToFocusScopeId:         ID; // Just navigated to this focus scope id (result of a successfully MoveRequest).
    NavJustMovedToKeyMods:              KeyChord;
    NavJustMovedToIsTabbing:            bool; // Copy of ImGuiNavMoveFlags_IsTabbing. Maybe we should store whole flags.
    NavJustMovedToHasSelectionData:     bool; // Copy of move result's ItemFlags & ImGuiItemFlags_HasSelectionUserData). Maybe we should just store ImGuiNavItemData.

    ConfigNavWindowingWithGamepad:      bool; // = true. Enable CTRL+TAB by holding ImGuiKey_GamepadFaceLeft (== ImGuiKey_NavGamepadMenu). When false, the button may still be used to toggle Menu layer.
    ConfigNavWindowingKeyNext:          KeyChord; // = ImGuiMod_Ctrl | ImGuiKey_Tab (or ImGuiMod_Super | ImGuiKey_Tab on OS X). For reconfiguration (see #4828)
    ConfigNavWindowingKeyPrev:          KeyChord; // = ImGuiMod_Ctrl | ImGuiMod_Shift | ImGuiKey_Tab (or ImGuiMod_Super | ImGuiMod_Shift | ImGuiKey_Tab on OS X)
    NavWindowingTarget:                 *Window; // Target window when doing CTRL+Tab (or Pad Menu + FocusPrev/Next), this window is temporarily displayed top-most!
    NavWindowingTargetAnim:             *Window; // Record of last valid NavWindowingTarget until DimBgRatio and NavWindowingHighlightAlpha becomes 0.0f, so the fade-out can stay on it.
    NavWindowingListWindow:             *Window; // Internal window actually listing the CTRL+Tab contents
    NavWindowingTimer:                  float;
    NavWindowingHighlightAlpha:         float;
    NavWindowingInputSource:            InputSource;
    NavWindowingToggleLayer:            bool; // Set while Alt or GamepadMenu is held, may be cleared by other operations, and processed when releasing the key.
    NavWindowingToggleKey:              Key; // Keyboard/gamepad key used when toggling to menu layer.
    NavWindowingAccumDeltaPos:          Vector2;
    NavWindowingAccumDeltaSize:         Vector2;

    DimBgRatio:                         float; // 0.0..1.0 animation when fading in a dimming background (for modal window and CTRL+TAB list)

    // Drag and Drop
    DragDropActive:                     bool;
    DragDropWithinSource:               bool; // Set when within a BeginDragDropXXX/EndDragDropXXX block for a drag source.
    DragDropWithinTarget:               bool; // Set when within a BeginDragDropXXX/EndDragDropXXX block for a drag target.
    DragDropSourceFlags:                DragDropFlags;
    DragDropSourceFrameCount:           s32;
    DragDropMouseButton:                s32;
    DragDropPayload:                    Payload;
    DragDropTargetRect:                 Rect; // Store rectangle of current target candidate (we favor small targets when overlapping)
    DragDropTargetClipRect:             Rect; // Store ClipRect at the time of item's drawing
    DragDropTargetId:                   ID;
    DragDropAcceptFlags:                DragDropFlags;
    DragDropAcceptIdCurrRectSurface:    float; // Target item surface (we resolve overlapping targets by prioritizing the smaller surface)
    DragDropAcceptIdCurr:               ID; // Target item id (set at the time of accepting the payload)
    DragDropAcceptIdPrev:               ID; // Target item id from previous frame (we need to store this to allow for overlapping drag and drop targets)
    DragDropAcceptFrameCount:           s32; // Last time a target expressed a desire to accept the source
    DragDropHoldJustPressedId:          ID; // Set when holding a payload just made ButtonBehavior() return a press.
    DragDropPayloadBufHeap:             Vector(u8); // We don't expose the ImVector<> directly, ImGuiPayload only holds pointer+size
    DragDropPayloadBufLocal:            [16] u8; // Local buffer for small payloads

    // Clipper
    ClipperTempDataStacked:             s32;
    ClipperTempData:                    Vector(ListClipperData);

    // Tables
    CurrentTable:                       *Table;
    DebugBreakInTable:                  ID; // Set to break in BeginTable() call.
    TablesTempDataStacked:              s32; // Temporary table data size (because we leave previous instances undestructed, we generally don't use TablesTempData.Size)
    TablesTempData:                     Vector(TableTempData); // Temporary table data (buffers reused/shared across instances, support nesting)
    Tables:                             Pool(Table); // Persistent table data
    TablesLastTimeActive:               Vector(float); // Last used timestamp of each tables (SOA, for efficient GC)
    DrawChannelsTempMergeBuffer:        Vector(DrawChannel);

    // Tab bars
    CurrentTabBar:                      *TabBar;
    TabBars:                            Pool(TabBar);
    CurrentTabBarStack:                 Vector(PtrOrIndex);
    ShrinkWidthBuffer:                  Vector(ShrinkWidthItem);

    // Multi-Select state
    BoxSelectState_:                    BoxSelectState;
    CurrentMultiSelect:                 *MultiSelectTempData;
    MultiSelectTempDataStacked:         s32; // Temporary multi-select data size (because we leave previous instances undestructed, we generally don't use MultiSelectTempData.Size)
    MultiSelectTempData_:               Vector(MultiSelectTempData);
    MultiSelectStorage:                 Pool(MultiSelectState);

    // Hover Delay system
    HoverItemDelayId:                   ID;
    HoverItemDelayIdPreviousFrame:      ID;
    HoverItemDelayTimer:                float; // Currently used by IsItemHovered()
    HoverItemDelayClearTimer:           float; // Currently used by IsItemHovered(): grace time before g.TooltipHoverTimer gets cleared.
    HoverItemUnlockedStationaryId:      ID; // Mouse has once been stationary on this item. Only reset after departing the item.
    HoverWindowUnlockedStationaryId:    ID; // Mouse has once been stationary on this window. Only reset after departing the window.

    // Mouse state
    MouseCursor_:                       MouseCursor;
    MouseStationaryTimer:               float; // Time the mouse has been stationary (with some loose heuristic)
    MouseLastValidPos:                  Vector2;

    // Widget state
    InputTextState_:                    InputTextState;
    InputTextDeactivatedState_:         InputTextDeactivatedState;
    InputTextPasswordFontBackupBaked:   FontBaked;
    InputTextPasswordFontBackupFlags:   FontFlags;
    TempInputId:                        ID; // Temporary text input when CTRL+clicking on a slider, etc.
    DataTypeZeroValue:                  DataTypeStorage; // 0 for all data types
    BeginMenuDepth:                     s32;
    BeginComboDepth:                    s32;
    ColorEditOptions:                   ColorEditFlags; // Store user options for color edit widgets
    ColorEditCurrentID:                 ID; // Set temporarily while inside of the parent-most ColorEdit4/ColorPicker4 (because they call each others).
    ColorEditSavedID:                   ID; // ID we are saving/restoring HS for
    ColorEditSavedHue:                  float; // Backup of last Hue associated to LastColor, so we can restore Hue in lossy RGB<>HSV round trips
    ColorEditSavedSat:                  float; // Backup of last Saturation associated to LastColor, so we can restore Saturation in lossy RGB<>HSV round trips
    ColorEditSavedColor:                U32; // RGB value with alpha set to 0.
    ColorPickerRef:                     Vector4; // Initial/reference color at the time of opening the color picker.
    ComboPreviewData_:                  ComboPreviewData;
    WindowResizeBorderExpectedRect:     Rect; // Expected border rect, switch to relative edit if moving
    WindowResizeRelativeMode:           bool;
    ScrollbarSeekMode:                  s16; // 0: scroll to clicked location, -1/+1: prev/next page.
    ScrollbarClickDeltaToGrabCenter:    float; // When scrolling to mouse location: distance between mouse and center of grab box, normalized in parent space.
    SliderGrabClickOffset:              float;
    SliderCurrentAccum:                 float; // Accumulated slider delta when using navigation controls.
    SliderCurrentAccumDirty:            bool; // Has the accumulated slider delta changed since last time we tried to apply it?
    DragCurrentAccumDirty:              bool;
    DragCurrentAccum:                   float; // Accumulator for dragging modification. Always high-precision, not rounded by end-user precision settings
    DragSpeedDefaultRatio:              float; // If speed == 0.0f, uses (max-min) * DragSpeedDefaultRatio
    DisabledAlphaBackup:                float; // Backup for style.Alpha for BeginDisabled()
    DisabledStackSize:                  s16;
    TooltipOverrideCount:               s16;
    TooltipPreviousWindow:              *Window; // Window of last tooltip submitted during the frame
    ClipboardHandlerData:               Vector(u8); // If no custom clipboard handler is defined
    MenusIdSubmittedThisFrame:          Vector(ID); // A list of menu IDs that were rendered at least once
    TypingSelectState_:                 TypingSelectState; // State for GetTypingSelectRequest()

    PlatformImeData_:                   PlatformImeData; // Data updated by current frame. Will be applied at end of the frame. For some backends, this is required to have WantVisible=true in order to receive text message.
    PlatformImeDataPrev:                PlatformImeData; // Previous frame data. When changed we call the platform_io.Platform_SetImeDataFn() handler.

    UserTextures:                       Vector(*TextureData); // List of textures created/managed by user or third-party extension. Automatically appended into platform_io.Textures[].
    DockContext_:                       DockContext;
    DockNodeWindowMenuHandler:          #type (ctx: *ImGuiContext, node: *DockNode, tab_bar: *TabBar) -> void #c_call;

    // Settings
    SettingsLoaded:                     bool;
    SettingsDirtyTimer:                 float; // Save .ini Settings to memory when time reaches zero
    SettingsIniData:                    TextBuffer; // In memory .ini settings
    SettingsHandlers:                   Vector(SettingsHandler); // List of .ini settings handlers
    SettingsWindows:                    ChunkStream(WindowSettings); // ImGuiWindow .ini settings entries
    SettingsTables:                     ChunkStream(TableSettings); // ImGuiTable .ini settings entries
    Hooks:                              Vector(ContextHook); // Hooks for extensions (e.g. test engine)
    HookIdNext:                         ID; // Next available HookId

    // Localization
    LocalizationTable:                  [13] *u8;

    LogEnabled:                         bool; // Currently capturing
    LogFlags_:                          LogFlags; // Capture flags/type
    LogWindow:                          *Window;
    LogFile:                            *void; // If != NULL log to stdout/ file
    LogBuffer:                          TextBuffer; // Accumulation buffer when log to clipboard. This is pointer so our GImGui static constructor doesn't call heap allocators.
    LogNextPrefix:                      *u8;
    LogNextSuffix:                      *u8;
    LogLinePosY:                        float;
    LogLineFirstItem:                   bool;
    LogDepthRef:                        s32;
    LogDepthToExpand:                   s32;
    LogDepthToExpandDefault:            s32; // Default/stored value for LogDepthMaxExpand if not specified in the LogXXX function call.

    ErrorCallback_:                     ErrorCallback; // = NULL. May be exposed in public API eventually.
    ErrorCallbackUserData:              *void; // = NULL
    ErrorTooltipLockedPos:              Vector2;
    ErrorFirst:                         bool;
    ErrorCountCurrentFrame:             s32; // [Internal] Number of errors submitted this frame.
    StackSizesInNewFrame:               ErrorRecoveryState; // [Internal]
    StackSizesInBeginForCurrentWindow:  *ErrorRecoveryState; // [Internal]

    DebugDrawIdConflictsCount:          s32; // Locked count (preserved when holding CTRL)
    DebugLogFlags_:                     DebugLogFlags;
    DebugLogBuf:                        TextBuffer;
    DebugLogIndex:                      TextIndex;
    DebugLogSkippedErrors:              s32;
    DebugLogAutoDisableFlags:           DebugLogFlags;
    DebugLogAutoDisableFrames:          U8;
    DebugLocateFrames:                  U8; // For DebugLocateItemOnHover(). This is used together with DebugLocateId which is in a hot/cached spot above.
    DebugBreakInLocateId:               bool; // Debug break in ItemAdd() call for g.DebugLocateId.
    DebugBreakKeyChord:                 KeyChord; // = ImGuiKey_Pause
    DebugBeginReturnValueCullDepth:     S8; // Cycle between 0..9 then wrap around.
    DebugItemPickerActive:              bool; // Item picker is active (started with DebugStartItemPicker())
    DebugItemPickerMouseButton:         U8;
    DebugItemPickerBreakId:             ID; // Will call IM_DEBUG_BREAK() when encountering this ID
    DebugFlashStyleColorTime:           float;
    DebugFlashStyleColorBackup:         Vector4;
    DebugMetricsConfig:                 MetricsConfig;
    DebugIDStackTool:                   IDStackTool;
    DebugAllocInfo_:                    DebugAllocInfo;
    DebugHoveredDockNode:               *DockNode; // Hovered dock node.

    FramerateSecPerFrame:               [60] float; // Calculate estimate of framerate for user over the last 60 frames..
    FramerateSecPerFrameIdx:            s32;
    FramerateSecPerFrameCount:          s32;
    FramerateSecPerFrameAccum:          float;
    WantCaptureMouseNextFrame:          s32; // Explicit capture override via SetNextFrameWantCaptureMouse()/SetNextFrameWantCaptureKeyboard(). Default to -1.
    WantCaptureKeyboardNextFrame:       s32; // "
    WantTextInputNextFrame:             s32; // Copied in EndFrame() from g.PlatformImeData.WantTextInput. Needs to be set for some backends (SDL3) to emit character inputs.
    TempBuffer:                         Vector(u8); // Temporary text buffer
    TempKeychordName:                   [64] u8;

    Constructor :: (this: *ImGuiContext, shared_font_atlas: *FontAtlas) -> void #cpp_method #foreign ImGui "??0ImGuiContext@@QEAA@PEAUImFontAtlas@@@Z";
}

// Transient per-window data, reset at the beginning of the frame. This used to be called ImGuiDrawContext, hence the DC variable name in ImGuiWindow.
// (That's theory, in practice the delimitation between ImGuiWindow and ImGuiWindowTempData is quite tenuous and could be reconsidered..)
// (This doesn't need a constructor because we zero-clear it as part of ImGuiWindow and all frame-temporary data are setup on Begin)
WindowTempData :: struct {
    CursorPos:                     Vector2; // Current emitting position, in absolute coordinates.
    CursorPosPrevLine:             Vector2;
    CursorStartPos:                Vector2; // Initial position after Begin(), generally ~ window position + WindowPadding.
    CursorMaxPos:                  Vector2; // Used to implicitly calculate ContentSize at the beginning of next frame, for scrolling range and auto-resize. Always growing during the frame.
    IdealMaxPos:                   Vector2; // Used to implicitly calculate ContentSizeIdeal at the beginning of next frame, for auto-resize only. Always growing during the frame.
    CurrLineSize:                  Vector2;
    PrevLineSize:                  Vector2;
    CurrLineTextBaseOffset:        float; // Baseline offset (0.0f by default on a new line, generally == style.FramePadding.y when a framed item has been added).
    PrevLineTextBaseOffset:        float;
    IsSameLine:                    bool;
    IsSetPos:                      bool;
    Indent:                        Vec1; // Indentation / start position from left of window (increased by TreePush/TreePop, etc.)
    ColumnsOffset:                 Vec1; // Offset to the current column (if ColumnsCurrent > 0). FIXME: This and the above should be a stack to allow use cases like Tree->Column->Tree. Need revamp columns API.
    GroupOffset:                   Vec1;
    CursorStartPosLossyness:       Vector2; // Record the loss of precision of CursorStartPos due to really large scrolling amount. This is used by clipper to compensate and fix the most common use case of large scroll area.

    NavLayerCurrent:               NavLayer; // Current layer, 0..31 (we currently only use 0..1)
    NavLayersActiveMask:           s16; // Which layers have been written to (result from previous frame)
    NavLayersActiveMaskNext:       s16; // Which layers have been written to (accumulator for current frame)
    NavIsScrollPushableX:          bool; // Set when current work location may be scrolled horizontally when moving left / right. This is generally always true UNLESS within a column.
    NavHideHighlightOneFrame:      bool;
    NavWindowHasScrollY:           bool; // Set per window when scrolling can be used (== ScrollMax.y > 0.0f)

    MenuBarAppending:              bool; // FIXME: Remove this
    MenuBarOffset:                 Vector2; // MenuBarOffset.x is sort of equivalent of a per-layer CursorPos.x, saved/restored as we switch to the menu bar. The only situation when MenuBarOffset.y is > 0 if when (SafeAreaPadding.y > FramePadding.y), often used on TVs.
    MenuColumns_:                  MenuColumns; // Simplified columns storage for menu items measurement
    TreeDepth:                     s32; // Current tree depth.
    TreeHasStackDataDepthMask:     U32; // Store whether given depth has ImGuiTreeNodeStackData data. Could be turned into a ImU64 if necessary.
    TreeRecordsClippedNodesY2Mask: U32; // Store whether we should keep recording Y2. Cleared when passing clip max. Equivalent TreeHasStackDataDepthMask value should always be set.
    ChildWindows:                  Vector(*Window);
    StateStorage:                  *Storage; // Current persistent per-window storage (store e.g. tree node open/close state)
    CurrentColumns:                *OldColumns; // Current columns set
    CurrentTableIdx:               s32; // Current table index (into g.Tables)
    LayoutType_:                   LayoutType;
    ParentLayoutType:              LayoutType; // Layout type of parent window at the time of Begin()
    ModalDimBgColor:               U32;

    // Status flags
    WindowItemStatusFlags:         ItemStatusFlags;
    ChildItemStatusFlags:          ItemStatusFlags;
    DockTabItemStatusFlags:        ItemStatusFlags;
    DockTabItemRect:               Rect;

    ItemWidth:                     float; // Current item width (>0.0: width in pixels, <0.0: align xx pixels to the right of window).
    TextWrapPos:                   float; // Current text wrap pos.
    ItemWidthStack:                Vector(float); // Store item widths to restore (attention: .back() is not == ItemWidth)
    TextWrapPosStack:              Vector(float); // Store text wrap pos to restore (attention: .back() is not == TextWrapPos)
}

// Storage for one window
Window :: struct {
    Ctx:                                *ImGuiContext; // Parent UI context (needs to be set explicitly by parent).
    Name:                               *u8; // Window name, owned by the window.
    ID_:                                ID; // == ImHashStr(Name)
    Flags:                              WindowFlags; // See enum ImGuiWindowFlags_
    FlagsPreviousFrame:                 WindowFlags; // See enum ImGuiWindowFlags_
    ChildFlags_:                        ChildFlags; // Set when window is a child window. See enum ImGuiChildFlags_
    WindowClass_:                       WindowClass; // Advanced users only. Set with SetNextWindowClass()
    Viewport:                           *ViewportP; // Always set in Begin(). Inactive windows may have a NULL value here if their viewport was discarded.
    ViewportId:                         ID; // We backup the viewport id (since the viewport may disappear or never be created if the window is inactive)
    ViewportPos:                        Vector2; // We backup the viewport position (since the viewport may disappear or never be created if the window is inactive)
    ViewportAllowPlatformMonitorExtend: s32; // Reset to -1 every frame (index is guaranteed to be valid between NewFrame..EndFrame), only used in the Appearing frame of a tooltip/popup to enforce clamping to a given monitor
    Pos:                                Vector2; // Position (always rounded-up to nearest pixel)
    Size:                               Vector2; // Current size (==SizeFull or collapsed title bar size)
    SizeFull:                           Vector2; // Size when non collapsed
    ContentSize:                        Vector2; // Size of contents/scrollable client area (calculated from the extents reach of the cursor) from previous frame. Does not include window decoration or window padding.
    ContentSizeIdeal:                   Vector2;
    ContentSizeExplicit:                Vector2; // Size of contents/scrollable client area explicitly request by the user via SetNextWindowContentSize().
    WindowPadding:                      Vector2; // Window padding at the time of Begin().
    WindowRounding:                     float; // Window rounding at the time of Begin(). May be clamped lower to avoid rendering artifacts with title bar, menu bar etc.
    WindowBorderSize:                   float; // Window border size at the time of Begin().
    TitleBarHeight:                     float; // Note that those used to be function before 2024/05/28. If you have old code calling TitleBarHeight() you can change it to TitleBarHeight.
    MenuBarHeight:                      float; // Note that those used to be function before 2024/05/28. If you have old code calling TitleBarHeight() you can change it to TitleBarHeight.
    DecoOuterSizeX1:                    float; // Left/Up offsets. Sum of non-scrolling outer decorations (X1 generally == 0.0f. Y1 generally = TitleBarHeight + MenuBarHeight). Locked during Begin().
    DecoOuterSizeY1:                    float; // Left/Up offsets. Sum of non-scrolling outer decorations (X1 generally == 0.0f. Y1 generally = TitleBarHeight + MenuBarHeight). Locked during Begin().
    DecoOuterSizeX2:                    float; // Right/Down offsets (X2 generally == ScrollbarSize.x, Y2 == ScrollbarSizes.y).
    DecoOuterSizeY2:                    float; // Right/Down offsets (X2 generally == ScrollbarSize.x, Y2 == ScrollbarSizes.y).
    DecoInnerSizeX1:                    float; // Applied AFTER/OVER InnerRect. Specialized for Tables as they use specialized form of clipping and frozen rows/columns are inside InnerRect (and not part of regular decoration sizes).
    DecoInnerSizeY1:                    float; // Applied AFTER/OVER InnerRect. Specialized for Tables as they use specialized form of clipping and frozen rows/columns are inside InnerRect (and not part of regular decoration sizes).
    NameBufLen:                         s32; // Size of buffer storing Name. May be larger than strlen(Name)!
    MoveId:                             ID; // == window->GetID("#MOVE")
    TabId:                              ID; // == window->GetID("#TAB")
    ChildId:                            ID; // ID of corresponding item in parent window (for navigation to return from child window to parent window)
    PopupId:                            ID; // ID in the popup stack when this window is used as a popup/menu (because we use generic Name/ID for recycling)
    Scroll:                             Vector2;
    ScrollMax:                          Vector2;
    ScrollTarget:                       Vector2; // target scroll position. stored as cursor position with scrolling canceled out, so the highest point is always 0.0f. (FLT_MAX for no change)
    ScrollTargetCenterRatio:            Vector2; // 0.0f = scroll so that target position is at top, 0.5f = scroll so that target position is centered
    ScrollTargetEdgeSnapDist:           Vector2; // 0.0f = no snapping, >0.0f snapping threshold
    ScrollbarSizes:                     Vector2; // Size taken by each scrollbars on their smaller axis. Pay attention! ScrollbarSizes.x == width of the vertical scrollbar, ScrollbarSizes.y = height of the horizontal scrollbar.
    ScrollbarX:                         bool; // Are scrollbars visible?
    ScrollbarY:                         bool; // Are scrollbars visible?
    ScrollbarXStabilizeEnabled:         bool; // Was ScrollbarX previously auto-stabilized?
    ScrollbarXStabilizeToggledHistory:  U8; // Used to stabilize scrollbar visibility in case of feedback loops
    ViewportOwned:                      bool;
    Active:                             bool; // Set to true on Begin(), unless Collapsed
    WasActive:                          bool;
    WriteAccessed:                      bool; // Set to true when any widget access the current window
    Collapsed:                          bool; // Set when collapsing window to become only title-bar
    WantCollapseToggle:                 bool;
    SkipItems:                          bool; // Set when items can safely be all clipped (e.g. window not visible or collapsed)
    SkipRefresh:                        bool; // [EXPERIMENTAL] Reuse previous frame drawn contents, Begin() returns false.
    Appearing:                          bool; // Set during the frame where the window is appearing (or re-appearing)
    Hidden:                             bool; // Do not display (== HiddenFrames*** > 0)
    IsFallbackWindow:                   bool; // Set on the "Debug##Default" window.
    IsExplicitChild:                    bool; // Set when passed _ChildWindow, left to false by BeginDocked()
    HasCloseButton:                     bool; // Set when the window has a close button (p_open != NULL)
    ResizeBorderHovered:                s8; // Current border being hovered for resize (-1: none, otherwise 0-3)
    ResizeBorderHeld:                   s8; // Current border being held for resize (-1: none, otherwise 0-3)
    BeginCount:                         s16; // Number of Begin() during the current frame (generally 0 or 1, 1+ if appending via multiple Begin/End pairs)
    BeginCountPreviousFrame:            s16; // Number of Begin() during the previous frame
    BeginOrderWithinParent:             s16; // Begin() order within immediate parent window, if we are a child window. Otherwise 0.
    BeginOrderWithinContext:            s16; // Begin() order within entire imgui context. This is mostly used for debugging submission order related issues.
    FocusOrder:                         s16; // Order within WindowsFocusOrder[], altered when windows are focused.
    AutoFitFramesX:                     S8;
    AutoFitFramesY:                     S8;
    AutoFitOnlyGrows:                   bool;
    AutoPosLastDirection:               Dir;
    HiddenFramesCanSkipItems:           S8; // Hide the window for N frames
    HiddenFramesCannotSkipItems:        S8; // Hide the window for N frames while allowing items to be submitted so we can measure their size
    HiddenFramesForRenderOnly:          S8; // Hide the window until frame N at Render() time only
    DisableInputsFrames:                S8; // Disable window interactions for N frames
    __bitfield:                         Cond;
    /* 
        SetWindowPosAllowFlags: Cond; /* 8 bits */ // store acceptable condition flags for SetNextWindowPos() use.
        SetWindowSizeAllowFlags: Cond; /* 8 bits */ // store acceptable condition flags for SetNextWindowSize() use.
        SetWindowCollapsedAllowFlags: Cond; /* 8 bits */ // store acceptable condition flags for SetNextWindowCollapsed() use.
        SetWindowDockAllowFlags: Cond; /* 8 bits */ // store acceptable condition flags for SetNextWindowDock() use.;
    */

    SetWindowPosVal:                    Vector2; // store window position when using a non-zero Pivot (position set needs to be processed when we know the window size)
    SetWindowPosPivot:                  Vector2; // store window pivot for positioning. ImVec2(0, 0) when positioning from top-left corner; ImVec2(0.5f, 0.5f) for centering; ImVec2(1, 1) for bottom right.

    IDStack:                            Vector(ID); // ID stack. ID are hashes seeded with the value at the top of the stack. (In theory this should be in the TempData structure)
    DC:                                 WindowTempData; // Temporary per-window data, reset at the beginning of the frame. This used to be called ImGuiDrawContext, hence the "DC" variable name.

    OuterRectClipped:                   Rect; // == Window->Rect() just after setup in Begin(). == window->Rect() for root window.
    InnerRect:                          Rect; // Inner rectangle (omit title bar, menu bar, scroll bar)
    InnerClipRect:                      Rect; // == InnerRect shrunk by WindowPadding*0.5f on each side, clipped within viewport or parent clip rect.
    WorkRect:                           Rect; // Initially covers the whole scrolling region. Reduced by containers e.g columns/tables when active. Shrunk by WindowPadding*1.0f on each side. This is meant to replace ContentRegionRect over time (from 1.71+ onward).
    ParentWorkRect:                     Rect; // Backup of WorkRect before entering a container such as columns/tables. Used by e.g. SpanAllColumns functions to easily access. Stacked containers are responsible for maintaining this. // FIXME-WORKRECT: Could be a stack?
    ClipRect:                           Rect; // Current clipping/scissoring rectangle, evolve as we are using PushClipRect(), etc. == DrawList->clip_rect_stack.back().
    ContentRegionRect:                  Rect; // FIXME: This is currently confusing/misleading. It is essentially WorkRect but not handling of scrolling. We currently rely on it as right/bottom aligned sizing operation need some size to rely on.
    HitTestHoleSize:                    Vec2ih; // Define an optional rectangular hole where mouse will pass-through the window.
    HitTestHoleOffset:                  Vec2ih;

    LastFrameActive:                    s32; // Last frame number the window was Active.
    LastFrameJustFocused:               s32; // Last frame number the window was made Focused.
    LastTimeActive:                     float; // Last timestamp the window was Active (using float as we don't need high precision there)
    ItemWidthDefault:                   float;
    StateStorage:                       Storage;
    ColumnsStorage:                     Vector(OldColumns);
    FontWindowScale:                    float; // User scale multiplier per-window, via SetWindowFontScale()
    FontWindowScaleParents:             float;
    FontRefSize:                        float; // This is a copy of window->CalcFontSize() at the time of Begin(), trying to phase out CalcFontSize() especially as it may be called on non-current window.
    SettingsOffset:                     s32; // Offset into SettingsWindows[] (offsets are always valid as we only grow the array from the back)

    DrawList_:                          *DrawList; // == &DrawListInst (for backward compatibility reason with code using imgui_internal.h we keep this a pointer)
    DrawListInst:                       DrawList;
    ParentWindow:                       *Window; // If we are a child _or_ popup _or_ docked window, this is pointing to our parent. Otherwise NULL.
    ParentWindowInBeginStack:           *Window;
    RootWindow:                         *Window; // Point to ourself or first ancestor that is not a child window. Doesn't cross through popups/dock nodes.
    RootWindowPopupTree:                *Window; // Point to ourself or first ancestor that is not a child window. Cross through popups parent<>child.
    RootWindowDockTree:                 *Window; // Point to ourself or first ancestor that is not a child window. Cross through dock nodes.
    RootWindowForTitleBarHighlight:     *Window; // Point to ourself or first ancestor which will display TitleBgActive color when this window is active.
    RootWindowForNav:                   *Window; // Point to ourself or first ancestor which doesn't have the NavFlattened flag.
    ParentWindowForFocusRoute:          *Window; // Set to manual link a window to its logical parent so that Shortcut() chain are honoerd (e.g. Tool linked to Document)

    NavLastChildNavWindow:              *Window; // When going to the menu bar, we remember the child window we came from. (This could probably be made implicit if we kept g.Windows sorted by last focused including child window.)
    NavLastIds:                         [2] ID; // Last known NavId for this window, per layer (0/1)
    NavRectRel:                         [2] Rect; // Reference rectangle, in window relative space
    NavPreferredScoringPosRel:          [2] Vector2; // Preferred X/Y position updated when moving on a given axis, reset to FLT_MAX.
    NavRootFocusScopeId:                ID; // Focus Scope ID at the time of Begin()

    MemoryDrawListIdxCapacity:          s32; // Backup of last idx/vtx count, so when waking up the window we can preallocate and avoid iterative alloc/copy
    MemoryDrawListVtxCapacity:          s32;
    MemoryCompacted:                    bool; // Set when window extraneous data have been garbage collected

    DockIsActive:                       bool; /* 1 bits */ // When docking artifacts are actually visible. When this is set, DockNode is guaranteed to be != NULL. ~~ (DockNode != NULL) && (DockNode->Windows.Size > 1).
    DockNodeIsVisible:                  bool #align 1; /* 1 bits */
    DockTabIsVisible:                   bool #align 1; /* 1 bits */ // Is our window visible this frame? ~~ is the corresponding tab selected?
    DockTabWantClose:                   bool #align 1; /* 1 bits */
    DockOrder:                          s16; // Order of the last time the window was visible within its DockNode. This is used to reorder windows that are reappearing on the same frame. Same value between windows that were active and windows that were none are possible.
    DockStyle:                          WindowDockStyle;
    DockNode_:                          *DockNode; // Which node are we docked into. Important: Prefer testing DockIsActive in many cases as this will still be set when the dock node is hidden.
    DockNodeAsHost:                     *DockNode; // Which node are we owning (for parent windows)
    DockId:                             ID; // Backup of last valid DockNode->ID, so single window remember their dock node id even when they are not bound any more

    Constructor :: (this: *Window, _context: *ImGuiContext, name: *u8) -> void #cpp_method #foreign ImGui "??0ImGuiWindow@@QEAA@PEAUImGuiContext@@PEBD@Z";
    Destructor :: (this: *Window) -> void #cpp_method #foreign ImGui "??1ImGuiWindow@@QEAA@XZ";

    GetID :: (this: *Window, str: *u8, str_end: *u8 = null) -> ID #cpp_method #foreign ImGui "?GetID@ImGuiWindow@@QEAAIPEBD0@Z";
    GetID :: (this: *Window, str: string) -> ID #no_context {
        return GetID(this, str.data, str.data + str.count);
    }
    GetID :: (this: *Window, ptr: *void) -> ID #cpp_method #foreign ImGui "?GetID@ImGuiWindow@@QEAAIPEBX@Z";
    GetID :: (this: *Window, n: s32) -> ID #cpp_method #foreign ImGui "?GetID@ImGuiWindow@@QEAAIH@Z";
    GetIDFromPos :: (this: *Window, p_abs: *Vector2) -> ID #cpp_method #foreign ImGui "?GetIDFromPos@ImGuiWindow@@QEAAIAEBUImVec2@@@Z";
    GetIDFromPos :: (this: *Window, p_abs: Vector2) -> ID #no_context {
        return GetIDFromPos(this, *p_abs);
    }
    GetIDFromRectangle :: (this: *Window, r_abs: *Rect) -> ID #cpp_method #foreign ImGui "?GetIDFromRectangle@ImGuiWindow@@QEAAIAEBUImRect@@@Z";
    GetIDFromRectangle :: (this: *Window, r_abs: Rect) -> ID #no_context {
        return GetIDFromRectangle(this, *r_abs);
    }

    // We don't use g.FontSize because the window may be != g.CurrentWindow.
    Rect_ :: (this: *Window) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?Rect@ImGuiWindow@@QEBA?AUImRect@@XZ";
    TitleBarRect :: (this: *Window) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?TitleBarRect@ImGuiWindow@@QEBA?AUImRect@@XZ";
    MenuBarRect :: (this: *Window) -> Rect #cpp_method #cpp_return_type_is_non_pod #foreign ImGui "?MenuBarRect@ImGuiWindow@@QEBA?AUImRect@@XZ";
}

// Extend ImGuiTabBarFlags_
TabBarFlagsPrivate :: enum s32 {
    ImGuiTabBarFlags_DockNode     :: 1048576;
    ImGuiTabBarFlags_IsFocused    :: 2097152;
    ImGuiTabBarFlags_SaveSettings :: 4194304;
}

// Extend ImGuiTabItemFlags_
TabItemFlagsPrivate :: enum s32 {
    ImGuiTabItemFlags_SectionMask_  :: 192;
    ImGuiTabItemFlags_NoCloseButton :: 1048576;
    ImGuiTabItemFlags_Button        :: 2097152;
    ImGuiTabItemFlags_Invisible     :: 4194304;
    ImGuiTabItemFlags_Unsorted      :: 8388608;
}

// Storage for one active tab item (sizeof() 48 bytes)
TabItem :: struct {
    ID_:               ID;
    Flags:             TabItemFlags;
    Window_:           *Window; // When TabItem is part of a DockNode's TabBar, we hold on to a window.
    LastFrameVisible:  s32;
    LastFrameSelected: s32; // This allows us to infer an ordered list of the last activated tabs with little maintenance
    Offset:            float; // Position relative to beginning of tab
    Width:             float; // Width currently displayed
    ContentWidth:      float; // Width of label + padding, stored during BeginTabItem() call (misnamed as "Content" would normally imply width of label only)
    RequestedWidth:    float; // Width optionally requested by caller, -1.0f is unused
    NameOffset:        S32; // When Window==NULL, offset to name within parent ImGuiTabBar::TabsNames
    BeginOrder:        S16; // BeginTabItem() order, used to re-order tabs after toggling ImGuiTabBarFlags_Reorderable
    IndexDuringLayout: S16; // Index only used during TabBarLayout(). Tabs gets reordered so 'Tabs[n].IndexDuringLayout == n' but may mismatch during additions.
    WantClose:         bool; // Marked as closed by SetTabItemClosed()

    Constructor :: (this: *TabItem) -> void #cpp_method #foreign ImGui "??0ImGuiTabItem@@QEAA@XZ";
}

// Storage for a tab bar (sizeof() 160 bytes)
TabBar :: struct {
    Window_:                         *Window;
    Tabs:                            Vector(TabItem);
    Flags:                           TabBarFlags;
    ID_:                             ID; // Zero for tab-bars used by docking
    SelectedTabId:                   ID; // Selected tab/window
    NextSelectedTabId:               ID; // Next selected tab/window. Will also trigger a scrolling animation
    VisibleTabId:                    ID; // Can occasionally be != SelectedTabId (e.g. when previewing contents for CTRL+TAB preview)
    CurrFrameVisible:                s32;
    PrevFrameVisible:                s32;
    BarRect:                         Rect;
    BarRectPrevWidth:                float; // Backup of previous width. When width change we enforce keep horizontal scroll on focused tab.
    CurrTabsContentsHeight:          float;
    PrevTabsContentsHeight:          float; // Record the height of contents submitted below the tab bar
    WidthAllTabs:                    float; // Actual width of all tabs (locked during layout)
    WidthAllTabsIdeal:               float; // Ideal width if all tabs were visible and not clipped
    ScrollingAnim:                   float;
    ScrollingTarget:                 float;
    ScrollingTargetDistToVisibility: float;
    ScrollingSpeed:                  float;
    ScrollingRectMinX:               float;
    ScrollingRectMaxX:               float;
    SeparatorMinX:                   float;
    SeparatorMaxX:                   float;
    ReorderRequestTabId:             ID;
    ReorderRequestOffset:            S16;
    BeginCount:                      S8;
    WantLayout:                      bool;
    VisibleTabWasSubmitted:          bool;
    TabsAddedNew:                    bool; // Set to true when a new tab item or button has been added to the tab bar during last frame
    ScrollButtonEnabled:             bool;
    TabsActiveCount:                 S16; // Number of tabs submitted this frame.
    LastTabItemIdx:                  S16; // Index of last BeginTabItem() tab for use by EndTabItem()
    ItemSpacingY:                    float;
    FramePadding:                    Vector2; // style.FramePadding locked at the time of BeginTabBar()
    BackupCursorPos:                 Vector2;
    TabsNames:                       TextBuffer; // For non-docking tab bar we re-append names in a contiguous buffer.

    Constructor :: (this: *TabBar) -> void #cpp_method #foreign ImGui "??0ImGuiTabBar@@QEAA@XZ";
}

// [Internal] sizeof() ~ 112
// We use the terminology "Enabled" to refer to a column that is not Hidden by user/api.
// We use the terminology "Clipped" to refer to a column that is out of sight because of scrolling/clipping.
// This is in contrast with some user-facing api such as IsItemVisible() / IsRectVisible() which use "Visible" to mean "not clipped".
TableColumn :: struct {
    Flags:                    TableColumnFlags; // Flags after some patching (not directly same as provided by user). See ImGuiTableColumnFlags_
    WidthGiven:               float; // Final/actual width visible == (MaxX - MinX), locked in TableUpdateLayout(). May be > WidthRequest to honor minimum width, may be < WidthRequest to honor shrinking columns down in tight space.
    MinX:                     float; // Absolute positions
    MaxX:                     float;
    WidthRequest:             float; // Master width absolute value when !(Flags & _WidthStretch). When Stretch this is derived every frame from StretchWeight in TableUpdateLayout()
    WidthAuto:                float; // Automatic width
    WidthMax:                 float; // Maximum width (FIXME: overwritten by each instance)
    StretchWeight:            float; // Master width weight when (Flags & _WidthStretch). Often around ~1.0f initially.
    InitStretchWeightOrWidth: float; // Value passed to TableSetupColumn(). For Width it is a content width (_without padding_).
    ClipRect:                 Rect; // Clipping rectangle for the column
    UserID:                   ID; // Optional, value passed to TableSetupColumn()
    WorkMinX:                 float; // Contents region min ~(MinX + CellPaddingX + CellSpacingX1) == cursor start position when entering column
    WorkMaxX:                 float; // Contents region max ~(MaxX - CellPaddingX - CellSpacingX2)
    ItemWidth:                float; // Current item width for the column, preserved across rows
    ContentMaxXFrozen:        float; // Contents maximum position for frozen rows (apart from headers), from which we can infer content width.
    ContentMaxXUnfrozen:      float;
    ContentMaxXHeadersUsed:   float; // Contents maximum position for headers rows (regardless of freezing). TableHeader() automatically softclip itself + report ideal desired size, to avoid creating extraneous draw calls
    ContentMaxXHeadersIdeal:  float;
    NameOffset:               S16; // Offset into parent ColumnsNames[]
    DisplayOrder:             TableColumnIdx; // Index within Table's IndexToDisplayOrder[] (column may be reordered by users)
    IndexWithinEnabledSet:    TableColumnIdx; // Index within enabled/visible set (<= IndexToDisplayOrder)
    PrevEnabledColumn:        TableColumnIdx; // Index of prev enabled/visible column within Columns[], -1 if first enabled/visible column
    NextEnabledColumn:        TableColumnIdx; // Index of next enabled/visible column within Columns[], -1 if last enabled/visible column
    SortOrder:                TableColumnIdx; // Index of this column within sort specs, -1 if not sorting on this column, 0 for single-sort, may be >0 on multi-sort
    DrawChannelCurrent:       TableDrawChannelIdx; // Index within DrawSplitter.Channels[]
    DrawChannelFrozen:        TableDrawChannelIdx; // Draw channels for frozen rows (often headers)
    DrawChannelUnfrozen:      TableDrawChannelIdx; // Draw channels for unfrozen rows
    IsEnabled:                bool; // IsUserEnabled && (Flags & ImGuiTableColumnFlags_Disabled) == 0
    IsUserEnabled:            bool; // Is the column not marked Hidden by the user? (unrelated to being off view, e.g. clipped by scrolling).
    IsUserEnabledNextFrame:   bool;
    IsVisibleX:               bool; // Is actually in view (e.g. overlapping the host window clipping rectangle, not scrolled).
    IsVisibleY:               bool;
    IsRequestOutput:          bool; // Return value for TableSetColumnIndex() / TableNextColumn(): whether we request user to output contents or not.
    IsSkipItems:              bool; // Do we want item submissions to this column to be completely ignored (no layout will happen).
    IsPreserveWidthAuto:      bool;
    NavLayerCurrent:          S8; // ImGuiNavLayer in 1 byte
    AutoFitQueue:             U8; // Queue of 8 values for the next 8 frames to request auto-fit
    CannotSkipItemsQueue:     U8; // Queue of 8 values for the next 8 frames to disable Clipped/SkipItem
    __bitfield:               U8;
    /* 
        SortDirection: U8; /* 2 bits */ // ImGuiSortDirection_Ascending or ImGuiSortDirection_Descending
        SortDirectionsAvailCount: U8; /* 2 bits */ // Number of available sort directions (0 to 3)
        SortDirectionsAvailMask: U8; /* 4 bits */ // Mask of available sort directions (1-bit each);
    */

    SortDirectionsAvailList:  U8; // Ordered list of available sort directions (2-bits each, total 8-bits)

    Constructor :: (this: *TableColumn) -> void #cpp_method #foreign ImGui "??0ImGuiTableColumn@@QEAA@XZ";
}

// Transient cell data stored per row.
// sizeof() ~ 6 bytes
TableCellData :: struct {
    BgColor: U32; // Actual color
    Column:  TableColumnIdx; // Column number
}

// Parameters for TableAngledHeadersRowEx()
// This may end up being refactored for more general purpose.
// sizeof() ~ 12 bytes
TableHeaderData :: struct {
    Index:     TableColumnIdx; // Column index
    TextColor: U32;
    BgColor0:  U32;
    BgColor1:  U32;
}

// Per-instance data that needs preserving across frames (seemingly most others do not need to be preserved aside from debug needs. Does that means they could be moved to ImGuiTableTempData?)
// sizeof() ~ 24 bytes
TableInstanceData :: struct {
    TableInstanceID:         ID;
    LastOuterHeight:         float; // Outer height from last frame
    LastTopHeadersRowHeight: float; // Height of first consecutive header rows from last frame (FIXME: this is used assuming consecutive headers are in same frozen set)
    LastFrozenHeight:        float; // Height of frozen section from last frame
    HoveredRowLast:          s32; // Index of row which was hovered last frame.
    HoveredRowNext:          s32; // Index of row hovered this frame, set after encountering it.

    Constructor :: (this: *TableInstanceData) -> void #cpp_method #foreign ImGui "??0ImGuiTableInstanceData@@QEAA@XZ";
}

// sizeof() ~ 592 bytes + heap allocs described in TableBeginInitMemory()
Table :: struct {
    ID_:                        ID;
    Flags:                      TableFlags;
    RawData:                    *void; // Single allocation to hold Columns[], DisplayOrderToIndex[], and RowCellData[]
    TempData:                   *TableTempData; // Transient data while table is active. Point within g.CurrentTableStack[]
    Columns:                    Span(TableColumn); // Point within RawData[]
    DisplayOrderToIndex:        Span(TableColumnIdx); // Point within RawData[]. Store display order of columns (when not reordered, the values are 0...Count-1)
    RowCellData:                Span(TableCellData); // Point within RawData[]. Store cells background requests for current row.
    EnabledMaskByDisplayOrder:  BitArrayPtr; // Column DisplayOrder -> IsEnabled map
    EnabledMaskByIndex:         BitArrayPtr; // Column Index -> IsEnabled map (== not hidden by user/api) in a format adequate for iterating column without touching cold data
    VisibleMaskByIndex:         BitArrayPtr; // Column Index -> IsVisibleX|IsVisibleY map (== not hidden by user/api && not hidden by scrolling/cliprect)
    SettingsLoadedFlags:        TableFlags; // Which data were loaded from the .ini file (e.g. when order is not altered we won't save order)
    SettingsOffset:             s32; // Offset in g.SettingsTables
    LastFrameActive:            s32;
    ColumnsCount:               s32; // Number of columns declared in BeginTable()
    CurrentRow:                 s32;
    CurrentColumn:              s32;
    InstanceCurrent:            S16; // Count of BeginTable() calls with same ID in the same frame (generally 0). This is a little bit similar to BeginCount for a window, but multiple tables with the same ID are multiple tables, they are just synced.
    InstanceInteracted:         S16; // Mark which instance (generally 0) of the same ID is being interacted with
    RowPosY1:                   float;
    RowPosY2:                   float;
    RowMinHeight:               float; // Height submitted to TableNextRow()
    RowCellPaddingY:            float; // Top and bottom padding. Reloaded during row change.
    RowTextBaseline:            float;
    RowIndentOffsetX:           float;
    __bitfield:                 TableRowFlags;
    /* 
        RowFlags: TableRowFlags; /* 16 bits */ // Current row flags, see ImGuiTableRowFlags_
        LastRowFlags: TableRowFlags; /* 16 bits */;
    */

    RowBgColorCounter:          s32; // Counter for alternating background colors (can be fast-forwarded by e.g clipper), not same as CurrentRow because header rows typically don't increase this.
    RowBgColor:                 [2] U32; // Background color override for current row.
    BorderColorStrong:          U32;
    BorderColorLight:           U32;
    BorderX1:                   float;
    BorderX2:                   float;
    HostIndentX:                float;
    MinColumnWidth:             float;
    OuterPaddingX:              float;
    CellPaddingX:               float; // Padding from each borders. Locked in BeginTable()/Layout.
    CellSpacingX1:              float; // Spacing between non-bordered cells. Locked in BeginTable()/Layout.
    CellSpacingX2:              float;
    InnerWidth:                 float; // User value passed to BeginTable(), see comments at the top of BeginTable() for details.
    ColumnsGivenWidth:          float; // Sum of current column width
    ColumnsAutoFitWidth:        float; // Sum of ideal column width in order nothing to be clipped, used for auto-fitting and content width submission in outer window
    ColumnsStretchSumWeights:   float; // Sum of weight of all enabled stretching columns
    ResizedColumnNextWidth:     float;
    ResizeLockMinContentsX2:    float; // Lock minimum contents width while resizing down in order to not create feedback loops. But we allow growing the table.
    RefScale:                   float; // Reference scale to be able to rescale columns on font/dpi changes.
    AngledHeadersHeight:        float; // Set by TableAngledHeadersRow(), used in TableUpdateLayout()
    AngledHeadersSlope:         float; // Set by TableAngledHeadersRow(), used in TableUpdateLayout()
    OuterRect:                  Rect; // Note: for non-scrolling table, OuterRect.Max.y is often FLT_MAX until EndTable(), unless a height has been specified in BeginTable().
    InnerRect:                  Rect; // InnerRect but without decoration. As with OuterRect, for non-scrolling tables, InnerRect.Max.y is "
    WorkRect:                   Rect;
    InnerClipRect:              Rect;
    BgClipRect:                 Rect; // We use this to cpu-clip cell background color fill, evolve during the frame as we cross frozen rows boundaries
    Bg0ClipRectForDrawCmd:      Rect; // Actual ImDrawCmd clip rect for BG0/1 channel. This tends to be == OuterWindow->ClipRect at BeginTable() because output in BG0/BG1 is cpu-clipped
    Bg2ClipRectForDrawCmd:      Rect; // Actual ImDrawCmd clip rect for BG2 channel. This tends to be a correct, tight-fit, because output to BG2 are done by widgets relying on regular ClipRect.
    HostClipRect:               Rect; // This is used to check if we can eventually merge our columns draw calls into the current draw call of the current window.
    HostBackupInnerClipRect:    Rect; // Backup of InnerWindow->ClipRect during PushTableBackground()/PopTableBackground()
    OuterWindow:                *Window; // Parent window for the table
    InnerWindow:                *Window; // Window holding the table data (== OuterWindow or a child window)
    ColumnsNames:               TextBuffer; // Contiguous buffer holding columns names
    DrawSplitter:               *DrawListSplitter; // Shortcut to TempData->DrawSplitter while in table. Isolate draw commands per columns to avoid switching clip rect constantly
    InstanceDataFirst:          TableInstanceData;
    InstanceDataExtra:          Vector(TableInstanceData); // FIXME-OPT: Using a small-vector pattern would be good.
    SortSpecsSingle:            TableColumnSortSpecs;
    SortSpecsMulti:             Vector(TableColumnSortSpecs); // FIXME-OPT: Using a small-vector pattern would be good.
    SortSpecs:                  TableSortSpecs; // Public facing sorts specs, this is what we return in TableGetSortSpecs()
    SortSpecsCount:             TableColumnIdx;
    ColumnsEnabledCount:        TableColumnIdx; // Number of enabled columns (<= ColumnsCount)
    ColumnsEnabledFixedCount:   TableColumnIdx; // Number of enabled columns using fixed width (<= ColumnsCount)
    DeclColumnsCount:           TableColumnIdx; // Count calls to TableSetupColumn()
    AngledHeadersCount:         TableColumnIdx; // Count columns with angled headers
    HoveredColumnBody:          TableColumnIdx; // Index of column whose visible region is being hovered. Important: == ColumnsCount when hovering empty region after the right-most column!
    HoveredColumnBorder:        TableColumnIdx; // Index of column whose right-border is being hovered (for resizing).
    HighlightColumnHeader:      TableColumnIdx; // Index of column which should be highlighted.
    AutoFitSingleColumn:        TableColumnIdx; // Index of single column requesting auto-fit.
    ResizedColumn:              TableColumnIdx; // Index of column being resized. Reset when InstanceCurrent==0.
    LastResizedColumn:          TableColumnIdx; // Index of column being resized from previous frame.
    HeldHeaderColumn:           TableColumnIdx; // Index of column header being held.
    ReorderColumn:              TableColumnIdx; // Index of column being reordered. (not cleared)
    ReorderColumnDir:           TableColumnIdx; // -1 or +1
    LeftMostEnabledColumn:      TableColumnIdx; // Index of left-most non-hidden column.
    RightMostEnabledColumn:     TableColumnIdx; // Index of right-most non-hidden column.
    LeftMostStretchedColumn:    TableColumnIdx; // Index of left-most stretched column.
    RightMostStretchedColumn:   TableColumnIdx; // Index of right-most stretched column.
    ContextPopupColumn:         TableColumnIdx; // Column right-clicked on, of -1 if opening context menu from a neutral/empty spot
    FreezeRowsRequest:          TableColumnIdx; // Requested frozen rows count
    FreezeRowsCount:            TableColumnIdx; // Actual frozen row count (== FreezeRowsRequest, or == 0 when no scrolling offset)
    FreezeColumnsRequest:       TableColumnIdx; // Requested frozen columns count
    FreezeColumnsCount:         TableColumnIdx; // Actual frozen columns count (== FreezeColumnsRequest, or == 0 when no scrolling offset)
    RowCellDataCurrent:         TableColumnIdx; // Index of current RowCellData[] entry in current row
    DummyDrawChannel:           TableDrawChannelIdx; // Redirect non-visible columns here.
    Bg2DrawChannelCurrent:      TableDrawChannelIdx; // For Selectable() and other widgets drawing across columns after the freezing line. Index within DrawSplitter.Channels[]
    Bg2DrawChannelUnfrozen:     TableDrawChannelIdx;
    NavLayer:                   S8; // ImGuiNavLayer at the time of BeginTable().
    IsLayoutLocked:             bool; // Set by TableUpdateLayout() which is called when beginning the first row.
    IsInsideRow:                bool; // Set when inside TableBeginRow()/TableEndRow().
    IsInitializing:             bool;
    IsSortSpecsDirty:           bool;
    IsUsingHeaders:             bool; // Set when the first row had the ImGuiTableRowFlags_Headers flag.
    IsContextPopupOpen:         bool; // Set when default context menu is open (also see: ContextPopupColumn, InstanceInteracted).
    DisableDefaultContextMenu:  bool; // Disable default context menu. You may submit your own using TableBeginContextMenuPopup()/EndPopup()
    IsSettingsRequestLoad:      bool;
    IsSettingsDirty:            bool; // Set when table settings have changed and needs to be reported into ImGuiTableSetttings data.
    IsDefaultDisplayOrder:      bool; // Set when display order is unchanged from default (DisplayOrder contains 0...Count-1)
    IsResetAllRequest:          bool;
    IsResetDisplayOrderRequest: bool;
    IsUnfrozenRows:             bool; // Set when we got past the frozen row.
    IsDefaultSizingPolicy:      bool; // Set if user didn't explicitly set a sizing policy in BeginTable()
    IsActiveIdAliveBeforeTable: bool;
    IsActiveIdInTable:          bool;
    HasScrollbarYCurr:          bool; // Whether ANY instance of this table had a vertical scrollbar during the current frame.
    HasScrollbarYPrev:          bool; // Whether ANY instance of this table had a vertical scrollbar during the previous.
    MemoryCompacted:            bool;
    HostSkipItems:              bool; // Backup of InnerWindow->SkipItem at the end of BeginTable(), because we will overwrite InnerWindow->SkipItem on a per-column basis

    Constructor :: (this: *Table) -> void #cpp_method #foreign ImGui "??0ImGuiTable@@QEAA@XZ";
    Destructor :: (this: *Table) -> void #cpp_method #foreign ImGui "??1ImGuiTable@@QEAA@XZ";
}

// Transient data that are only needed between BeginTable() and EndTable(), those buffers are shared (1 per level of stacked table).
// - Accessing those requires chasing an extra pointer so for very frequently used data we leave them in the main table structure.
// - We also leave out of this structure data that tend to be particularly useful for debugging/metrics.
// FIXME-TABLE: more transient data could be stored in a stacked ImGuiTableTempData: e.g. SortSpecs.
// sizeof() ~ 136 bytes.
TableTempData :: struct {
    TableIndex:                   s32; // Index in g.Tables.Buf[] pool
    LastTimeActive:               float; // Last timestamp this structure was used
    AngledHeadersExtraWidth:      float; // Used in EndTable()
    AngledHeadersRequests:        Vector(TableHeaderData); // Used in TableAngledHeadersRow()

    UserOuterSize:                Vector2; // outer_size.x passed to BeginTable()
    DrawSplitter:                 DrawListSplitter;

    HostBackupWorkRect:           Rect; // Backup of InnerWindow->WorkRect at the end of BeginTable()
    HostBackupParentWorkRect:     Rect; // Backup of InnerWindow->ParentWorkRect at the end of BeginTable()
    HostBackupPrevLineSize:       Vector2; // Backup of InnerWindow->DC.PrevLineSize at the end of BeginTable()
    HostBackupCurrLineSize:       Vector2; // Backup of InnerWindow->DC.CurrLineSize at the end of BeginTable()
    HostBackupCursorMaxPos:       Vector2; // Backup of InnerWindow->DC.CursorMaxPos at the end of BeginTable()
    HostBackupColumnsOffset:      Vec1; // Backup of OuterWindow->DC.ColumnsOffset at the end of BeginTable()
    HostBackupItemWidth:          float; // Backup of OuterWindow->DC.ItemWidth at the end of BeginTable()
    HostBackupItemWidthStackSize: s32; //Backup of OuterWindow->DC.ItemWidthStack.Size at the end of BeginTable()

    Constructor :: (this: *TableTempData) -> void #cpp_method #foreign ImGui "??0ImGuiTableTempData@@QEAA@XZ";
}

// sizeof() ~ 16
TableColumnSettings :: struct {
    WidthOrWeight: float;
    UserID:        ID;
    Index:         TableColumnIdx;
    DisplayOrder:  TableColumnIdx;
    SortOrder:     TableColumnIdx;
    SortDirection: U8; /* 2 bits */
    IsEnabled:     S8 #align 1; /* 2 bits */ // "Visible" in ini file
    IsStretch:     U8 #align 1; /* 1 bits */

    Constructor :: (this: *TableColumnSettings) -> void #cpp_method #foreign ImGui "??0ImGuiTableColumnSettings@@QEAA@XZ";
}

// This is designed to be stored in a single ImChunkStream (1 header followed by N ImGuiTableColumnSettings, etc.)
TableSettings :: struct {
    ID_:             ID; // Set to 0 to invalidate/delete the setting
    SaveFlags:       TableFlags; // Indicate data we want to save using the Resizable/Reorderable/Sortable/Hideable flags (could be using its own flags..)
    RefScale:        float; // Reference scale to be able to rescale columns on font/dpi changes.
    ColumnsCount:    TableColumnIdx;
    ColumnsCountMax: TableColumnIdx; // Maximum number of columns this settings instance can store, we can recycle a settings instance with lower number of columns but not higher
    WantApply:       bool; // Set when loaded from .ini data (to enable merging/loading .ini data into an already running context)

    Constructor :: (this: *TableSettings) -> void #cpp_method #foreign ImGui "??0ImGuiTableSettings@@QEAA@XZ";
    GetColumnSettings :: (this: *TableSettings) -> *TableColumnSettings #cpp_method #foreign ImGui "?GetColumnSettings@ImGuiTableSettings@@QEAAPEAUImGuiTableColumnSettings@@XZ";
}

// Hooks and storage for a given font backend.
// This structure is likely to evolve as we add support for incremental atlas updates.
// Conceptually this could be public, but API is still going to be evolve.
FontLoader :: struct {
    Name:                       *u8;
    LoaderInit:                 #type (atlas: *FontAtlas) -> bool #c_call;
    LoaderShutdown:             #type (atlas: *FontAtlas) -> void #c_call;
    FontSrcInit:                #type (atlas: *FontAtlas, src: *FontConfig) -> bool #c_call;
    FontSrcDestroy:             #type (atlas: *FontAtlas, src: *FontConfig) -> void #c_call;
    FontSrcContainsGlyph:       #type (atlas: *FontAtlas, src: *FontConfig, codepoint: Wchar) -> bool #c_call;
    FontBakedInit:              #type (atlas: *FontAtlas, src: *FontConfig, baked: *FontBaked, loader_data_for_baked_src: *void) -> bool #c_call;
    FontBakedDestroy:           #type (atlas: *FontAtlas, src: *FontConfig, baked: *FontBaked, loader_data_for_baked_src: *void) -> void #c_call;
    FontBakedLoadGlyph:         #type (atlas: *FontAtlas, src: *FontConfig, baked: *FontBaked, loader_data_for_baked_src: *void, codepoint: Wchar, out_glyph: *FontGlyph, out_advance_x: *float) -> bool #c_call;

    // Size of backend data, Per Baked * Per Source. Buffers are managed by core to avoid excessive allocations.
    // FIXME: At this point the two other types of buffers may be managed by core to be consistent?
    FontBakedSrcLoaderDataSize: u64;

    Constructor :: (this: *FontLoader) -> void #cpp_method #foreign ImGui "??0ImFontLoader@@QEAA@XZ";
}

FontAtlasGetFontLoaderForStbTruetype :: () -> *FontLoader #foreign ImGui "?ImFontAtlasGetFontLoaderForStbTruetype@@YAPEBUImFontLoader@@XZ";

// Helpers: ImTextureRef ==/!= operators provided as convenience
// (note that _TexID and _TexData are never set simultaneously)
operator== :: (lhs: *TextureRef, rhs: *TextureRef) -> bool #foreign ImGui "??8@YA_NAEBUImTextureRef@@0@Z";
operator== :: (lhs: TextureRef, rhs: TextureRef) -> bool #no_context {
    return operator==(*lhs, *rhs);
}
operator!= :: (lhs: *TextureRef, rhs: *TextureRef) -> bool #foreign ImGui "??9@YA_NAEBUImTextureRef@@0@Z";
operator!= :: (lhs: TextureRef, rhs: TextureRef) -> bool #no_context {
    return operator!=(*lhs, *rhs);
}

FontAtlasRectId_GetIndex :: (id: FontAtlasRectId) -> s32 #foreign ImGui "?ImFontAtlasRectId_GetIndex@@YAHH@Z";
FontAtlasRectId_GetGeneration :: (id: FontAtlasRectId) -> u32 #foreign ImGui "?ImFontAtlasRectId_GetGeneration@@YAIH@Z";
FontAtlasRectId_Make :: (index_idx: s32, gen_idx: s32) -> FontAtlasRectId #foreign ImGui "?ImFontAtlasRectId_Make@@YAHHH@Z";

// Packed rectangle lookup entry (we need an indirection to allow removing/reordering rectangles)
// User are returned ImFontAtlasRectId values which are meant to be persistent.
// We handle this with an indirection. While Rects[] may be in theory shuffled, compacted etc., RectsIndex[] cannot it is keyed by ImFontAtlasRectId.
// RectsIndex[] is used both as an index into Rects[] and an index into itself. This is basically a free-list. See ImFontAtlasBuildAllocRectIndexEntry() code.
// Having this also makes it easier to e.g. sort rectangles during repack.
FontAtlasRectEntry :: struct {
    TargetIndex: s32; /* 20 bits */ // When Used: ImFontAtlasRectId -> into Rects[]. When unused: index to next unused RectsIndex[] slot to consume free-list.
    __bitfield:  u32 #align 2;
    /* 
        Generation: u32; /* 10 bits */ // Increased each time the entry is reused for a new rectangle.
        IsUsed: u32; /* 1 bits */;
    */
}

// Data available to potential texture post-processing functions
FontAtlasPostProcessData :: struct {
    FontAtlas_: *FontAtlas;
    Font_:      *Font;
    FontSrc:    *FontConfig;
    FontBaked_: *FontBaked;
    Glyph:      *FontGlyph;

    // Pixel data
    Pixels:     *void;
    Format:     TextureFormat;
    Pitch:      s32;
    Width:      s32;
    Height:     s32;
}

stbrp_node :: struct {}
stbrp_node_im :: stbrp_node;

stbrp_context_opaque :: struct {
    data: [80] u8;
}

// Internal storage for incrementally packing and building a ImFontAtlas
FontAtlasBuilder :: struct {
    PackContext:              stbrp_context_opaque; // Actually 'stbrp_context' but we don't want to define this in the header file.
    PackNodes:                Vector(stbrp_node_im);
    Rects:                    Vector(TextureRect);
    RectsIndex:               Vector(FontAtlasRectEntry); // ImFontAtlasRectId -> index into Rects[]
    TempBuffer:               Vector(u8); // Misc scratch buffer
    RectsIndexFreeListStart:  s32; // First unused entry
    RectsPackedCount:         s32; // Number of packed rectangles.
    RectsPackedSurface:       s32; // Number of packed pixels. Used when compacting to heuristically find the ideal texture size.
    RectsDiscardedCount:      s32;
    RectsDiscardedSurface:    s32;
    FrameCount:               s32; // Current frame count
    MaxRectSize:              Vec2i; // Largest rectangle to pack (de-facto used as a "minimum texture size")
    MaxRectBounds:            Vec2i; // Bottom-right most used pixels
    LockDisableResize:        bool; // Disable resizing texture
    PreloadedAllGlyphsRanges: bool; // Set when missing ImGuiBackendFlags_RendererHasTextures features forces atlas to preload everything.

    // Cache of all ImFontBaked
    BakedPool:                StableVector(FontBaked, 32);
    BakedMap:                 Storage; // BakedId --> ImFontBaked*
    BakedDiscardedCount:      s32;

    PackIdMouseCursors:       FontAtlasRectId; // White pixel + mouse cursors. Also happen to be fallback in case of packing failure.
    PackIdLinesTexData:       FontAtlasRectId;

    Constructor :: (this: *FontAtlasBuilder) -> void #cpp_method #foreign ImGui "??0ImFontAtlasBuilder@@QEAA@XZ";
}

FontAtlasBuildInit :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasBuildInit@@YAXPEAUImFontAtlas@@@Z";
FontAtlasBuildDestroy :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasBuildDestroy@@YAXPEAUImFontAtlas@@@Z";
FontAtlasBuildMain :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasBuildMain@@YAXPEAUImFontAtlas@@@Z";
FontAtlasBuildSetupFontLoader :: (atlas: *FontAtlas, font_loader: *FontLoader) -> void #foreign ImGui "?ImFontAtlasBuildSetupFontLoader@@YAXPEAUImFontAtlas@@PEBUImFontLoader@@@Z";
FontAtlasBuildUpdatePointers :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasBuildUpdatePointers@@YAXPEAUImFontAtlas@@@Z";
FontAtlasBuildRenderBitmapFromString :: (atlas: *FontAtlas, x: s32, y: s32, w: s32, h: s32, in_str: *u8, in_marker_char: u8) -> void #foreign ImGui "?ImFontAtlasBuildRenderBitmapFromString@@YAXPEAUImFontAtlas@@HHHHPEBDD@Z";
FontAtlasBuildClear :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasBuildClear@@YAXPEAUImFontAtlas@@@Z";

FontAtlasTextureAdd :: (atlas: *FontAtlas, w: s32, h: s32) -> *TextureData #foreign ImGui "?ImFontAtlasTextureAdd@@YAPEAUImTextureData@@PEAUImFontAtlas@@HH@Z";
FontAtlasTextureMakeSpace :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasTextureMakeSpace@@YAXPEAUImFontAtlas@@@Z";
FontAtlasTextureRepack :: (atlas: *FontAtlas, w: s32, h: s32) -> void #foreign ImGui "?ImFontAtlasTextureRepack@@YAXPEAUImFontAtlas@@HH@Z";
FontAtlasTextureGrow :: (atlas: *FontAtlas, old_w: s32 = -1, old_h: s32 = -1) -> void #foreign ImGui "?ImFontAtlasTextureGrow@@YAXPEAUImFontAtlas@@HH@Z";
FontAtlasTextureCompact :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasTextureCompact@@YAXPEAUImFontAtlas@@@Z";
FontAtlasTextureGetSizeEstimate :: (atlas: *FontAtlas) -> Vec2i #cpp_return_type_is_non_pod #foreign ImGui "?ImFontAtlasTextureGetSizeEstimate@@YA?AUImVec2i@@PEAUImFontAtlas@@@Z";

FontAtlasBuildSetupFontSpecialGlyphs :: (atlas: *FontAtlas, font: *Font, src: *FontConfig) -> void #foreign ImGui "?ImFontAtlasBuildSetupFontSpecialGlyphs@@YAXPEAUImFontAtlas@@PEAUImFont@@PEAUImFontConfig@@@Z";
FontAtlasBuildLegacyPreloadAllGlyphRanges :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasBuildLegacyPreloadAllGlyphRanges@@YAXPEAUImFontAtlas@@@Z";
FontAtlasBuildGetOversampleFactors :: (src: *FontConfig, baked: *FontBaked, out_oversample_h: *s32, out_oversample_v: *s32) -> void #foreign ImGui "?ImFontAtlasBuildGetOversampleFactors@@YAXPEAUImFontConfig@@PEAUImFontBaked@@PEAH2@Z";
FontAtlasBuildDiscardBakes :: (atlas: *FontAtlas, unused_frames: s32) -> void #foreign ImGui "?ImFontAtlasBuildDiscardBakes@@YAXPEAUImFontAtlas@@H@Z";

FontAtlasFontSourceInit :: (atlas: *FontAtlas, src: *FontConfig) -> bool #foreign ImGui "?ImFontAtlasFontSourceInit@@YA_NPEAUImFontAtlas@@PEAUImFontConfig@@@Z";
FontAtlasFontSourceAddToFont :: (atlas: *FontAtlas, font: *Font, src: *FontConfig) -> void #foreign ImGui "?ImFontAtlasFontSourceAddToFont@@YAXPEAUImFontAtlas@@PEAUImFont@@PEAUImFontConfig@@@Z";
FontAtlasFontDestroySourceData :: (atlas: *FontAtlas, src: *FontConfig) -> void #foreign ImGui "?ImFontAtlasFontDestroySourceData@@YAXPEAUImFontAtlas@@PEAUImFontConfig@@@Z";
FontAtlasFontInitOutput :: (atlas: *FontAtlas, font: *Font) -> bool #foreign ImGui "?ImFontAtlasFontInitOutput@@YA_NPEAUImFontAtlas@@PEAUImFont@@@Z";
FontAtlasFontDestroyOutput :: (atlas: *FontAtlas, font: *Font) -> void #foreign ImGui "?ImFontAtlasFontDestroyOutput@@YAXPEAUImFontAtlas@@PEAUImFont@@@Z";
FontAtlasFontDiscardBakes :: (atlas: *FontAtlas, font: *Font, unused_frames: s32) -> void #foreign ImGui "?ImFontAtlasFontDiscardBakes@@YAXPEAUImFontAtlas@@PEAUImFont@@H@Z";

FontAtlasBakedGetId :: (font_id: ID, baked_size: float, rasterizer_density: float) -> ID #foreign ImGui "?ImFontAtlasBakedGetId@@YAIIMM@Z";
FontAtlasBakedGetOrAdd :: (atlas: *FontAtlas, font: *Font, font_size: float, font_rasterizer_density: float) -> *FontBaked #foreign ImGui "?ImFontAtlasBakedGetOrAdd@@YAPEAUImFontBaked@@PEAUImFontAtlas@@PEAUImFont@@MM@Z";
FontAtlasBakedGetClosestMatch :: (atlas: *FontAtlas, font: *Font, font_size: float, font_rasterizer_density: float) -> *FontBaked #foreign ImGui "?ImFontAtlasBakedGetClosestMatch@@YAPEAUImFontBaked@@PEAUImFontAtlas@@PEAUImFont@@MM@Z";
FontAtlasBakedAdd :: (atlas: *FontAtlas, font: *Font, font_size: float, font_rasterizer_density: float, baked_id: ID) -> *FontBaked #foreign ImGui "?ImFontAtlasBakedAdd@@YAPEAUImFontBaked@@PEAUImFontAtlas@@PEAUImFont@@MMI@Z";
FontAtlasBakedDiscard :: (atlas: *FontAtlas, font: *Font, baked: *FontBaked) -> void #foreign ImGui "?ImFontAtlasBakedDiscard@@YAXPEAUImFontAtlas@@PEAUImFont@@PEAUImFontBaked@@@Z";
FontAtlasBakedAddFontGlyph :: (atlas: *FontAtlas, baked: *FontBaked, src: *FontConfig, in_glyph: *FontGlyph) -> *FontGlyph #foreign ImGui "?ImFontAtlasBakedAddFontGlyph@@YAPEAUImFontGlyph@@PEAUImFontAtlas@@PEAUImFontBaked@@PEAUImFontConfig@@PEBU1@@Z";
FontAtlasBakedAddFontGlyphAdvancedX :: (atlas: *FontAtlas, baked: *FontBaked, src: *FontConfig, codepoint: Wchar, advance_x: float) -> void #foreign ImGui "?ImFontAtlasBakedAddFontGlyphAdvancedX@@YAXPEAUImFontAtlas@@PEAUImFontBaked@@PEAUImFontConfig@@GM@Z";
FontAtlasBakedDiscardFontGlyph :: (atlas: *FontAtlas, font: *Font, baked: *FontBaked, glyph: *FontGlyph) -> void #foreign ImGui "?ImFontAtlasBakedDiscardFontGlyph@@YAXPEAUImFontAtlas@@PEAUImFont@@PEAUImFontBaked@@PEAUImFontGlyph@@@Z";
FontAtlasBakedSetFontGlyphBitmap :: (atlas: *FontAtlas, baked: *FontBaked, src: *FontConfig, glyph: *FontGlyph, r: *TextureRect, src_pixels: *u8, src_fmt: TextureFormat, src_pitch: s32) -> void #foreign ImGui "?ImFontAtlasBakedSetFontGlyphBitmap@@YAXPEAUImFontAtlas@@PEAUImFontBaked@@PEAUImFontConfig@@PEAUImFontGlyph@@PEAUImTextureRect@@PEBEW4ImTextureFormat@@H@Z";

FontAtlasPackInit :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasPackInit@@YAXPEAUImFontAtlas@@@Z";
FontAtlasPackAddRect :: (atlas: *FontAtlas, w: s32, h: s32, overwrite_entry: *FontAtlasRectEntry = null) -> FontAtlasRectId #foreign ImGui "?ImFontAtlasPackAddRect@@YAHPEAUImFontAtlas@@HHPEAUImFontAtlasRectEntry@@@Z";
FontAtlasPackGetRect :: (atlas: *FontAtlas, id: FontAtlasRectId) -> *TextureRect #foreign ImGui "?ImFontAtlasPackGetRect@@YAPEAUImTextureRect@@PEAUImFontAtlas@@H@Z";
FontAtlasPackGetRectSafe :: (atlas: *FontAtlas, id: FontAtlasRectId) -> *TextureRect #foreign ImGui "?ImFontAtlasPackGetRectSafe@@YAPEAUImTextureRect@@PEAUImFontAtlas@@H@Z";
FontAtlasPackDiscardRect :: (atlas: *FontAtlas, id: FontAtlasRectId) -> void #foreign ImGui "?ImFontAtlasPackDiscardRect@@YAXPEAUImFontAtlas@@H@Z";

FontAtlasUpdateNewFrame :: (atlas: *FontAtlas, frame_count: s32, renderer_has_textures: bool) -> void #foreign ImGui "?ImFontAtlasUpdateNewFrame@@YAXPEAUImFontAtlas@@H_N@Z";
FontAtlasAddDrawListSharedData :: (atlas: *FontAtlas, data: *DrawListSharedData) -> void #foreign ImGui "?ImFontAtlasAddDrawListSharedData@@YAXPEAUImFontAtlas@@PEAUImDrawListSharedData@@@Z";
FontAtlasRemoveDrawListSharedData :: (atlas: *FontAtlas, data: *DrawListSharedData) -> void #foreign ImGui "?ImFontAtlasRemoveDrawListSharedData@@YAXPEAUImFontAtlas@@PEAUImDrawListSharedData@@@Z";
FontAtlasUpdateDrawListsTextures :: (atlas: *FontAtlas, old_tex: TextureRef, new_tex: TextureRef) -> void #foreign ImGui "?ImFontAtlasUpdateDrawListsTextures@@YAXPEAUImFontAtlas@@UImTextureRef@@1@Z";
FontAtlasUpdateDrawListsSharedData :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasUpdateDrawListsSharedData@@YAXPEAUImFontAtlas@@@Z";

FontAtlasTextureBlockConvert :: (src_pixels: *u8, src_fmt: TextureFormat, src_pitch: s32, dst_pixels: *u8, dst_fmt: TextureFormat, dst_pitch: s32, w: s32, h: s32) -> void #foreign ImGui "?ImFontAtlasTextureBlockConvert@@YAXPEBEW4ImTextureFormat@@HPEAE1HHH@Z";
FontAtlasTextureBlockPostProcess :: (data: *FontAtlasPostProcessData) -> void #foreign ImGui "?ImFontAtlasTextureBlockPostProcess@@YAXPEAUImFontAtlasPostProcessData@@@Z";
FontAtlasTextureBlockPostProcessMultiply :: (data: *FontAtlasPostProcessData, multiply_factor: float) -> void #foreign ImGui "?ImFontAtlasTextureBlockPostProcessMultiply@@YAXPEAUImFontAtlasPostProcessData@@M@Z";
FontAtlasTextureBlockFill :: (dst_tex: *TextureData, dst_x: s32, dst_y: s32, w: s32, h: s32, col: U32) -> void #foreign ImGui "?ImFontAtlasTextureBlockFill@@YAXPEAUImTextureData@@HHHHI@Z";
FontAtlasTextureBlockCopy :: (src_tex: *TextureData, src_x: s32, src_y: s32, dst_tex: *TextureData, dst_x: s32, dst_y: s32, w: s32, h: s32) -> void #foreign ImGui "?ImFontAtlasTextureBlockCopy@@YAXPEAUImTextureData@@HH0HHHH@Z";
FontAtlasTextureBlockQueueUpload :: (atlas: *FontAtlas, tex: *TextureData, x: s32, y: s32, w: s32, h: s32) -> void #foreign ImGui "?ImFontAtlasTextureBlockQueueUpload@@YAXPEAUImFontAtlas@@PEAUImTextureData@@HHHH@Z";

TextureDataGetFormatBytesPerPixel :: (format: TextureFormat) -> s32 #foreign ImGui "?ImTextureDataGetFormatBytesPerPixel@@YAHW4ImTextureFormat@@@Z";
TextureDataGetStatusName :: (status: TextureStatus) -> *u8 #foreign ImGui "?ImTextureDataGetStatusName@@YAPEBDW4ImTextureStatus@@@Z";
TextureDataGetFormatName :: (format: TextureFormat) -> *u8 #foreign ImGui "?ImTextureDataGetFormatName@@YAPEBDW4ImTextureFormat@@@Z";

FontAtlasDebugLogTextureRequests :: (atlas: *FontAtlas) -> void #foreign ImGui "?ImFontAtlasDebugLogTextureRequests@@YAXPEAUImFontAtlas@@@Z";

FontAtlasGetMouseCursorTexData :: (atlas: *FontAtlas, cursor_type: MouseCursor, out_offset: *Vector2, out_size: *Vector2, out_uv_border: *[2] Vector2, out_uv_fill: *[2] Vector2) -> bool #foreign ImGui "?ImFontAtlasGetMouseCursorTexData@@YA_NPEAUImFontAtlas@@HPEAUImVec2@@1QEAU2@2@Z";

//
// #elsewhere declarations that were moved out of namespaces / structs:
//


TextBuffer_EmptyString: [1] u8 #elsewhere ImGui "?EmptyString@ImGuiTextBuffer@@2PADA";

#scope_file

#import "Basic"; // For push_context

ImGui :: #library,no_dll "windows/ImGui";
