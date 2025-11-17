#load "BufferManager.jai";

Vertex :: struct
{
	Position: Vector3;
	TextureID: u32;
	TexCoords: Vector2;
	Fade: float;
	Thickness: float;

	Color: Vector4;
};

LineVertex :: struct
{
	Position: Vector3;

	Color: Vector4;
	//EntityID: u64;
}

RenderData :: struct
{
	VertexBuffer: DBufferManager(Vertex, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32));
	IndexBuffer: DBufferManager(u32, VkBufferUsageFlagBits.INDEX_BUFFER_BIT.(u32));
	LineVertexBuffer: DBufferManager(LineVertex, VkBufferUsageFlagBits.SHADER_DEVICE_ADDRESS_BIT.(u32));
}

UploadVertexData :: (using renderData: *RenderData)
{
	BeginImmediateSumbit(vk.UploadCommandBuffer);
		Update(*IndexBuffer, vk.UploadCommandBuffer);
		Update(*VertexBuffer, vk.UploadCommandBuffer);
		
        SetObjectName(IndexBuffer.buffer.handle, "Renderer2D.IndexBuffer");
        SetObjectName(VertexBuffer.buffer.handle, "Renderer2D.VertexBuffer");

		SetObjectName(IndexBuffer.stagingBuffer.handle, "Renderer2D.IndexStagingBuffer");
        SetObjectName(VertexBuffer.stagingBuffer.handle, "Renderer2D.VertexStagingBuffer");
	EndImmediateSumbit(vk.UploadCommandBuffer);
}

UploadLineVertexData :: (using renderData: *RenderData)
{
	vk.BeginImmediateSumbit(vk.UploadCommandBuffer);
		Update(*LineVertexBuffer, vk.UploadCommandBuffer);
		
        vk.SetObjectName(LineVertexBuffer.buffer.handle, "Renderer2D.LineVertexBuffer");
		vk.SetObjectName(LineVertexBuffer.stagingBuffer.handle, "Renderer2D.LineVertexStagingBuffer");
	vk.EndImmediateSumbit(vk.UploadCommandBuffer);
}

Reset :: (using renderData: *RenderData)
{
	array_reset_keeping_memory(*IndexBuffer.data);
	array_reset_keeping_memory(*VertexBuffer.data);
	array_reset_keeping_memory(*LineVertexBuffer.data);
}

Free :: (using renderData: *RenderData)
{
	Free(*VertexBuffer);
	Free(*IndexBuffer);
	Free(*LineVertexBuffer);
}

DrawQuad :: (using renderData: *RenderData, transform: Matrix4, texID: u32, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	vertexCount := VertexBuffer.data.count;

	array_add(*VertexBuffer.data, 
	.{ Position = xyz(transform * .{ 0.5,  0.5, 0.0, 1.0}), TexCoords = .{ 1.0, 0.0 }, TextureID = texID, Color = color/*, EntityID = entityID */},
	.{ Position = xyz(transform * .{-0.5,  0.5, 0.0, 1.0}), TexCoords = .{ 0.0, 0.0 }, TextureID = texID, Color = color/*, EntityID = entityID */},
	.{ Position = xyz(transform * .{-0.5, -0.5, 0.0, 1.0}), TexCoords = .{ 0.0, 1.0 }, TextureID = texID, Color = color/*, EntityID = entityID */},
	.{ Position = xyz(transform * .{ 0.5, -0.5, 0.0, 1.0}), TexCoords = .{ 1.0, 1.0 }, TextureID = texID, Color = color/*, EntityID = entityID */});
		
	array_add(*IndexBuffer.data, 
	cast(u32)(0 + vertexCount),
	cast(u32)(1 + vertexCount),
	cast(u32)(2 + vertexCount),

	cast(u32)(2 + vertexCount),
	cast(u32)(3 + vertexCount),
	cast(u32)(0 + vertexCount));
}

DrawLineQuad :: (using renderData: *RenderData, transform: Matrix4, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	vertices := Vector4.[
		transform * .{ 0.5,  0.5, 0.0, 1.0},
		transform * .{-0.5,  0.5, 0.0, 1.0},
		transform * .{-0.5, -0.5, 0.0, 1.0},
		transform * .{ 0.5, -0.5, 0.0, 1.0},
	];
	inline DrawLine(renderData, xyz(vertices[0]), xyz(vertices[1]), color, entityID);
	inline DrawLine(renderData, xyz(vertices[1]), xyz(vertices[2]), color, entityID);
	inline DrawLine(renderData, xyz(vertices[2]), xyz(vertices[3]), color, entityID);
	inline DrawLine(renderData, xyz(vertices[3]), xyz(vertices[0]), color, entityID);
}

