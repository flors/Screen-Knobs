// Visuales con dos knobs. La lectura de los GPIO está en la pestaña Knobs.

// Versión suavizada de los valores, para que el movimiento sea fluido
float k1Suave = 0;
float k2Suave = 0;

// ---- Ajustes ----
final int     K1_MAX_CLICS    = 10;     // clics (en cada sentido) hasta el tamaño mínimo/máximo
final float   TAM_MIN         = 0.10;   // diámetro mínimo (fracción del lado corto de la pantalla)
final float   TAM_MAX         = 0.90;   // diámetro máximo
final float   PASO_X          = 0.03;   // cuánto se mueve por clic el knob 2 (fracción del ancho; 0.03 = ~33 clics para cruzar la pantalla)
final color   COLOR_CIRCULO   = #FF9AA2;
final float   SUAVIZADO       = 1;   // 0 = no se mueve, 1 = sin suavizado

void setup() {
  fullScreen();
  noCursor();
  initKnobs();
}

void draw() {
  // Suaviza los valores para que el movimiento sea fluido
  k1Suave = lerp(k1Suave, knobValue1, SUAVIZADO);
  k2Suave = lerp(k2Suave, knobValue2, SUAVIZADO);

  background(0);
  float lado = min(width, height);

  // Knob 1 -> tamaño (0 = tamaño medio; positivo = más grande; negativo = más pequeño)
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

// FPS y memoria, siempre visibles 
void mostrarInfo() {
  java.lang.Runtime rt = java.lang.Runtime.getRuntime();
  float usadaMB = (rt.totalMemory() - rt.freeMemory()) / 1048576.0;
  float maxMB   = rt.maxMemory() / 1048576.0;

  String info = "FPS: " + nf(frameRate, 0, 1)
              + "    MEM: " + nf(usadaMB, 0, 0) + " / " + nf(maxMB, 0, 0) + " MB"
              + "    " + width + "x" + height;
  
  info += "    K1: " + knobValue1 + "    K2: " + knobValue2;

  fill(255);
  textSize(20);
  text(info, 20, height - 20);
}

void exit() {
  closeKnobs();
  super.exit();
}
