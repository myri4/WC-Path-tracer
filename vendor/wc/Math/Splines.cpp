#include "Splines.h"

namespace blaze
{
	glm::vec2 bezierLerp(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, float t)
	{
		glm::vec2 intermediateA = glm::mix(p0, p1, t);
		glm::vec2 intermediateB = glm::mix(p1, p2, t);

		return glm::mix(intermediateA, intermediateB, t);
	}

	glm::vec2 bezierLerp(glm::vec2 p0, glm::vec2 p1, glm::vec2 p2, glm::vec2 p3, float t)
	{
		glm::vec2 intermediateA = glm::mix(p0, p1, t);
		glm::vec2 intermediateB = glm::mix(p1, p2, t);
		glm::vec2 intermediateC = glm::mix(p2, p3, t);

		return bezierLerp(intermediateA, intermediateB, intermediateC, t);
	}
}