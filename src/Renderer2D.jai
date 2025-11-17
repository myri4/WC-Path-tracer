Renderer2D :: struct // @TODO: Rename this
{
	renderSize: Vector2; // @NOTE: why is this a float vec2?

	// Rendering
	framebuffer: VkFramebuffer;
	renderPass: VkRenderPass;

	outputImage: vk.Image;
	outputImageView: VkImageView;

	depthImage: vk.Image;
	depthImageView: VkImageView;

	shader: vk.Pipeline;
	descriptorSet: VkDescriptorSet;
	textureCapacity: u32 = 0;

	lineShader: vk.Pipeline;

	// Post processing
	// bloom: BloomPass;
	// composite: CompositePass;
	// crt: CRTPass;

	finalImage: [2]vk.Image;
	finalImageView: [2]VkImageView;
	screenSampler: VkSampler;

	cmd: [vk.FRAME_OVERLAP]VkCommandBuffer;
	computeCmd: [vk.FRAME_OVERLAP]VkCommandBuffer;
	imguiImageID: VkDescriptorSet = VK_NULL_HANDLE;
}

Init :: (using renderer: *Renderer2D)
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
			cmdAllocInfo.commandPool = vk.GraphicsCommandPool;
			vkAllocateCommandBuffers(vk.logicalDevice, *cmdAllocInfo, *cmd[i]);
			cmdAllocInfo.commandPool = vk.ComputeCommandPool;
			vkAllocateCommandBuffers(vk.logicalDevice, *cmdAllocInfo, *computeCmd[i]);
		}
	}

	{
		attachmentDescriptions := VkAttachmentDescription.[
			.{
				format = .R32G32B32A32_SFLOAT, // @WARNING: if the image format is changed this should also be changed
				samples = ._1_BIT,
				loadOp = .CLEAR,
				storeOp = .STORE,
				stencilLoadOp = .DONT_CARE,
				stencilStoreOp = .DONT_CARE,
				initialLayout = .UNDEFINED,
				finalLayout = .GENERAL,
			},
			.{
				format = .D32_SFLOAT, // @WARNING: if the image format is changed this should also be changed
				samples = ._1_BIT,
				loadOp = .CLEAR,
				storeOp = .STORE,
				stencilLoadOp = .CLEAR,
				stencilStoreOp = .DONT_CARE,
				initialLayout = .UNDEFINED,
				finalLayout = .DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
			}
		];

		colorReferences: [..]VkAttachmentReference;

		append(*colorReferences, .{ 0, .COLOR_ATTACHMENT_OPTIMAL });

		depthAttachmentRef := VkAttachmentReference.{ 1, .DEPTH_STENCIL_ATTACHMENT_OPTIMAL };
		subpass := VkSubpassDescription.{
			pipelineBindPoint = .GRAPHICS,
			colorAttachmentCount = cast(u32)colorReferences.count,
			pColorAttachments = colorReferences.data,

			pDepthStencilAttachment = *depthAttachmentRef,
		};

		dependencies := VkSubpassDependency.[
			.{
				srcSubpass = VK_SUBPASS_EXTERNAL,
				dstSubpass = 0,
				srcStageMask = .BOTTOM_OF_PIPE_BIT,
				dstStageMask = .COLOR_ATTACHMENT_OUTPUT_BIT,
				srcAccessMask = .MEMORY_READ_BIT,
				dstAccessMask = .COLOR_ATTACHMENT_READ_BIT | .COLOR_ATTACHMENT_WRITE_BIT,
				dependencyFlags = .BY_REGION_BIT,
			},
			.{
				srcSubpass = VK_SUBPASS_EXTERNAL,
				dstSubpass = 0,
				srcStageMask = .EARLY_FRAGMENT_TESTS_BIT | .LATE_FRAGMENT_TESTS_BIT,
				dstStageMask = .EARLY_FRAGMENT_TESTS_BIT | .LATE_FRAGMENT_TESTS_BIT,
				srcAccessMask = 0,
				dstAccessMask = .DEPTH_STENCIL_ATTACHMENT_WRITE_BIT,
			},
		];

		vk.Create(*renderPass, .{
			attachmentCount = attachmentDescriptions.count,
			pAttachments = attachmentDescriptions.data,
			subpassCount = 1,
			pSubpasses = *subpass,
			dependencyCount = dependencies.count,
			pDependencies = dependencies.data,
		});
	}

	dynamicStates := VkDynamicState.[.VIEWPORT, .SCISSOR];

	blending := VkPipelineColorBlendAttachmentState.{
		blendEnable = VK_FALSE,
		srcColorBlendFactor = .SRC_ALPHA,
		dstColorBlendFactor = .ONE_MINUS_SRC_ALPHA,

		colorBlendOp = .ADD,
		srcAlphaBlendFactor = .SRC_ALPHA,
		dstAlphaBlendFactor = .ONE_MINUS_SRC_ALPHA,
		alphaBlendOp = .ADD,

		colorWriteMask = .R_BIT | .G_BIT | .B_BIT | .A_BIT,
	};

	blendAttachments := VkPipelineColorBlendAttachmentState.[blending];

	{
		createInfo := vk.PipelineCreateInfo.{
			renderPass = renderPass,
			bindingFlags = .[.VARIABLE_DESCRIPTOR_COUNT_BIT | .PARTIALLY_BOUND_BIT],

			depthTest = true,
			dynamicDescriptorCount = true,
			
			dynamicStates = dynamicStates,
			blendAttachments = blendAttachments,
		};		

		success:, createInfo.binaries[0] = vk.load_spirv_binary("assets/shaders/Renderer2D.vert");
		if !success return;
		success, createInfo.binaries[1] = vk.load_spirv_binary("assets/shaders/Renderer2D.frag");
		if !success return;

		success, shader = vk.CreatePipeline(createInfo);
		if !success return;
	}

	{
		createInfo := vk.PipelineCreateInfo.{
			renderPass = renderPass,

			depthTest = true,

			topology = .LINE_LIST,

			dynamicStates = dynamicStates,
			blendAttachments = blendAttachments,
		};

		success:, createInfo.binaries[0] = vk.load_spirv_binary("assets/shaders/Line.vert");
		if !success return;
		success, createInfo.binaries[1] = vk.load_spirv_binary("assets/shaders/Line.frag");
		if !success return;

		success, lineShader = vk.CreatePipeline(createInfo);
	}
}

