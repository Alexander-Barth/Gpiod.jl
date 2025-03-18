module Gpiod

import Base: read, write
include("LibGpiod.jl")

using Gpiod.LibGpiod

const INPUT = LibGpiod.GPIOD_LINE_DIRECTION_INPUT
const OUTPUT = LibGpiod.GPIOD_LINE_DIRECTION_OUTPUT
const LOW = false
const HIGH = true

struct Pi
    chip_path::String
    consumer::String
    request::Dict{Cuint,Ptr{LibGpiod.gpiod_request_config}}
end

function Pi(;chip_path = "/dev/gpiochip0",
            consumer = "Gpiod.jl")
    request = Dict{Cuint,Ptr{LibGpiod.gpiod_request_config}}()
    return Pi(chip_path,consumer,request)
end

function setup(pi::Pi,offset,mode)
    chip = gpiod_chip_open(pi.chip_path);

    if haskey(pi.request,Cuint(offset))
        @debug "releasing previous request for pin $offset"
        request = pi.request[Cuint(offset)]
        gpiod_line_request_release(request)
    end

    settings = gpiod_line_settings_new();
    if (settings == C_NULL)
        gpiod_chip_close(chip);
        return
    end

    gpiod_line_settings_set_direction(settings, mode);

    line_cfg = gpiod_line_config_new();
    if (line_cfg == C_NULL)
	gpiod_line_settings_free(settings);
        return
    end

    ret = gpiod_line_config_add_line_settings(line_cfg, [Cuint(offset)], 1,
						  settings);
    if (ret != 0)
        gpiod_line_config_free(line_cfg);
        return
    end

    req_cfg = gpiod_request_config_new();
    if (req_cfg == C_NULL)
	gpiod_line_config_free(line_cfg);
        return
    end

    gpiod_request_config_set_consumer(req_cfg, pi.consumer);
    request = gpiod_chip_request_lines(chip, req_cfg, line_cfg);

    @assert request != C_NULL

    gpiod_request_config_free(req_cfg);
    gpiod_line_config_free(line_cfg);
    gpiod_line_settings_free(settings);
    gpiod_chip_close(chip);

    pi.request[Cuint(offset)] = request
    return nothing
end

function Base.read(pi::Pi,offset)
    request = pi.request[Cuint(offset)]
    value = gpiod_line_request_get_value(request, offset);
    return value == GPIOD_LINE_VALUE_ACTIVE
end

function Base.write(pi::Pi,offset,value::Bool)
    request = pi.request[Cuint(offset)]
    v = (value ? GPIOD_LINE_VALUE_ACTIVE : GPIOD_LINE_VALUE_INACTIVE)
    gpiod_line_request_set_value(request, offset, v)
    return nothing
end

end
