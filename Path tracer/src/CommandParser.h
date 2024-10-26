#pragma once

#include <magic_enum.hpp>
#include <string>
#include <vector>

namespace wc 
{
	enum class CommandType { UNKNOWN = -1, recompile };

	struct CommandParser 
	{
	private:
		std::vector<std::string> BreakArgs(const std::string& input)
		{
			std::vector<std::string> arguments;
			std::string arg;
			size_t start = 0;

			for (size_t i = 0; i <= input.size(); ++i)
			{
				if (i == input.size() || input[i] == ' ')
				{
					if (i > start)
						arguments.push_back(input.substr(start, i - start));
					start = i + 1;
				}
			}

			return arguments;
		}
	public:
		std::vector<std::string> args;

		CommandType Parse(const std::string& text)
		{
			int32_t length = text.find(' ');

			std::string cmd;
			if (length != -1)
			{
				cmd = text.substr(0, length);

				std::string sArgs = text.substr(length + 1);
				args = BreakArgs(sArgs);
			}
			else cmd = text;

			for (uint32_t i = 0; i < magic_enum::enum_count<CommandType>(); i++)
				if (cmd == magic_enum::enum_name((CommandType)i)) return (CommandType)i;

			return CommandType::UNKNOWN;
		}
	};
}