DrawLineQuad :: (using renderData: *RenderData, start: Vector2, end: Vector2, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	vertices := Vector3.[
		.{end.x,   end.y,   0.0},
		.{start.x, end.y,   0.0},
		.{start.x, start.y, 0.0},
		.{end.x,   start.y, 0.0},
	];
	inline DrawLine(renderData, vertices[0], vertices[1], color, entityID);
	inline DrawLine(renderData, vertices[1], vertices[2], color, entityID);
	inline DrawLine(renderData, vertices[2], vertices[3], color, entityID);
	inline DrawLine(renderData, vertices[3], vertices[0], color, entityID);
}

DrawQuad :: (using renderData: *RenderData, position: Vector3, size: Vector2, texID: u32 = 0, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	transform := Matrix4_Identity;
	translate(*transform, position);
	scale(*transform, .{ size.x, size.y, 1.0 });
	inline DrawQuad(renderData, transform, texID, color, entityID);
}

DrawQuad :: (using renderData: *RenderData, position: Vector2, size: Vector2, texID: u32 = 0, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	inline DrawQuad(renderData, .{position.x, position.y, 0.0}, size, texID, color, entityID);
}

// Note: Rotation should be in radians
DrawQuad :: (using renderData: *RenderData, position: Vector3, size: Vector2, rotation: float, texID: u32 = 0, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	transform := Matrix4_Identity;
	translate(*transform, position);
	transform = rotate(transform, .{ w = cos(rotation * 0.5), z = sin(rotation * 0.5) }); // @Inconsistency @CompilerReport: why didnt the compiler complain when I passed a pointer to transform?
	scale(*transform, .{ size.x, size.y, 1.0 });
	inline DrawQuad(renderData, transform, texID, color, entityID);
}

DrawQuad :: (using renderData: *RenderData, position: Vector2, size: Vector2, rotation: float, texID: u32 = 0, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	inline DrawQuad(renderData, .{position.x, position.y, 0.0}, size, rotation, texID, color, entityID);
}

DrawTriangle :: (using renderData: *RenderData, v1: Vector2, v2: Vector2, v3: Vector2, texID: u32, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	vertexCount := VertexBuffer.data.count;
	array_add(*VertexBuffer.data,
	.{ Position = .{v1.x, v1.y, 0.0}, TexCoords = .{ 1.0, 0.0 }, TextureID = texID, Color = color/*, EntityID = entityID */},
	.{ Position = .{v2.x, v2.y, 0.0}, TexCoords = .{ 0.0, 0.0 }, TextureID = texID, Color = color/*, EntityID = entityID */},
	.{ Position = .{v3.x, v3.y, 0.0}, TexCoords = .{ 0.0, 1.0 }, TextureID = texID, Color = color/*, EntityID = entityID */});

	array_add(*IndexBuffer.data, 
	cast(u32)(0 + vertexCount),
	cast(u32)(1 + vertexCount),
	cast(u32)(2 + vertexCount));
}

DrawCircle :: (using renderData: *RenderData, transform: Matrix4, thickness: float = 1.0, fade: float = 0.05, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	vertexCount := VertexBuffer.data.count;
	array_add(*VertexBuffer.data,
	.{ Position = xyz(transform * .{ 1.0,  1.0, 0.0, 1.0}), TexCoords = .{  1.0,  1.0 }, Thickness = thickness, Fade = fade, Color = color/*, EntityID = entityID */},
	.{ Position = xyz(transform * .{-1.0,  1.0, 0.0, 1.0}), TexCoords = .{ -1.0,  1.0 }, Thickness = thickness, Fade = fade, Color = color/*, EntityID = entityID */},
	.{ Position = xyz(transform * .{-1.0, -1.0, 0.0, 1.0}), TexCoords = .{ -1.0, -1.0 }, Thickness = thickness, Fade = fade, Color = color/*, EntityID = entityID */},
	.{ Position = xyz(transform * .{ 1.0, -1.0, 0.0, 1.0}), TexCoords = .{  1.0, -1.0 }, Thickness = thickness, Fade = fade, Color = color/*, EntityID = entityID */});

	array_add(*IndexBuffer.data, 
	cast(u32)(0 + vertexCount),
	cast(u32)(1 + vertexCount),
	cast(u32)(2 + vertexCount),

	cast(u32)(2 + vertexCount),
	cast(u32)(3 + vertexCount),
	cast(u32)(0 + vertexCount));
}