AllocateNewDescriptor :: (using renderer: *Renderer2D, count: u32)
{
	textureCapacity = count;
	
	if descriptorSet
		vkFreeDescriptorSets(vk.logicalDevice, vk.DescriptorAllocator.CurrentPool, 1, *descriptorSet);

	set_counts := VkDescriptorSetVariableDescriptorCountAllocateInfo.{
		descriptorSetCount = 1,
		pDescriptorCounts = *count,
	};
	vk.AllocateDescriptorSet(*descriptorSet, shader.descriptorLayout, *set_counts, set_counts.descriptorSetCount);
}

UpdateTextures :: (using renderer: *Renderer2D, assetManager: AssetManager)
{
	push_allocator(temp);
    defer reset_temporary_storage();
	infos: [..]VkDescriptorImageInfo;
	for image : assetManager.Textures
		array_add(*infos, .{image.sampler, image.view, .SHADER_READ_ONLY_OPTIMAL});

	write := VkWriteDescriptorSet.{
		dstSet = descriptorSet,
		dstBinding = 0,
		descriptorCount = xx infos.count,
		descriptorType = .COMBINED_IMAGE_SAMPLER,
		pImageInfo = infos.data,
	};

	vkUpdateDescriptorSets(vk.logicalDevice, 1, *write, 0, null);
}

