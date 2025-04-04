#pragma once

#define GLM_ENABLE_EXPERIMENTAL
#include <glm/glm.hpp>
#include <glm/gtx/transform.hpp>
#include <glm/gtx/matrix_decompose.hpp>

#define GLM_ENABLE_EXPERIMENTAL
#include <glm/gtx/quaternion.hpp>

namespace wc
{
	struct OrthographicCamera
	{
		glm::mat4 ProjectionMatrix;

		glm::vec3 Position;
		float Rotation = 0.f;
		float Zoom = 1.f;

		void Shake(float shake, float maxOffset = 0.3f, float maxRotation = 10.f);

		void SetProjection(float left, float right, float bottom, float top, float Near = -1.f, float Far = 1.f);

		void Update(glm::vec2 halfSize, float Near = -1.f, float Far = 1.f);

		glm::mat4 GetViewMatrix() const;

		glm::mat4 GetViewProjectionMatrix() const;
	};

	struct Camera3D
	{
		glm::vec3 Position;
		glm::vec3 Front = glm::vec3(0.f, 0.f, -1.f);
		glm::vec3 Up = glm::vec3(0.f, 1.f, 0.f);

		float Yaw = 0.f;
		float Pitch = 0.f;
		float Roll = glm::radians(90.f);
		float FOV = glm::radians(90.f);

		glm::mat4 GetViewMatrix() const;

		void Update(float aspectRatio);
	};

	struct EditorCamera
	{
		EditorCamera() = default;
		//EditorCamera(float fov, float aspectRatio, float nearClip, float farClip);

		glm::mat4 GetViewProjectionMatrix() const { return Projection * ViewMatrix; }

		glm::vec3 GetUpDirection() const { return glm::rotate(GetOrientation(), glm::vec3(0.f, 1.f, 0.f)); }
		glm::vec3 GetRightDirection() const { return glm::rotate(GetOrientation(), glm::vec3(1.f, 0.f, 0.f)); }
		glm::vec3 GetForwardDirection() const {	return glm::rotate(GetOrientation(), glm::vec3(0.f, 0.f, -1.f)); }
		glm::quat GetOrientation() const { return glm::quat(glm::vec3(-Pitch, -Yaw, 0.f));	}

		void Update(float AspectRatio);

		void UpdateView();

		glm::vec3 CalculatePosition() const;

		glm::vec2 PanSpeed(glm::vec2 size) const;

		float ZoomSpeed() const;
		
		float m_FOV = 45.f, NearClip = 0.1f, FarClip = 1000.f;

		glm::mat4 Projection = glm::mat4(1.f);
		glm::mat4 ViewMatrix = glm::mat4(1.f);
		glm::vec3 Position = { 0.f, 0.f, 0.f };
		glm::vec3 FocalPoint = { 0.f, 0.f, 0.f };

		glm::vec2 m_InitialMousePosition = { 0.f, 0.f };

		float Pitch = 0.f, Yaw = 0.f;
		float RotationSpeed = 0.8f;

		float m_Distance = 10.f;
	};

	bool DecomposeTransform(const glm::mat4& transform, glm::vec3& translation, glm::vec3& rotation, glm::vec3& scale);
}