#pragma once

#include "Window.h"

namespace wc::FileDialogs
{
	bool OpenInFileExplorer(const std::string& path);

	// These return empty strings if cancelled
	std::string OpenFile(GLFWwindow* window, const char* filter);

	std::string SaveFile(GLFWwindow* window, const char* filter);

	//TODO - see return a filepath/error if not on Windows
	std::string OpenFolder(GLFWwindow* window);
}