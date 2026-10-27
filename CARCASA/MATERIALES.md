# Lista de materiales — Carcasa opción 1

Opción 1 (variante **D** del visor [`carcasa_bienal_v2.html`](carcasa_bienal_v2.html)). Medidas totales del conjunto: **128 × 220 × 65 mm** (ancho × alto × fondo), sin cables. Todas las cotas salen del modelo 3D.

> Las cotas de la pantalla, la Raspberry y la placa de prototipos son **estimadas**: verificar con calibre antes de cortar y de comprar la tornillería.

## Planchas de metacrilato (corte láser)

Metacrilato transparente. Los archivos de corte están en [`svg/`](svg/).

| Cant. | Pieza | Medidas | Archivo |
|---|---|---|---|
| 1 | Placa frontal, **3 mm** | 128 × 208 mm, esquinas R8. 16 agujeros Ø2,8 (M2,5) y 2 ranuras de 7 × 8 mm para los cables de los encoders (quedan ocultas tras la pantalla) | [`opcion1_placa_frontal_3mm.svg`](svg/opcion1_placa_frontal_3mm.svg) |
| 1 | Placa trasera, **5 mm** | 128 × 208 mm (mismo contorno que la frontal). 4 agujeros Ø2,8 y 2 cerraduras para colgar (agujero Ø9 + ranura Ø4,5, separación 80 mm) | [`opcion1_placa_trasera_5mm.svg`](svg/opcion1_placa_trasera_5mm.svg) |

## Electrónica

| Cant. | Pieza | Notas |
|---|---|---|
| 1 | Pantalla HDMI 7" táctil (tipo Waveshare 7" C) | 100 × 165 mm, agujeros de fijación de 108 × 157 mm (M2,5) |
| 2 | Encoder Pimoroni Picade Max | Placa de 38 × 18 mm, agujeros de 32 × 12 mm (M2,5), conector JST-SH de 4 pines. Se montan en el frente, tumbados y con el conector a la derecha en los dos |
| 1 | Raspberry Pi 5 con refrigerador activo oficial | Agujeros de fijación de 58 × 49 mm (M2,5) |
| 1 | Placa de prototipos con header hembra 2×20 | A medida del GPIO (modelada 56 × 7 mm). Lleva 2 bornes de tornillo de 4 vías (paso 5,08 mm), uno por mando. **La Pi con esta placa mide 27 mm de alto**, desde la cara inferior de la Pi hasta lo alto de los bornes |

## Cables

| Cant. | Pieza | Notas |
|---|---|---|
| 1 | Cable micro-HDMI → HDMI | De la Raspberry a la pantalla. Conectores rectos, flexible o tipo "slim" |
| 1 | Cable USB-A → micro-USB | Táctil y alimentación de la pantalla. Conectores rectos, flexible o tipo "slim" |
| 1 | Cable micro-HDMI → HDMI | Hacia una 2ª pantalla (en el modelo solo se reserva el espacio) |
| 1 | Cable USB-C y fuente oficial de 27 W (5 V / 5 A) | Alimentación de la Raspberry Pi 5 |
| 2 | Cable JST-SH 4 pines → Dupont | Uno por mando: GND, SW, ENCA, ENCB |
| 1 | Pasacables adhesivo redondo (Ø13, tipo clip de silicona) | Se pega en la cara interior de la placa trasera y sujeta el cable de alimentación. Se pueden añadir más donde haga falta |

Los cables de la pantalla salen por encima del borde superior de la plancha, con una curva amplia.

## Separadores

| Cant. | Pieza | Dónde |
|---|---|---|
| 4 | Separador de latón M2,5 hembra-hembra, **7 mm** | Entre la pantalla y la placa frontal |
| 4 | Separador M2,5 hembra-hembra, **6 mm** | Entre la Raspberry y la placa frontal |
| 4 | Separador hexagonal M2,5 hembra-hembra, **35 mm** | Entre las dos placas, justo detrás de cada separador de la pantalla. Deja 2,0 mm de margen a los bornes |

## Tornillería

| Cant. | Pieza | Dónde |
|---|---|---|
| 4 | Tornillo M2,5 × 16 | Pantalla: atraviesa el separador de 7 mm y la placa frontal, y entra en el separador de 35 mm |
| 4 | Tornillo M2,5 × 6, avellanado | Raspberry, desde delante y a ras |
| 4 | Tornillo M2,5 × 4 | Raspberry, por detrás |
| 8 | Tornillo M2,5 × 8 | Encoders, atornillados por delante |
| 8 | Tuerca M2,5 | Encoders |
| 4 | Tornillo M2,5 × 8, avellanado | Placa trasera, por detrás y a ras |

## Fijación a la pared

| Cant. | Pieza | Notas |
|---|---|---|
| 2 | Tornillo de pared de cabeza ancha (Ø8), M4 × 40 | Separación entre tornillos: 80 mm. Dejar unos 9 mm fuera de la pared |
| 2 | Taco | Adecuado al tipo de pared |

Se cuelga por el agujero grande de cada cerradura y se desliza hacia abajo. El hueco de 35 mm entre pared y plancha aloja la Raspberry y los cables.

## Conexión de los mandos al GPIO

Orden de los cables de cada mando: GND, SW, ENCA, ENCB, en la fila interior del header. Cada mando va a un borne de la placa de prototipos.

| Mando | Pines físicos | Señales |
|---|---|---|
| Mando 1 | 9 · 11 · 13 · 15 | GND · GPIO17 · GPIO27 · GPIO22 |
| Mando 2 | 39 · 37 · 35 · 33 | GND · GPIO26 · GPIO19 · GPIO13 |
