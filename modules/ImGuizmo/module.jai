//
// This file was auto-generated using the following command:
//
// jai scripts/generate_bindings.jai
//

// call inside your own window and before Manipulate() in order to draw gizmo to that window.
// Or pass a specific ImDrawList to draw to (e.g. ImGui::GetForegroundDrawList()).
SetDrawlist :: (drawlist: *DrawList = null) -> void #foreign ImGuizmo "?SetDrawlist@ImGuizmo@@YAXPEAUImDrawList@@@Z";

// call BeginFrame right after ImGui_XXXX_NewFrame();
BeginFrame :: () -> void #foreign ImGuizmo "?BeginFrame@ImGuizmo@@YAXXZ";

// this is necessary because when imguizmo is compiled into a dll, and imgui into another
// globals are not shared between them.
// More details at https://stackoverflow.com/questions/19373061/what-happens-to-global-and-static-variables-in-a-shared-library-when-it-is-dynam
// expose method to set imgui context
SetImGuiContext :: (ctx: *ImGuiContext) -> void #foreign ImGuizmo "?SetImGuiContext@ImGuizmo@@YAXPEAUImGuiContext@@@Z";

// return true if mouse cursor is over any gizmo control (axis, plan or screen component)
IsOver :: () -> bool #foreign ImGuizmo "?IsOver@ImGuizmo@@YA_NXZ";

// return true if mouse IsOver or if the gizmo is in moving state
IsUsing :: () -> bool #foreign ImGuizmo "?IsUsing@ImGuizmo@@YA_NXZ";

// return true if the view gizmo is in moving state
IsUsingViewManipulate :: () -> bool #foreign ImGuizmo "?IsUsingViewManipulate@ImGuizmo@@YA_NXZ";

// only check if your mouse is over the view manipulator - no matter whether it's active or not
IsViewManipulateHovered :: () -> bool #foreign ImGuizmo "?IsViewManipulateHovered@ImGuizmo@@YA_NXZ";

// return true if any gizmo is in moving state
IsUsingAny :: () -> bool #foreign ImGuizmo "?IsUsingAny@ImGuizmo@@YA_NXZ";

// enable/disable the gizmo. Stay in the state until next call to Enable.
// gizmo is rendered with gray half transparent color when disabled
Enable :: (enable: bool) -> void #foreign ImGuizmo "?Enable@ImGuizmo@@YAX_N@Z";

// helper functions for manualy editing translation/rotation/scale with an input float
// translation, rotation and scale float points to 3 floats each
// Angles are in degrees (more suitable for human editing)
// example:
// float matrixTranslation[3], matrixRotation[3], matrixScale[3];
// ImGuizmo::DecomposeMatrixToComponents(gizmoMatrix.m16, matrixTranslation, matrixRotation, matrixScale);
// ImGui::InputFloat3("Tr", matrixTranslation, 3);
// ImGui::InputFloat3("Rt", matrixRotation, 3);
// ImGui::InputFloat3("Sc", matrixScale, 3);
// ImGuizmo::RecomposeMatrixFromComponents(matrixTranslation, matrixRotation, matrixScale, gizmoMatrix.m16);
//
// These functions have some numerical stability issues for now. Use with caution.
DecomposeMatrixToComponents :: (matrix: *float, translation: *float, rotation: *float, scale: *float) -> void #foreign ImGuizmo "?DecomposeMatrixToComponents@ImGuizmo@@YAXPEBMPEAM11@Z";
RecomposeMatrixFromComponents :: (translation: *float, rotation: *float, scale: *float, matrix: *float) -> void #foreign ImGuizmo "?RecomposeMatrixFromComponents@ImGuizmo@@YAXPEBM00PEAM@Z";

SetRect :: (x: float, y: float, width: float, height: float) -> void #foreign ImGuizmo "?SetRect@ImGuizmo@@YAXMMMM@Z";

// default is false
SetOrthographic :: (isOrthographic: bool) -> void #foreign ImGuizmo "?SetOrthographic@ImGuizmo@@YAX_N@Z";

