using Gpiod: Pi, setup, INPUT

pin = 21; # GPIO 21, Board 40

pi = Pi()
setup(pi,pin,INPUT)

while true
    value = read(pi,pin)
    @show value
    sleep(1)
end
