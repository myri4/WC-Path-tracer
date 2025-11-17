PipelineCreateInfo :: struct {
	binaries: [2][]u32;

	renderSize: Vector2;
	renderPass: VkRenderPass;

	blendAttachments: []VkPipelineColorBlendAttachmentState;
	depthTest: bool;

	topology: VkPrimitiveTopology = .TRIANGLE_LIST;
	frontFace: VkFrontFace = .CLOCKWISE;

	bindingFlags: []VkDescriptorBindingFlags;
	dynamicDescriptorCount: bool;

	dynamicStates: []VkDynamicState;
}

ComputePipelineCreateInfo :: struct {
	binary: []u32;

	bindingFlags: []VkDescriptorBindingFlags;
	dynamicDescriptorCount: bool;
}

Pipeline :: struct {	
	handle: VkPipeline;
	layout: VkPipelineLayout;
	descriptorLayout: VkDescriptorSetLayout;
}

Destroy :: (using pipeline: Pipeline) {
	Destroy(*handle);
	Destroy(*layout);
	Destroy(*descriptorLayout);
}

load_spirv_binary :: (filename: string) -> (bool, []u32) {
	file_data, success := read_entire_file(filename);
    if !success {
        log_error("Can't open file at location: %\n", filename);
        return false, .[];
    }
    
    if file_data.count % 4 != 0 {
        log_error("File size % is not divisible by 4 (u32 size)\n", file_data.count);
        return false, .[];
    }
    
    u32_count := file_data.count / 4;
    
    buffer: []u32;
    buffer.data = cast(*u32) file_data.data;
    buffer.count = u32_count;
    
    return true, buffer;
}