// Render a cube with face color corresponding to face normal. Usefull for debug/tests
DrawCubes :: (view: *float, projection: *float, matrices: *float, matrixCount: s32) -> void #foreign ImGuizmo "?DrawCubes@ImGuizmo@@YAXPEBM00H@Z";
DrawGrid :: (view: *float, projection: *float, matrix: *float, gridSize: float) -> void #foreign ImGuizmo "?DrawGrid@ImGuizmo@@YAXPEBM00M@Z";

// call it when you want a gizmo
// Needs view and projection matrices.
// matrix parameter is the source matrix (where will be gizmo be drawn) and might be transformed by the function. Return deltaMatrix is optional
// translation is applied in world space
OPERATION :: enum_flags s32 {
    TRANSLATE_X   :: 1;
    TRANSLATE_Y   :: 2;
    TRANSLATE_Z   :: 4;
    ROTATE_X      :: 8;
    ROTATE_Y      :: 16;
    ROTATE_Z      :: 32;
    ROTATE_SCREEN :: 64;
    SCALE_X       :: 128;
    SCALE_Y       :: 256;
    SCALE_Z       :: 512;
    BOUNDS        :: 1024;
    SCALE_XU      :: 2048;
    SCALE_YU      :: 4096;
    SCALE_ZU      :: 8192;

    TRANSLATE     :: 7;
    ROTATE        :: 120;
    SCALE         :: 896;
    SCALEU        :: 14336;
    UNIVERSAL     :: 14463;
}

MODE :: enum s32 {
    LOCAL :: 0;
    WORLD :: 1;
}

Manipulate :: (view: *float, projection: *float, operation: OPERATION, mode: MODE, matrix: *float, deltaMatrix: *float = null, snap: *float = null, localBounds: *float = null, boundsSnap: *float = null) -> bool #foreign ImGuizmo "?Manipulate@ImGuizmo@@YA_NPEBM0W4OPERATION@1@W4MODE@1@PEAM3000@Z";

//
// Please note that this cubeview is patented by Autodesk : https://patents.google.com/patent/US7782319B2/en
// It seems to be a defensive patent in the US. I don't think it will bring troubles using it as
// other software are using the same mechanics. But just in case, you are now warned!
//
ViewManipulate :: (view: *float, length: float, position: Vector2, size: Vector2, backgroundColor: U32) -> void #foreign ImGuizmo "?ViewManipulate@ImGuizmo@@YAXPEAMMUImVec2@@1I@Z";

// use this version if you did not call Manipulate before and you are just using ViewManipulate
ViewManipulate :: (view: *float, projection: *float, operation: OPERATION, mode: MODE, matrix: *float, length: float, position: Vector2, size: Vector2, backgroundColor: U32) -> void #foreign ImGuizmo "?ViewManipulate@ImGuizmo@@YAXPEAMPEBMW4OPERATION@1@W4MODE@1@0MUImVec2@@4I@Z";

SetAlternativeWindow :: (window: *Window) -> void #foreign ImGuizmo "?SetAlternativeWindow@ImGuizmo@@YAXPEAUImGuiWindow@@@Z";

SetID :: (id: s32) -> void #foreign ImGuizmo "?SetID@ImGuizmo@@YAXH@Z";

// ID stack/scopes
// Read the FAQ (docs/FAQ.md or http://dearimgui.org/faq) for more details about how ID are handled in dear imgui.
// - Those questions are answered and impacted by understanding of the ID stack system:
//   - "Q: Why is my widget not reacting when I click on it?"
//   - "Q: How can I have widgets with an empty label?"
//   - "Q: How can I have multiple widgets with the same label?"
// - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
//   want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
// - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
// - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
//   whereas "str_id" denote a string that is only used as an ID and not normally displayed.
PushID :: (str_id: *u8) -> void #foreign ImGuizmo "?PushID@ImGuizmo@@YAXPEBD@Z";
PushID :: (str_id_begin: *u8, str_id_end: *u8) -> void #foreign ImGuizmo "?PushID@ImGuizmo@@YAXPEBD0@Z";
PushID :: (str_id: string) #no_context {
    PushID(str_id.data, str_id.data + str_id.count);
}
PushID :: (ptr_id: *void) -> void #foreign ImGuizmo "?PushID@ImGuizmo@@YAXPEBX@Z";
PushID :: (int_id: s32) -> void #foreign ImGuizmo "?PushID@ImGuizmo@@YAXH@Z";
PopID :: () -> void #foreign ImGuizmo "?PopID@ImGuizmo@@YAXXZ";
GetID :: (str_id: *u8) -> ID #foreign ImGuizmo "?GetID@ImGuizmo@@YAIPEBD@Z";
GetID :: (str_id_begin: *u8, str_id_end: *u8) -> ID #foreign ImGuizmo "?GetID@ImGuizmo@@YAIPEBD0@Z";
GetID :: (str_id: string) -> ID #no_context {
    return GetID(str_id.data, str_id.data + str_id.count);
}
GetID :: (ptr_id: *void) -> ID #foreign ImGuizmo "?GetID@ImGuizmo@@YAIPEBX@Z";

