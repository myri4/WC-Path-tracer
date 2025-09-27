#ifndef RANDOM_GLSL
#define RANDOM_GLSL

#include "constants.glsl"

// PCG hash, see:
// https://www.reedbeta.com/blog/hash-functions-for-gpu-rendering/

// Used as initial seed to the PRNG.
uint pcg_hash(uint seed)
{
	uint state = seed * 747796405u + 2891336453u;
	uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
	return (word >> 22u) ^ word;
}

// Used to advance the PCG state.
uint rand_pcg(inout uint rng_state)
{
	uint state = rng_state;
	rng_state = rng_state * 747796405u + 2891336453u;
	uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
	return (word >> 22u) ^ word;
}

// Advances the prng state and returns the corresponding random float.
float rand(inout uint state)
{
	uint x = rand_pcg(state);
	state = x;
	return float(x) * uintBitsToFloat(0x2f800000u);
}

/*
uvec2 ucoord = uvec2(gl_FragCoord.xy);
uint pixel_index = ucoord.x + ucoord.y * uint(u_viewportWidth);
uint seed = pcg_hash(pixel_index);

// a random vec3 in [0, 1]
fragColor = vec3(rand(seed), rand(seed), rand(seed));
*/

float RandomValueNormalDistribution(inout uint seed)
{
	float theta = 2.f * PI * rand(seed);
	float rho = sqrt(-2.f * log(rand(seed)));
	return rho * cos(theta);
}

vec3 RandomDirection(inout uint seed)
{
	float x = RandomValueNormalDistribution(seed);
	float y = RandomValueNormalDistribution(seed);
	float z = RandomValueNormalDistribution(seed);
	return normalize(vec3(x, y, z));
}

vec3 RandomHemisphereDirection(vec3 normal, inout uint seed)
{
	vec3 dir = RandomDirection(seed);
	return dir * sign(dot(normal, dir));
}

#endif