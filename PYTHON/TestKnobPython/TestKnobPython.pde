// TestKnobPython: esqueleto con dos knobs.
// La lectura de los knobs está en la pestaña Knob.

void setup() {
  size(400, 300);
  initKnobs();
}
void draw() {
}


// Se llama cada vez que un knob da un paso.
// knobNum = 1 o 2, valor = +1 (horario) o -1 (antihorario)
void knobTurned() {
  if (knobNum == 1) {
    if (valor == +1) println("Knob 1: horario");
    if (valor == -1) println("Knob 1: antihorario");
  }
  if (knobNum == 2) {
    if (valor == +1) println("Knob 2: horario");
    if (valor == -1) println("Knob 2: antihorario");
  }
}

// Se llama cada vez que se pulsa el botón de un knob. knobNum = 1 o 2
void knobPressed() {
  if (knobNum == 1) {
    println("Knob 1: pulsado");
  }
  if (knobNum == 2) {
    println("Knob 2: pulsado");
  }
}