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

	lineShader: vk.Pipeline;

	screenSampler: VkSampler;

	cmd: [vk.FRAME_OVERLAP]VkCommandBuffer;
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

	

	vk.Create(*screenSampler, .{
		magFilter = .LINEAR,
		minFilter = .LINEAR,
		mipmapMode = .LINEAR,
		addressModeU = .CLAMP_TO_EDGE,
		addressModeV = .CLAMP_TO_EDGE,
		addressModeW = .CLAMP_TO_EDGE,
	});

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
}

Deinit :: (using renderer: *Renderer2D)
{
	vk.Destroy(lineShader);

	DestroyScreen(renderer);

	vk.Destroy(*renderPass);
}

Flush :: (using,except(cmd) renderer: *Renderer2D, using renderData: *RenderData, viewProj: Matrix4)
{
	//if LineVertexBuffer.data.count == 0 return;

	cmd := renderer.cmd[vk.CURRENT_FRAME_INDEX];
	vkResetCommandBuffer(cmd, 0);

	begInfo := VkCommandBufferBeginInfo.{ flags = .ONE_TIME_SUBMIT_BIT };

	vkBeginCommandBuffer(cmd, *begInfo);
	clearValues := VkClearValue.[
		.{color._float32 = .[0.0, 0.0, 0.0, 0.0]},
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
	UploadLineVertexData(renderData);

	m_data.vertexBuffer = GetDeviceAddress(LineVertexBuffer.buffer);

	vkCmdBindPipeline(cmd, .GRAPHICS, lineShader.handle);
	vkCmdPushConstants(cmd, lineShader.layout, .VERTEX_BIT, 0, size_of(type_of(m_data)), *m_data);

	vkCmdDraw(cmd, xx LineVertexBuffer.data.count, 1, 0, 0);

	vkCmdEndRenderPass(cmd);
	vkEndCommandBuffer(cmd);

	Submit(cmd, vk.graphicsQueue);
}