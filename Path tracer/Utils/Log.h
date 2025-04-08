#pragma once

#include <glm/gtx/string_cast.hpp>

// This ignores all warnings raised inside External headers
#pragma warning(push, 0)
#include <spdlog/spdlog.h>
#include <spdlog/fmt/ostr.h>
#pragma warning(pop)

#include <mutex>

#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/base_sink.h>
#include <spdlog/fmt/ostr.h>

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

	inline std::shared_ptr<spdlog::logger> g_AppLogger;
	inline std::shared_ptr<spdlog::logger> g_CoreLogger;
	inline std::shared_ptr<ConsoleSinkMt> g_ConsoleSink;
	
	static void InitLog()
	{
		g_ConsoleSink = std::make_shared<ConsoleSinkMt>();

		std::array<spdlog::sink_ptr, 3> logSinks;
		logSinks[0] = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
		logSinks[1] = std::make_shared<spdlog::sinks::basic_file_sink_mt>("log/log.txt", true);
		logSinks[2] = g_ConsoleSink;

		// old pattern - "%^[%D %T][%l] %n: %v%$"
		std::string pattern = "%^[%T][%l] %n: %v%$";

		logSinks[0]->set_pattern(pattern);
		logSinks[1]->set_pattern(pattern);
		logSinks[2]->set_pattern(pattern);

		g_CoreLogger = std::make_shared<spdlog::logger>("Core", begin(logSinks), std::prev(end(logSinks)));
		g_AppLogger = std::make_shared<spdlog::logger>("App", std::next(begin(logSinks)), end(logSinks));
		spdlog::register_logger(g_CoreLogger);
		spdlog::register_logger(g_AppLogger);

		g_AppLogger->set_level(spdlog::level::trace);
		g_CoreLogger->set_level(spdlog::level::trace);
	}
}

template<typename OStream, glm::length_t L, typename T, glm::qualifier Q>
inline OStream& operator<<(OStream& os, glm::vec<L, T, Q> vector) { return os << glm::to_string(vector); }

template<typename OStream, glm::length_t C, glm::length_t R, typename T, glm::qualifier Q>
inline OStream& operator<<(OStream& os, const glm::mat<C, R, T, Q>& matrix) { return os << glm::to_string(matrix); }

template<typename OStream, typename T, glm::qualifier Q>
inline OStream& operator<<(OStream& os, glm::qua<T, Q> quaternion) { return os << glm::to_string(quaternion); }

template<glm::length_t L, typename T, glm::qualifier Q>
struct fmt::formatter<glm::vec<L, T, Q>> 
{
    constexpr auto parse(format_parse_context& ctx) -> decltype(ctx.begin()) { return ctx.begin(); }
    
    template <typename FormatContext>
    auto format(const glm::vec<L, T, Q>& v, FormatContext& ctx) const -> decltype(ctx.out()) { return format_to(ctx.out(), "{}", glm::to_string(v)); }
};

template<glm::length_t C, glm::length_t R, typename T, glm::qualifier Q>
struct fmt::formatter<glm::mat<C, R, T, Q>> 
{
    constexpr auto parse(format_parse_context& ctx) -> decltype(ctx.begin()) { return ctx.begin(); }
        
    template <typename FormatContext>
    auto format(const glm::mat<C, R, T, Q>& m, FormatContext& ctx) -> decltype(ctx.out()) { return format_to(ctx.out(), "{}", glm::to_string(m)); }
};

// Formatter for quaternions
template<typename T, glm::qualifier Q>
struct fmt::formatter<glm::qua<T, Q>> 
{
    constexpr auto parse(format_parse_context& ctx) -> decltype(ctx.begin()) { return ctx.begin(); }
    
    template <typename FormatContext>
    auto format(const glm::qua<T, Q>& q, FormatContext& ctx) const -> decltype(ctx.out()) { return format_to(ctx.out(), "{}", glm::to_string(q)); }
};

// Core log macros
#define WC_CORE_TRACE(...)		wc::g_CoreLogger->trace(__VA_ARGS__);
#define WC_CORE_INFO(...)		wc::g_CoreLogger->info(__VA_ARGS__);
#define WC_CORE_WARN(...)		wc::g_CoreLogger->warn(__VA_ARGS__);
#define WC_CORE_ERROR(...)		wc::g_CoreLogger->error(__VA_ARGS__);
#define WC_CORE_CRITICAL(...)	wc::g_CoreLogger->critical(__VA_ARGS__);
#define WC_CORE_DEBUG(...)		wc::g_CoreLogger->debug(__VA_ARGS__);
#define WC_CORE_DEBUG(...)		wc::g_CoreLogger->debug(__VA_ARGS__);
#define WC_CORE_LOG(level, ...)	wc::g_CoreLogger->log(level, __VA_ARGS__);
#define WC_CORE_TODO WC_CORE_INFO("@TODO: Implement!")

#define WC_APP_TRACE(...)         wc::g_AppLogger->trace(__VA_ARGS__);
#define WC_APP_INFO(...)          wc::g_AppLogger->info(__VA_ARGS__);
#define WC_APP_WARN(...)          wc::g_AppLogger->warn(__VA_ARGS__);
#define WC_APP_ERROR(...)         wc::g_AppLogger->error(__VA_ARGS__);
#define WC_APP_CRITICAL(...)      wc::g_AppLogger->critical(__VA_ARGS__);
#define WC_APP_DEBUG(...)         wc::g_AppLogger->debug(__VA_ARGS__);
#define WC_APP_LOG(level, ...)	  wc::g_AppLogger->log(level, __VA_ARGS__);


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