#pragma once

#define GLM_ENABLE_EXPERIMENTAL
#include <glm/gtx/string_cast.hpp>

// This ignores all warnings raised inside External headers
#pragma warning(push, 0)
#include <spdlog/spdlog.h>
#include <spdlog/fmt/ostr.h>
#pragma warning(pop)

#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/base_sink.h>
#include <mutex>

namespace wc 
{
	template<typename Mutex>
	struct ConsoleSink : public spdlog::sinks::base_sink<Mutex>
	{
		struct Message
		{
			std::string loggerName;
			const char* filename = nullptr;
			const char* funcname = nullptr;
			std::string payload;
			spdlog::level::level_enum level;
			std::chrono::system_clock::time_point time;
			size_t thread_id = 0;
			uint32_t line = 0;
		};

		std::vector<Message> messages;
	protected:
		void sink_it_(const spdlog::details::log_msg& msg) override
		{
			spdlog::memory_buf_t formatted;
			spdlog::sinks::base_sink<Mutex>::formatter_->format(msg, formatted);
			messages.push_back({
				.loggerName = std::string(msg.logger_name.data(), msg.logger_name.size()),
				.filename = msg.source.filename,
				.funcname = msg.source.funcname,
				.payload = std::string(msg.payload.data(), msg.payload.size()),
				.level = msg.level,
				.time = msg.time,
				.thread_id = msg.thread_id,
				.line = (uint32_t)msg.source.line,
				});
			//std::cout << fmt::to_string(formatted);
		}

		void flush_() override
		{
			//std::cout << std::flush;
		}
	};

	using ConsoleSinkMt = ConsoleSink<std::mutex>;

	struct Log
	{
		static void Init()
		{
			GetConsoleSink() = std::make_shared<ConsoleSinkMt>();

			std::array<spdlog::sink_ptr, 3> logSinks;
			logSinks[0] = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
			logSinks[1] = std::make_shared<spdlog::sinks::basic_file_sink_mt>("log/log.txt", true);
			logSinks[2] = GetConsoleSink();

			// old pattern - "%^[%D %T][%l] %n: %v%$"
			std::string pattern = "%^[%T][%l] %n: %v%$";

			logSinks[0]->set_pattern(pattern);
			logSinks[1]->set_pattern(pattern);
			logSinks[2]->set_pattern(pattern);

			GetCoreLogger() = std::make_shared<spdlog::logger>("Core", begin(logSinks), std::prev(end(logSinks)));
			GetAppLogger() = std::make_shared<spdlog::logger>("App", std::next(begin(logSinks)), end(logSinks));
			spdlog::register_logger(Log::GetCoreLogger());
			spdlog::register_logger(Log::GetAppLogger());

			GetAppLogger()->set_level(spdlog::level::trace);
			GetCoreLogger()->set_level(spdlog::level::trace);
		}

		static std::shared_ptr<spdlog::logger>& GetAppLogger() 
		{ 
			static std::shared_ptr<spdlog::logger> s_AppLogger;
			return s_AppLogger; 
		}

		static std::shared_ptr<spdlog::logger>& GetCoreLogger()
		{
			static std::shared_ptr<spdlog::logger> s_CoreLogger;
			return s_CoreLogger;
		}

		static std::shared_ptr<ConsoleSinkMt>& GetConsoleSink()
		{
			static std::shared_ptr<ConsoleSinkMt> s_ConsoleSink;
			return s_ConsoleSink;
		}
	};
}

template<typename OStream, glm::length_t L, typename T, glm::qualifier Q>
inline OStream& operator<<(OStream& os, const glm::vec<L, T, Q>& vector)
{
	return os << glm::to_string(vector);
}

template<typename OStream, glm::length_t C, glm::length_t R, typename T, glm::qualifier Q>
inline OStream& operator<<(OStream& os, const glm::mat<C, R, T, Q>& matrix)
{
	return os << glm::to_string(matrix);
}

template<typename OStream, typename T, glm::qualifier Q>
inline OStream& operator<<(OStream& os, glm::qua<T, Q> quaternion)
{
	return os << glm::to_string(quaternion);
}

// Core log macros
#define WC_CORE_TRACE(...)		wc::Log::GetCoreLogger()->trace(__VA_ARGS__);
#define WC_CORE_INFO(...)		wc::Log::GetCoreLogger()->info(__VA_ARGS__);
#define WC_CORE_WARN(...)		wc::Log::GetCoreLogger()->warn(__VA_ARGS__);
#define WC_CORE_ERROR(...)		wc::Log::GetCoreLogger()->error(__VA_ARGS__);
#define WC_CORE_CRITICAL(...)	wc::Log::GetCoreLogger()->critical(__VA_ARGS__);
#define WC_CORE_DEBUG(...)		wc::Log::GetCoreLogger()->debug(__VA_ARGS__);
#define WC_CORE_DEBUG(...)		wc::Log::GetCoreLogger()->debug(__VA_ARGS__);
#define WC_CORE_LOG(level, ...)	wc::Log::GetCoreLogger()->log(level, __VA_ARGS__);
#define WC_CORE_TODO WC_CORE_INFO("@TODO: Implement!")

#define WC_APP_TRACE(...)         wc::Log::GetAppLogger()->trace(__VA_ARGS__);
#define WC_APP_INFO(...)          wc::Log::GetAppLogger()->info(__VA_ARGS__);
#define WC_APP_WARN(...)          wc::Log::GetAppLogger()->warn(__VA_ARGS__);
#define WC_APP_ERROR(...)         wc::Log::GetAppLogger()->error(__VA_ARGS__);
#define WC_APP_CRITICAL(...)      wc::Log::GetAppLogger()->critical(__VA_ARGS__);
#define WC_APP_DEBUG(...)         wc::Log::GetAppLogger()->debug(__VA_ARGS__);
#define WC_APP_LOG(level, ...)	  wc::Log::GetAppLogger()->log(level, __VA_ARGS__);


#define WC_TRACE(...)      { WC_CORE_TRACE(__VA_ARGS__) WC_APP_TRACE(__VA_ARGS__) }
#define WC_INFO(...)       { WC_CORE_INFO(__VA_ARGS__) WC_APP_INFO(__VA_ARGS__) }
#define WC_WARN(...)       { WC_CORE_WARN(__VA_ARGS__) WC_APP_WARN(__VA_ARGS__) }
#define WC_ERROR(...)      { WC_CORE_ERROR(__VA_ARGS__) WC_APP_ERROR(__VA_ARGS__) }
#define WC_CRITICAL(...)   { WC_CORE_CRITICAL(__VA_ARGS__) WC_APP_CRITICAL(__VA_ARGS__) }
#define WC_DEBUG(...)      { WC_CORE_TRACE(__VA_ARGS__) WC_APP_TRACE(__VA_ARGS__) }
#define WC_LOG(level, ...) { WC_CORE_LOG(level, __VA_ARGS__) WC_APP_LOG(level, __VA_ARGS__) }

#define WC_ENABLE_ASSERTS


#ifdef WC_ENABLE_ASSERTS
// Currently accepts at least the condition and one additional parameter (the message) being optional
#define WC_DEBUGBREAK() __debugbreak();
#define WC_ASSERT(x) assert(x);
#else
#define WC_DEBUGBREAK(x)
#define WC_ASSERT(...)
#endif