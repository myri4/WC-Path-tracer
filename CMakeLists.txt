cmake_minimum_required(VERSION 3.8)


project("PathTracer")
add_definitions(
-DNOMINMAX 
-DWIN32_LEAN_AND_MEAN 
-DIMGUI_DEFINE_MATH_OPERATORS
-DGLM_FORCE_CTOR_INIT
-DGLM_FORCE_SILENT_WARNINGS
-DGLM_ENABLE_EXPERIMENTAL)
string(REPLACE "-Wformat" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

file(GLOB_RECURSE SOURCES "${CMAKE_SOURCE_DIR}/Path tracer/*.cpp" "${CMAKE_SOURCE_DIR}/Path tracer/*.h")
file(GLOB IMGUI_SOURCES
"vendor/imgui/*.cpp" "vendor/imgui/*.h"
"vendor/imgui/misc/cpp/*.cpp" "vendor/imgui/misc/cpp/*.h"
)

add_executable("PathTracer"
    ${SOURCES}
    ${IMGUI_SOURCES}
    #"vendor/imguizmo/ImGuizmo.cpp"
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)

find_package(Vulkan REQUIRED)
set(VULKAN_SDK $ENV{VULKAN_SDK})
set(VULKAN_LIBRARY_DIRS "${VULKAN_SDK}/Lib")

add_subdirectory("vendor/glfw")
add_subdirectory("vendor/spdlog")
#add_subdirectory("vendor/yaml-cpp")
add_subdirectory("vendor/glm")


target_link_libraries(${PROJECT_NAME} 
Vulkan::Vulkan
glfw 
spdlog::spdlog 
#yaml-cpp 
glm::glm 
)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_link_libraries(${PROJECT_NAME} $ENV{VULKAN_SDK}/Lib/spirv-cross-cored.lib)
else()
    target_link_libraries(${PROJECT_NAME} $ENV{VULKAN_SDK}/Lib/spirv-cross-core.lib)
endif()

target_include_directories(${PROJECT_NAME} PUBLIC 
"vendor/"
"vendor/imgui"
)
target_link_directories(${PROJECT_NAME} PUBLIC ${VULKAN_LIBRARY_DIRS})

set(PROJECT_SRC_DIR "${PROJECT_SOURCE_DIR}/Path tracer") # We define PROJECT_SRC_DIR like this because PROJECT_SOURCE_DIR is a predefined macro
set(PROJECT_WORK_DIR "${PROJECT_SRC_DIR}/workdir")
# SHADER COMPILATION
set(SHADER_IN_DIR "${PROJECT_SRC_DIR}/shaders")
file(GLOB SHADER_SOURCES
        "${SHADER_IN_DIR}/*.vert"
        "${SHADER_IN_DIR}/*.frag"
        "${SHADER_IN_DIR}/*.comp")

file(GLOB SHADER_HEADERS
        "${SHADER_IN_DIR}/include/*.glsl")

# Create custom target for all shaders
add_custom_target(shaders ALL)

foreach(SHADER ${SHADER_SOURCES})
    get_filename_component(SHADER_NAME ${SHADER} NAME)
    add_custom_command(
            OUTPUT "${PROJECT_WORK_DIR}/assets/shaders/${SHADER_NAME}"
            COMMAND "$ENV{VULKAN_SDK}/Bin/glslc.exe"
            -std=450core
            -I"${SHADER_IN_DIR}/include"
            -o "${PROJECT_WORK_DIR}/assets/shaders/${SHADER_NAME}"
            -O0
            ${SHADER}
            DEPENDS ${SHADER}
            ${SHADER_HEADERS}
            COMMENT "Compiling ${SHADER_NAME}"
            VERBATIM
    )
    add_custom_target(${SHADER_NAME} DEPENDS "${PROJECT_WORK_DIR}/assets/shaders/${SHADER_NAME}")
    add_dependencies(shaders ${SHADER_NAME})
endforeach()

# Make shaders compile automatically when building the main target
add_dependencies(${PROJECT_NAME} shaders)