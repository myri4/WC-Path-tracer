#pragma once

#include "FileDialogs.h"

#include <Windows.h>
#include <commdlg.h>
#include <shlobj.h> // remove this
#include <shellapi.h>

#include <filesystem>
#include <imgui/imgui.h>
#include <imgui/imgui_internal.h>

namespace wc::FileDialogs
{
	bool OpenInFileExplorer(const std::string& path) {
#ifdef _WIN32
		// Convert string to wide string if needed
		std::wstring widePath(path.begin(), path.end());

		// Use ShellExecute to open the path in Explorer
		HINSTANCE result = ShellExecuteW(
			NULL,           // Parent window handle
			L"explore",     // Operation to perform
			widePath.c_str(), // Path to open
			NULL,           // Parameters
			NULL,           // Default working directory
			SW_SHOWNORMAL  // Show window normally
		);

		// Check if the operation was successful
		// ShellExecute returns a value greater than 32 if successful
		return (reinterpret_cast<INT_PTR>(result) > 32);
#endif
	}

	// These return empty strings if cancelled
	std::string OpenFile(GLFWwindow* window, const char* filter)
	{
		OPENFILENAMEA ofn;
		ZeroMemory(&ofn, sizeof(OPENFILENAME));
		ofn.lStructSize = sizeof(OPENFILENAME);
		ofn.hwndOwner = glfwGetWin32Window(window);
		CHAR szFile[260] = { 0 };
		CHAR currentDir[256] = { 0 };
		ofn.lpstrFile = szFile;
		ofn.nMaxFile = sizeof(szFile);
		if (GetCurrentDirectoryA(256, currentDir))
			ofn.lpstrInitialDir = currentDir;
		ofn.lpstrFilter = filter;
		ofn.nFilterIndex = 1;
		ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST | OFN_NOCHANGEDIR;

		if (GetOpenFileNameA(&ofn))
			return ofn.lpstrFile;

		return std::string();
	}

	std::string SaveFile(GLFWwindow* window, const char* filter)
	{
		OPENFILENAMEA ofn;
		CHAR szFile[260] = { 0 };
		CHAR currentDir[256] = { 0 };
		ZeroMemory(&ofn, sizeof(OPENFILENAME));
		ofn.lStructSize = sizeof(OPENFILENAME);
		ofn.hwndOwner = glfwGetWin32Window(window);
		ofn.lpstrFile = szFile;
		ofn.nMaxFile = sizeof(szFile);
		if (GetCurrentDirectoryA(256, currentDir))
			ofn.lpstrInitialDir = currentDir;
		ofn.lpstrFilter = filter;
		ofn.nFilterIndex = 1;
		ofn.Flags = OFN_PATHMUSTEXIST | OFN_OVERWRITEPROMPT | OFN_NOCHANGEDIR;

		// Sets the default extension by extracting it from the filter
		ofn.lpstrDefExt = strchr(filter, '\0') + 1;

		if (GetSaveFileNameA(&ofn))
			return ofn.lpstrFile;

		return std::string();
	}

	//TODO - see return a filepath/error if not on Windows
	std::string OpenFolder(GLFWwindow* window)
	{
#ifdef _WIN32
		BROWSEINFOA bi = { 0 };
		bi.hwndOwner = glfwGetWin32Window(window);
		bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_NEWDIALOGSTYLE;

		// Show the folder selection dialog
		LPITEMIDLIST pidl = SHBrowseForFolderA(&bi);

		if (pidl != nullptr)
		{
			CHAR path[MAX_PATH];
			// Convert the selected folder's PIDL to a path
			if (SHGetPathFromIDListA(pidl, path))
			{
				// Free the PIDL allocated by SHBrowseForFolder
				CoTaskMemFree(pidl);
				return std::string(path);
			}

			// Free the PIDL if SHGetPathFromIDListA fails
			CoTaskMemFree(pidl);
		}

		return std::string(); // Return an empty string if the user cancels the dialog
#endif
	}
}