#Cargamos librería GPIOZero, compatible con Pi5 y se usa RotaryEncoder, de la misma librería para leer de forma mas estable los encoders y con callbacks 
from gpiozero import RotaryEncoder, Button 
import os
import time

#Variables knob y pulsadores de cada encoder 
# max_steps=0 significa sin límite de pasos.
knob1 = RotaryEncoder(27, 22, max_steps=0)   # ENCA=GPIO27, ENCB=GPIO22
btn1 = Button(17, pull_up=True, bounce_time=0.02)             # SW=GPIO17

knob2 = RotaryEncoder(19, 13, max_steps=0)   # ENCA=GPIO19, ENCB=GPIO13
btn2 = Button(26, pull_up=True, bounce_time=0.02)             # SW=GPIO26



# Se ejecuta cada vez que el knob1 da un paso en sentido horario.
def turn_cw_1():
    print("K1 +1", flush=True)

# Se ejecuta cada vez que el knob1 da un paso en sentido antihorario.
def turned_ccw_1():
    print("K1 -1", flush=True)


# Se ejecuta al pulsar el botón knob1
def button_pressed_1():
    print("K1 0", flush=True)


# Listeners eventos knob 1 
knob1.when_rotated_clockwise = turn_cw_1
knob1.when_rotated_counter_clockwise = turned_ccw_1
btn1.when_pressed = button_pressed_1


# Se ejecuta cada vez que el knob2 da un paso en sentido horario.
def turn_cw_2():
    print("K2 +1", flush=True)

# Se ejecuta cada vez que el knob2 da un paso en sentido antihorario.
def turned_ccw_2():
    print("K2 -1", flush=True)


# Se ejecuta al pulsar el botón knob2
def button_pressed_2():
    print("K2 0", flush=True)

# Listeners eventos knob 2
knob2.when_rotated_clockwise = turn_cw_2
knob2.when_rotated_counter_clockwise = turned_ccw_2
btn2.when_pressed = button_pressed_2



# Si Processing se cierra, el script se cierra solo (así no se queda vivo y los gpio no quedab abiertos).
processingRef = os.getppid()
while True:
    time.sleep(1)
    if os.getppid() != processingRef:
        os._exit(0)