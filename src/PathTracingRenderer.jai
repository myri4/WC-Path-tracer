#load "BufferManager.jai";

ComputeWorkGroupSize :: 4;

Camera :: struct {	
	position := Vector3.{0.0, 0.0, 0.0};
	direction := Vector3.{0.0, 0.0, -1.0};

	yaw: float;
	pitch: float;

	fov: float = 90.0;

	projection: Matrix4; @NoDisplay
	view: Matrix4; @NoDisplay

	inverseProjection: Matrix4; @NoDisplay
	inverseView: Matrix4; @NoDisplay
}

Update :: (using cam: *Camera, aspectRatio: float = 16.0 / 9.0) {
	rYaw := radians(yaw);
	rPitch := radians(pitch);
	cosPitch := cos(rPitch);
	direction = normalize(Vector3.{ cos(rYaw) * cosPitch, sin(rPitch), sin(rYaw) * cosPitch });

	view = transpose(make_look_at_matrix(position, position + direction, .{0.0, 1.0, 0.0}, false));
	success:, inverseView = inverse(view);
	if !success log_error("Failed to inverse a view matrix\n");

	projection = transpose(make_projection_matrix(radians(fov), aspectRatio, 0.1, 100.0));
	success, inverseProjection = inverse(projection);
	if !success log_error("Failed to inverse a projection matrix\n");
}

SceneData :: struct {
	// Camera
	inverseProjection: Matrix4;
	inverseView: Matrix4;
	position: Vector3;
	MaxBounceCount: u32 = 3;
	Samples: u32 = 1;
	SphereCount: u32;
	RenderedFramesCount: u32;
}

MaterialType :: enum u32 {
	METAL      :: 0;
	DIELECTRIC :: 1;
}

Material :: struct {
	type: MaterialType;
	albedo: Vector3; @Color @Name=Albedo
	emission: Vector3; @Color @Name=Emission

	metallic: float; @Name=Metallic @Range[min=0,max=1]
	roughness: float; @Name=Roughness @Range[min=0,max=1]
 	ior: float = 1.0; @Name=Index_of_refraction // @Range[min=1]
}

SetMetal :: (using mat: *Material, a: Vector3, r: float, sp: float) {
	albedo = a;
	roughness = r;
	metallic = sp;
}

SetDielectric :: (using mat: *Material, color: Vector3, r: float, index_of_refraction: float) {
	albedo = color;
	roughness = r;
	ior = index_of_refraction;
}

MaterialID :: u32;

Sphere :: struct {
	position: Vector3; @Name=Position
	radius: float; @Name=Radius
	mat: MaterialID; @NoDisplay
}

