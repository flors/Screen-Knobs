// ===== Knobs.pde =====
// Lectura de dos knobs con Pi4J (GPIO en la Raspberry Pi 5).
// El sketch principal solo necesita: initKnobs(), closeKnobs(), knobValue1 y knobValue2.
import com.pi4j.Pi4J;
import com.pi4j.context.Context;
import com.pi4j.io.gpio.digital.*;
import java.util.function.IntConsumer;

// Valores de los knobs, listos para usar. 0 = estado por defecto (el botón vuelve a 0).
volatile int knobValue1 = 0;
volatile int knobValue2 = 0;

// Antirrebote por hardware de Pi4J, en microsegundos (0 = sin filtro)
final long DEBOUNCE_ENCODER_US = 0;
final long DEBOUNCE_BOTON_US   = 20000;

// NUEVO: cada cuánto mira los pines el hilo de lectura (en nanosegundos). 500000 = 0,5 ms
final long PERIODO_LECTURA_NS = 500000;
// NUEVO: tiempo mínimo entre dos pulsaciones del botón (milisegundos), para ignorar rebotes
final long ANTIRREBOTE_BOTON_MS = 30;

Context pi4j;
Knob knob1, knob2;
Thread hiloLectura;                 // NUEVO
volatile boolean leyendo = false;   // NUEVO

// Decodificación de cuadratura. Si el sentido sale invertido en un knob,
// intercambia sus pines A y B en initKnobs().
final int[] T = {0,1,-1,0,  -1,0,0,1,  1,0,0,-1,  0,-1,1,0};

void initKnobs() {
  pi4j = Pi4J.newAutoContext();
  // Pines BCM: (nombre, ENCA, ENCB, SW, variable donde se guarda el valor)
  knob1 = new Knob("K1", 27, 22, 17, v -> knobValue1 = v);
  knob2 = new Knob("K2", 19, 13, 26, v -> knobValue2 = v);

  // NUEVO: un único hilo lee los dos knobs, siempre en orden
  leyendo = true;
  hiloLectura = new Thread(() -> {
    while (leyendo) {
      knob1.leer();
      knob2.leer();
      java.util.concurrent.locks.LockSupport.parkNanos(PERIODO_LECTURA_NS);
    }
  }, "lectura-knobs");
  hiloLectura.setDaemon(true);
  hiloLectura.start();
}

void closeKnobs() {
  leyendo = false;   // NUEVO: para el hilo antes de liberar los pines
  try {
    if (hiloLectura != null) hiloLectura.join(200);
  } catch (InterruptedException e) { }
  if (pi4j != null) pi4j.shutdown();   // libera los pines
}

// Un knob: encoder (A y B) + botón (SW)
class Knob {
  DigitalInput inA, inB, inSW;
  IntConsumer salida;       // a dónde se manda el valor final
  int pasos = 0;
  int valor = 0;
  int lastState = 0;
  boolean swPulsado = false;   // NUEVO
  long ultimoPulso = 0;        // NUEVO

  Knob(String nombre, int pinA, int pinB, int pinSW, IntConsumer salida) {
    this.salida = salida;
    inA  = entrada(nombre + "_A",  pinA,  DEBOUNCE_ENCODER_US);   // el id debe ser único en todo el sketch
    inB  = entrada(nombre + "_B",  pinB,  DEBOUNCE_ENCODER_US);
    inSW = entrada(nombre + "_SW", pinSW, DEBOUNCE_BOTON_US);
    lastState = estado();
    swPulsado = (inSW.state() == DigitalState.LOW);
  }

  // Entrada digital con pull-up
  DigitalInput entrada(String id, int bcm, long debounceUs) {
    return pi4j.create(DigitalInput.newConfigBuilder(pi4j)
      .id(id).name(id).address(bcm)
      .debounce(debounceUs)
      .pull(PullResistance.PULL_UP)
      .build());
  }

  // Estado actual de A y B (dos bits)
  int estado() {
    return (inA.state() == DigitalState.HIGH ? 2 : 0)
         | (inB.state() == DigitalState.HIGH ? 1 : 0);
  }

  // NUEVO: se llama una vez cada ~0,5 ms desde el hilo de lectura (y solo desde ahí)
  void leer() {
    // Encoder
    int s = estado();
    if (s != lastState) {
      pasos += T[(lastState << 2) | s];
      lastState = s;
      int nuevo = pasos / 4;            // 4 pasos por "clic"
      if (nuevo != valor) {
        valor = nuevo;
        salida.accept(valor);
      }
    }

    // Botón: actúa al pulsar (flanco de bajada)
    boolean pulsado = (inSW.state() == DigitalState.LOW);
    long ahora = System.currentTimeMillis();
    if (pulsado && !swPulsado && ahora - ultimoPulso > ANTIRREBOTE_BOTON_MS) {
      reset();
      ultimoPulso = ahora;
    }
    swPulsado = pulsado;
  }

  void reset() {
    pasos = 0;
    valor = 0;
    salida.accept(0);
  }
}