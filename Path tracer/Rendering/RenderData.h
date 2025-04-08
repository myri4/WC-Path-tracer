#pragma once

#include "vk/Buffer.h"
#include "vk/Image.h"

#include <glm/glm.hpp>

#include "Font.h"

#undef LoadImage

namespace blaze
{
	struct Vertex
	{
		glm::vec3 Position;
		uint32_t TextureID = 0;
		glm::vec2 TexCoords;
		float Fade = 0.f;
		float Thickness = 0.f;
		uint64_t EntityID = 0;

		glm::vec4 Color;
		Vertex() = default;
		Vertex(const glm::vec3& pos, glm::vec2 texCoords, uint32_t texID, const glm::vec4& color, uint64_t eid) : Position(pos), TexCoords(texCoords), TextureID(texID), Color(color), EntityID(eid) {}
		Vertex(const glm::vec3& pos, glm::vec2 texCoords, float thickness, float fade, const glm::vec4& color, uint64_t eid) : Position(pos), TexCoords(texCoords), Thickness(thickness), Fade(fade), Color(color), EntityID(eid) {}
	};

	struct LineVertex
	{
		glm::vec3 Position;

		glm::vec4 Color;
		uint64_t EntityID = 0;

		LineVertex() = default;
		LineVertex(const glm::vec3& pos, const glm::vec4& color, uint64_t eid) : Position(pos), Color(color), EntityID(eid) {}
	};

	struct RenderData
	{
		vk::DBufferManager<Vertex, vk::DEVICE_ADDRESS> VertexBuffer;
		vk::DBufferManager<uint32_t, vk::INDEX_BUFFER> IndexBuffer;
		vk::DBufferManager<LineVertex, vk::DEVICE_ADDRESS> LineVertexBuffer;

		auto GetVertexBuffer() const { return VertexBuffer.GetBuffer(); }
		auto GetIndexBuffer() const { return IndexBuffer.GetBuffer(); }

		auto GetLineVertexBuffer() const { return LineVertexBuffer.GetBuffer(); }

		auto GetIndexCount() const { return IndexBuffer.GetSize(); }
		auto GetVertexCount() const { return VertexBuffer.GetSize(); }

		auto GetLineVertexCount() const { return LineVertexBuffer.GetSize(); }

		void UploadVertexData();

		void UploadLineVertexData();

		void Reset();

		void Free();

		void DrawQuad(const glm::mat4& transform, uint32_t texID, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawLineQuad(const glm::mat4& transform, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawLineQuad(glm::vec2 start, glm::vec2 end, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawQuad(const glm::vec3& position, glm::vec2 size, uint32_t texID = 0, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		// Note: Rotation should be in radians
		void DrawQuad(const glm::vec3& position, glm::vec2 size, float rotation, uint32_t texID = 0, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawTriangle(glm::vec2 v1, glm::vec2 v2, glm::vec2 v3, uint32_t texID, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawCircle(const glm::mat4& transform, float thickness = 1.f, float fade = 0.05f, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawCircle(glm::vec3 position, float radius, float thickness = 1.f, float fade = 0.05f, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);

		void DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec4& startColor, const glm::vec4& endColor, uint64_t entityID = 0);

		//void DrawLines(const LineVertex* vertices, uint32_t count)
		//{
		//	memcpy(LineVertexBuffer + LineVertexBuffer.Counter * sizeof(LineVertex), vertices, count * sizeof(LineVertex));
		//	LineVertexBuffer.Counter += count;
		//}

		void DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec3& startColor, const glm::vec3& endColor, uint64_t entityID = 0);
		void DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);
		void DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec3& color, uint64_t entityID = 0);


		void DrawLine(glm::vec2 start, glm::vec2 end, const glm::vec4& color = glm::vec4(1.f), uint64_t entityID = 0);
		void DrawLine(glm::vec2 start, glm::vec2 end, const glm::vec3& startColor, const glm::vec3& endColor, uint64_t entityID = 0);
		void DrawLine(glm::vec2 start, glm::vec2 end, const glm::vec3& color, uint64_t entityID = 0);

		// @TODO:
		// Add support for color gradient and specifying vec3s instead of vec4s for colors
		// Add support for 3D
		void DrawBezierCurve(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, const glm::vec4& color = glm::vec4(1.f), uint32_t steps = 30, uint64_t entityID = 0);

		void DrawBezierCurve(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, glm::vec2 p3, const glm::vec4& color = glm::vec4(1.f), uint32_t steps = 30, uint64_t entityID = 0);

		void DrawString(const std::string& string, const Font& font, const glm::mat4& transform, const glm::vec4& color = glm::vec4(1.f), float lineSpacing = 0.f, float kerning = 0.f, uint64_t entityID = 0);

		void DrawString(const std::string& string, const Font& font, glm::vec2 position, glm::vec2 scale, float rotation, const glm::vec4& color = glm::vec4(1.f), float lineSpacing = 0.f, float kerning = 0.f, uint64_t entityID = 0);

		void DrawString(const std::string& string, const Font& font, glm::vec2 position, const glm::vec4& color = glm::vec4(1.f), float lineSpacing = 0.f, float kerning = 0.f, uint64_t entityID = 0);
	};
}
