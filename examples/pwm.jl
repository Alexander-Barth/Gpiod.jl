using Gpiod: Pi, setup, OUTPUT

pin = 14; # GPIO 14, Board 8

pi = Pi()
setup(pi,pin,OUTPUT)


frequency = 1000 # Hz
dutycyle = 255 # 64, 128, 192, 255
range = 255

dutycyle = 64

range ÷ dutycyle




#PiGPIO.set_PWM_frequency(pi,enable[i],frequency)
#            PiGPIO.set_PWM_dutycycle(pi, enable[i], dutycyle)

function toggle(pin)
    function cb(timer)
        state = !state
        write(pi,pin,state)
    end
    state = false
    return cb
end
cb = toggle(pin)

t = Timer(cb,0, interval = 0.00001)



