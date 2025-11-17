#import "Math";

GetMipSize :: (level: u32, size: Vector2) -> Vector2 { return .{ size.x >> level, size.y >> level }; } // @TODO: Make this take iVector2 instead of normal one

GetMipLevelCount :: (size: Vector2) -> u32 { return floor(log(min(size.x, size.y)) / #run log(2.0)).(u32); }

GenerateImageMemoryBarier :: (
	image: VkImage,
	oldImageLayout: VkImageLayout,
	newImageLayout: VkImageLayout,
	subresourceRange: VkImageSubresourceRange) -> VkImageMemoryBarrier
{
	barier := VkImageMemoryBarrier.{
		srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
		dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
		oldLayout = oldImageLayout,
		newLayout = newImageLayout,
		image = image,
		subresourceRange = subresourceRange,
	};

	if oldImageLayout == {
	    case .PREINITIALIZED;   				barier.srcAccessMask = .HOST_WRITE_BIT;
	    case .COLOR_ATTACHMENT_OPTIMAL;  		barier.srcAccessMask = .COLOR_ATTACHMENT_WRITE_BIT;
	    case .DEPTH_STENCIL_ATTACHMENT_OPTIMAL; barier.srcAccessMask = .DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
	    case .TRANSFER_SRC_OPTIMAL;    			barier.srcAccessMask = .TRANSFER_READ_BIT;
	    case .TRANSFER_DST_OPTIMAL;	 			barier.srcAccessMask = .TRANSFER_WRITE_BIT;
	    case .SHADER_READ_ONLY_OPTIMAL;	    	barier.srcAccessMask = .SHADER_READ_BIT;
	}

	if newImageLayout == {
		case .TRANSFER_DST_OPTIMAL;				barier.dstAccessMask = .TRANSFER_WRITE_BIT;
		case .TRANSFER_SRC_OPTIMAL;				barier.dstAccessMask = .TRANSFER_READ_BIT;
		case .COLOR_ATTACHMENT_OPTIMAL;			barier.dstAccessMask = .COLOR_ATTACHMENT_WRITE_BIT;
		case .DEPTH_STENCIL_ATTACHMENT_OPTIMAL;	barier.dstAccessMask |= .DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;
		case .SHADER_READ_ONLY_OPTIMAL;
			if barier.srcAccessMask == 0
			   barier.srcAccessMask = .HOST_WRITE_BIT | .TRANSFER_WRITE_BIT;

			barier.dstAccessMask = .SHADER_READ_BIT;
	}

	return barier;
}

ImageSpecification :: struct
{
    format := VkFormat.UNDEFINED;
    width: u32 = 1;
    height: u32 = 1;
    mipLevels: u32 = 1;
    usage: VkImageUsageFlags;
};

Image :: struct
{
    handle: VkImage = VK_NULL_HANDLE;
    allocation : VmaAllocation = VK_NULL_HANDLE;
    
    width, height : u32 = 0;
    mipLevels: u32 = 1;
    layers: u32 = 1;
    format : VkFormat = .UNDEFINED;
};

Create :: (using image: *Image, dimg_info: VkImageCreateInfo, usage : VmaMemoryUsage = .GPU_ONLY, requiredFlags: VkMemoryPropertyFlags = 0, call := #caller_code) -> VkResult #expand
{
	dimg_allocinfo := VmaAllocationCreateInfo.{
		usage = usage,
		requiredFlags = requiredFlags,
	};

	width = dimg_info.extent.width;
	height = dimg_info.extent.height;
	mipLevels = dimg_info.mipLevels;
	layers = dimg_info.arrayLayers;
	format = dimg_info.format;

	result := vmaCreateImage(allocator, *dimg_info, *dimg_allocinfo, *handle, *allocation, null);
	#if GRAPHICS_VALIDATION
    {
        if result != .SUCCESS return result;
        if validationLayersFound
        {
            name := #run -> string {
                nodes := compiler_get_nodes(call);       

                procCall := cast(*Code_Procedure_Call) nodes;

                builder: String_Builder;
                print_expression(*builder, procCall.arguments_sorted[0]);
                result := builder_to_string(*builder);
                return result;
            }

            SetObjectName(handle, name);
        }
    }

	return result;
}

Create :: (using image: *Image, imageSpec: ImageSpecification, usage : VmaMemoryUsage = .GPU_ONLY, requiredFlags: VkMemoryPropertyFlags = 0) -> VkResult 
{
	return Create(image, .{
	imageType = ._2D,
	format = imageSpec.format,

	extent = .{
		width = imageSpec.width,
		height = imageSpec.height,
		depth = 1,
	},

	mipLevels = imageSpec.mipLevels,
	arrayLayers = 1,
	samples = ._1_BIT,
	tiling = .OPTIMAL,
	usage = imageSpec.usage
	}, usage, requiredFlags);
}


Destroy :: (using image: *Image)
{
	vmaDestroyImage(allocator, image.handle, allocation);
	handle = VK_NULL_HANDLE;
	allocation = VK_NULL_HANDLE;
}

GetSubresourceLayout :: (image: VkImage, aspectMask: VkImageAspectFlagBits = .COLOR_BIT) -> VkSubresourceLayout
{
	subResource := VkImageSubresource.{ aspectMask = aspectMask };
	subResourceLayout: VkSubresourceLayout;

	vkGetImageSubresourceLayout(logicalDevice, image, *subResource, *subResourceLayout);
	return subResourceLayout;
}

SetLayout :: (
	using image: Image,
	cmd: VkCommandBuffer,
	oldImageLayout: VkImageLayout,
	newImageLayout: VkImageLayout,
	subresourceRange: VkImageSubresourceRange,
	srcStageMask: VkPipelineStageFlags,
	dstStageMask: VkPipelineStageFlags)
{
	imageMemoryBarrier := GenerateImageMemoryBarier(handle, oldImageLayout, newImageLayout, subresourceRange);

	vkCmdPipelineBarrier(cmd, srcStageMask, dstStageMask, 0, 0, null, 0, null, 1, *imageMemoryBarrier);
}

// Fixed sub resource on first mip level and layer
SetLayout :: (
	using image: Image,
	cmd: VkCommandBuffer,
	aspectMask: VkImageAspectFlags,
	oldImageLayout: VkImageLayout,
	newImageLayout: VkImageLayout,
	srcStageMask: VkPipelineStageFlags,
	dstStageMask: VkPipelineStageFlags)
{
	SetLayout(image, cmd, oldImageLayout, newImageLayout, .{
		aspectMask = aspectMask,
		levelCount = mipLevels,
		layerCount = layers,
		}, srcStageMask, dstStageMask);
}

InsertMemoryBarrier :: (
	using image: Image,
	cmd: VkCommandBuffer,
	srcAccessMask: VkAccessFlags,
	dstAccessMask: VkAccessFlags,
	oldImageLayout: VkImageLayout,
	newImageLayout: VkImageLayout,
	srcStageMask: VkPipelineStageFlags,
	dstStageMask: VkPipelineStageFlags,
	subresourceRange: VkImageSubresourceRange)
{
	imageMemoryBarrier := VkImageMemoryBarrier.{
		srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
		srcAccessMask = srcAccessMask,
		dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED,
		dstAccessMask = dstAccessMask,
		oldLayout = oldImageLayout,
		newLayout = newImageLayout,
		image = image.handle,
		subresourceRange = subresourceRange,
	};

	vkCmdPipelineBarrier(cmd, srcStageMask, dstStageMask, 0, 0, null, 0, null, 1, *imageMemoryBarrier);
}

InsertMemoryBarrier :: (
	using image: Image,
	cmd: VkCommandBuffer,
	aspectMask: VkImageAspectFlags,
	srcAccessMask: VkAccessFlags,
	dstAccessMask: VkAccessFlags,
	oldImageLayout: VkImageLayout,
	newImageLayout: VkImageLayout,
	srcStageMask: VkPipelineStageFlags,
	dstStageMask: VkPipelineStageFlags)
{
	InsertMemoryBarrier(image, cmd, srcAccessMask, dstAccessMask, oldImageLayout, newImageLayout, srcStageMask, dstStageMask, .{
		aspectMask = aspectMask,
		levelCount = mipLevels,
		layerCount = layers,
	});
}

HasDepth :: (image: Image) -> bool
{
	formats :: VkFormat.[
		.D16_UNORM,
		.X8_D24_UNORM_PACK32,
		.D32_SFLOAT,
		.D16_UNORM_S8_UINT,
		.D24_UNORM_S8_UINT,
		.D32_SFLOAT_S8_UINT
	];

	return array_find(formats, image.format);
}

HasStencil :: (image: Image) -> bool
{
	formats :: VkFormat.[
		.S8_UINT,
        .D16_UNORM_S8_UINT,
        .D24_UNORM_S8_UINT,
        .D32_SFLOAT_S8_UINT,
	];

	return array_find(formats, image.format);
}

Create :: (view: *VkImageView, using image: Image) -> VkResult
{
    viewCreateInfo := VkImageViewCreateInfo.{
		image = handle,
		viewType = ifx layers > 1 VkImageViewType._2D_ARRAY else VkImageViewType._2D,
		format = format,
		components = .{ .R, .G, .B, .A },
		subresourceRange = .{
			aspectMask = ifx HasDepth(image) VkImageAspectFlags.DEPTH_BIT else VkImageAspectFlags.COLOR_BIT,
			levelCount = mipLevels,
			layerCount = layers,
		},
	};
    return vkCreateImageView(logicalDevice, *viewCreateInfo, allocationCallbacks, view);
}