CreateScreen :: (using renderer: *Renderer2D, size: Vector2)
{
	renderSize = size;

	{
		result := vk.Create(*outputImage, .{
			format = .R32G32B32A32_SFLOAT,
			width = xx renderSize.x,
			height = xx renderSize.y,
			usage = .COLOR_ATTACHMENT_BIT | .SAMPLED_BIT | .TRANSFER_SRC_BIT/*| .STORAGE_BIT*/,
		});

		if result != .SUCCESS
		{
			print("Failed creating an image with result '%'", result);
			return;
		}
		vk.SetObjectName(outputImage.handle, "Renderer2D.outputImage");

		vk.Create(*outputImageView, outputImage);
		vk.SetObjectName(outputImageView, "Renderer2D.outputImageView");
	}

	{
		result := vk.Create(*depthImage, .{
			format = .D32_SFLOAT,
			width = xx renderSize.x,
			height = xx renderSize.y,
			usage = .DEPTH_STENCIL_ATTACHMENT_BIT,
			});

		if result != .SUCCESS
		{
			print("Failed creating a depth image with result '%'", result);
			return;
		}
		vk.SetObjectName(depthImage.handle, "Renderer2D.depthImage");

		vk.Create(*depthImageView, depthImage);
		vk.SetObjectName(depthImageView, "Renderer2D.depthImageView");
	}

	attachments := VkImageView.[outputImageView, depthImageView];
	vk.Create(*framebuffer, .{
		renderPass = renderPass,
		attachmentCount = attachments.count,
		pAttachments = attachments.data,
		width = xx renderSize.x,
		height = xx renderSize.y,
		layers = 1,
	});

	for * image, i : finalImage
	{
		result := vk.Create(image, .{
			format = .R32G32B32A32_SFLOAT,
			width = xx renderSize.x,
			height = xx renderSize.y,
			usage = .SAMPLED_BIT | .STORAGE_BIT | .TRANSFER_SRC_BIT,
		});

		if result != .SUCCESS
		{
			print("Failed creating a finalImage[%] image with result '%'", i, result);
			return;
		}

		vk.SetObjectName(image.handle, tprint("Renderer2D.finalImage[%]", i));
		
		vk.Create(*finalImageView[i], image.*);
		vk.SetObjectName(finalImageView[i], tprint("Renderer2D.finalImageView[%]", i));
	}

	vk.BeginImmediateSumbit(vk.UploadCommandBuffer);
	for image : finalImage
	{
		imageMemoryBarrier := vk.GenerateImageMemoryBarier(image.handle, .UNDEFINED, .GENERAL, .{
			aspectMask = .COLOR_BIT,
			levelCount = 1,
			layerCount = 1,
		});

		vkCmdPipelineBarrier(vk.UploadCommandBuffer, .ALL_COMMANDS_BIT, .ALL_COMMANDS_BIT, 0, 0, null, 0, null, 1, *imageMemoryBarrier);
	}
	vk.EndImmediateSumbit(vk.UploadCommandBuffer);

	//bloom.CreateImages(renderSize, m_OutputImage.GetMipLevelCount());

	// For now we are using the same sampler for sampling the screen and the bloom images but maybe it should be separated
	vk.Create(*screenSampler, .{
		magFilter = .LINEAR,
		minFilter = .LINEAR,
		mipmapMode = .LINEAR,
		addressModeU = .CLAMP_TO_EDGE,
		addressModeV = .CLAMP_TO_EDGE,
		addressModeW = .CLAMP_TO_EDGE,
	});

	/*int m_PassCount = 0; // @NOTE: Not sure if this is working properly
	int m_FinalPass = 0;

	auto GetImageBuffer = [&]()
		{
			m_FinalPass = m_PassCount++ % 2;
			return m_FinalImageView[m_FinalPass];
		};

	bloom.SetUp(m_OutputImageView);
	composite.SetUp(m_ScreenSampler, GetImageBuffer(), m_OutputImageView, bloom.GetOutput());
	{

		auto output = GetImageBuffer();
		auto input = GetImageBuffer();
		crt.SetUp(m_ScreenSampler, output, input);
	}*/

	imguiImageID = ImGui.ImplVulkan_AddTexture(screenSampler, outputImageView, .GENERAL);
}

Resize :: (using renderer: *Renderer2D, newSize: Vector2)
{
	DestroyScreen(renderer);
	CreateScreen(renderer, newSize);
}

