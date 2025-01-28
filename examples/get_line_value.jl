using Gpiod: Pi, setup, INPUT
using Gpiod: gpiod_line_request_get_value

offset = Cuint(16); # GPIO 16, Board 36

pi = Pi()
request = setup(pi,offset,INPUT)

while true
    value = gpiod_line_request_get_value(request, offset);
    @show value
    sleep(1)
end
