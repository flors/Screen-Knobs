// Visuales con dos knobs. La lectura de los knobs está en la pestaña Knobs.

// Versión suavizada de los valores, para que las animaciones no den saltos
float k1Suave = 0;
float k2Suave = 0;

// Info de CPU
long cpuTotalPrev = 0, cpuIdlePrev = 0;
float cpuUso = 0;            // % de CPU de todo el sistema
float cpuTemp = 0;           // temperatura en °C
int ultimaLecturaCpu = 0;

// ---- Ajustes ----
final int     K1_MAX_CLICS  = 10;    // clics desde el centro hasta el tamaño mínimo/máximo
final float   TAM_MIN       = 0.10;  // diámetro mínimo (fracción del lado corto de la pantalla)
final float   TAM_MAX       = 0.90;  // diámetro máximo
final float   PASO_X        = 0.03;  // cuánto se mueve por clic el knob 2 (fracción del ancho; 0.03 = ~33 clics para cruzar la pantalla)
final color   COLOR_CIRCULO = #FF9AA2;
final float   SUAVIZADO     = 0.15;  // 0 = no se mueve, 1 = sin suavizado

void setup() {
  //fullScreen(P2D);
  size(720,480);
  //smooth(8);
  noCursor();
  initKnobs();
}

void draw() {
  // Suaviza los valores para que el círculo se mueva con fluidez
  k1Suave = lerp(k1Suave, knobValue1, SUAVIZADO);
  k2Suave = lerp(k2Suave, knobValue2, SUAVIZADO);

  background(0);
  float lado = min(width, height);

  // Knob 1 -> tamaño (0 = tamaño medio, el de por defecto)
  float d = map(constrain(k1Suave, -K1_MAX_CLICS, K1_MAX_CLICS),
                -K1_MAX_CLICS, K1_MAX_CLICS, TAM_MIN * lado, TAM_MAX * lado);

  // Knob 2 -> posición horizontal (0 = centro; positivo = derecha; negativo = izquierda)
  // Al salir por un lado de la pantalla, vuelve a entrar por el otro.
  float x = width / 2 + k2Suave * PASO_X * width;
  x = ((x % width) + width) % width;

  noStroke();
  fill(COLOR_CIRCULO);
  ellipse(x, height / 2, d, d);
  // Copias a ambos lados, para que al cruzar el borde el círculo salga por un lado
  // mientras entra por el otro, sin saltos
  ellipse(x - width, height / 2, d, d);
  ellipse(x + width, height / 2, d, d);

  mostrarInfo();
}

// Lee el uso de CPU y la temperatura una vez por segundo (no en cada fotograma)
void actualizarCpu() {
  if (millis() - ultimaLecturaCpu < 1000) return;
  ultimaLecturaCpu = millis();

  // Uso de CPU: se compara el tiempo ocupado con el total entre dos lecturas
  try {
    String[] p = splitTokens(leerPrimeraLinea("/proc/stat"));   // "cpu" user nice system idle iowait irq softirq steal
    long total = 0;
    for (int i = 1; i <= 8 && i < p.length; i++) total += Long.parseLong(p[i]);
    long idle = Long.parseLong(p[4]) + Long.parseLong(p[5]);
    long dTotal = total - cpuTotalPrev;
    long dIdle  = idle - cpuIdlePrev;
    if (cpuTotalPrev > 0 && dTotal > 0) cpuUso = 100.0 * (dTotal - dIdle) / dTotal;
    cpuTotalPrev = total;
    cpuIdlePrev = idle;
  } catch (Exception e) {
    println("Error leyendo CPU: " + e);
  }

  // Temperatura (el sistema la da en milésimas de grado)
  try {
    cpuTemp = Float.parseFloat(trim(leerPrimeraLinea("/sys/class/thermal/thermal_zone0/temp"))) / 1000.0;
  } catch (Exception e) {
    println("Error leyendo temperatura: " + e);
  }
}

// FPS, memoria y CPU, siempre visibles
void mostrarInfo() {
  actualizarCpu();

  java.lang.Runtime rt = java.lang.Runtime.getRuntime();
  float usadaMB = (rt.totalMemory() - rt.freeMemory()) / 1048576.0;
  float maxMB   = rt.maxMemory() / 1048576.0;

  String info = "FPS: " + nf(frameRate, 0, 1)
              + "    MEM: " + nf(usadaMB, 0, 0) + " / " + nf(maxMB, 0, 0) + " MB"
              + "    CPU: " + nf(cpuUso, 0, 0) + "%  " + nf(cpuTemp, 0, 1) + " C"
              + "    " + width + "x" + height;

  info += "    K1: " + knobValue1 + "    K2: " + knobValue2;

  fill(255);
  textSize(20);
  text(info, 20, height - 00);
}

// Lee la primera línea de un archivo de texto
String leerPrimeraLinea(String ruta) throws Exception {
  try (java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(ruta))) {
    return br.readLine();
  }
}

void exit() {
  closeKnobs();
  super.exit();
}
