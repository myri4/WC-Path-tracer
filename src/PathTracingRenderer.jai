#load "BufferManager.jai";
#load "ModelLoader.jai";

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

	projection = make_projection_matrix(radians(fov), aspectRatio, 0.1, 100.0);
	projection = transpose(projection);
	success, inverseProjection = inverse(projection);
	if !success log_error("Failed to inverse a projection matrix\n");
}

SceneData :: struct {
	// Camera
	inverseProjection: Matrix4;
	inverseView: Matrix4;
	position: Vector3;
	maxBounceCount: u32 = 3;
	samples: u32 = 1;
	sphereCount: u32;
	drawCommandCount: u32;

	renderedFramesCount: u32;

	boxID: u32;
}

MaterialType :: enum u32 {
	METAL      :: 0;
	DIELECTRIC :: 1;
}

Material :: struct {
	type: MaterialType;
	albedo: Vector3; @Color @Name=Albedo
	emission: Vector3; @Color @Name=Emission
	emissionStrength: float; @Name=Emission_Strength

	metallic: float; @Name=Metallic @Range[min=0,max=1]
	roughness: float; @Name=Roughness @Range[min=0,max=1]

 	absorption: Vector3; @Color @Name=Absorption
 	absorptionStrength: float = 1.0; @Name=Absorption_Strength
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


	materials: DBufferManager(Material, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay
	spheres: DBufferManager(Sphere, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay

	vertexBuffer: DBufferManager(Vector3, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay
	indexBuffer: DBufferManager(u32, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay
	bvhBuffer: DBufferManager(Node, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay

	drawCommandBuffer: DBufferManager(DrawCommand, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32)); @NoDisplay

	samples: u32 = 1;
	maxBounceCount: u32 = 3;
	renderedFramesCount: u32;
	boxID: u32;
}	

Node :: struct {
	min := Vector3.{FLOAT32_MAX, FLOAT32_MAX, FLOAT32_MAX};
	max := Vector3.{-FLOAT32_MAX, -FLOAT32_MAX, -FLOAT32_MAX};

	union {
		leftNode: u32;
		firstTriangleIndex: u32;
	}
	triangleCount: u32;
}
DrawCommand :: struct {
    vertexBuffer: VkDeviceAddress;
    indexBuffer: VkDeviceAddress;
    bvhBuffer: VkDeviceAddress;
    indexCount: u32;
}

trianglePositionBuffer: [..]Vector3;
triangleIndexBuffer: [..]u32;
bvh: [..]Node;
nodesUsed: u32;

UpdateNodeBounds :: (nodeIndex: u32) {
    node := *bvh[nodeIndex];
	i: u32;
	while i < node.triangleCount {
		index := node.firstTriangleIndex + i;
		a := trianglePositionBuffer[triangleIndexBuffer[index + 0]];
		b := trianglePositionBuffer[triangleIndexBuffer[index + 1]];
		c := trianglePositionBuffer[triangleIndexBuffer[index + 2]];

        node.min = min(node.min, a);
        node.min = min(node.min, b);
		node.min = min(node.min, c);
        
        node.max = max(node.max, a);
		node.max = max(node.max, b);
        node.max = max(node.max, c);
		i += 3;
    }
}

Subdivide :: (nodeIndex: u32, depth: u32 = 32) {
    node := *bvh[nodeIndex];
    if node.triangleCount <= 6 || depth == 0 return;

    extent := node.max - node.min;
    axis: s32;
    if extent.y > extent.x axis = 1;
    if extent.z > extent.component[axis] axis = 2;
    splitPos := node.min.component[axis] + extent.component[axis] * 0.5;
	
    i := node.firstTriangleIndex;
    j := i + node.triangleCount - 3;
    while i <= j {
        a := trianglePositionBuffer[triangleIndexBuffer[i + 0]].component[axis];
        b := trianglePositionBuffer[triangleIndexBuffer[i + 1]].component[axis];
        c := trianglePositionBuffer[triangleIndexBuffer[i + 2]].component[axis];
		if (a + b + c) / 3.0 < splitPos {
			i += 3;
		}
        else {
            swap(*triangleIndexBuffer[i + 0], *triangleIndexBuffer[j + 0]);
            swap(*triangleIndexBuffer[i + 1], *triangleIndexBuffer[j + 1]);
            swap(*triangleIndexBuffer[i + 2], *triangleIndexBuffer[j + 2]);
			j -= 3;
		}
    }
    leftCount := i - node.firstTriangleIndex;
    if leftCount == 0 || leftCount == node.triangleCount { return; }

	append(*bvh);
    leftChildIdx := nodesUsed;
	nodesUsed += 1;
	
	append(*bvh);
    rightChildIdx := nodesUsed;
	nodesUsed += 1;
	//print("% %\n", nodesUsed, bvh.count);
	
    bvh[leftChildIdx].firstTriangleIndex = node.firstTriangleIndex;
    bvh[leftChildIdx].triangleCount = leftCount;
    bvh[rightChildIdx].firstTriangleIndex = i;
    bvh[rightChildIdx].triangleCount = node.triangleCount - leftCount;
    node.leftNode = leftChildIdx;
    node.triangleCount = 0;

    UpdateNodeBounds(leftChildIdx);
    UpdateNodeBounds(rightChildIdx);

    Subdivide(leftChildIdx, depth - 1);
    Subdivide(rightChildIdx, depth - 1);
}

LoadModel :: (using renderer: *PathTracingRenderer) {
	success, model := parse_obj_file("assets/models/mushroom.obj");
	if success {
		for vertex : model.vertices {
			append(*vertexBuffer.data, vertex.position);
			append(*trianglePositionBuffer, vertex.position);
		}

		copy(*triangleIndexBuffer, model.indices);
		append(*bvh);
		bvh[0].triangleCount = xx triangleIndexBuffer.count;
		nodesUsed += 1;
		UpdateNodeBounds(0);
		Subdivide(0);
		copy(*indexBuffer.data, triangleIndexBuffer);

		print("% %\n", nodesUsed, bvh.count);
		
		copy(*bvhBuffer.data, bvh);

		free(trianglePositionBuffer);
		free(triangleIndexBuffer);
		free(model.vertices);
    	free(model.indices);
	}

	
	BeginImmediateSumbit(vk.UploadCommandBuffer);
		Update(*vertexBuffer, vk.UploadCommandBuffer);
		Update(*indexBuffer, vk.UploadCommandBuffer);
		Update(*bvhBuffer, vk.UploadCommandBuffer);

		append(*drawCommandBuffer.data, .{
			vertexBuffer = GetDeviceAddress(vertexBuffer.buffer),
			indexBuffer = GetDeviceAddress(indexBuffer.buffer),
			bvhBuffer = GetDeviceAddress(bvhBuffer.buffer),
			indexCount = xx triangleIndexBuffer.count
		});
		Update(*drawCommandBuffer, vk.UploadCommandBuffer);

		
        SetObjectName(vertexBuffer.buffer.handle, "PathTracer.vertexBuffer");
        SetObjectName(indexBuffer.buffer.handle, "PathTracer.indexBuffer");
        SetObjectName(bvhBuffer.buffer.handle, "PathTracer.bvhBuffer");
        SetObjectName(drawCommandBuffer.buffer.handle, "PathTracer.drawCommandBuffer");

        SetObjectName(vertexBuffer.stagingBuffer.handle, "PathTracer.vertexBuffer");
        SetObjectName(indexBuffer.stagingBuffer.handle, "PathTracer.indexBuffer");
        SetObjectName(bvhBuffer.stagingBuffer.handle, "PathTracer.bvhBuffer");
        SetObjectName(drawCommandBuffer.stagingBuffer.handle, "PathTracer.drawCommandBuffer");
	EndImmediateSumbit(vk.UploadCommandBuffer);
}

Init :: (using renderer: *PathTracingRenderer) {
	LoadModel(renderer);

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

	glass := PushMaterial(renderer);
	Ground := PushMaterial(renderer);
	materials.data[Ground].albedo = .{0.8, 0.8, 0.0};
	materials.data[Ground].roughness = 1.0;

	Left := PushMaterial(renderer);
	materials.data[Left].emission = .{0.8, 0.8, 0.8} * 2.0;

	Right := PushMaterial(renderer);
	SetMetal(*materials.data[Right], .{0.8, 0.6, 0.2}, 0.75, 0.02);

	SetDielectric(*materials.data[glass], .{0.0, 0.5, 1.0}, 0.07, 1.5);


	append(*spheres.data, .{.{0.0, 0.0, -1.0}, 0.5, glass});
	append(*spheres.data, .{.{-1.0, 0.0, -1.0}, 0.5, Left});
	append(*spheres.data, .{.{1.0, 0.0, -1.0}, 0.5, Right});
	append(*spheres.data, .{.{0.0, -100.5, -1.0}, 100.0, Ground});


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
	renderedFramesCount = 0;
}

Render :: (using renderer: *PathTracingRenderer, camera: Camera) {
	cmd := computeCmd[vk.CURRENT_FRAME_INDEX];
	vkResetCommandBuffer(cmd, 0);

	begInfo := VkCommandBufferBeginInfo.{ flags = .ONE_TIME_SUBMIT_BIT };

	vkBeginCommandBuffer(cmd, *begInfo);

	vkCmdBindPipeline(cmd, .COMPUTE, pipeline.handle);
	vkCmdBindDescriptorSets(cmd, .COMPUTE, pipeline.layout, 0, 1, *descriptorSet, 0, null);

	sceneData = .{
		sphereCount = xx spheres.data.count,

		drawCommandCount = xx drawCommandBuffer.data.count,

		inverseProjection = camera.inverseProjection,
		inverseView = camera.inverseView,
		position = camera.position,
		samples = samples,
		maxBounceCount = maxBounceCount,
		renderedFramesCount = renderedFramesCount,
		boxID = boxID,
	};
	renderedFramesCount += 1;

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

		drawCommandBP: VkDeviceAddress;
	};
	data.sdp = GetDeviceAddress(sceneDataBuffer);
	data.mbp = GetDeviceAddress(materials.buffer);
	data.sphereBP = GetDeviceAddress(spheres.buffer);

	data.drawCommandBP = GetDeviceAddress(drawCommandBuffer.buffer);
	
	vkCmdPushConstants(cmd, pipeline.layout, .COMPUTE_BIT, 0, size_of(type_of(data)), *data);

	workGroupSize := renderSize / Vector2.{ComputeWorkGroupSize, ComputeWorkGroupSize};
	vkCmdDispatch(cmd, xx ceil(workGroupSize.x), xx ceil(workGroupSize.y), 1);

	vkEndCommandBuffer(cmd);

	Submit(cmd, vk.computeQueue);
}

UpdateMaterials :: (using renderer: *PathTracingRenderer) {
	BeginImmediateSumbit(vk.UploadCommandBuffer);
		Update(*materials, vk.UploadCommandBuffer);
		Update(*spheres, vk.UploadCommandBuffer);

        SetObjectName(materials.buffer.handle, "PathTracer.Materials");
        SetObjectName(spheres.buffer.handle, "PathTracer.Spheres");

		SetObjectName(materials.stagingBuffer.handle, "PathTracer.materials");
        SetObjectName(spheres.stagingBuffer.handle, "PathTracer.spheres");

	EndImmediateSumbit(vk.UploadCommandBuffer);
}

Deinit :: (using renderer: *PathTracingRenderer) {
	DestroyScreen(renderer);
	Destroy(pipeline);
	Destroy(*screenSampler);

	Free(*materials);
	Free(*spheres);

	Free(*vertexBuffer);
	Free(*indexBuffer);
	Free(*bvhBuffer);

	free(bvh);
	
	Free(*sceneDataBuffer);
}

PushMaterial :: (using renderer: *PathTracingRenderer) -> MaterialID {
	append(*materials.data);

	return xx (materials.data.count - 1);
}