// return true if the cursor is over the operation's gizmo
IsOver :: (op: OPERATION) -> bool #foreign ImGuizmo "?IsOver@ImGuizmo@@YA_NW4OPERATION@1@@Z";
SetGizmoSizeClipSpace :: (value: float) -> void #foreign ImGuizmo "?SetGizmoSizeClipSpace@ImGuizmo@@YAXM@Z";

// Allow axis to flip
// When true (default), the guizmo axis flip for better visibility
// When false, they always stay along the positive world/local axis
AllowAxisFlip :: (value: bool) -> void #foreign ImGuizmo "?AllowAxisFlip@ImGuizmo@@YAX_N@Z";

// Configure the limit where axis are hidden
SetAxisLimit :: (value: float) -> void #foreign ImGuizmo "?SetAxisLimit@ImGuizmo@@YAXM@Z";

// Set an axis mask to permanently hide a given axis (true -> hidden, false -> shown)
SetAxisMask :: (x: bool, y: bool, z: bool) -> void #foreign ImGuizmo "?SetAxisMask@ImGuizmo@@YAX_N00@Z";

// Configure the limit where planes are hiden
SetPlaneLimit :: (value: float) -> void #foreign ImGuizmo "?SetPlaneLimit@ImGuizmo@@YAXM@Z";

// from a x,y,z point in space and using Manipulation view/projection matrix, check if mouse is in pixel radius distance of that projected point
IsOver :: (position: *float, pixelRadius: float) -> bool #foreign ImGuizmo "?IsOver@ImGuizmo@@YA_NPEAMM@Z";

COLOR :: enum s32 {
    DIRECTION_X           :: 0;
    DIRECTION_Y           :: 1;
    DIRECTION_Z           :: 2;
    PLANE_X               :: 3;
    PLANE_Y               :: 4;
    PLANE_Z               :: 5;
    SELECTION             :: 6;
    INACTIVE              :: 7;
    TRANSLATION_LINE      :: 8;
    SCALE_LINE            :: 9;
    ROTATION_USING_BORDER :: 10;
    ROTATION_USING_FILL   :: 11;
    HATCHED_AXIS_LINES    :: 12;
    TEXT                  :: 13;
    TEXT_SHADOW           :: 14;
    COUNT                 :: 15;
}

Style :: struct {
    Constructor :: (this: *Style) -> void #cpp_method #foreign ImGuizmo "??0Style@ImGuizmo@@QEAA@XZ";

    TranslationLineThickness:   float; // Thickness of lines for translation gizmo
    TranslationLineArrowSize:   float; // Size of arrow at the end of lines for translation gizmo
    RotationLineThickness:      float; // Thickness of lines for rotation gizmo
    RotationOuterLineThickness: float; // Thickness of line surrounding the rotation gizmo
    ScaleLineThickness:         float; // Thickness of lines for scale gizmo
    ScaleLineCircleSize:        float; // Size of circle at the end of lines for scale gizmo
    HatchedAxisLineThickness:   float; // Thickness of hatched axis lines
    CenterCircleSize:           float; // Size of circle at the center of the translate/scale gizmo

    Colors:                     [15] Vector4;
}

GetStyle :: () -> *Style #foreign ImGuizmo "?GetStyle@ImGuizmo@@YAAEAUStyle@1@XZ";

#scope_file

ImGuizmo :: #library,no_dll "windows/ImGuizmo";

#import "ImGui2";
#import "Math";
