#ifndef MATH_GLSL
#define MATH_GLSL

#define saturate(x) clamp(x, 0.0, 1.0)
#define atan2(x, y) atan(y, x)

float luminance(vec3 linear) { return dot(linear, vec3(0.2126, 0.7152, 0.0722)); }

vec3 ycbcrToRgb(float luminance, vec2 cbcr) 
{
    // Taken from https://developer.apple.com/documentation/arkit/arframe/2867984-capturedimage
    const mat4 ycbcrToRgbTransform = mat4(
         1.0000,  1.0000,  1.0000,  0.0000,
         0.0000, -0.3441,  1.7720,  0.0000,
         1.4020, -0.7141,  0.0000,  0.0000,
        -0.7010,  0.5291, -0.8860,  1.0000
    );
    return (ycbcrToRgbTransform * vec4(luminance, cbcr, 1.0)).rgb;
}

float rtLerp(vec3 uvw, float a, float b, float c) { return uvw.x * a + uvw.y * b + uvw.z * c; }
vec2 rtLerp(vec3 uvw, vec2 a, vec2 b, vec2 c) { return uvw.x * a + uvw.y * b + uvw.z * c; }
vec3 rtLerp(vec3 uvw, vec3 a, vec3 b, vec3 c) { return uvw.x * a + uvw.y * b + uvw.z * c; }
vec4 rtLerp(vec3 uvw, vec4 a, vec4 b, vec4 c) { return uvw.x * a + uvw.y * b + uvw.z * c; }

uint convertColor(vec4 color) 
{ // Remember! Convert from 0-1 to 0-255!
	int r = int(color.r);
	int g = int(color.g);
	int b = int(color.b);
	int a = int(color.a);
	return a << 24 | b << 16 | g << 8 | r;
}

vec4 decompress(uint num) 
{ // Remember! Convert from 0-255 to 0-1!
    vec4 Output;
    Output.r = float((num & uint(0x000000ff)));
    Output.g = float((num & uint(0x0000ff00)) >> 8);
    Output.b = float((num & uint(0x00ff0000)) >> 16);
    Output.a = float((num & uint(0xff000000)) >> 24);
    return Output;
}

// NOTE: x and z are swapped here cuz idk... gpus...
int to1D(ivec3 pos, uint size) { return int((pos.x * size * size) + (pos.y * size) + pos.z); }
	
ivec3 to3D(int i, ivec3 size) 
{
	int z = i / (size.x * size.y);
	i -= (z * size.x * size.y);
	int y = i / size.x;
	int x = i % size.x;
	return ivec3(x, y, z);
}

#endif