DrawCircle :: (using renderData: *RenderData, position: Vector3, radius: float, thickness: float = 1.0, fade: float = 0.05, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	transform := Matrix4_Identity;
	translate(*transform, position);
	scale(*transform, .{ radius, radius, 1.0 });
	inline DrawCircle(renderData, transform, thickness, fade, color, entityID);
}

DrawCircle :: (using renderData: *RenderData, position: Vector2, radius: float, thickness: float = 1.0, fade: float = 0.05, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0)
{
	inline DrawCircle(renderData, .{position.x, position.y, 0.0}, radius, thickness, fade, color, entityID);
}

DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, startColor: Vector4, endColor: Vector4, entityID: u64 = 0)
{
	array_add(*LineVertexBuffer.data, 
	.{start, startColor/*, entityID*/}, 
	.{end, endColor/*, entityID*/});
}

//void DrawLines(const LineVertex* vertices, u32 count)
//{
//	memcpy(LineVertexBuffer + LineVertexBuffer.Counter * sizeof(LineVertex), vertices, count * sizeof(LineVertex));
//	LineVertexBuffer.Counter += count;
//}

DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, startColor: Vector3, endColor: Vector3, entityID: u64 = 0) { inline DrawLine(renderData, start, end, .{startColor.x, startColor.y, startColor.z, 1.0}, .{endColor.x, endColor.y, endColor.z, 1.0}, entityID); }
DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0) { inline DrawLine(renderData, start, end, color, color, entityID); }
DrawLine :: (using renderData: *RenderData, start: Vector3, end: Vector3, color: Vector3, entityID: u64 = 0) { inline DrawLine(renderData, start, end, color, color, entityID); }

DrawLine :: (using renderData: *RenderData, start: Vector2, end: Vector2, color := Vector4.{1.0, 1.0, 1.0, 1.0}, entityID: u64 = 0) { inline DrawLine(renderData, .{start.x, start.y, 0.0}, .{end.x, end.y, 0.0}, color, color, entityID); }
DrawLine :: (using renderData: *RenderData, start: Vector2, end: Vector2, startColor: Vector3, endColor: Vector3, entityID: u64 = 0) { inline DrawLine(renderData, .{start.x, start.y, 0.0}, .{end.x, end.y, 0.0}, .{startColor.x, startColor.y, startColor.z, 1.0}, .{endColor.x, endColor.y, endColor.z, 1.0}, entityID); }
DrawLine :: (using renderData: *RenderData, start: Vector2, end: Vector2, color: Vector3, entityID: u64 = 0) { inline DrawLine(renderData, .{start.x, start.y, 0.0}, .{end.x, end.y, 0.0}, color, color, entityID); }

// @TODO:
// Add support for color gradient and specifying vec3s instead of vec4s for colors
// Add support for 3D
DrawBezierCurve :: (using renderData: *RenderData, p0: Vector2, p1: Vector2, p2: Vector2, color: Vector4, steps: u32, entityID: u64 = 0)
{
	/*prevPointOnCurve := p0;
	for i: 0..steps-1
	{
		t: float = (i + 1.0) / steps;
		nextOnCurve := bezierLerp(p0, p1, p2, t);
		DrawLine(prevPointOnCurve, nextOnCurve, color, entityID);
		prevPointOnCurve = nextOnCurve;
	}*/
}

DrawBezierCurve :: (using renderData: *RenderData, p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, color: Vector4, steps: u32, entityID: u64 = 0)
{
	/*Vector2 prevPointOnCurve = p0;
	for (u32 i = 0; i < steps; i++)
	{
		float t = (i + 1.0) / steps;
		Vector2 nextOnCurve = bezierLerp(p0, p1, p2, p3, t);
		DrawLine(prevPointOnCurve, nextOnCurve, color, entityID);
		prevPointOnCurve = nextOnCurve;
	}*/
}

Font :: struct
{

}

