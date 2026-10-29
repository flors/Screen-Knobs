# Lista de materiales — Carcasa opción 1

Opción 1 (variante **D** del visor [`carcasa_bienal_v2.html`](carcasa_bienal_v2.html)). Medidas totales del conjunto: **128 × 220 × 63 mm** (ancho × alto × fondo), sin cables. Todas las cotas salen del modelo 3D.

> ⚠️ **WARNING: PENDIENTE CONFIRMAR MEDIDAS REALES.** Queda pendiente:
> - Ajustar métrica de Raspberry & Knobs. En los dibujos se mantiene M2,5.
> - Mover agujeros Raspberry hacía arriba (para poder conectar cable alimentación pantalla) 
>- Corregir posición agujeros pantalla
>- Añadir agujeros para sujetar cableado (pasar bridas) 
>- Quitar agujero para pasar cables de knobs. Y dibujar agujero para atornillar el knob por la parte trasera del metacrilato. 

## Planchas de metacrilato (corte láser)
Metacrilato transparente. Archivos de corte en [`svg/`](svg/) y en [`dxf/`](dxf/), con el mismo dibujo en mm y a tamaño real.

| Cant. | Pieza | Medidas | Archivo |
|---|---|---|---|
| 1 | Placa frontal, **3 mm** | 128 × 208 mm. 4 agujeros Ø3,2 (M3: pantalla), 12 agujeros Ø2,8 (M2,5: encoders y Raspberry) y 2 ranuras de 7 × 8 mm para los cables de los encoders (quedan ocultas tras la pantalla) | [SVG](svg/opcion1_placa_frontal_3mm.svg) · [DXF](dxf/opcion1_placa_frontal_3mm.dxf) |
| 1 | Placa trasera, **3 mm** | 128 × 208 mm (mismo contorno que la frontal). 4 agujeros Ø3,2 (M3) y 2 cerraduras para colgar (agujero Ø9 + ranura Ø4,5, separación 80 mm) | [SVG](svg/opcion1_placa_trasera_3mm.svg) · [DXF](dxf/opcion1_placa_trasera_3mm.dxf) |


## Separadores
> ⚠️ **WARNING: el largo de separadores se puede ajustar según los tamaños disponibles en el mercado.**

Lo ideal sería pasar todo a M3. 
Los de la Raspberry y los knobs son de M2,5 (quizás venían en kit ya comprado).
En la Raspberry tienen un aro amarillo, que se podría ampliar para usar M3. 

Las cantidades de la tabla son suponiendo que se consiguen separadores y tornillos M2,5

| Cant. | Pieza | Dónde |
|---|---|---|
| 4 | Separador de latón **M3** hembra-hembra, **10 mm** | Entre la pantalla y la placa frontal. En la simulación 3D, lo ideal era 7mm. En Diotronic suelen tener de 5mm o 10mm. Comprobarlo con medidas de la pantalla cual funciona mejor.  
| 4 | Separador **M2,5 macho-hembra. 6mm (en simulación 3D)** | Raspberry. Pueden ser de 5mm o 10mm. Mejor usar macho-hembra en este caso. Si el separador es hembra-hembra es difícil conseguir tornillos tan cortos para que no choquen.  
| 4 | Separador hexagonal **M3** hembra-hembra, **35 mm (en simulación 3D)** | Entre las dos placas, justo detrás de cada separador de la pantalla |

## Tornillería
> ⚠️**Avellanados:** los tornillos avellanados permiten que la cabeza quede a ras, pero el avellanado (el hueco donde encaja la cabeza) hay que hacerlo a mano en el metacrilato. La alternativa es usar un tornillo normal que sobresalga por fuera del metacrilato.

**M3:**

| Cant. | Pieza | Dónde |
|---|---|---|
| 4 | Tornillo **M3** × 20 | Pantalla: atraviesa el separador de 10 mm y la placa frontal, y entra en el separador de 35 mm |
| 4 | Tornillo **M3** × 8, avellanado | Placa trasera, por detrás y a ras (ver notas) |

**M2,5:**

| Cant. | Pieza | Dónde |
|---|---|---|
| 8 | Tornillo M2,5 × 8 | Encoders, atornillados por detrás (los agujeros de la placa de los encoders son M2,5) |
| 8 | Tuerca M2,5 | Encoders |
| 4 | Tuerca M2,5 | Raspberry: rosca macho del separador, por delante de la placa frontal (queda tapada por la pantalla). Normalmente incluida en el kit de la Raspberry |
| 4 | Tornillo M2,5 × 4 | Raspberry: rosca hembra del separador, por la cara de la Pi. Normalmente incluido en el kit de la Raspberry |


## Fijación a la pared
**DEPENDE DE MONTAJE EN SALA** 
Recomendación:
| Cant. | Pieza | Notas |
|---|---|---|
| 2 | Tornillo de pared de cabeza ancha (Ø8), M4 × 40 | Separación entre tornillos: 80 mm. Dejar unos 9 mm fuera de la pared |
| 2 | Taco | Adecuado al tipo de pared |

Se cuelga por el agujero grande de cada cerradura y se desliza hacia abajo. El hueco de 35 mm entre pared y plancha aloja la Raspberry y los cables.

