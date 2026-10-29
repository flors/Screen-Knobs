# Lista de materiales — Carcasa opción 1

Opción 1 (variante **D** del visor [`carcasa_bienal_v2.html`](carcasa_bienal_v2.html)). Medidas totales del conjunto: **128 × 220 × 63 mm** (ancho × alto × fondo), sin cables. Todas las cotas salen del modelo 3D.

> ⚠️ **WARNING: PENDIENTE CONFIRMAR MEDIDAS REALES.** Las cotas de la pantalla, la Raspberry y la placa de prototipos son **estimadas**, y falta confirmar el diámetro real de los agujeros de la pantalla (ver las notas del final). No cortar las planchas ni comprar la tornillería hasta verificarlo con calibre.
>
> ⚠️ **WARNING: PENDIENTE AÑADIR AGUJEROS PARA BRIDAS** (para sujetar los cables) en las placas **antes del corte láser**. Los archivos de corte actuales no los incluyen.

## Planchas de metacrilato (corte láser)

Metacrilato transparente. Archivos de corte en [`svg/`](svg/) y en [`dxf/`](dxf/), con el mismo dibujo en mm y a tamaño real.

| Cant. | Pieza | Medidas | Archivo |
|---|---|---|---|
| 1 | Placa frontal, **3 mm** | 128 × 208 mm, esquinas R8. 4 agujeros Ø3,2 (M3: pantalla), 12 agujeros Ø2,8 (M2,5: encoders y Raspberry) y 2 ranuras de 7 × 8 mm para los cables de los encoders (quedan ocultas tras la pantalla) | [SVG](svg/opcion1_placa_frontal_3mm.svg) · [DXF](dxf/opcion1_placa_frontal_3mm.dxf) |
| 1 | Placa trasera, **3 mm** | 128 × 208 mm (mismo contorno que la frontal). 4 agujeros Ø3,2 (M3) y 2 cerraduras para colgar (agujero Ø9 + ranura Ø4,5, separación 80 mm) | [SVG](svg/opcion1_placa_trasera_3mm.svg) · [DXF](dxf/opcion1_placa_trasera_3mm.dxf) |

## Cables

| Cant. | Pieza | Notas |
|---|---|---|
| 1 | Cable micro-HDMI → HDMI | De la Raspberry a la pantalla. Conectores rectos, flexible o tipo "slim" |
| 1 | Cable USB-A → micro-USB | Táctil y alimentación de la pantalla. Conectores rectos, flexible o tipo "slim" |
| 1 | Cable micro-HDMI → HDMI | Hacia una 2ª pantalla (en el modelo solo se reserva el espacio) |
| 1 | Cable USB-C y fuente oficial de 27 W (5 V / 5 A) | Alimentación de la Raspberry Pi 5 |
| 2 | Cable JST-SH 4 pines → Dupont | Uno por mando: GND, SW, ENCA, ENCB |

Los cables de la pantalla salen por encima del borde superior de la plancha, con una curva amplia.

## Separadores

Todo en **M3**, salvo los de la Raspberry (M2,5), que deberían venir con su kit. Los encoders también son M2,5.

| Cant. | Pieza | Dónde |
|---|---|---|
| 4 | Separador de latón **M3** hembra-hembra, **10 mm** | Entre la pantalla y la placa frontal. Los de 7 mm no existen: se venden de 5 en 5 mm (por ejemplo en Diotronic) y se elige 10 mm porque los conectores de la parte trasera de la pantalla no caben en 5 mm |
| 4 | Separador **M2,5 macho-hembra**, 6 mm (rosca macho de 6 mm) | Raspberry. El lado macho atraviesa la placa frontal y se fija con una tuerca por delante; la Pi se atornilla en el lado hembra. Así los tornillos no chocan dentro del separador. Si los agujeros de la Raspberry son M2,5, deberían venir con el kit de la Raspberry |
| 4 | Separador hexagonal **M3** hembra-hembra, **35 mm** | Entre las dos placas, justo detrás de cada separador de la pantalla. Deja 2,0 mm de margen a los bornes (la Pi con su placa de prototipos mide 27 mm de alto) |

## Tornillería

**M3:**

| Cant. | Pieza | Dónde |
|---|---|---|
| 4 | Tornillo **M3** × 20 | Pantalla: atraviesa el separador de 10 mm y la placa frontal, y entra en el separador de 35 mm |
| 4 | Tornillo **M3** × 8, avellanado | Placa trasera, por detrás y a ras (ver notas) |

**M2,5:**

| Cant. | Pieza | Dónde |
|---|---|---|
| 8 | Tornillo M2,5 × 8 | Encoders, atornillados por delante (los agujeros de la placa de los encoders son M2,5) |
| 8 | Tuerca M2,5 | Encoders |
| 4 | Tuerca M2,5 | Raspberry: rosca macho del separador, por delante de la placa frontal (queda tapada por la pantalla). Normalmente incluida en el kit de la Raspberry |
| 4 | Tornillo M2,5 × 4 | Raspberry: rosca hembra del separador, por la cara de la Pi. Normalmente incluido en el kit de la Raspberry |

### Notas

- **Avellanados:** los tornillos avellanados permiten que la cabeza quede a ras, pero el avellanado (el hueco donde encaja la cabeza) hay que hacerlo a mano en el metacrilato. La alternativa es usar un tornillo normal que sobresalga por fuera del metacrilato.
- **Métrica:** se sugiere M3 para todo, salvo lo de la Raspberry y los encoders, cuya métrica depende de sus agujeros (M2,5). Esta lista se puede ampliar.
- **Por confirmar:** los agujeros de la pantalla (tipo Waveshare 7" C) también podrían ser M2,5. Para pasar un tornillo M3 hacen falta agujeros de al menos 3,2 mm en la propia placa de la pantalla. Si no es así, habría que usar M2,5 también en la pantalla.

## Fijación a la pared
**DEPENDE DE MONTAJE EN SALA** 

Recomendación:
| Cant. | Pieza | Notas |
|---|---|---|
| 2 | Tornillo de pared de cabeza ancha (Ø8), M4 × 40 | Separación entre tornillos: 80 mm. Dejar unos 9 mm fuera de la pared |
| 2 | Taco | Adecuado al tipo de pared |

Se cuelga por el agujero grande de cada cerradura y se desliza hacia abajo. El hueco de 35 mm entre pared y plancha aloja la Raspberry y los cables.

## Conexión de los knobs al GPIO
En caso de usar la placa con los pines soldados. 
Orden de los cables de cada knob: GND, SW, ENCA, ENCB, en la fila interior del header. Cada knb va a un borne de la placa de prototipos.

| Knob | Pines físicos | Señales |
|---|---|---|
| Knob 1 (Izquierda)| 9 · 11 · 13 · 15 | GND · GPIO17 · GPIO27 · GPIO22 |
| Knob 2 (Derecha) | 39 · 37 · 35 · 33 | GND · GPIO26 · GPIO19 · GPIO13 |

