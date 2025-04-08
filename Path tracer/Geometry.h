#pragma once

#include <glm/glm.hpp>
#include <glm/gtx/compatibility.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <memory>
#include <random>

using namespace glm;

struct Ray
{
    vec3 Origin;
    vec3 Direction;
};

inline float RandomValue()
{
    static std::uniform_real_distribution<float> distribution(0.f, 1.f);
    static std::mt19937 generator;
    return distribution(generator);
}

// Returns a random real in [min,max).
inline float RandomValue(float min, float max) { return min + (max - min) * RandomValue(); }

inline vec3 RandomVec3() { return vec3(RandomValue(), RandomValue(), RandomValue()); }

inline vec3 RandomVec3(float min, float max) { return vec3(RandomValue(min, max), RandomValue(min, max), RandomValue(min, max)); }

inline vec3 RandomDir() { return normalize(RandomVec3()); }

inline vec3 RandomInHemisphere(const vec3& normal)
{
    auto dir = RandomDir();
    return dir * sign(dot(normal, dir));
}

inline vec3 RandomInUnitSphere()
{
    while (true)
    {
        auto p = RandomVec3(-1.f, 1.f);
        if (dot(p, p) < 1.f)
            return p;
    }
}

inline vec3 RandomUnitVector() { return normalize(RandomInUnitSphere()); }

inline vec3 RandomOnHemisphere(const vec3& normal)
{
    vec3 dir = RandomUnitVector();
    return dir * sign(dot(normal, dir));
}

struct Material;
using MaterialID = uint32_t;

struct HitInfo
{
    vec3 p;
    vec3 normal;
    float t;
    bool front;
    MaterialID material;
};

struct Sphere
{
    bool Intersect(const Ray& ray, float tmin, float tmax, HitInfo& rec) const
    {
        vec3 oc = ray.Origin - Position;
        float a = dot(ray.Direction, ray.Direction);
        float half_b = dot(oc, ray.Direction);
        float c = dot(oc, oc) - Radius * Radius;

        float discriminant = half_b * half_b - a * c;
        if (discriminant < 0.f) return false;
        float sqrtd = sqrt(discriminant);

        // Find the nearest root that lies in the acceptable range.
        auto root = (-half_b - sqrtd) / a;
        if (root <= tmin || tmax <= root)
        {
            root = (-half_b + sqrtd) / a;
            if (root <= tmin || tmax <= root)
                return false;
        }

        rec.t = root;
        rec.p = ray.Origin + ray.Direction * rec.t;
        rec.normal = ((rec.p - Position) / Radius);
        rec.front = dot(ray.Direction, rec.normal) < 0.f;
        rec.normal *= rec.front ? 1.f : -1.f;
        rec.material = Material;

        return true;
    }

    vec3 Position;
    float Radius;
    MaterialID Material;
};

enum class MaterialType
{
    Lambertian,
    Metal,
    Dielectric,
    DiffuseLight
};

float reflectance(float cosine, float ref_idx) // Use Schlick's approximation for reflectance.
{
    float r0 = (1.f - ref_idx) / (1.f + ref_idx);
    r0 = r0 * r0;
    return r0 + (1.f - r0) * pow(1.f - cosine, 5.f);
}

struct Material 
{
    Material() = default;
    vec3 albedo = vec3(0.f);
    vec3 emission = vec3(0.f);

    float specularProbability = 0.f;
    float roughness = 0.f;
    float ior = 1.f;
    MaterialType type = MaterialType::Lambertian;

    bool scatter(const Ray& ray, const HitInfo& rec, vec3& attenuation, Ray& scattered)
    {
        switch (type)
        {
        case MaterialType::Lambertian:
        {
            scattered = Ray(rec.p, normalize(rec.normal + RandomUnitVector()));
            attenuation = albedo;
            return true;
        }
        case MaterialType::Metal:
        {
            bool isSpecularBounce = specularProbability >= RandomValue();
            scattered = Ray(rec.p, normalize(reflect(ray.Direction, rec.normal) + (roughness * isSpecularBounce) * RandomUnitVector()));
            attenuation = mix(albedo, vec3(1.f), (float)isSpecularBounce);
            return true;
        }
        case MaterialType::Dielectric:
        {
            attenuation = albedo;
            float refraction_ratio = rec.front ? (1.f / ior) : ior;

            float cos_theta = min(dot(-ray.Direction, rec.normal), 1.f);
            float sin_theta = sqrt(1.f - cos_theta * cos_theta);

            bool cannot_refract = refraction_ratio * sin_theta > 1.0;
            vec3 direction;

            if (cannot_refract || reflectance(cos_theta, refraction_ratio) > RandomValue())
                direction = reflect(ray.Direction, rec.normal);
            else
                direction = refract(ray.Direction, rec.normal, refraction_ratio);

            scattered = Ray(rec.p, normalize(direction + roughness * RandomUnitVector()));
            return true;
        }
        case MaterialType::DiffuseLight:
            return false;
        default:
            return false;
        }
    }

    void SetLambertian(vec3 a) { type = MaterialType::Lambertian; albedo = a; }

    void SetMetal(vec3 a, float r, float sp)
    {
        albedo = a;
        roughness = r;
        specularProbability = sp;
        type = MaterialType::Metal;
    }

    void SetDielectric(vec3 color, float r, float index_of_refraction)
    {
        albedo = color;
        roughness = r;
        ior = index_of_refraction;
        type = MaterialType::Dielectric;
    }

    void SetDiffuseLight(vec3 c) { type = MaterialType::DiffuseLight; emission = c; }
};