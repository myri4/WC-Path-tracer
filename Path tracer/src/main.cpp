//#define GLM_FORCE_INTRINSICS 

#pragma warning( push )
#pragma warning( disable : 4702) // Disable unreachable code
#define GLFW_INCLUDE_NONE
//#define GLM_FORCE_PURE
#define GLM_FORCE_CTOR_INIT
#define GLM_FORCE_SILENT_WARNINGS
#include "Scene.h"

//DANGEROUS!
#pragma warning(push, 0)

#define STB_IMAGE_IMPLEMENTATION
#include <stb_image/stb_image.h>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb_image/stb_write.h>

#pragma warning(pop)


int main()
{
    Scene scene;
    scene.Create();
    scene.Render();
	

	return 0;
}