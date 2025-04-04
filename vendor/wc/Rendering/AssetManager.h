#pragma once

#include <unordered_map>
#include <vector>

#include "Texture.h"
#include "../Utils/Image.h"
#include "Font.h"

namespace blaze
{
    struct AssetManager
    {
        std::unordered_map<std::string, uint32_t> TextureCache;
        std::unordered_map<std::string, uint32_t> FontCache;

        std::vector<Texture> Textures;
        std::vector<Font> Fonts;

        bool TexturesUpdated = false; // This is set to true when a new texture is loaded. It's used to signal when we need to resize the descriptor set

        void Init()
        {
			Texture texture;
			uint32_t white = 0xFFFFFFFF;
			texture.Load(&white, 1, 1);
            PushTexture(texture, "None");
        }

        void Free()
        {
			for (auto& texture : Textures)
                texture.Destroy();

            Textures.clear();
            TextureCache.clear();
        }

		uint32_t LoadFont(const std::string& file)
		{
			if (FontCache.find(file) != FontCache.end())
				return FontCache[file];

			if (std::filesystem::exists(file))
			{
                auto& font = Fonts.emplace_back();
				
				font.Load(file, *this);
                TexturesUpdated = true;
                FontCache[file] = uint32_t(Fonts.size() - 1);

				return uint32_t(Fonts.size() - 1);
			}

            FontCache[file] = 0;
			WC_CORE_ERROR("Cannot find file at location: {}", file);
			return 0;
		}

		uint32_t PushTexture(const Texture& texture)
		{
			Textures.emplace_back(texture);
            TexturesUpdated = true;

			return uint32_t(Textures.size() - 1);
		}

        uint32_t PushTexture(const Texture& texture, const std::string& name)
        {
            if (TextureCache.find(name) != TextureCache.end())
                return TextureCache[name];

            auto texID = PushTexture(texture);

            TextureCache[name] = texID;
            return texID;
        }

        uint32_t LoadTexture(const std::string& file, Texture& texture, bool mipMapping = false)
        {
            if (TextureCache.find(file) != TextureCache.end())
                return TextureCache[file];

            if (std::filesystem::exists(file))
            {
                texture.Load(file, mipMapping);

                return PushTexture(texture, file);
            }

            texture = Textures[0];
            TextureCache[file] = 0;
            WC_CORE_ERROR("Cannot find file at location: {}", file);
            return 0;
        }

        uint32_t LoadTexture(const std::string& file, bool mipMapping = false)
        {
            Texture texture;
            return LoadTexture(file, texture, mipMapping);
        }

        uint32_t LoadTextureFromMemory(const Image& image, const std::string& name)
        {
            if (TextureCache.find(name) != TextureCache.end())
                return TextureCache[name];

            Texture texture;
            texture.Load(image.Data, image.Width, image.Height);

            return PushTexture(texture, name);
        }

		uint32_t AllocateTexture(const TextureSpecification& specification)
		{
			Texture texture;
			texture.Allocate(specification);

			return PushTexture(texture);
		}
    };
}
