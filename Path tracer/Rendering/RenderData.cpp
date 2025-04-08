#include "RenderData.h"

#include "vk/Commands.h"

#include "AssetManager.h"

#include "../Utils/Image.h"
#include "../Math/Splines.h"

#include <glm/gtc/matrix_transform.hpp>

namespace blaze
{
	void RenderData::UploadVertexData()
	{
		vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
			IndexBuffer.Update(cmd);
			VertexBuffer.Update(cmd);
			IndexBuffer.GetBuffer().SetName("IndexBuffer");
			VertexBuffer.GetBuffer().SetName("VertexBuffer");
			});
	}

	void RenderData::UploadLineVertexData()
	{
		vk::SyncContext::ImmediateSubmit([&](VkCommandBuffer cmd) {
			LineVertexBuffer.Update(cmd);
			});
	}

	void RenderData::Reset()
	{
		IndexBuffer.Reset();
		VertexBuffer.Reset();
		LineVertexBuffer.Reset();
	}

	void RenderData::Free()
	{
		VertexBuffer.Free();
		IndexBuffer.Free();
		LineVertexBuffer.Free();
	}

	void RenderData::DrawQuad(const glm::mat4& transform, uint32_t texID, const glm::vec4& color, uint64_t entityID)
	{
		auto vertCount = VertexBuffer.GetSize();

		VertexBuffer.Push({ transform * glm::vec4(0.5f,  0.5f, 0.f, 1.f), { 1.f, 0.f }, texID, color, entityID });
		VertexBuffer.Push({ transform * glm::vec4(-0.5f,  0.5f, 0.f, 1.f), { 0.f, 0.f }, texID, color, entityID });
		VertexBuffer.Push({ transform * glm::vec4(-0.5f, -0.5f, 0.f, 1.f), { 0.f, 1.f }, texID, color, entityID });
		VertexBuffer.Push({ transform * glm::vec4(0.5f, -0.5f, 0.f, 1.f), { 1.f, 1.f }, texID, color, entityID });

		IndexBuffer.Push(0 + vertCount);
		IndexBuffer.Push(1 + vertCount);
		IndexBuffer.Push(2 + vertCount);

		IndexBuffer.Push(2 + vertCount);
		IndexBuffer.Push(3 + vertCount);
		IndexBuffer.Push(0 + vertCount);
	}

	void RenderData::DrawLineQuad(const glm::mat4& transform, const glm::vec4& color, uint64_t entityID)
	{
		glm::vec3 vertices[4];
		vertices[0] = transform * glm::vec4(0.5f, 0.5f, 0.f, 1.f);
		vertices[1] = transform * glm::vec4(-0.5f, 0.5f, 0.f, 1.f);
		vertices[2] = transform * glm::vec4(-0.5f, -0.5f, 0.f, 1.f);
		vertices[3] = transform * glm::vec4(0.5f, -0.5f, 0.f, 1.f);
		DrawLine(vertices[0], vertices[1], color, entityID);
		DrawLine(vertices[1], vertices[2], color, entityID);
		DrawLine(vertices[2], vertices[3], color, entityID);
		DrawLine(vertices[3], vertices[0], color, entityID);
	}

	void RenderData::DrawLineQuad(glm::vec2 start, glm::vec2 end, const glm::vec4& color, uint64_t entityID)
	{
		glm::vec3 vertices[4];
		vertices[0] = glm::vec4(end.x, end.y, 0.f, 1.f);
		vertices[1] = glm::vec4(start.x, end.y, 0.f, 1.f);
		vertices[2] = glm::vec4(start.x, start.y, 0.f, 1.f);
		vertices[3] = glm::vec4(end.x, start.y, 0.f, 1.f);
		DrawLine(vertices[0], vertices[1], color, entityID);
		DrawLine(vertices[1], vertices[2], color, entityID);
		DrawLine(vertices[2], vertices[3], color, entityID);
		DrawLine(vertices[3], vertices[0], color, entityID);
	}

	void RenderData::DrawQuad(const glm::vec3& position, glm::vec2 size, uint32_t texID, const glm::vec4& color, uint64_t entityID)
	{
		glm::mat4 transform = glm::translate(glm::mat4(1.f), position) * glm::scale(glm::mat4(1.f), { size.x, size.y, 1.f });
		DrawQuad(transform, texID, color, entityID);
	}

	// Note: Rotation should be in radians
	void RenderData::DrawQuad(const glm::vec3& position, glm::vec2 size, float rotation, uint32_t texID, const glm::vec4& color, uint64_t entityID)
	{
		glm::mat4 transform = glm::translate(glm::mat4(1.f), position) * glm::rotate(glm::mat4(1.f), rotation, { 0.f, 0.f, 1.f }) * glm::scale(glm::mat4(1.f), { size.x, size.y, 1.f });
		DrawQuad(transform, texID, color, entityID);
	}

	void RenderData::DrawTriangle(glm::vec2 v1, glm::vec2 v2, glm::vec2 v3, uint32_t texID, const glm::vec4& color, uint64_t entityID)
	{
		auto vertCount = VertexBuffer.GetSize();
		VertexBuffer.Push({ glm::vec4(v1, 0.f, 1.f), { 1.f, 0.f }, texID, color, entityID });
		VertexBuffer.Push({ glm::vec4(v2, 0.f, 1.f), { 0.f, 0.f }, texID, color, entityID });
		VertexBuffer.Push({ glm::vec4(v3, 0.f, 1.f), { 0.f, 1.f }, texID, color, entityID });

		IndexBuffer.Push(0 + vertCount);
		IndexBuffer.Push(1 + vertCount);
		IndexBuffer.Push(2 + vertCount);
	}

	void RenderData::DrawCircle(const glm::mat4& transform, float thickness, float fade, const glm::vec4& color, uint64_t entityID)
	{
		auto vertCount = VertexBuffer.GetSize();

		VertexBuffer.Push({ transform * glm::vec4(1.f, 1.f, 0.f, 1.f),  {  1.f, 1.f }, thickness, fade, color, entityID });
		VertexBuffer.Push({ transform * glm::vec4(-1.f, 1.f, 0.f, 1.f),  { -1.f, 1.f }, thickness, fade, color, entityID });
		VertexBuffer.Push({ transform * glm::vec4(-1.f, -1.f, 0.f, 1.f), { -1.f,-1.f }, thickness, fade, color, entityID });
		VertexBuffer.Push({ transform * glm::vec4(1.f, -1.f, 0.f, 1.f), {  1.f,-1.f }, thickness, fade, color, entityID });

		IndexBuffer.Push(0 + vertCount);
		IndexBuffer.Push(1 + vertCount);
		IndexBuffer.Push(2 + vertCount);

		IndexBuffer.Push(2 + vertCount);
		IndexBuffer.Push(3 + vertCount);
		IndexBuffer.Push(0 + vertCount);
	}

	void RenderData::DrawCircle(glm::vec3 position, float radius, float thickness, float fade, const glm::vec4& color, uint64_t entityID)
	{
		auto transform = glm::translate(glm::mat4(1.f), position) * glm::scale(glm::mat4(1.f), { radius, radius, 1.f });
		DrawCircle(transform, thickness, fade, color, entityID);
	}

	void RenderData::DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec4& startColor, const glm::vec4& endColor, uint64_t entityID)
	{
		LineVertexBuffer.Push({ glm::vec4(start, 1.f), startColor, entityID });
		LineVertexBuffer.Push({ glm::vec4(end, 1.f), endColor, entityID });
	}

	//void DrawLines(const LineVertex* vertices, uint32_t count)
	//{
	//	memcpy(LineVertexBuffer + LineVertexBuffer.Counter * sizeof(LineVertex), vertices, count * sizeof(LineVertex));
	//	LineVertexBuffer.Counter += count;
	//}

	void RenderData::DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec3& startColor, const glm::vec3& endColor, uint64_t entityID) { DrawLine(start, end, glm::vec4(startColor, 1.f), glm::vec4(endColor, 1.f), entityID); }
	void RenderData::DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec4& color, uint64_t entityID) { DrawLine(start, end, color, color, entityID); }
	void RenderData::DrawLine(const glm::vec3& start, const glm::vec3& end, const glm::vec3& color, uint64_t entityID) { DrawLine(start, end, color, color, entityID); }


	void RenderData::DrawLine(glm::vec2 start, glm::vec2 end, const glm::vec4& color, uint64_t entityID) { DrawLine(glm::vec3(start, 0.f), glm::vec3(end, 0.f), color, color, entityID); }
	void RenderData::DrawLine(glm::vec2 start, glm::vec2 end, const glm::vec3& startColor, const glm::vec3& endColor, uint64_t entityID) { DrawLine(glm::vec3(start, 0.f), glm::vec3(end, 0.f), glm::vec4(startColor, 1.f), glm::vec4(endColor, 1.f), entityID); }
	void RenderData::DrawLine(glm::vec2 start, glm::vec2 end, const glm::vec3& color, uint64_t entityID) { DrawLine(glm::vec3(start, 0.f), glm::vec3(end, 0.f), color, color, entityID); }

	// @TODO:
	// Add support for color gradient and specifying vec3s instead of vec4s for colors
	// Add support for 3D
	void RenderData::DrawBezierCurve(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, const glm::vec4& color, uint32_t steps, uint64_t entityID)
	{
		glm::vec2 prevPointOnCurve = p0;
		for (uint32_t i = 0; i < steps; i++)
		{
			float t = (i + 1.f) / steps;
			glm::vec2 nextOnCurve = bezierLerp(p0, p1, p2, t);
			DrawLine(prevPointOnCurve, nextOnCurve, color, entityID);
			prevPointOnCurve = nextOnCurve;
		}
	}

	void RenderData::DrawBezierCurve(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, glm::vec2 p3, const glm::vec4& color, uint32_t steps, uint64_t entityID)
	{
		glm::vec2 prevPointOnCurve = p0;
		for (uint32_t i = 0; i < steps; i++)
		{
			float t = (i + 1.f) / steps;
			glm::vec2 nextOnCurve = bezierLerp(p0, p1, p2, p3, t);
			DrawLine(prevPointOnCurve, nextOnCurve, color, entityID);
			prevPointOnCurve = nextOnCurve;
		}
	}

	void RenderData::DrawString(const std::string& string, const Font& font, const glm::mat4& transform, const glm::vec4& color, float lineSpacing, float kerning, uint64_t entityID)
	{
		const auto& fontGeometry = font.Geometry;
		const auto& metrics = fontGeometry.getMetrics();
		uint32_t texID = font.TextureID;
		auto& fontAtlas = font.Tex;
		float texelWidth = 1.f / fontAtlas.image.GetSize().x;
		float texelHeight = 1.f / fontAtlas.image.GetSize().y;

		double x = 0.0;
		double fsScale = 1.0 / (metrics.ascenderY - metrics.descenderY);
		double y = 0.0;

		const float spaceGlyphAdvance = fontGeometry.getGlyph(' ')->getAdvance();

		for (uint32_t i = 0; i < string.size(); i++)
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
				x += 4.f * (fsScale * spaceGlyphAdvance + kerning);
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
				Vertex(transform * glm::vec4(quadMax, 0.f, 1.f), texCoordMax, texID, color, entityID),
				Vertex(transform * glm::vec4(quadMin.x, quadMax.y, 0.f, 1.f), { texCoordMin.x, texCoordMax.y }, texID, color, entityID),
				Vertex(transform * glm::vec4(quadMin, 0.f, 1.f), texCoordMin, texID, color, entityID),
				Vertex(transform * glm::vec4(quadMax.x, quadMin.y, 0.f, 1.f), { texCoordMax.x, texCoordMin.y }, texID, color, entityID),
			};

			for (uint32_t i = 0; i < 4; i++)
			{
				vertices[i].Thickness = -1.f;
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
		}
	}

	void RenderData::DrawString(const std::string& string, const Font& font, glm::vec2 position, glm::vec2 scale, float rotation, const glm::vec4& color, float lineSpacing, float kerning, uint64_t entityID)
	{
		glm::mat4 transform = glm::translate(glm::mat4(1.f), { position.x, position.y, 0.f }) * glm::rotate(glm::mat4(1.f), rotation, { 0.f, 0.f, 1.f }) * glm::scale(glm::mat4(1.f), { scale.x, scale.y, 1.f });
		DrawString(string, font, transform, color, lineSpacing, kerning, entityID);
	}

	void RenderData::DrawString(const std::string& string, const Font& font, glm::vec2 position, const glm::vec4& color, float lineSpacing, float kerning, uint64_t entityID)
	{
		glm::mat4 transform = glm::translate(glm::mat4(1.f), { position.x, position.y, 0.f });
		DrawString(string, font, transform, color, lineSpacing, kerning, entityID);
	}
}