CreatePipeline :: (using createInfo: PipelineCreateInfo) -> bool, Pipeline {
	using pipeline: Pipeline;
	shaderModules: [2]VkShaderModule;
	shaderStages:  [2]VkPipelineShaderStageCreateInfo;

	for binary, i : binaries {
		moduleCreateInfo := VkShaderModuleCreateInfo.{
			codeSize = cast(u64)binary.count * size_of(u32),
			pCode = binary.data,
		};

		result := vkCreateShaderModule(logicalDevice, *moduleCreateInfo, null, *shaderModules[i]); 
		if result != .SUCCESS {
			log_error("Could not create shader module % with error code '%'\n", i, result);
			return false, .{};
		}
	}

	defer {
		for * shaderModule : shaderModules
    	    Destroy(shaderModule);
	}

	{ // Reflection
		layoutBindings: [..]VkDescriptorSetLayoutBinding;
		ranges: [..]VkPushConstantRange;

		spvcContext: spvc.Context;
		if spvc.context_create(*spvcContext) != .SUCCESS { 
			log_error("Could not create spvc context!\n"); 
			return false, .{}; 
		} 
		defer spvc.context_destroy(spvcContext);
		spvc.context_set_error_callback(spvcContext, (userdata: *void, error: *u8) -> void #c_call { push_context {log("Spirv-cross error: %\n", error); }}, null);

		for binary, i : binaries {
			defer spvc.context_release_allocations(spvcContext);

			ir: spvc.parsed_ir;
    		if spvc.context_parse_spirv(spvcContext, cast(*spvc.Id)binary.data, cast(u64) binary.count, *ir) != .SUCCESS 
				return false, .{}; 

			compiler: spvc.compiler;
    		if spvc.context_create_compiler(spvcContext, .NONE, ir, .TAKE_OWNERSHIP, *compiler) != .SUCCESS 
				return false, .{}; 

    		resources: spvc.resources;
    		if spvc.compiler_create_shader_resources(compiler, *resources) != .SUCCESS 
				return false, .{}; 

    		entry_points: []spvc.entry_point;
    		if spvc.compiler_get_entry_points(compiler, *entry_points.data, cast(*u64)*entry_points.count) != .SUCCESS 
				return false, .{};

			if entry_points.count == 0 {
				log_error("Cannot parse a shader with zero entry points!\n");
				return false, .{};
			}
			
			shaderStage : VkShaderStageFlagBits = xx (1 << entry_points[0].execution_model);

			push_constants: []spvc.reflected_resource;
			if spvc.resources_get_resource_list_for_type(resources, .PUSH_CONSTANT, *push_constants.data, cast(*u64)*push_constants.count) != .SUCCESS 
				return false, .{};

			for resource : push_constants {
				range := VkPushConstantRange.{ stageFlags = shaderStage };
				spvc.compiler_get_declared_struct_size(compiler, spvc.compiler_get_type_handle(compiler, resource.base_type_id), cast(*u64)*range.size);
				
				array_add(*ranges, range); // @TODO: emplace
			}


			uniform_buffers: []spvc.reflected_resource;
			if spvc.resources_get_resource_list_for_type(resources, .UNIFORM_BUFFER, *uniform_buffers.data, cast(*u64)*uniform_buffers.count) != .SUCCESS 
				return false, .{};

			for resource : uniform_buffers {
				add := true;
				descriptorType : VkDescriptorType = .UNIFORM_BUFFER;
				binding := spvc.compiler_get_decoration(compiler, resource.id, .Binding);
				for * layoutBinding : layoutBindings
					if layoutBinding.descriptorType == descriptorType && layoutBinding.binding == binding {
						add = false;
						layoutBinding.stageFlags |= shaderStage;
						break;
					}

				if add {
					//type := compiler.get_type(resource.type_id);

					descriptorCount : u32 = 1;
					//if type.array[0] > 0 descriptorCount = type.array[0];

					array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
						binding = binding,
						descriptorType = descriptorType,
						descriptorCount = descriptorCount,
						stageFlags = shaderStage,
					});
				}
			}


			storage_buffers: []spvc.reflected_resource;
			if spvc.resources_get_resource_list_for_type(resources, .STORAGE_BUFFER, *storage_buffers.data, cast(*u64)*storage_buffers.count) != .SUCCESS 
				return false, .{};

			for resource : storage_buffers {
				add := true;
				descriptorType: VkDescriptorType = .STORAGE_BUFFER;
				binding := spvc.compiler_get_decoration(compiler, resource.id, .Binding);
				for * layoutBinding : layoutBindings
					if layoutBinding.descriptorType == descriptorType && layoutBinding.binding == binding {
						add = false;
						layoutBinding.stageFlags |= shaderStage;
						break;
					}

				if add {
					//const auto& type = compiler.get_type(resource.type_id);

					descriptorCount : u32 = 1;
					// @TODO: report this as an issue with the new spirv-cross reflection as this is probably a nullptr and gives random garbage which is not supposed to happen
					//if (type.array[0] > 0) descriptorCount = type.array[0]; 

					array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
						binding = binding,
						descriptorType = descriptorType,
						descriptorCount = descriptorCount,
						stageFlags = shaderStage,
					});
				}
			}

			if shaderStage == .FRAGMENT_BIT {
				storage_images: []spvc.reflected_resource;
				if spvc.resources_get_resource_list_for_type(resources, .STORAGE_IMAGE, *storage_images.data, cast(*u64)*storage_images.count) != .SUCCESS 
					return false, .{};

				for resource : storage_images {
					//type := compiler.get_type(resource.type_id);

					descriptorCount : u32 = 1;
					//if (type.array[0] > 0) descriptorCount = type.array[0];

					array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
						binding = spvc.compiler_get_decoration(compiler, resource.id, .Binding),
						descriptorType = .STORAGE_IMAGE,
						descriptorCount = descriptorCount,
						stageFlags = shaderStage,
					});
				}


				sampled_images: []spvc.reflected_resource;
				if spvc.resources_get_resource_list_for_type(resources, .SAMPLED_IMAGE, *sampled_images.data, cast(*u64)*sampled_images.count) != .SUCCESS
					return false, .{};

				for * resource : sampled_images {
					// type := compiler.get_type(resource.type_id);

					descriptorCount: u32 = 1;
					//if (type.array[0] > 0) descriptorCount = type.array[0];

					array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
						binding = spvc.compiler_get_decoration(compiler, resource.id, .Binding),
						descriptorType = .COMBINED_IMAGE_SAMPLER,
						descriptorCount = descriptorCount,
						stageFlags = shaderStage,
					});
				}
			}

			shaderStages[i] = VkPipelineShaderStageCreateInfo.{
			    stage = cast(VkShaderStageFlagBits)shaderStage,
			    module = shaderModules[i],
			    pName = "main",
            };
		}

		if dynamicDescriptorCount {
			binding := *layoutBindings[layoutBindings.count - 1];
			limits := physicalDevice.properties.limits;
			if binding.descriptorType == .COMBINED_IMAGE_SAMPLER 
                binding.descriptorCount = min(limits.maxDescriptorSetSampledImages, limits.maxPerStageDescriptorSamplers);
			if binding.descriptorType == .SAMPLER 
                binding.descriptorCount = limits.maxPerStageDescriptorSamplers;
			//@TODO: add more stuff here
		}

		layoutInfo := VkDescriptorSetLayoutCreateInfo.{
			bindingCount = cast(u32)layoutBindings.count,
			pBindings = layoutBindings.data,
		};

		binding_flags: VkDescriptorSetLayoutBindingFlagsCreateInfo;

		if bindingFlags.count > 0 {
			binding_flags.bindingCount = cast(u32)bindingFlags.count;
			binding_flags.pBindingFlags = bindingFlags.data;

			layoutInfo.pNext = *binding_flags;
		}

		result := Create(*descriptorLayout, layoutInfo);

		if result != .SUCCESS {
			log_error("Failed to create descriptor set layout with error code %\n", result);
			return false, .{};
		}

		result = Create(*layout, .{
			setLayoutCount = 1,
			pSetLayouts = *descriptorLayout,
			pushConstantRangeCount = cast(u32)ranges.count,
			pPushConstantRanges = ranges.data,
		});
		if result != .SUCCESS {
			log_error("Failed to create pipeline layout with error code %\n", result);
			return false, .{};
		}
	}

	viewport := VkViewport.{
		//y = renderSize.y, // change this to 0 to invert
		width = renderSize.x,
		height = renderSize.y,
		//height = -renderSize.y, // remove the - to invert
		minDepth = 0.0,
		maxDepth = 1.0,
	};

	scissor := VkRect2D.{ extent = VkExtent2D.{ cast(u32)renderSize.x, cast(u32)renderSize.y } };

	depthStencil := VkPipelineDepthStencilStateCreateInfo.{
		depthTestEnable = xx depthTest,
		depthWriteEnable = xx depthTest, // should be depth write
		depthCompareOp = ifx depthTest VkCompareOp.LESS_OR_EQUAL else VkCompareOp.ALWAYS, // should be changeable
		depthBoundsTestEnable = xx false,
		stencilTestEnable = xx false,
		maxDepthBounds = 1.0,
	};

	viewportState := VkPipelineViewportStateCreateInfo.{
		viewportCount = 1,
		pViewports = *viewport,
		scissorCount = 1,
		pScissors = *scissor,
	};

	colorBlending := VkPipelineColorBlendStateCreateInfo.{
		logicOpEnable = xx false,
		logicOp = .COPY,
		attachmentCount = cast(u32)blendAttachments.count,
		pAttachments = blendAttachments.data,
		blendConstants = .[1.0, 1.0, 1.0, 1.0]
	};


	inputAssembly := VkPipelineInputAssemblyStateCreateInfo.{ topology = topology };

	rasterizer := VkPipelineRasterizationStateCreateInfo.{ polygonMode = .FILL, cullMode = .NONE, frontFace = frontFace, lineWidth = 1.0 };

	multisampling := VkPipelineMultisampleStateCreateInfo.{ rasterizationSamples = ._1_BIT, minSampleShading = 1.0 };

	vertexInputState: VkPipelineVertexInputStateCreateInfo;
	pipelineInfo := VkGraphicsPipelineCreateInfo.{
		stageCount = cast(u32)shaderStages.count,
		pStages = shaderStages.data,
		pVertexInputState = *vertexInputState,
		pInputAssemblyState = *inputAssembly,
		pViewportState = *viewportState,
		pRasterizationState = *rasterizer,
		pMultisampleState = *multisampling,

		pDepthStencilState = *depthStencil,
		pColorBlendState = *colorBlending,
		layout = layout,
		renderPass = renderPass,
	};

	dynamicStateInfo: VkPipelineDynamicStateCreateInfo;
	if dynamicStates.count > 0 {
		dynamicStateInfo.dynamicStateCount = cast(u32)dynamicStates.count;
		dynamicStateInfo.pDynamicStates = dynamicStates.data;
		pipelineInfo.pDynamicState = *dynamicStateInfo;
	}

	result := vkCreateGraphicsPipelines(logicalDevice, VK_NULL_HANDLE, 1, *pipelineInfo, null, *handle);
	if result != .SUCCESS {
		log_error("Failed to create a graphics pipeline with error code: %\n", result);
		return false, .{};
	}

	return true, pipeline;
}

