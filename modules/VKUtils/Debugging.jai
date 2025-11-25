#if GRAPHICS_VALIDATION
{
    validationLayersFound := false;
    debug_messenger : VkDebugUtilsMessengerEXT;

    vkCreateDebugUtilsMessengerEXT  : PFN_vkCreateDebugUtilsMessengerEXT;
    vkDestroyDebugUtilsMessengerEXT : PFN_vkDestroyDebugUtilsMessengerEXT;
    vkSetDebugUtilsObjectNameEXT    : PFN_vkSetDebugUtilsObjectNameEXT;
    vkCmdBeginDebugUtilsLabelEXT    : PFN_vkCmdBeginDebugUtilsLabelEXT;
    vkCmdEndDebugUtilsLabelEXT      : PFN_vkCmdEndDebugUtilsLabelEXT;
    vkCmdInsertDebugUtilsLabelEXT   : PFN_vkCmdInsertDebugUtilsLabelEXT;
    vkQueueBeginDebugUtilsLabelEXT  : PFN_vkQueueBeginDebugUtilsLabelEXT;
    vkQueueEndDebugUtilsLabelEXT    : PFN_vkQueueEndDebugUtilsLabelEXT;
    vkQueueInsertDebugUtilsLabelEXT : PFN_vkQueueInsertDebugUtilsLabelEXT;

    BeginLabel :: (cmd: VkCommandBuffer, labelName: *u8, color: Vector4)
    {
    	if validationLayersFound
    	{
    		label := VkDebugUtilsLabelEXT.{ 
    		    pLabelName = labelName,
    		    color = .[color.x, color.y, color.z, color.w]
            };
    		vkCmdBeginDebugUtilsLabelEXT(cmd, *label);
    	}
    }

    InsertLabel :: (cmd: VkCommandBuffer, labelName: *u8, color: Vector4)
    {
    	if validationLayersFound
    	{
    		label := VkDebugUtilsLabelEXT.{ 
    		    pLabelName = labelName,
    		    color = .[color.x, color.y, color.z, color.w]
            };
    		vkCmdInsertDebugUtilsLabelEXT(cmd, *label);
    	}
    }

    EndLabel :: (cmd: VkCommandBuffer)
    {
    	if validationLayersFound vkCmdEndDebugUtilsLabelEXT(cmd);
    }


    BeginLabel :: (queue: VkQueue, labelName: *u8, color: Vector4)
    {
    	if validationLayersFound
    	{
    		label := VkDebugUtilsLabelEXT.{ 
    		    pLabelName = labelName,
    		    color = .[color.x, color.y, color.z, color.w]
            };
    		vkQueueBeginDebugUtilsLabelEXT(queue, *label);
    	}
    }

    InsertLabel :: (queue: VkQueue, labelName: *u8, color: Vector4)
    {
    	if validationLayersFound
    	{
    		label := VkDebugUtilsLabelEXT.{ 
    		    pLabelName = labelName,
    		    color = .[color.x, color.y, color.z, color.w]
            };
    		vkQueueInsertDebugUtilsLabelEXT(queue, *label);
    	}
    }

    EndLabel :: (queue: VkQueue)
    {
    	if validationLayersFound vkQueueEndDebugUtilsLabelEXT(queue);
    }
	// @TODO: this function should probably take in general Type as parameter instead of only VkObjectType
    SetObjectNameT :: (type: VkObjectType, handle: $T, name: string)
    {
    	if validationLayersFound
    	{
    		name_info := VkDebugUtilsObjectNameInfoEXT.{            
    		    objectType = type,
    		    objectHandle = xx handle,
    		    pObjectName = temp_c_string(name),
            };
    		vkSetDebugUtilsObjectNameEXT(logicalDevice, *name_info);
    	}
    }
}
else
{
    BeginLabel :: (cmd: VkCommandBuffer, labelName: *u8, color: Vector4) {}

    InsertLabel :: (cmd: VkCommandBuffer, labelName: *u8, color: Vector4) {}

    EndLabel :: (cmd: VkCommandBuffer) {}


    BeginLabel :: (queue: VkQueue, labelName: *u8, color: Vector4) {}

    InsertLabel :: (queue: VkQueue, labelName: *u8, color: Vector4) {}

    EndLabel :: (queue: VkQueue) {}

    SetObjectNameT :: (type: VkObjectType, handle: u64, name: string) {}
}

SetObjectName :: (handle: $T, name: string) // @NOTE: If handle is some kind of pointer the function fails.
{ 
    #if GRAPHICS_VALIDATION {
        
	    SetObjectNameT(get_vulkan_object_type(type_of(handle)), handle, name); 
    }
}