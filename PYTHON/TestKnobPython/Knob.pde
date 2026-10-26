// ===== Knobs.pde =====
// Lectura de dos knobs a través de knob.py (Python), que manda los valores por la salida estándar.
// El sketch principal solo necesita: initKnobs(), closeKnobs(), knobValue1 y knobValue2.
import java.io.*;

// Valores de los knobs (llegan desde knob.py). 0 = estado por defecto (el botón vuelve a 0).
volatile int knobValue1 = 0;
volatile int knobValue2 = 0;

final String SCRIPT_KNOBS = "knob.py";   // dentro de la carpeta data del sketch

Process procesoKnobs;
Thread hiloKnobs;

void initKnobs() {
  try {
    ProcessBuilder pb = new ProcessBuilder("python3", dataPath(SCRIPT_KNOBS));
    pb.redirectError(ProcessBuilder.Redirect.INHERIT);   // los errores de Python salen en la consola
    procesoKnobs = pb.start();
    final BufferedReader lector = new BufferedReader(new InputStreamReader(procesoKnobs.getInputStream()));

    // Un hilo espera los mensajes de Python y actualiza los valores en cuanto llegan
    hiloKnobs = new Thread(() -> {
      try {
        String linea;
        while ((linea = lector.readLine()) != null) {
          procesarLineaKnob(linea);
        }
        println("knob.py ha terminado");
      } catch (IOException e) { }
    }, "lector-knobs");
    hiloKnobs.setDaemon(true);
    hiloKnobs.start();
  } catch (Exception e) {
    e.printStackTrace();
  }
}

// Interpreta una línea: "K1 5" o "K2 -3"
void procesarLineaKnob(String linea) {
  String[] p = splitTokens(linea);
  if (p.length != 2) return;
  try {
    int v = Integer.parseInt(p[1]);
    if (p[0].equals("K1")) knobValue1 = v;
    else if (p[0].equals("K2")) knobValue2 = v;
  } catch (NumberFormatException e) { }
}

void closeKnobs() {
  if (procesoKnobs != null) procesoKnobs.destroy();   // cierra el script de Python
}