#pragma once

#include <wc/Utils/Log.h>
#include <wc/Utils/CPUImage.h>

#include <vector>
#include <print>

#include "Geometry.h"

#include <wc/Utils/Time.h>

struct Camera
{
    glm::vec3 Position;
    float FOV = 90.f;
    glm::mat4 Projection;
    glm::mat4 InverseProjection;
    glm::mat4 View;

    void Update()
    {
        View = glm::lookAt(Position, glm::vec3(0.f, 0.f, -1.f), glm::vec3(0.f, 1.f, 0.f));

        Projection = glm::perspective(glm::radians(FOV), 16.f / 9.f, 0.1f, 100.0f);
        InverseProjection = glm::inverse(Projection);
    }
};

struct Scene
{
    Camera camera;
    uint32_t Samples = 10;
    uint32_t Depth = 5;

    std::vector<Sphere> Spheres;
    std::vector<Material> Materials;

    wc::CPUImage image;

    MaterialID PushMaterial()
    {
        Materials.push_back(Material());
        return Materials.size() - 1;
    }

    bool Intersect(const Ray& ray, HitInfo& rec)
    {
        HitInfo temp_rec;
        bool hit_anything = false;
        float t = 150.f;

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

    glm::vec3 TraceRay2(const Ray& ray, uint32_t depth)
    {
        if (depth == 0) return glm::vec3(0.f);

        HitInfo rec;
        if (!Intersect(ray, rec))
            return glm::vec3(0.f);// glm::mix(glm::vec3(1.f), glm::vec3(0.5f, 0.7f, 1.f), 0.5f * (ray.Direction.y + 1.f));

        Ray scattered;
        glm::vec3 attenuation;
        glm::vec3 emmission = Materials[rec.material].emission;
        if (!Materials[rec.material].scatter(ray, rec, attenuation, scattered))
            return emmission;

        return emmission + attenuation * TraceRay2(scattered, depth - 1);
    }

    glm::vec3 TraceRay(Ray ray)
    {
        glm::vec3 incomingLight = glm::vec3(0.f);
        glm::vec3 rayColor = glm::vec3(1.f);

        for (uint32_t i = 0; i <= Depth; i++)
        {
            HitInfo rec;
            if (!Intersect(ray, rec))
                return glm::vec3(0.f);// glm::mix(glm::vec3(1.f), glm::vec3(0.5f, 0.7f, 1.f), 0.5f * (ray.Direction.y + 1.f));

            glm::vec3 attenuation;
            if (!Materials[rec.material].scatter(ray, rec, attenuation, ray)) 
                return incomingLight + Materials[rec.material].emission * rayColor;

            incomingLight += Materials[rec.material].emission * rayColor;
            rayColor *= attenuation;
        }

        return incomingLight;
    }

    glm::vec3 Tonemap_ACES(glm::vec3 x)
    {
        // Narkowicz 2015, "ACES Filmic Tone Mapping Curve"
        const float a = 2.51;
        const float b = 0.03;
        const float c = 2.43;
        const float d = 0.59;
        const float e = 0.14;
        return (x * (a * x + b)) / (x * (c * x + d) + e);
    }

    void Render()
    {
        camera.Update();
        for (uint32_t y = 0; y < image.Height; y++)
        {
            for (uint32_t x = 0; x < image.Width; x++)
            {
                glm::vec2 coord = { (float)x / (float)image.Width, (float)y / (float)image.Height };
                coord.y = 1.f - coord.y;
                coord = coord * 2.f - 1.f; // -1 -> 1
                glm::vec4 target = camera.InverseProjection * glm::vec4(coord.x, coord.y, 1, 1);
                glm::vec3 rayDirection = glm::vec3(camera.View * glm::vec4(glm::normalize(glm::vec3(target) / target.w), 0.f));

                glm::vec3 result;

                for (int sample = 0; sample < Samples; sample++)
                    result += TraceRay(Ray(camera.Position, rayDirection));

                result /= Samples;
                result = pow(result, glm::vec3(1.f / 2.2f));
                result = Tonemap_ACES(result);
                image.Set(x, y, glm::vec4(result, 1.f) * 255.f);
            }
        }
    }
};