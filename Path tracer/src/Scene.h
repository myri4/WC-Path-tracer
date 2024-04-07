#pragma once

#include <wc/Utils/Log.h>
#include <wc/Utils/CPUImage.h>

#include <vector>
#include <print>

#include "Geometry.h"

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
    uint32_t Samples = 100;
    uint32_t Depth = 5;

    std::vector<Sphere> Spheres;
    std::vector<Material> Materials;

    MaterialID PushMaterial()
    {
        Materials.push_back(Material());
        return Materials.size() - 1;
    }

    void Create()
    {
        auto Ground = PushMaterial();
        Materials[Ground].SetLambertian(glm::vec3(0.8, 0.8, 0.0));

        auto Center = PushMaterial();
        Materials[Center].SetLambertian(glm::vec3(0.7, 0.3, 0.3));

        auto Left = PushMaterial();
        Materials[Left].SetDiffuseLight(glm::vec3(0.8, 0.8, 0.8) * 2.f);

        auto Right = PushMaterial();
        Materials[Right].SetMetal(glm::vec3(0.8, 0.6, 0.2), 0.75f, 0.02f);

        auto glass = PushMaterial();
        Materials[glass].SetDielectric(glm::vec3(0.f, 0.5f, 05.f), 0.07f, 1.5f);

        //Spheres.push_back(Sphere(glm::vec3(0.f, 0.f, -1.f), 0.5f));
        //Spheres.push_back(Sphere(glm::vec3(0.f, -100.5f, -1.f), 100.f));

        Spheres.push_back(Sphere(glm::vec3(0.0, 0.0, -1.0), 0.5, glass));
        Spheres.push_back(Sphere(glm::vec3(-1.0, 0.0, -1.0), 0.5, Left));
        Spheres.push_back(Sphere(glm::vec3(1.0, 0.0, -1.0), 0.5, Right));
        Spheres.push_back(Sphere(glm::vec3(0.f, -100.5f, -1.f), 100.f, Ground));
    }

    bool Intersect(const Ray& ray, HitRecord& rec)
    {
        HitRecord temp_rec;
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

    glm::vec3 TraceRay(const Ray& ray, uint32_t depth)
    {
        if (depth == 0) return glm::vec3(0.f);

        HitRecord rec;
        if (!Intersect(ray, rec))
            return glm::vec3(0.f);// glm::mix(glm::vec3(1.f), glm::vec3(0.5f, 0.7f, 1.f), 0.5f * (ray.Direction.y + 1.f));

        Ray scattered;
        glm::vec3 attenuation;
        glm::vec3 emmission = Materials[rec.material].emission;
        if (!Materials[rec.material].scatter(ray, rec, attenuation, scattered))
            return emmission;

        return emmission + attenuation * TraceRay(scattered, depth - 1);
    }

    glm::vec3 TraceRay2(Ray ray)
    {
        glm::vec3 incomingLight = glm::vec3(0.f);
        glm::vec3 rayColor = glm::vec3(1.f);

        for (uint32_t i = 0; i < Depth; i++)
        {
            HitRecord rec;
            if (!Intersect(ray, rec))
                return glm::vec3(0.f);// glm::mix(glm::vec3(1.f), glm::vec3(0.5f, 0.7f, 1.f), 0.5f * (ray.Direction.y + 1.f));

            glm::vec3 attenuation;
            glm::vec3 emmission = Materials[rec.material].emission;
            Materials[rec.material].scatter(ray, rec, attenuation, ray);

            incomingLight += emmission * rayColor;
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
        wc::CPUImage image;
        image.Allocate(400, 225, 3);

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
                    result += TraceRay2(Ray(camera.Position, rayDirection));
                
                result /= Samples;
                result = pow(result, glm::vec3(1.f / 2.2f));
                result = Tonemap_ACES(result);
                image.Set(x, y, glm::vec4(result, 1.f) * 255.f);
            }
        }

        image.Save("output.png");
    }
};