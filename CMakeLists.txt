cmake_minimum_required(VERSION 3.8)

set(OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}")
set(VENDOR "vendor/")

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
file(GLOB_RECURSE SOURCES2 "vendor/wc/*.cpp" "vendor/wc/*.h")
file(GLOB IMGUI_SOURCES
"vendor/imgui/*.cpp" "vendor/imgui/*.h"
"vendor/imgui/misc/cpp/*.cpp" "vendor/imgui/misc/cpp/*.h"
)

# Check if we're inside CLion
if (NOT DEFINED ENV{CLION_IDE})
    if (MSVC)
        add_definitions(-DMSVC)
    endif()
else()
    add_definitions(-DCLION)
endif()

add_executable("PathTracer"
    ${SOURCES}
    ${SOURCES2}
    ${IMGUI_SOURCES}
    #"vendor/imguizmo/ImGuizmo.cpp"
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_DIRECTORY}"
)

if(MSVC)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")
    
    add_compile_definitions(
        $<$<CONFIG:Debug>:_ITERATOR_DEBUG_LEVEL=2>
        $<$<CONFIG:Release>:_ITERATOR_DEBUG_LEVEL=0>
    )
endif()

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