#ifndef CONSTANTS_GLSL
#define CONSTANTS_GLSL

const float Epsilon = 1e-4;
const float bias = 1e-5;
const float kInfinity = 3.402823466e+38F;
//const float MAX_FLOAT = uintBitsToFloat(0x7f7fffffu);

const float PI = 3.14159265358979323846264338327950288;
const float TAU = PI * 2.0;
const float HPI = PI * 0.5;
const float QPI = PI * 0.25;
const float IPI = 1.f / PI;
const float ITAU = 1.f / TAU;

// Golden ratio: (1 + sqrt(5)) / 2
const float PHI = 1.61803398875;

const float MIN_ROUGHNESS = 0.002025;
const float MIN_PERCEPTUAL_ROUGHNESS = 0.045;

#endif