DrawString :: (using renderData: *RenderData, text: string, font: Font, transform: Matrix4, color: Vector4, lineSpacing: float, kerning: float, entityID: u64 = 0)
{
	/*const auto& fontGeometry = font.Geometry;
	const auto& metrics = fontGeometry.getMetrics();
	u32 texID = font.TextureID;
	auto& fontAtlas = font.Tex;
	float texelWidth = 1.0 / fontAtlas.image.GetSize().x;
	float texelHeight = 1.0 / fontAtlas.image.GetSize().y;

	double x = 0.0;
	double fsScale = 1.0 / (metrics.ascenderY - metrics.descenderY);
	double y = 0.0;

	const float spaceGlyphAdvance = fontGeometry.getGlyph(' ')->getAdvance();

	for (u32 i = 0; i < string.size(); i++)
	{
		auto vertCount = VertexBuffer.GetSize();

		char character = string[i];

		if (character == '\r')
			continue;

		if (character == '\n')
		{
			x = 0;
			y -= fsScale * metrics.lineHeight + lineSpacing;
			continue;
		}

		if (character == ' ')
		{
			double advance = spaceGlyphAdvance;
			if (i < string.size() - 1)
			{
				char nextCharacter = string[i + 1];
				double dAdvance;
				fontGeometry.getAdvance(dAdvance, character, nextCharacter);
				advance = dAdvance;
			}

			x += fsScale * advance + kerning;
			continue;
		}

		if (character == '\t')
		{
			x += 4.0 * (fsScale * spaceGlyphAdvance + kerning);
			continue;
		}

		auto glyph = fontGeometry.getGlyph(character);

		if (!glyph)
			glyph = fontGeometry.getGlyph('?');

		if (!glyph) return;

		double al, ab, ar, at;
		glyph->getQuadAtlasBounds(al, ab, ar, at);
		glm::dvec2 texCoordMin(al, ab);
		glm::dvec2 texCoordMax(ar, at);

		double pl, pb, pr, pt;
		glyph->getQuadPlaneBounds(pl, pb, pr, pt);
		glm::dvec2 quadMin(pl, pb);
		glm::dvec2 quadMax(pr, pt);

		quadMin = quadMin * fsScale + glm::dvec2(x, y);
		quadMax = quadMax * fsScale + glm::dvec2(x, y);

		texCoordMin *= glm::dvec2(texelWidth, texelHeight);
		texCoordMax *= glm::dvec2(texelWidth, texelHeight);

		Vertex vertices[] = {
			Vertex(transform * Vector4(quadMax, 0.0, 1.0), texCoordMax, texID, color, entityID),
			Vertex(transform * Vector4(quadMin.x, quadMax.y, 0.0, 1.0), { texCoordMin.x, texCoordMax.y }, texID, color, entityID),
			Vertex(transform * Vector4(quadMin, 0.0, 1.0), texCoordMin, texID, color, entityID),
			Vertex(transform * Vector4(quadMax.x, quadMin.y, 0.0, 1.0), { texCoordMax.x, texCoordMin.y }, texID, color, entityID),
		};

		for (u32 i = 0; i < 4; i++)
		{
			vertices[i].Thickness = -1.0;
			VertexBuffer.Push(vertices[i]);
		}

		IndexBuffer.Push(0 + vertCount);
		IndexBuffer.Push(1 + vertCount);
		IndexBuffer.Push(2 + vertCount);

		IndexBuffer.Push(2 + vertCount);
		IndexBuffer.Push(3 + vertCount);
		IndexBuffer.Push(0 + vertCount);

		if (i < string.size() - 1)
		{
			double advance = glyph->getAdvance();
			char nextCharacter = string[i + 1];
			fontGeometry.getAdvance(advance, character, nextCharacter);

			x += fsScale * advance + kerning;
		}
	}*/
}

/*DrawString :: (string: string, const Font& font, Vector2 position, Vector2 scale, float rotation, color: Vector4, float lineSpacing, float kerning, entityID: u64 = 0)
{
	glm::mat4 transform = glm::translate(glm::mat4(1.0), { position.x, position.y, 0.0 }) * glm::rotate(glm::mat4(1.0), rotation, { 0.0, 0.0, 1.0 }) * glm::scale(glm::mat4(1.0), { scale.x, scale.y, 1.0 });
	DrawString(string, font, transform, color, lineSpacing, kerning, entityID);

}
DrawString :: (string: string, const Font& font, Vector2 position, color: Vector4, float lineSpacing, float kerning, entityID: u64 = 0)
{
	glm::mat4 transform = glm::translate(glm::mat4(1.0), { position.x, position.y, 0.0 });
	DrawString(string, font, transform, color, lineSpacing, kerning, entityID);
}*/

#scope_file

// @TODO: Remove this ugly hack
xyz :: inline (vec: Vector4) -> Vector3 { return .{vec.x, vec.y, vec.z}; }