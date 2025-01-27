module LibGpiod

# hard-coding for now
const libgpiod = "/home/pi/opt/libgpiod/lib/libgpiod.so"
using CEnum

mutable struct gpiod_chip end

mutable struct gpiod_chip_info end

mutable struct gpiod_line_info end

mutable struct gpiod_line_settings end

mutable struct gpiod_line_config end

mutable struct gpiod_request_config end

mutable struct gpiod_line_request end

mutable struct gpiod_info_event end

mutable struct gpiod_edge_event end

mutable struct gpiod_edge_event_buffer end

function gpiod_chip_open(path)
    ccall((:gpiod_chip_open, libgpiod), Ptr{gpiod_chip}, (Ptr{Cchar},), path)
end

function gpiod_chip_close(chip)
    ccall((:gpiod_chip_close, libgpiod), Cvoid, (Ptr{gpiod_chip},), chip)
end

function gpiod_chip_get_info(chip)
    ccall((:gpiod_chip_get_info, libgpiod), Ptr{gpiod_chip_info}, (Ptr{gpiod_chip},), chip)
end

function gpiod_chip_get_path(chip)
    ccall((:gpiod_chip_get_path, libgpiod), Ptr{Cchar}, (Ptr{gpiod_chip},), chip)
end

function gpiod_chip_get_line_info(chip, offset)
    ccall((:gpiod_chip_get_line_info, libgpiod), Ptr{gpiod_line_info}, (Ptr{gpiod_chip}, Cuint), chip, offset)
end

function gpiod_chip_watch_line_info(chip, offset)
    ccall((:gpiod_chip_watch_line_info, libgpiod), Ptr{gpiod_line_info}, (Ptr{gpiod_chip}, Cuint), chip, offset)
end

function gpiod_chip_unwatch_line_info(chip, offset)
    ccall((:gpiod_chip_unwatch_line_info, libgpiod), Cint, (Ptr{gpiod_chip}, Cuint), chip, offset)
end

function gpiod_chip_get_fd(chip)
    ccall((:gpiod_chip_get_fd, libgpiod), Cint, (Ptr{gpiod_chip},), chip)
end

function gpiod_chip_wait_info_event(chip, timeout_ns)
    ccall((:gpiod_chip_wait_info_event, libgpiod), Cint, (Ptr{gpiod_chip}, Int64), chip, timeout_ns)
end

function gpiod_chip_read_info_event(chip)
    ccall((:gpiod_chip_read_info_event, libgpiod), Ptr{gpiod_info_event}, (Ptr{gpiod_chip},), chip)
end

function gpiod_chip_get_line_offset_from_name(chip, name)
    ccall((:gpiod_chip_get_line_offset_from_name, libgpiod), Cint, (Ptr{gpiod_chip}, Ptr{Cchar}), chip, name)
end

function gpiod_chip_request_lines(chip, req_cfg, line_cfg)
    ccall((:gpiod_chip_request_lines, libgpiod), Ptr{gpiod_line_request}, (Ptr{gpiod_chip}, Ptr{gpiod_request_config}, Ptr{gpiod_line_config}), chip, req_cfg, line_cfg)
end

function gpiod_chip_info_free(info)
    ccall((:gpiod_chip_info_free, libgpiod), Cvoid, (Ptr{gpiod_chip_info},), info)
end

function gpiod_chip_info_get_name(info)
    ccall((:gpiod_chip_info_get_name, libgpiod), Ptr{Cchar}, (Ptr{gpiod_chip_info},), info)
end

function gpiod_chip_info_get_label(info)
    ccall((:gpiod_chip_info_get_label, libgpiod), Ptr{Cchar}, (Ptr{gpiod_chip_info},), info)
end

function gpiod_chip_info_get_num_lines(info)
    ccall((:gpiod_chip_info_get_num_lines, libgpiod), Csize_t, (Ptr{gpiod_chip_info},), info)
end

@cenum gpiod_line_value::Int32 begin
    GPIOD_LINE_VALUE_ERROR = -1
    GPIOD_LINE_VALUE_INACTIVE = 0
    GPIOD_LINE_VALUE_ACTIVE = 1