DestroyScreen :: (using renderer: *Renderer2D)
{
	Destroy(*framebuffer);

	Destroy(*outputImage);
	Destroy(*outputImageView);

	ImGui.ImplVulkan_RemoveTexture(imguiImageID);

	Destroy(*depthImage);
	Destroy(*depthImageView);

	Destroy(*screenSampler);

	for * image, i : finalImage
	{
		Destroy(image);
		Destroy(*finalImageView[i]);
	}

	//bloom.DestroyImages();
}

Deinit :: (using renderer: *Renderer2D)
{
	/*bloom.Deinit();
	composite.Deinit();
	crt.Deinit();*/

	vk.Destroy(shader);
	vk.Destroy(lineShader);

	DestroyScreen(renderer);

	vk.Destroy(*renderPass);
}

Flush :: (using,except(cmd) renderer: *Renderer2D, using renderData: *RenderData, viewProj: Matrix4)
{
	//if (!m_IndexCount && !m_LineVertexCount) return;

	{
		cmd := renderer.cmd[vk.CURRENT_FRAME_INDEX];
		vkResetCommandBuffer(cmd, 0);

		begInfo := VkCommandBufferBeginInfo.{ flags = .ONE_TIME_SUBMIT_BIT };

		vkBeginCommandBuffer(cmd, *begInfo);
		clearValues := VkClearValue.[
			.{color._float32 = .[0.0, 0.0, 0.0, 1.0]},
			.{depthStencil.depth = 1.0},
		];

		extent := VkExtent2D.{ renderSize.x.(u32), renderSize.y.(u32) };
		rpInfo := VkRenderPassBeginInfo.{
			renderPass = renderPass,
			framebuffer = framebuffer,
			clearValueCount = clearValues.count,
			pClearValues = clearValues.data,
			renderArea.extent = extent,
		};		

		vkCmdBeginRenderPass(cmd, *rpInfo, .INLINE);

		viewport := VkViewport.{
			//.y = createInfo.renderSize.y; // change this to 0 to invert
			width = renderSize.x,
			height = renderSize.y,
			//height = -createInfo.renderSize.y; // remove the - to invert
			maxDepth = 1.0,
		};

		scissor := VkRect2D.{ extent = extent };

		vkCmdSetViewport(cmd, 0, 1, *viewport);
		vkCmdSetScissor(cmd, 0, 1, *scissor);

		m_data: struct {
			ViewProj: Matrix4;
			vertexBuffer: VkDeviceAddress;
		};
		m_data.ViewProj = viewProj;
		if IndexBuffer.data.count
		{
			UploadVertexData(renderData);
			m_data.vertexBuffer = GetDeviceAddress(VertexBuffer.buffer);

			vkCmdBindPipeline(cmd, .GRAPHICS, shader.handle);
			vkCmdPushConstants(cmd, shader.layout, .VERTEX_BIT, 0, size_of(type_of(m_data)), *m_data);

			vkCmdBindDescriptorSets(cmd, .GRAPHICS, shader.layout, 0, 1, *descriptorSet, 0, null);
			vkCmdBindIndexBuffer(cmd, IndexBuffer.buffer.handle, 0, .UINT32);
			vkCmdDrawIndexed(cmd, xx IndexBuffer.data.count, 1, 0, 0, 0);
		}

		if LineVertexBuffer.data.count
		{
			UploadLineVertexData(renderData);

			m_data.vertexBuffer = GetDeviceAddress(LineVertexBuffer.buffer);

			vkCmdBindPipeline(cmd, .GRAPHICS, lineShader.handle);
			vkCmdPushConstants(cmd, lineShader.layout, .VERTEX_BIT, 0, size_of(type_of(m_data)), *m_data);

			vkCmdDraw(cmd, xx LineVertexBuffer.data.count, 1, 0, 0);
		}

		vkCmdEndRenderPass(cmd);
		vkEndCommandBuffer(cmd);

		Submit(cmd, vk.graphicsQueue); // @Bug?: why do I need to put vk. ?
	}

	/*{
		wc::CommandEncoder cmd;
		bloom.Execute(cmd);
		composite.Execute(cmd, renderSize);
		crt.Execute(cmd, renderSize, 0.f);

		cmd.ExecuteCompute(m_ComputeCmd[CURRENT_FRAME]);
	}*/
}