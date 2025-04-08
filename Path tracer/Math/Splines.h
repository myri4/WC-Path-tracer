#pragma once

#include <glm/glm.hpp>

namespace blaze
{
	glm::vec2 bezierLerp(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, float t);

	glm::vec2 bezierLerp(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, glm::vec2 p3, float t);
}