end

@cenum gpiod_line_direction::UInt32 begin
    GPIOD_LINE_DIRECTION_AS_IS = 1
    GPIOD_LINE_DIRECTION_INPUT = 2
    GPIOD_LINE_DIRECTION_OUTPUT = 3
end

@cenum gpiod_line_edge::UInt32 begin
    GPIOD_LINE_EDGE_NONE = 1
    GPIOD_LINE_EDGE_RISING = 2
    GPIOD_LINE_EDGE_FALLING = 3
    GPIOD_LINE_EDGE_BOTH = 4
end

@cenum gpiod_line_bias::UInt32 begin
    GPIOD_LINE_BIAS_AS_IS = 1
    GPIOD_LINE_BIAS_UNKNOWN = 2
    GPIOD_LINE_BIAS_DISABLED = 3
    GPIOD_LINE_BIAS_PULL_UP = 4
    GPIOD_LINE_BIAS_PULL_DOWN = 5
end

@cenum gpiod_line_drive::UInt32 begin
    GPIOD_LINE_DRIVE_PUSH_PULL = 1
    GPIOD_LINE_DRIVE_OPEN_DRAIN = 2
    GPIOD_LINE_DRIVE_OPEN_SOURCE = 3
end

@cenum gpiod_line_clock::UInt32 begin
    GPIOD_LINE_CLOCK_MONOTONIC = 1
    GPIOD_LINE_CLOCK_REALTIME = 2
    GPIOD_LINE_CLOCK_HTE = 3
end

