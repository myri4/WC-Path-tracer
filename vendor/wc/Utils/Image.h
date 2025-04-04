#pragma once

#include <glm/glm.hpp>
#include <string>

#include <stb_image/stb_image.h>
#include <stb_image/stb_write.h>

namespace wc
{
	struct Image
	{
		uint8_t* Data = nullptr;
		uint32_t Width = 0, Height = 0, Channels = 0, bytes_per_scanline = 0;

		Image() = default;
		Image(uint32_t width, uint32_t height, uint32_t channels) {	Allocate(width, height, channels); }
		Image(void* data, uint32_t width, uint32_t height, uint32_t channels) { Init(data, width, height, channels); }

		void Init(void* data, uint32_t width, uint32_t height, uint32_t channels)
		{
			Width = width;
			Height = height;
			Channels = channels;
			bytes_per_scanline = Width * channels;
			Data = (uint8_t*)data;
		}

		void Allocate(uint32_t width, uint32_t height, uint32_t channels)
		{
			Width = width;
			Height = height;
			Channels = channels;
			bytes_per_scanline = Width * channels;
			Data = new uint8_t[Width * Height * Channels];
		}

		void Load(const std::string& file, int reqComp = 0)
		{
			int width, height, channels;
			Data = stbi_load(file.c_str(), &width, &height, &channels, reqComp);
			Width = width;
			Height = height;
			Channels = reqComp != 0 ? reqComp : channels;
			bytes_per_scanline = Width * Channels;
		}

		void Save(const std::string& file)
		{
			stbi_write_png(file.c_str(), Width, Height, Channels, Data, bytes_per_scanline);
		}

		glm::vec4 Color(uint32_t x, uint32_t y)
		{
			glm::vec4 color;
			color.r = Data[y * bytes_per_scanline + x * Channels + 0];
			color.g = Data[y * bytes_per_scanline + x * Channels + 1];
			color.b = Data[y * bytes_per_scanline + x * Channels + 2];
			color.a = Data[y * bytes_per_scanline + x * Channels + 3];
			return color;
		}

		void Set(uint32_t x, uint32_t y, const glm::vec4& color)
		{
			Data[y * bytes_per_scanline + x * Channels + 0] = (uint8_t)color.r;
			Data[y * bytes_per_scanline + x * Channels + 1] = (uint8_t)color.g;
			Data[y * bytes_per_scanline + x * Channels + 2] = (uint8_t)color.b;
			Data[y * bytes_per_scanline + x * Channels + 3] = (uint8_t)color.a;
		}

		auto AllocSize() { return Width * Height * Channels; }

		void Free() { free(Data); }
	};
}