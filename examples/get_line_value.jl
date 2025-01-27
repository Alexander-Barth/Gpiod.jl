using Gpiod

using Gpiod.LibGpiod: GPIOD_LINE_DIRECTION_INPUT
using Gpiod.LibGpiod

function setup(offset;
               chip_path = "/dev/gpiochip0",
               consumer = "get_line_value")
    
    chip = gpiod_chip_open(chip_path);

    settings = gpiod_line_settings_new();
    if (settings == C_NULL)
        gpiod_chip_close(chip);
        return
    end

    gpiod_line_settings_set_direction(settings, GPIOD_LINE_DIRECTION_INPUT);

    line_cfg = gpiod_line_config_new();
    if (line_cfg == C_NULL)
	gpiod_line_settings_free(settings);
        return
    end

    ret = gpiod_line_config_add_line_settings(line_cfg, [offset], 1,
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

    gpiod_request_config_set_consumer(req_cfg, consumer);

    request = gpiod_chip_request_lines(chip, req_cfg, line_cfg);

    gpiod_request_config_free(req_cfg);

    gpiod_line_config_free(line_cfg);

    gpiod_line_settings_free(settings);

    gpiod_chip_close(chip);

    return request
end

offset = Cuint(16); # GPIO 16, Board 36

request = setup(offset)

while true
    value = gpiod_line_request_get_value(request, offset[]);
    @show value
    sleep(1)
end