function gpiod_line_info_free(info)
    ccall((:gpiod_line_info_free, libgpiod), Cvoid, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_copy(info)
    ccall((:gpiod_line_info_copy, libgpiod), Ptr{gpiod_line_info}, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_offset(info)
    ccall((:gpiod_line_info_get_offset, libgpiod), Cuint, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_name(info)
    ccall((:gpiod_line_info_get_name, libgpiod), Ptr{Cchar}, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_is_used(info)
    ccall((:gpiod_line_info_is_used, libgpiod), Bool, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_consumer(info)
    ccall((:gpiod_line_info_get_consumer, libgpiod), Ptr{Cchar}, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_direction(info)
    ccall((:gpiod_line_info_get_direction, libgpiod), gpiod_line_direction, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_edge_detection(info)
    ccall((:gpiod_line_info_get_edge_detection, libgpiod), gpiod_line_edge, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_bias(info)
    ccall((:gpiod_line_info_get_bias, libgpiod), gpiod_line_bias, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_drive(info)
    ccall((:gpiod_line_info_get_drive, libgpiod), gpiod_line_drive, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_is_active_low(info)
    ccall((:gpiod_line_info_is_active_low, libgpiod), Bool, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_is_debounced(info)
    ccall((:gpiod_line_info_is_debounced, libgpiod), Bool, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_debounce_period_us(info)
    ccall((:gpiod_line_info_get_debounce_period_us, libgpiod), Culong, (Ptr{gpiod_line_info},), info)
end

function gpiod_line_info_get_event_clock(info)
    ccall((:gpiod_line_info_get_event_clock, libgpiod), gpiod_line_clock, (Ptr{gpiod_line_info},), info)
end

@cenum gpiod_info_event_type::UInt32 begin
    GPIOD_INFO_EVENT_LINE_REQUESTED = 1
    GPIOD_INFO_EVENT_LINE_RELEASED = 2
    GPIOD_INFO_EVENT_LINE_CONFIG_CHANGED = 3
end

function gpiod_info_event_free(event)
    ccall((:gpiod_info_event_free, libgpiod), Cvoid, (Ptr{gpiod_info_event},), event)
end

function gpiod_info_event_get_event_type(event)
    ccall((:gpiod_info_event_get_event_type, libgpiod), gpiod_info_event_type, (Ptr{gpiod_info_event},), event)
end

function gpiod_info_event_get_timestamp_ns(event)
    ccall((:gpiod_info_event_get_timestamp_ns, libgpiod), UInt64, (Ptr{gpiod_info_event},), event)
end

function gpiod_info_event_get_line_info(event)
    ccall((:gpiod_info_event_get_line_info, libgpiod), Ptr{gpiod_line_info}, (Ptr{gpiod_info_event},), event)
end

function gpiod_line_settings_new()
    ccall((:gpiod_line_settings_new, libgpiod), Ptr{gpiod_line_settings}, ())
end

function gpiod_line_settings_free(settings)
    ccall((:gpiod_line_settings_free, libgpiod), Cvoid, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_reset(settings)
    ccall((:gpiod_line_settings_reset, libgpiod), Cvoid, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_copy(settings)
    ccall((:gpiod_line_settings_copy, libgpiod), Ptr{gpiod_line_settings}, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_direction(settings, direction)
    ccall((:gpiod_line_settings_set_direction, libgpiod), Cint, (Ptr{gpiod_line_settings}, gpiod_line_direction), settings, direction)
end

function gpiod_line_settings_get_direction(settings)
    ccall((:gpiod_line_settings_get_direction, libgpiod), gpiod_line_direction, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_edge_detection(settings, edge)
    ccall((:gpiod_line_settings_set_edge_detection, libgpiod), Cint, (Ptr{gpiod_line_settings}, gpiod_line_edge), settings, edge)
end

function gpiod_line_settings_get_edge_detection(settings)
    ccall((:gpiod_line_settings_get_edge_detection, libgpiod), gpiod_line_edge, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_bias(settings, bias)
    ccall((:gpiod_line_settings_set_bias, libgpiod), Cint, (Ptr{gpiod_line_settings}, gpiod_line_bias), settings, bias)
end

function gpiod_line_settings_get_bias(settings)
    ccall((:gpiod_line_settings_get_bias, libgpiod), gpiod_line_bias, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_drive(settings, drive)
    ccall((:gpiod_line_settings_set_drive, libgpiod), Cint, (Ptr{gpiod_line_settings}, gpiod_line_drive), settings, drive)
end

function gpiod_line_settings_get_drive(settings)
    ccall((:gpiod_line_settings_get_drive, libgpiod), gpiod_line_drive, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_active_low(settings, active_low)
    ccall((:gpiod_line_settings_set_active_low, libgpiod), Cvoid, (Ptr{gpiod_line_settings}, Bool), settings, active_low)
end

function gpiod_line_settings_get_active_low(settings)
    ccall((:gpiod_line_settings_get_active_low, libgpiod), Bool, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_debounce_period_us(settings, period)
    ccall((:gpiod_line_settings_set_debounce_period_us, libgpiod), Cvoid, (Ptr{gpiod_line_settings}, Culong), settings, period)
end

function gpiod_line_settings_get_debounce_period_us(settings)
    ccall((:gpiod_line_settings_get_debounce_period_us, libgpiod), Culong, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_event_clock(settings, event_clock)
    ccall((:gpiod_line_settings_set_event_clock, libgpiod), Cint, (Ptr{gpiod_line_settings}, gpiod_line_clock), settings, event_clock)
end

function gpiod_line_settings_get_event_clock(settings)
    ccall((:gpiod_line_settings_get_event_clock, libgpiod), gpiod_line_clock, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_settings_set_output_value(settings, value)
    ccall((:gpiod_line_settings_set_output_value, libgpiod), Cint, (Ptr{gpiod_line_settings}, gpiod_line_value), settings, value)
end

function gpiod_line_settings_get_output_value(settings)
    ccall((:gpiod_line_settings_get_output_value, libgpiod), gpiod_line_value, (Ptr{gpiod_line_settings},), settings)
end

function gpiod_line_config_new()
    ccall((:gpiod_line_config_new, libgpiod), Ptr{gpiod_line_config}, ())
end

function gpiod_line_config_free(config)
    ccall((:gpiod_line_config_free, libgpiod), Cvoid, (Ptr{gpiod_line_config},), config)
end

function gpiod_line_config_reset(config)
    ccall((:gpiod_line_config_reset, libgpiod), Cvoid, (Ptr{gpiod_line_config},), config)
end

function gpiod_line_config_add_line_settings(config, offsets, num_offsets, settings)
    ccall((:gpiod_line_config_add_line_settings, libgpiod), Cint, (Ptr{gpiod_line_config}, Ptr{Cuint}, Csize_t, Ptr{gpiod_line_settings}), config, offsets, num_offsets, settings)
end

function gpiod_line_config_get_line_settings(config, offset)
    ccall((:gpiod_line_config_get_line_settings, libgpiod), Ptr{gpiod_line_settings}, (Ptr{gpiod_line_config}, Cuint), config, offset)
end

function gpiod_line_config_set_output_values(config, values, num_values)
    ccall((:gpiod_line_config_set_output_values, libgpiod), Cint, (Ptr{gpiod_line_config}, Ptr{gpiod_line_value}, Csize_t), config, values, num_values)
end

function gpiod_line_config_get_num_configured_offsets(config)
    ccall((:gpiod_line_config_get_num_configured_offsets, libgpiod), Csize_t, (Ptr{gpiod_line_config},), config)
end

function gpiod_line_config_get_configured_offsets(config, offsets, max_offsets)
    ccall((:gpiod_line_config_get_configured_offsets, libgpiod), Csize_t, (Ptr{gpiod_line_config}, Ptr{Cuint}, Csize_t), config, offsets, max_offsets)
end

function gpiod_request_config_new()
    ccall((:gpiod_request_config_new, libgpiod), Ptr{gpiod_request_config}, ())
end

function gpiod_request_config_free(config)
    ccall((:gpiod_request_config_free, libgpiod), Cvoid, (Ptr{gpiod_request_config},), config)
end

function gpiod_request_config_set_consumer(config, consumer)
    ccall((:gpiod_request_config_set_consumer, libgpiod), Cvoid, (Ptr{gpiod_request_config}, Ptr{Cchar}), config, consumer)
end

function gpiod_request_config_get_consumer(config)
    ccall((:gpiod_request_config_get_consumer, libgpiod), Ptr{Cchar}, (Ptr{gpiod_request_config},), config)
end

function gpiod_request_config_set_event_buffer_size(config, event_buffer_size)
    ccall((:gpiod_request_config_set_event_buffer_size, libgpiod), Cvoid, (Ptr{gpiod_request_config}, Csize_t), config, event_buffer_size)
end

function gpiod_request_config_get_event_buffer_size(config)
    ccall((:gpiod_request_config_get_event_buffer_size, libgpiod), Csize_t, (Ptr{gpiod_request_config},), config)
end

function gpiod_line_request_release(request)
    ccall((:gpiod_line_request_release, libgpiod), Cvoid, (Ptr{gpiod_line_request},), request)
end

function gpiod_line_request_get_chip_name(request)
    ccall((:gpiod_line_request_get_chip_name, libgpiod), Ptr{Cchar}, (Ptr{gpiod_line_request},), request)
end

function gpiod_line_request_get_num_requested_lines(request)
    ccall((:gpiod_line_request_get_num_requested_lines, libgpiod), Csize_t, (Ptr{gpiod_line_request},), request)
end

function gpiod_line_request_get_requested_offsets(request, offsets, max_offsets)
    ccall((:gpiod_line_request_get_requested_offsets, libgpiod), Csize_t, (Ptr{gpiod_line_request}, Ptr{Cuint}, Csize_t), request, offsets, max_offsets)
end

function gpiod_line_request_get_value(request, offset)
    ccall((:gpiod_line_request_get_value, libgpiod), gpiod_line_value, (Ptr{gpiod_line_request}, Cuint), request, offset)
end

function gpiod_line_request_get_values_subset(request, num_values, offsets, values)
    ccall((:gpiod_line_request_get_values_subset, libgpiod), Cint, (Ptr{gpiod_line_request}, Csize_t, Ptr{Cuint}, Ptr{gpiod_line_value}), request, num_values, offsets, values)
end

function gpiod_line_request_get_values(request, values)
    ccall((:gpiod_line_request_get_values, libgpiod), Cint, (Ptr{gpiod_line_request}, Ptr{gpiod_line_value}), request, values)
end

function gpiod_line_request_set_value(request, offset, value)
    ccall((:gpiod_line_request_set_value, libgpiod), Cint, (Ptr{gpiod_line_request}, Cuint, gpiod_line_value), request, offset, value)
end

function gpiod_line_request_set_values_subset(request, num_values, offsets, values)
    ccall((:gpiod_line_request_set_values_subset, libgpiod), Cint, (Ptr{gpiod_line_request}, Csize_t, Ptr{Cuint}, Ptr{gpiod_line_value}), request, num_values, offsets, values)
end

function gpiod_line_request_set_values(request, values)
    ccall((:gpiod_line_request_set_values, libgpiod), Cint, (Ptr{gpiod_line_request}, Ptr{gpiod_line_value}), request, values)
end

function gpiod_line_request_reconfigure_lines(request, config)
    ccall((:gpiod_line_request_reconfigure_lines, libgpiod), Cint, (Ptr{gpiod_line_request}, Ptr{gpiod_line_config}), request, config)
end

function gpiod_line_request_get_fd(request)
    ccall((:gpiod_line_request_get_fd, libgpiod), Cint, (Ptr{gpiod_line_request},), request)
end

function gpiod_line_request_wait_edge_events(request, timeout_ns)
    ccall((:gpiod_line_request_wait_edge_events, libgpiod), Cint, (Ptr{gpiod_line_request}, Int64), request, timeout_ns)
end

function gpiod_line_request_read_edge_events(request, buffer, max_events)
    ccall((:gpiod_line_request_read_edge_events, libgpiod), Cint, (Ptr{gpiod_line_request}, Ptr{gpiod_edge_event_buffer}, Csize_t), request, buffer, max_events)
end

@cenum gpiod_edge_event_type::UInt32 begin
    GPIOD_EDGE_EVENT_RISING_EDGE = 1
    GPIOD_EDGE_EVENT_FALLING_EDGE = 2
end

function gpiod_edge_event_free(event)
    ccall((:gpiod_edge_event_free, libgpiod), Cvoid, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_copy(event)
    ccall((:gpiod_edge_event_copy, libgpiod), Ptr{gpiod_edge_event}, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_get_event_type(event)
    ccall((:gpiod_edge_event_get_event_type, libgpiod), gpiod_edge_event_type, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_get_timestamp_ns(event)
    ccall((:gpiod_edge_event_get_timestamp_ns, libgpiod), UInt64, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_get_line_offset(event)
    ccall((:gpiod_edge_event_get_line_offset, libgpiod), Cuint, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_get_global_seqno(event)
    ccall((:gpiod_edge_event_get_global_seqno, libgpiod), Culong, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_get_line_seqno(event)
    ccall((:gpiod_edge_event_get_line_seqno, libgpiod), Culong, (Ptr{gpiod_edge_event},), event)
end

function gpiod_edge_event_buffer_new(capacity)
    ccall((:gpiod_edge_event_buffer_new, libgpiod), Ptr{gpiod_edge_event_buffer}, (Csize_t,), capacity)
end

function gpiod_edge_event_buffer_get_capacity(buffer)
    ccall((:gpiod_edge_event_buffer_get_capacity, libgpiod), Csize_t, (Ptr{gpiod_edge_event_buffer},), buffer)
end

function gpiod_edge_event_buffer_free(buffer)
    ccall((:gpiod_edge_event_buffer_free, libgpiod), Cvoid, (Ptr{gpiod_edge_event_buffer},), buffer)
end

function gpiod_edge_event_buffer_get_event(buffer, index)
    ccall((:gpiod_edge_event_buffer_get_event, libgpiod), Ptr{gpiod_edge_event}, (Ptr{gpiod_edge_event_buffer}, Culong), buffer, index)
end

function gpiod_edge_event_buffer_get_num_events(buffer)
    ccall((:gpiod_edge_event_buffer_get_num_events, libgpiod), Csize_t, (Ptr{gpiod_edge_event_buffer},), buffer)
end

function gpiod_is_gpiochip_device(path)
    ccall((:gpiod_is_gpiochip_device, libgpiod), Bool, (Ptr{Cchar},), path)
end

function gpiod_api_version()
    ccall((:gpiod_api_version, libgpiod), Ptr{Cchar}, ())
end

# exports
const PREFIXES = ["CX", "gpiod_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
