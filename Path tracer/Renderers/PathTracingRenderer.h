#pragma once

#include "../Rendering/Shader.h"

#include "../Rendering/CommandEncoder.h"

#include <glm/glm.hpp>
#include <glm/gtx/compatibility.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

using namespace wc;
using namespace glm;

constexpr uint32_t ComputeWorkGroupSize = 4;

struct Camera
{	
	vec3 position = vec3(0.0f, 0.0f, 0.0f);
	vec3 direction = vec3(0.f, 0.f, -1.f);

	float yaw = 0.f;
	float pitch = 0.f;

	float fov = 90.f;

	mat4 projection;
	mat4 inverseProjection;
	mat4 inverseView;

	void Update(float aspectRatio = 16.f / 9.f)
	{
		float rYaw = glm::radians(yaw);
		float rPitch = glm::radians(pitch);
		float cosPitch = glm::cos(rPitch);
		glm::vec3 dir;
		dir.x = glm::cos(rYaw) * cosPitch;
		dir.y = glm::sin(rPitch);
		dir.z = glm::sin(rYaw) * cosPitch;
		direction = glm::normalize(dir);

		inverseView = inverse(lookAt(position, position + direction, vec3(0.f, 1.f, 0.f)));

		projection = perspective(radians(fov), aspectRatio, 0.1f, 100.0f);
		inverseProjection = inverse(projection);
	}
};

struct SceneData
{
	// Camera
	mat4 inverseProjection;
	mat4 inverseView;
	vec3 position;
	uint32_t MaxBounceCount = 3;
	uint32_t Samples = 1;
	uint32_t SphereCount = 0;
	uint32_t RenderedFramesCount = 0;
};

struct Material
{
	vec3 albedo;
	vec3 emission;

	float metallic = 0.0f;
	float roughness = 0.0f;
	float ior = 1.0f;

	void SetMetal(vec3 a, float r, float sp)
	{
		albedo = a;
		roughness = r;
		metallic = sp;
	}

	void SetDielectric(vec3 color, float r, float index_of_refraction)
	{
		albedo = color;
		roughness = r;
		ior = index_of_refraction;
	}
};

using MaterialID = uint32_t;

struct Sphere
{
	vec3 position;
	float radius;
	MaterialID mat;
};

struct PathTracingRenderer
{
	vec2 renderSize;

	Pipeline pipeline;
	VkDescriptorSet descriptorSet;
	VkDescriptorSet ImguiImageID;

	vk::Image outputImage;
	vk::ImageView outputImageView;

	vk::Sampler screenSampler;

	VkCommandBuffer computeCmd[FRAME_OVERLAP];

	SceneData sceneData;
	vk::Buffer sceneDataBuffer;


	std::vector<Material> Materials;
	vk::Buffer MaterialsBuffer;

	std::vector<Sphere> Spheres;
	vk::Buffer SpheresBuffer;

	uint32_t samples = 1;
	uint32_t MaxBounceCount = 3;
	uint32_t RenderedFramesCount = 0;

	void Init();

	void CreateScreen(vec2 size);

	void DestroyScreen();

	void Resize(vec2 size);

	void Render(const Camera& camera);

	void UpdateMaterials();

	void Deinit();

	MaterialID PushMaterial()
	{
		Materials.push_back(Material());
		return Materials.size() - 1;
	}
};