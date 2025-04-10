#pragma once

#include "Utils/Log.h"
#include "Utils/Image.h"

#include <vector>

#include "Geometry.h"

#include "Renderers/PathTracingRenderer.h"

using namespace glm;

vec3 Tonemap_PBRNeutral(vec3 color)
{
	const float startCompression = 0.8f - 0.04f;
	const float desaturation = 0.15f;

	float x = min(color.r, min(color.g, color.b));
	float offset = x < 0.08f ? x - 6.25f * x * x : 0.04f;
	color -= offset;

	float peak = max(color.r, max(color.g, color.b));
	if (peak < startCompression)
		return color;

	const float d = 1.0f - startCompression;
	float newPeak = 1.0f - d * d / (peak + d - startCompression);
	color *= newPeak / peak;

	float g = 1.0f - 1.0f / (desaturation * (peak - newPeak) + 1.0f);
	return mix(color, newPeak * vec3(1.0f), g);
}

struct Scene
{
    Camera camera;
    uint32_t Samples = 10;
    uint32_t Depth = 5;

    std::vector<Sphere> Spheres;
    std::vector<Material> Materials;

    wc::Image image;

    MaterialID PushMaterial()
    {
        Materials.push_back(Material());
        return Materials.size() - 1;
    }

    bool Intersect(const Ray& ray, HitInfo& rec)
    {
        HitInfo temp_rec;
        bool hit_anything = false;
        float t = 150.0f;

        for (const auto& object : Spheres)
        {
            if (object.Intersect(ray, 0.001f, t, temp_rec))
            {
                hit_anything = true;
                t = temp_rec.t;
                rec = temp_rec;
            }
        }

        return hit_anything;
    }

    vec3 TraceRay2(const Ray& ray, uint32_t depth)
    {
        if (depth == 0) return vec3(0.f);

        HitInfo rec;
        if (!Intersect(ray, rec))
            return vec3(0.0f);// mix(vec3(1.f), vec3(0.5f, 0.7f, 1.f), 0.5f * (ray.Direction.y + 1.f));

        Ray scattered;
        vec3 attenuation;
        vec3 emmission = Materials[rec.material].emission;
        if (!Materials[rec.material].scatter(ray, rec, attenuation, scattered))
            return emmission;

        return emmission + attenuation * TraceRay2(scattered, depth - 1);
    }

    vec3 TraceRay(Ray ray)
    {
        vec3 incomingLight = vec3(0.0f);
        vec3 rayColor = vec3(1.0f);

        for (uint32_t i = 0; i <= Depth; i++)
        {
            HitInfo rec;
            if (!Intersect(ray, rec))
                return vec3(0.0f);// mix(vec3(1.f), vec3(0.5f, 0.7f, 1.f), 0.5f * (ray.Direction.y + 1.f));

            vec3 attenuation;
            if (!Materials[rec.material].scatter(ray, rec, attenuation, ray)) 
                return incomingLight + Materials[rec.material].emission * rayColor;

            incomingLight += Materials[rec.material].emission * rayColor;
            rayColor *= attenuation;
        }

        return incomingLight;
    }    

    void Render()
    {
        camera.Update();
        for (uint32_t y = 0; y < image.Height; y++)
        {
            for (uint32_t x = 0; x < image.Width; x++)
            {
                vec2 coord = { (float)x / (float)image.Width, (float)y / (float)image.Height };
                coord.y = 1.f - coord.y;
                coord = coord * 2.f - 1.f; // -1 -> 1
                vec4 target = camera.inverseProjection * vec4(coord.x, coord.y, 1, 1);
                vec3 rayDirection = vec3(camera.inverseView * vec4(normalize(vec3(target) / target.w), 0.0f));

                vec3 result;

                for (int sample = 0; sample < Samples; sample++)
                    result += TraceRay(Ray(camera.position, rayDirection));

                result /= Samples;
                result = pow(result, vec3(1.0f / 2.2f));
                result = Tonemap_PBRNeutral(result);
                image.Set(x, y, vec4(result, 1.0f) * 255.f);
            }
        }
    }
};