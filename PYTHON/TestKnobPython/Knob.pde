// ===== Knob.pde =====
// Lanza knob.py (carpeta data) y convierte sus mensajes en llamadas a
// knobTurned() y knobPressed(), que define el sketch principal.
// Versión para la Raspberry Pi (Linux).
//
// Mensajes de knob.py:   K1 +1  /  K1 -1  /  K1 0      (K2 igual)
//   +1 = un paso en sentido horario
//   -1 = un paso en sentido antihorario
//    0 = botón pulsado
import java.io.*;
import java.util.concurrent.ConcurrentLinkedQueue;

int knobNum = 0;   // knob que ha generado el evento (1 o 2)
int valor = 0;     // +1 = sentido horario, -1 = sentido antihorario

final String PYTHON = "python3";
final String SCRIPT_KNOBS = "knob.py";   // dentro de la carpeta data del sketch

Process procesoKnobs;
// Cola de eventos {knob, tipo}: tipo +1 = giro horario, -1 = giro antihorario, 0 = pulsación
ConcurrentLinkedQueue<int[]> eventosKnobs = new ConcurrentLinkedQueue<int[]>();

void initKnobs() {
  try {
    ProcessBuilder pb = new ProcessBuilder(PYTHON, dataPath(SCRIPT_KNOBS));
    pb.redirectError(ProcessBuilder.Redirect.INHERIT);   // los errores de Python salen en la consola
    procesoKnobs = pb.start();
  } catch (Exception e) {
    e.printStackTrace();
    return;
  }

  // Un thread lee lo que escribe knob.py y lo mete en la cola
  final BufferedReader lector = new BufferedReader(new InputStreamReader(procesoKnobs.getInputStream()));
  Thread hilo = new Thread(() -> {
    try {
      String linea;
      while ((linea = lector.readLine()) != null) leeLineaKnob(linea);
      println("knob.py ha terminado");
    } catch (IOException e) { }
  }, "lector-knobs");
  hilo.setDaemon(true);
  hilo.start();

  // Al cerrar el sketch se cierra también knob.py (y se liberan los GPIO)
  Runtime.getRuntime().addShutdownHook(new Thread(() -> {
    if (procesoKnobs != null) procesoKnobs.destroy();
  }));

  registerMethod("pre", this); // Añadir función "pre" para que se ejecute justo antes del draw
}

// Interpreta una línea: "K1 +1", "K2 -1", "K1 0" (pulsación)
void leeLineaKnob(String linea) {
  String[] p = splitTokens(linea);
  if (p.length != 2) return;
  int num;
  if (p[0].equals("K1")) num = 1;
  else if (p[0].equals("K2")) num = 2;
  else return;
  int tipo = int(p[1]);                 // +1, -1 o 0
  if (tipo < -1 || tipo > 1) return;
  eventosKnobs.add(new int[] { num, tipo });
}

// Se ejecuta en el thread de Processing, antes de cada draw(), para evitar ponerlo en el draw()
//Se añade en la función initKnobs. Se podría quitar esto y añadir al inicio en el draw como una llamada a una funcion normal
void pre() {
  int[] e;
  while ((e = eventosKnobs.poll()) != null) {
    knobNum = e[0];
    if (e[1] == 0) {
      knobPressed();
    } else {
      valor = e[1];
      knobTurned();
    }
  }
}