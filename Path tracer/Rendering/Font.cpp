#include "Font.h"
#include "RenderData.h"

#include "AssetManager.h"
#include "../Utils/Image.h"

namespace wc
{
	void Font::Load(const std::string filepath, AssetManager& assetManager)
    {
        msdfgen::FreetypeHandle* ft = msdfgen::initializeFreetype();

        if (!ft) return; // @TODO: Handle errors

        msdfgen::FontHandle* font = loadFont(ft, filepath.c_str());
        if (!font) return;

        struct CharsetRange
        {
            uint32_t Begin, End;
        };

        // From imgui_draw.cpp
        static const CharsetRange charsetRanges[] =
        {
            { 0x0020, 0x00FF }
        };

        msdf_atlas::Charset charset;
        for (auto& range : charsetRanges)
        {
            for (uint32_t c = range.Begin; c <= range.End; c++)
                charset.add(c);
        }

        Geometry = msdf_atlas::FontGeometry(&Glyphs);
        Geometry.loadCharset(font, 1.0, charset);


        double emSize = 40.0;

        msdf_atlas::TightAtlasPacker atlasPacker;
        // atlasPacker.setDimensionsConstraint()
        atlasPacker.setPixelRange(2.0);
        atlasPacker.setMiterLimit(1.0);
        atlasPacker.setPadding(0);
        atlasPacker.setScale(emSize);
        atlasPacker.pack(Glyphs.data(), (int)Glyphs.size());


        int width, height;
        atlasPacker.getDimensions(width, height);
        emSize = atlasPacker.getScale();

#define DEFAULT_ANGLE_THRESHOLD 3.0
#define LCG_MULTIPLIER 6364136223846793005ull
#define LCG_INCREMENT 1442695040888963407ull
#define THREAD_COUNT 8
        // if MSDF || MTSDF

        uint64_t coloringSeed = 0;
        bool expensiveColoring = false;
        if (expensiveColoring)
        {
            msdf_atlas::Workload([&glyphs = Glyphs, &coloringSeed](int i, int threadNo) -> bool {
                unsigned long long glyphSeed = (LCG_MULTIPLIER * (coloringSeed ^ i) + LCG_INCREMENT) * !!coloringSeed;
                glyphs[i].edgeColoring(msdfgen::edgeColoringInkTrap, DEFAULT_ANGLE_THRESHOLD, glyphSeed);
                return true;
                }, Glyphs.size()).finish(THREAD_COUNT);
        }
        else
        {
            unsigned long long glyphSeed = coloringSeed;
            for (msdf_atlas::GlyphGeometry& glyph : Glyphs)
            {
                glyphSeed *= LCG_MULTIPLIER;
                glyph.edgeColoring(msdfgen::edgeColoringInkTrap, DEFAULT_ANGLE_THRESHOLD, glyphSeed);
            }
        }

        msdf_atlas::GeneratorAttributes attributes;
        attributes.config.overlapSupport = true;
        attributes.scanlinePass = true;

        msdf_atlas::ImmediateAtlasGenerator<float, 3, msdf_atlas::msdfGenerator, msdf_atlas::BitmapAtlasStorage<uint8_t, 3>> generator(width, height);
        generator.setAttributes(attributes);
        generator.setThreadCount(8);
        generator.generate(Glyphs.data(), (int)Glyphs.size());

        auto bitmap = (msdfgen::BitmapConstRef<uint8_t, 3>)generator.atlasStorage();
        auto bytes_per_scanline = bitmap.width * 3;

        Image newBitmap(bitmap.width, bitmap.height, 4);

        for (uint32_t x = 0; x < bitmap.width; x++)
            for (uint32_t y = 0; y < bitmap.height; y++)
            {
                glm::vec3 col;
                col.r = bitmap.pixels[y * bytes_per_scanline + x * 3 + 0];
                col.g = bitmap.pixels[y * bytes_per_scanline + x * 3 + 1];
                col.b = bitmap.pixels[y * bytes_per_scanline + x * 3 + 2];
                newBitmap.Set(x, y, glm::vec4(col, 255.f));
            }

        Tex.Load(newBitmap.Data, newBitmap.Width, newBitmap.Height);
        TextureID = assetManager.PushTexture(Tex, filepath);
        newBitmap.Free();

        destroyFont(font);
        deinitializeFreetype(ft);
    }

    glm::vec2 Font::CalculateTextSize(const std::string& string, float lineSpacing, float kerning)
    {
		const auto& fontGeometry = Geometry;
		const auto& metrics = fontGeometry.getMetrics();

		glm::dvec2 begin = glm::dvec2(0.0), end = glm::dvec2(0.0);

		double x = 0.0;
		double y = 0.0;
		double fsScale = 1.0 / (metrics.ascenderY - metrics.descenderY);

		const double spaceGlyphAdvance = fontGeometry.getGlyph(' ')->getAdvance();

		for (uint32_t i = 0; i < string.size(); i++)
		{
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

			if (!glyph)
				return glm::dvec2(0.0);

			double pl, pb, pr, pt;
			glyph->getQuadPlaneBounds(pl, pb, pr, pt);
			glm::dvec2 quadMin(pl, pb);
			glm::dvec2 quadMax(pr, pt);

			quadMin = quadMin * fsScale + glm::dvec2{x, y};
			quadMax = quadMax * fsScale + glm::dvec2{x, y};

			begin = glm::min(begin, quadMin);
			end = glm::max(end, quadMax);

			if (i < string.size() - 1)
			{
				double advance = glyph->getAdvance();
				char nextCharacter = string[i + 1];
				fontGeometry.getAdvance(advance, character, nextCharacter);

				x += fsScale * advance + kerning;
			}
		}
		return end - begin;
    }
}