CreatePipeline :: (using createInfo: ComputePipelineCreateInfo) -> bool, Pipeline {
	using pipeline: Pipeline;
	shaderStage: VkShaderStageFlags = .COMPUTE_BIT;

	shaderModule: VkShaderModule;
	result := Create(*shaderModule, .{ // This is put here so when an invalid spirv ir is passed the vk validation layers crash immediately
		codeSize = cast(u64)binary.count * size_of(u32),
		pCode = binary.data,
	});
	if result != .SUCCESS {
		log_error("Failed to create a shader module with error code: %\n", result);
		return false, .{};
	}

	defer Destroy(*shaderModule);

	{ // Reflection

		layoutBindings: [..]VkDescriptorSetLayoutBinding;

    	spvcContext: spvc.Context;
		if spvc.context_create(*spvcContext) != .SUCCESS 
			return false, .{}; 

		defer spvc.context_destroy(spvcContext);
		spvc.context_set_error_callback(spvcContext, (userdata: *void, error: *u8) -> void #c_call { push_context{ log("Spirv-cross error: %\n", error); }}, null);

    	ir: spvc.parsed_ir;
    	if spvc.context_parse_spirv(spvcContext, cast(*spvc.Id)binary.data, cast(u64) binary.count, *ir) != .SUCCESS 
			return false, .{}; 

		compiler: spvc.compiler;
    	if spvc.context_create_compiler(spvcContext, .NONE, ir, .TAKE_OWNERSHIP, *compiler) != .SUCCESS 
			return false, .{}; 

    	resources: spvc.resources;
    	if spvc.compiler_create_shader_resources(compiler, *resources) != .SUCCESS 
			return false, .{}; 

    	entry_points: []spvc.entry_point;
    	if spvc.compiler_get_entry_points(compiler, *entry_points.data, cast(*u64)*entry_points.count) != .SUCCESS 
			return false, .{};

		if entry_points.count == 0  {
			log_error("Cannot parse a shader with zero entry points!\n");
			return false, .{};
		}


		uniform_buffers: []spvc.reflected_resource;
		if spvc.resources_get_resource_list_for_type(resources, .UNIFORM_BUFFER, *uniform_buffers.data, cast(*u64)*uniform_buffers.count) != .SUCCESS 
			return false, .{};

		for resource : uniform_buffers {
			//type := compiler.get_type(resource.type_id);

			descriptorCount : u32 = 1;
			//if type.array[0] > 0 descriptorCount = type.array[0];

			array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
				binding = spvc.compiler_get_decoration(compiler, resource.id, .Binding),
				descriptorType = .UNIFORM_BUFFER,
				descriptorCount = descriptorCount,
				stageFlags = shaderStage,
			});
		}


		storage_buffers: []spvc.reflected_resource;
		if spvc.resources_get_resource_list_for_type(resources, .STORAGE_BUFFER, *storage_buffers.data, cast(*u64)*storage_buffers.count) != .SUCCESS 
			return false, .{};

		for resource : storage_buffers {
			//type := compiler.get_type(resource.type_id);

			descriptorCount : u32 = 1;
			//if type.array[0] > 0 descriptorCount = type.array[0];

			array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
				binding = spvc.compiler_get_decoration(compiler, resource.id, .Binding),
				descriptorType = .STORAGE_BUFFER,
				descriptorCount = descriptorCount,
				stageFlags = shaderStage,
			});
		}


		storage_images: []spvc.reflected_resource;
		if spvc.resources_get_resource_list_for_type(resources, .STORAGE_IMAGE, *storage_images.data, cast(*u64)*storage_images.count) != .SUCCESS 
			return false, .{};

		for resource : storage_images {
			//type := compiler.get_type(resource.type_id);

			descriptorCount : u32 = 1;
			//if type.array[0] > 0 descriptorCount = type.array[0];

			array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
				binding = spvc.compiler_get_decoration(compiler, resource.id, .Binding),
				descriptorType = .STORAGE_IMAGE,
				descriptorCount = descriptorCount,
				stageFlags = shaderStage,
			});
		}


		sampled_images: []spvc.reflected_resource;
		if spvc.resources_get_resource_list_for_type(resources, .SAMPLED_IMAGE, *sampled_images.data, cast(*u64)*sampled_images.count) != .SUCCESS
			return false, .{};

		for resource : sampled_images {
			//type := compiler.get_type(resource.type_id);

			descriptorCount : u32 = 1;
			//if type.array[0] > 0 descriptorCount = type.array[0];

			array_add(*layoutBindings, .{ // @TODO: maybe make this emplace not push
				binding = spvc.compiler_get_decoration(compiler, resource.id, .Binding),
				descriptorType = .SAMPLED_IMAGE,
				descriptorCount = descriptorCount,
				stageFlags = shaderStage,
			});
		}

		if dynamicDescriptorCount {
			binding := *layoutBindings[layoutBindings.count - 1];
			limits := physicalDevice.properties.limits;
			if binding.descriptorType == .COMBINED_IMAGE_SAMPLER 
                binding.descriptorCount = min(limits.maxDescriptorSetSampledImages, limits.maxPerStageDescriptorSamplers);
			if binding.descriptorType == .SAMPLER 
                binding.descriptorCount = limits.maxPerStageDescriptorSamplers;
			//@TODO: add more stuff here
		}

		layoutInfo := VkDescriptorSetLayoutCreateInfo.{
			bindingCount = cast(u32)layoutBindings.count,
			pBindings = layoutBindings.data,
		};

		binding_flags: VkDescriptorSetLayoutBindingFlagsCreateInfo;

		if bindingFlags.count > 0 {
			binding_flags.bindingCount = cast(u32)bindingFlags.count;
			binding_flags.pBindingFlags = bindingFlags.data;

			layoutInfo.pNext = *binding_flags;
		}

		result := Create(*descriptorLayout, layoutInfo);

		if result != .SUCCESS {
			log_error("Failed to create descriptor set layout with error code %\n", result);
			return false, .{};
		}

		info := VkPipelineLayoutCreateInfo.{
			setLayoutCount = 1,
			pSetLayouts = *descriptorLayout,
		};

		range := VkPushConstantRange.{ stageFlags = shaderStage };
		push_constants: []spvc.reflected_resource;
		if spvc.resources_get_resource_list_for_type(resources, .PUSH_CONSTANT, *push_constants.data, cast(*u64)*push_constants.count) != .SUCCESS 
			return false, .{};

		if push_constants.count > 0 {
			spvc.compiler_get_declared_struct_size(compiler, spvc.compiler_get_type_handle(compiler, push_constants[0].base_type_id), cast(*u64)*range.size);

			info.pPushConstantRanges = *range;
			info.pushConstantRangeCount = 1;
		}

		result = Create(*layout, info);
		if result != .SUCCESS {
			log_error("Failed to create pipeline layout with error code %\n", result);
			return false, .{};
		}
	}

	pipelineCreateInfo := VkComputePipelineCreateInfo.{
		stage = VkPipelineShaderStageCreateInfo.{
		    stage = shaderStage,
		    module = shaderModule,
		    pName = "main",
	    },
		layout = layout,
	};

	result = vkCreateComputePipelines(logicalDevice, VK_NULL_HANDLE, 1, *pipelineCreateInfo, null, *handle);
	if result != .SUCCESS {
		print("Failed to create a compute pipeline with result: %\n", result);
		return false, .{};
	}

	return true, pipeline;
}

IsPipelineCacheValid :: (data: *void) -> bool {
	header := (cast(*VkPipelineCacheHeaderVersionOne)data).*;
	if header.headerSize <= 0  return false;
	if header.headerVersion != VK_PIPELINE_CACHE_HEADER_VERSION_ONE  return false;
	if header.vendorID != physicalDevice.properties.vendorID  return false;
	if header.deviceID != physicalDevice.properties.deviceID  return false;
	return memcmp(header.pipelineCacheUUID, physicalDevice.properties.pipelineCacheUUID, size_of(header.pipelineCacheUUID)) == 0;
}

#scope_file
spvc :: #import "spirv_cross"; 
#import "File";