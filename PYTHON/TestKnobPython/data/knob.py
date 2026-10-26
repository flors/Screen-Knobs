#!/usr/bin/env python3
# Lee dos knobs (encoder + botón) y escribe por la salida estándar una línea
# cada vez que cambia su valor:   K1 5   /   K2 -3
import os
import sys
import time
from threading import Lock
from gpiozero import DigitalInputDevice, Button

# Decodificación de cuadratura (igual que en la versión de Pi4J).
# Si el sentido sale invertido, intercambia pin_a y pin_b del knob afectado.
T = [0,1,-1,0,  -1,0,0,1,  1,0,0,-1,  0,-1,1,0]
lock = Lock()


def enviar(nombre, valor):
    try:
        print(f"{nombre} {valor}", flush=True)
    except BrokenPipeError:   # Processing se ha cerrado
        os._exit(0)


class Knob:
    def __init__(self, nombre, pin_a, pin_b, pin_sw):
        self.nombre = nombre
        self.pasos = 0
        self.valor = 0

        self.a = DigitalInputDevice(pin_a, pull_up=True)
        self.b = DigitalInputDevice(pin_b, pull_up=True)
        self.sw = Button(pin_sw, pull_up=True, bounce_time=0.02)

        # Nivel de cada pin (1 = HIGH). Con pull-up, "activo" significa nivel bajo.
        self.nivel_a = int(not self.a.is_active)
        self.nivel_b = int(not self.b.is_active)
        self.ultimo = (self.nivel_a << 1) | self.nivel_b

        self.a.when_activated   = lambda: self.cambio("a", 0)
        self.a.when_deactivated = lambda: self.cambio("a", 1)
        self.b.when_activated   = lambda: self.cambio("b", 0)
        self.b.when_deactivated = lambda: self.cambio("b", 1)
        self.sw.when_pressed    = self.reset

        enviar(self.nombre, 0)

    def cambio(self, cual, nivel):
        with lock:
            if cual == "a":
                self.nivel_a = nivel
            else:
                self.nivel_b = nivel
            s = (self.nivel_a << 1) | self.nivel_b
            self.pasos += T[(self.ultimo << 2) | s]
            self.ultimo = s
            nuevo = int(self.pasos / 4)   # 4 pasos por "clic"
            if nuevo != self.valor:
                self.valor = nuevo
                enviar(self.nombre, nuevo)

    def reset(self):
        with lock:
            self.pasos = 0
            if self.valor != 0:
                self.valor = 0
                enviar(self.nombre, 0)


# Pines BCM: (nombre, ENCA, ENCB, SW)
knobs = [
    Knob("K1", pin_a=27, pin_b=22, pin_sw=17),
    Knob("K2", pin_a=19, pin_b=13, pin_sw=26),
]

# Si Processing desaparece, el script se cierra solo (así no se queda vivo).
padre = os.getppid()
while True:
    time.sleep(1)
    if os.getppid() != padre:
        os._exit(0)