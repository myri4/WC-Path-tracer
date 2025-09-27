#include "PathTracingRenderer.h"

#include "../imgui_backend/imgui_impl_vulkan.h"

using namespace glm;

void PathTracingRenderer::Init()
{
	for (uint32_t i = 0; i < FRAME_OVERLAP; i++)
	{
		//vk::SyncContext::GraphicsCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, Cmd[i]);
		vk::SyncContext::ComputeCommandPool.Allocate(VK_COMMAND_BUFFER_LEVEL_PRIMARY, computeCmd[i]);
	}

	pipeline.Create("assets/shaders/pathTracer.comp");
	vk::descriptorAllocator.Allocate(descriptorSet, pipeline.descriptorLayout);

	screenSampler.Create({
		.magFilter = vk::Filter::LINEAR,
		.minFilter = vk::Filter::LINEAR,
		.mipmapMode = vk::SamplerMipmapMode::LINEAR,
		.addressModeU = vk::SamplerAddressMode::CLAMP_TO_EDGE,
		.addressModeV = vk::SamplerAddressMode::CLAMP_TO_EDGE,
		.addressModeW = vk::SamplerAddressMode::CLAMP_TO_EDGE,
		});

	sceneDataBuffer.Allocate(sizeof(SceneData), vk::DEVICE_ADDRESS);
	sceneDataBuffer.SetName("SceneDataBuffer");

	auto Ground = PushMaterial();
	Materials[Ground].albedo = glm::vec3(0.8, 0.8, 0.0);
	Materials[Ground].roughness = 1.f;

	auto Center = PushMaterial();
	Materials[Center].albedo = glm::vec3(0.7, 0.3, 0.3);

	auto Left = PushMaterial();
	Materials[Left].emission = glm::vec3(0.8, 0.8, 0.8) * 2.f;

	auto Right = PushMaterial();
	Materials[Right].SetMetal(glm::vec3(0.8, 0.6, 0.2), 0.75f, 0.02f);

	auto glass = PushMaterial();
	Materials[glass].SetDielectric(glm::vec3(0.f, 0.5f, 05.f), 0.07f, 1.5f);


	Spheres.push_back(Sphere(glm::vec3(0.0, 0.0, -1.0), 0.5, glass));
	Spheres.push_back(Sphere(glm::vec3(-1.0, 0.0, -1.0), 0.5, Left));
	Spheres.push_back(Sphere(glm::vec3(1.0, 0.0, -1.0), 0.5, Right));
	Spheres.push_back(Sphere(glm::vec3(0.f, -100.5f, -1.f), 100.f, Ground));


	MaterialsBuffer.Allocate(sizeof(Material) * Materials.size(), vk::DEVICE_ADDRESS); // @TODO: Make this resizeable
	SpheresBuffer.Allocate(sizeof(Sphere) * Spheres.size(), vk::DEVICE_ADDRESS); // @TODO: Make this resizeable

	UpdateMaterials();
}

void PathTracingRenderer::UpdateMaterials()
{
	vk::StagingBuffer matSB;
	matSB.Allocate(sizeof(Material) * Materials.size());
	matSB.SetData(Materials.data(), sizeof(Material) * Materials.size());

	vk::StagingBuffer sphereSB;
	sphereSB.Allocate(sizeof(Sphere) * Spheres.size());
	sphereSB.SetData(Spheres.data(), sizeof(Sphere) * Spheres.size());

	vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer commandBuffer) {
		MaterialsBuffer.SetData(commandBuffer, matSB, sizeof(Material) * Materials.size());
		SpheresBuffer.SetData(commandBuffer, sphereSB, sizeof(Sphere) * Spheres.size());
		});

	matSB.Free();
	sphereSB.Free();
}

void PathTracingRenderer::CreateScreen(glm::vec2 size)
{
	renderSize = size;

	{
		outputImage.Create({
			.format = VK_FORMAT_R32G32B32A32_SFLOAT,
			.width = (uint32_t)renderSize.x,
			.height = (uint32_t)renderSize.y,
			.usage = VK_IMAGE_USAGE_STORAGE_BIT | VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_TRANSFER_SRC_BIT/*| VK_IMAGE_USAGE_STORAGE_BIT*/,
			});
		outputImage.SetName("PathTracingRenderer::outputImage");

		outputImageView.Create(outputImage);
		outputImageView.SetName("PathTracingRenderer::outputImageView");
	}

	vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
		outputImage.SetLayout(cmd, VK_IMAGE_ASPECT_COLOR_BIT, VK_IMAGE_LAYOUT_UNDEFINED, VK_IMAGE_LAYOUT_GENERAL);
		});

	vk::DescriptorWriter writer(descriptorSet);
	writer.BindImage(0, screenSampler, outputImageView, VK_IMAGE_LAYOUT_GENERAL, VK_DESCRIPTOR_TYPE_STORAGE_IMAGE);

	ImguiImageID = MakeImGuiDescriptor(ImguiImageID, { screenSampler, outputImageView, VK_IMAGE_LAYOUT_GENERAL });
}

void PathTracingRenderer::DestroyScreen()
{
	outputImage.Destroy();
	outputImageView.Destroy();
}

void PathTracingRenderer::Resize(glm::vec2 size)
{
	DestroyScreen();
	CreateScreen(size);
}

void PathTracingRenderer::Render(const Camera& camera)
{
	wc::CommandEncoder cmd;
	cmd.BindShader(pipeline);
	cmd.BindDescriptorSet(descriptorSet);

	sceneData = {
		.SphereCount = (uint32_t)Spheres.size(),
		.inverseProjection = camera.inverseProjection,
		.inverseView = camera.inverseView,
		.position = camera.position,
		.Samples = samples,
		.MaxBounceCount = MaxBounceCount,
		.RenderedFramesCount = RenderedFramesCount,
	};
	RenderedFramesCount++;

	vk::StagingBuffer stagingBuffer;
	stagingBuffer.Allocate(sizeof(SceneData));
	stagingBuffer.SetData(&sceneData, sizeof(sceneData));

	vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer commandBuffer) {
		sceneDataBuffer.SetData(commandBuffer, stagingBuffer, sizeof(SceneData));
	});

	stagingBuffer.Free();

	struct
	{
		VkDeviceAddress sdp;
		VkDeviceAddress mbp;
		VkDeviceAddress sphereBP;
	}data;
	data.sdp = sceneDataBuffer.GetDeviceAddress();
	data.mbp = MaterialsBuffer.GetDeviceAddress();
	data.sphereBP = SpheresBuffer.GetDeviceAddress();
	cmd.PushConstants(data);

	cmd.Dispatch(glm::ceil((glm::vec2)renderSize / glm::vec2(ComputeWorkGroupSize)));
	cmd.ExecuteCompute(computeCmd[CURRENT_FRAME]);
}

void PathTracingRenderer::Deinit()
{
	DestroyScreen();
	pipeline.Destroy();
	screenSampler.Destroy();

	MaterialsBuffer.Free();
	SpheresBuffer.Free();
	sceneDataBuffer.Free();
}