PathTracingRenderer :: struct {
	renderSize: Vector2; @NoEdit

	pipeline: vk.Pipeline; @NoDisplay
	descriptorSet: VkDescriptorSet; @NoDisplay
	ImguiImageID: VkDescriptorSet; @NoDisplay

	outputImage: vk.Image; @NoDisplay
	outputImageView: VkImageView; @NoDisplay

	screenSampler: VkSampler; @NoDisplay

	computeCmd: [vk.FRAME_OVERLAP]VkCommandBuffer; @NoDisplay

	sceneData: SceneData; @NoDisplay
	sceneDataBuffer: vk.Buffer; @NoDisplay


	Materials: DBufferManager(Material, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay

	Spheres: DBufferManager(Sphere, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay

	samples: u32 = 1;
	MaxBounceCount: u32 = 3;
	RenderedFramesCount: u32;
}

Init :: (using renderer: *PathTracingRenderer) {
	{
		push_allocator(temp);
		defer reset_temporary_storage();

		{
			cmdAllocInfo := VkCommandBufferAllocateInfo.{ 
				commandBufferCount = 1,
				level = .PRIMARY,        
			};

			for i: 0..vk.FRAME_OVERLAP - 1
			{
				//cmdAllocInfo.commandPool = vk.GraphicsCommandPool;
				//vkAllocateCommandBuffers(vk.logicalDevice, *cmdAllocInfo, *cmd[i]);
				cmdAllocInfo.commandPool = vk.ComputeCommandPool;
				vkAllocateCommandBuffers(vk.logicalDevice, *cmdAllocInfo, *computeCmd[i]);
			}
		}

		{
			createInfo := vk.ComputePipelineCreateInfo.{
				//bindingFlags = .[.VARIABLE_DESCRIPTOR_COUNT_BIT | .PARTIALLY_BOUND_BIT],

				dynamicDescriptorCount = true,
			};		

			success:, createInfo.binary = vk.load_spirv_binary("assets/shaders/pathTracer.comp");
			if !success return;

			success, pipeline = vk.CreatePipeline(createInfo);
			if !success return;
		}
		vk.AllocateDescriptorSet(*descriptorSet, pipeline.descriptorLayout);

		vk.Create(*screenSampler, .{
			magFilter = .LINEAR,
			minFilter = .LINEAR,
			mipmapMode = .LINEAR,
			addressModeU = .CLAMP_TO_EDGE,
			addressModeV = .CLAMP_TO_EDGE,
			addressModeW = .CLAMP_TO_EDGE,
		});

		vk.AllocateGPUBuffer(*sceneDataBuffer, size_of(SceneData), .SHADER_DEVICE_ADDRESS_BIT);
		vk.SetObjectName(sceneDataBuffer.handle, "SceneDataBuffer");
	}

	Ground := PushMaterial(renderer);
	Materials.data[Ground].albedo = .{0.8, 0.8, 0.0};
	Materials.data[Ground].roughness = 1.0;

	Left := PushMaterial(renderer);
	Materials.data[Left].emission = .{0.8, 0.8, 0.8} * 2.0;

	Right := PushMaterial(renderer);
	SetMetal(*Materials.data[Right], .{0.8, 0.6, 0.2}, 0.75, 0.02);

	glass := PushMaterial(renderer);
	SetDielectric(*Materials.data[glass], .{0.0, 0.5, 1.0}, 0.07, 1.5);


	append(*Spheres.data, .{.{0.0, 0.0, -1.0}, 0.5, glass});
	append(*Spheres.data, .{.{-1.0, 0.0, -1.0}, 0.5, Left});
	append(*Spheres.data, .{.{1.0, 0.0, -1.0}, 0.5, Right});
	append(*Spheres.data, .{.{0.0, -100.5, -1.0}, 100.0, Ground});

	UpdateMaterials(renderer);
}


CreateScreen :: (using renderer: *PathTracingRenderer, size: Vector2) {
	renderSize = size;

	{
		result := vk.Create(*outputImage, .{
			format = .R32G32B32A32_SFLOAT,
			width = xx renderSize.x,
			height = xx renderSize.y,
			usage = .STORAGE_BIT | .SAMPLED_BIT | .TRANSFER_SRC_BIT,
		});

		if result != .SUCCESS {
			print("Failed creating an image with result '%'", result);
			return;
		}
		vk.SetObjectName(outputImage.handle, "PathTracingRenderer.outputImage");

		vk.Create(*outputImageView, outputImage);
		vk.SetObjectName(outputImageView, "PathTracingRenderer.outputImageView");
	}

	{
		vk.BeginImmediateSumbit(vk.UploadCommandBuffer);
		imageMemoryBarrier := vk.GenerateImageMemoryBarier(outputImage.handle, .UNDEFINED, .GENERAL, .{ aspectMask = .COLOR_BIT, levelCount = 1, layerCount = 1});

		vkCmdPipelineBarrier(vk.UploadCommandBuffer, .ALL_COMMANDS_BIT, .ALL_COMMANDS_BIT, 0, 0, null, 0, null, 1, *imageMemoryBarrier);
		vk.EndImmediateSumbit(vk.UploadCommandBuffer);
	}

	imageInfo := VkDescriptorImageInfo.{screenSampler, outputImageView, .GENERAL};
	write := VkWriteDescriptorSet .{
		dstSet = descriptorSet,
		dstBinding = 0,
		descriptorType = .STORAGE_IMAGE,
		descriptorCount = 1,
		pImageInfo = *imageInfo,
	};
	vkUpdateDescriptorSets(vk.logicalDevice, 1, *write, 0, null);

	ImguiImageID = ImGui.ImplVulkan_AddTexture(screenSampler, outputImageView, .GENERAL);
}

DestroyScreen :: (using renderer: *PathTracingRenderer) {
	Destroy(*outputImage);
	Destroy(*outputImageView);
	ImGui.ImplVulkan_RemoveTexture(ImguiImageID);
}

Resize :: (using renderer: *PathTracingRenderer, size: Vector2) {
	DestroyScreen(renderer);
	CreateScreen(renderer, size);
	RenderedFramesCount = 0;
}

Render :: (using renderer: *PathTracingRenderer, camera: Camera) {
	cmd := computeCmd[vk.CURRENT_FRAME_INDEX];
	vkResetCommandBuffer(cmd, 0);

	begInfo := VkCommandBufferBeginInfo.{ flags = .ONE_TIME_SUBMIT_BIT };

	vkBeginCommandBuffer(cmd, *begInfo);

	vkCmdBindPipeline(cmd, .COMPUTE, pipeline.handle);
	vkCmdBindDescriptorSets(cmd, .COMPUTE, pipeline.layout, 0, 1, *descriptorSet, 0, null);

	sceneData = .{
		SphereCount = xx Spheres.data.count,
		inverseProjection = camera.inverseProjection,
		inverseView = camera.inverseView,
		position = camera.position,
		Samples = samples,
		MaxBounceCount = MaxBounceCount,
		RenderedFramesCount = RenderedFramesCount,
	};
	RenderedFramesCount += 1;

	stagingBuffer: vk.Buffer;
	AllocateStagingBuffer(*stagingBuffer, size_of(SceneData));
	SetData(stagingBuffer, *sceneData, size_of(SceneData));

	BeginImmediateSumbit(vk.UploadCommandBuffer);
		bufCopy := VkBufferCopy.{ size = xx size_of(SceneData) };
		vkCmdCopyBuffer(vk.UploadCommandBuffer, stagingBuffer.handle, sceneDataBuffer.handle, 1, *bufCopy);
	EndImmediateSumbit(vk.UploadCommandBuffer);

	Free(*stagingBuffer);

	data: struct {
		sdp: VkDeviceAddress;
		mbp: VkDeviceAddress;
		sphereBP: VkDeviceAddress;
	};
	data.sdp = GetDeviceAddress(sceneDataBuffer);
	data.mbp = GetDeviceAddress(Materials.buffer);
	data.sphereBP = GetDeviceAddress(Spheres.buffer);
	
	vkCmdPushConstants(cmd, pipeline.layout, .COMPUTE_BIT, 0, size_of(type_of(data)), *data);

	workGroupSize := renderSize / Vector2.{ComputeWorkGroupSize, ComputeWorkGroupSize};
	vkCmdDispatch(cmd, xx ceil(workGroupSize.x), xx ceil(workGroupSize.y), 1);

	vkEndCommandBuffer(cmd);

	Submit(cmd, vk.computeQueue);
}

UpdateMaterials :: (using renderer: *PathTracingRenderer) {
	BeginImmediateSumbit(vk.UploadCommandBuffer);
		Update(*Materials, vk.UploadCommandBuffer);
		Update(*Spheres, vk.UploadCommandBuffer);
		
        SetObjectName(Materials.buffer.handle, "PathTracer.Materials");
        SetObjectName(Spheres.buffer.handle, "PathTracer.Spheres");

		SetObjectName(Materials.stagingBuffer.handle, "PathTracer.Materials");
        SetObjectName(Spheres.stagingBuffer.handle, "PathTracer.Spheres");
	EndImmediateSumbit(vk.UploadCommandBuffer);
}

Deinit :: (using renderer: *PathTracingRenderer) {
	DestroyScreen(renderer);
	Destroy(pipeline);
	Destroy(*screenSampler);

	Free(*Materials);
	Free(*Spheres);
	Free(*sceneDataBuffer);
}

PushMaterial :: (using renderer: *PathTracingRenderer) -> MaterialID {
	append(*Materials.data);

	return xx (Materials.data.count - 1);
}