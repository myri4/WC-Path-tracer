LineVertex :: struct {
	Position: Vector3;

	Color: Vector4;
	//EntityID: u64;
}

RenderData :: struct {
	LineVertexBuffer: DBufferManager(LineVertex, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32));
}

UploadLineVertexData :: (using renderData: *RenderData) {
	vk.BeginImmediateSumbit(vk.UploadCommandBuffer);
		Update(*LineVertexBuffer, vk.UploadCommandBuffer);
		
        vk.SetObjectName(LineVertexBuffer.buffer.handle, "Renderer2D.LineVertexBuffer");
		vk.SetObjectName(LineVertexBuffer.stagingBuffer.handle, "Renderer2D.LineVertexStagingBuffer");
	vk.EndImmediateSumbit(vk.UploadCommandBuffer);
}

Reset :: (using renderData: *RenderData) { array_reset_keeping_memory(*LineVertexBuffer.data); }

Free :: (using renderData: *RenderData) { Free(*LineVertexBuffer); }

DrawLineQuad :: (using renderData: *RenderData, transform: Matrix4, color := Vector4.{1.0, 1.0, 1.0, 1.0}) {
	vertices := Vector4.[
		transform * .{ 0.5,  0.5, 0.0, 1.0},
		transform * .{-0.5,  0.5, 0.0, 1.0},
		transform * .{-0.5, -0.5, 0.0, 1.0},
		transform * .{ 0.5, -0.5, 0.0, 1.0},
	];
	inline DrawLine(renderData, xyz(vertices[0]), xyz(vertices[1]), color);
	inline DrawLine(renderData, xyz(vertices[1]), xyz(vertices[2]), color);
	inline DrawLine(renderData, xyz(vertices[2]), xyz(vertices[3]), color);
	inline DrawLine(renderData, xyz(vertices[3]), xyz(vertices[0]), color);
}

DrawLineCube :: (using renderData: *RenderData, min: Vector3, max: Vector3, color := Vector4.{1.0, 1.0, 1.0, 1.0}) {
    vertices := Vector3.[
        .{min.x, min.y, min.z},
        .{max.x, min.y, min.z},
        .{min.x, max.y, min.z},
        .{min.x, min.y, max.z},
        .{max.x, max.y, min.z},
        .{min.x, max.y, max.z},
        .{max.x, max.y, max.z},
        .{max.x, min.y, max.z},
    ];
    
    inline DrawLine(renderData, vertices[0], vertices[1], color);
    inline DrawLine(renderData, vertices[1], vertices[2], color);
    inline DrawLine(renderData, vertices[2], vertices[3], color);
    inline DrawLine(renderData, vertices[3], vertices[0], color);
    
    inline DrawLine(renderData, vertices[4], vertices[5], color);
    inline DrawLine(renderData, vertices[5], vertices[6], color);
    inline DrawLine(renderData, vertices[6], vertices[7], color);
    inline DrawLine(renderData, vertices[7], vertices[4], color);
    
    inline DrawLine(renderData, vertices[0], vertices[4], color);
    inline DrawLine(renderData, vertices[1], vertices[5], color);
    inline DrawLine(renderData, vertices[2], vertices[6], color);
    inline DrawLine(renderData, vertices[3], vertices[7], color);
}

DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, startColor: Vector4, endColor: Vector4) { array_add(*LineVertexBuffer.data, .{start, startColor}, .{end, endColor}); }

DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, startColor: Vector3, endColor: Vector3) { inline DrawLine(renderData, start, end, .{startColor.x, startColor.y, startColor.z, 1.0}, .{endColor.x, endColor.y, endColor.z, 1.0}); }
DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, color := Vector4.{1.0, 1.0, 1.0, 1.0}) { inline DrawLine(renderData, start, end, color, color); }
DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, color: Vector3) { inline DrawLine(renderData, start, end, color, color); }

#scope_file

// @TODO: Remove this ugly hack
xyz :: inline (vec: Vector4) -> Vector3 { return .{vec.x, vec.y, vec.z}; }