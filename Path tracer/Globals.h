#pragma once

#include <glm/glm.hpp>
#include "Utils/Window.h"
#include "Utils/Time.h"

namespace wc 
{
	struct GlobalVariables
	{
		Window window; // @TODO: maybe rename to main window

		Clock deltaTimer;
		float deltaTime = 0.f;


		void UpdateTime()
		{
			deltaTime = deltaTimer.restart();
		}
	};

	inline GlobalVariables Globals;
}