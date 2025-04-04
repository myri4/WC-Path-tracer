#pragma once

#include <cstdlib>
#include <cstdint>
#include <cstring>

namespace wc
{
	struct Buffer
	{
		void* Data = nullptr;
		size_t Size = 0;

		Buffer() = default;

		Buffer(size_t size) { Allocate(size); }

		Buffer(const Buffer&) = default;

		static Buffer Copy(Buffer other)
		{
			Buffer result(other.Size);
			memcpy(result.Data, other.Data, other.Size);
			return result;
		}

		void Allocate()	{ Data = malloc(Size);	}

		void Allocate(size_t size)
		{
			Free();

			Size = size;
			Allocate();
		}

		void Free()
		{
			free(Data);
			Data = nullptr;
			Size = 0;
		}

		template<typename T>
		T* As()	{ return (T*)Data; }

		operator bool() const {	return (bool)Data; }
	};

	// @TODO:
	// Add Realloc
	// Search for potential improvements
	template<typename T>
	struct FPtr // Short for fat pointer
	{
		T* Data = nullptr;
		uint32_t Count = 0;

		FPtr() = default;
		FPtr(const FPtr&) = default;

		FPtr(uint32_t count) { Allocate(count); }

		void Allocate() { Data = new T[Count];	}

		void Allocate(uint32_t count)
		{
			Free();

			Count = count;
			Allocate();
		}

		void Free()
		{
			delete[] Data;
			Data = nullptr;
			Count = 0;
		}

		const T& operator [](uint32_t index) const { return Data[index]; }
		T& operator [](uint32_t index) { return Data[index]; }

		T* begin() { return Data; }
		T* end() { return Data + Count; }

		const T* begin() const { return Data; }
		const T* end() const { return Data + Count; }

		operator bool() const {	return (bool)Data; }
	};
}