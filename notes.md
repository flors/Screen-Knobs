# GPIO desde Processing

https://pi.processing.org/tutorial/visual-synth/ (2014) 

## Open issues with GPIO access: 

https://github.com/benfry/processing4/issues/807 

https://github.com/falue/elisas_synchronotron/issues/3####1

## Alternativas para leer GPIO (usando PI como PC Linux + Processing) 

JAVA: https://www.pi4j.com/ 
Ejemplo: https://github.com/flors/Screen-Knobs/tree/main/JAVA/TestKnobJava 

Python: https://gpiozero.readthedocs.io/en/stable/installing.html 
Ejemplo: https://github.com/flors/Screen-Knobs/tree/main/PYTHON

Recomendaciones, en general, mejor usar python: https://codigoelectronica.com/blog/gpio-raspberry-pi (Buscar: "¿Qué librerías son las recomendadas actualmente?")
<img width="1315" height="500" alt="Screenshot 2026-11-08 at 12 35 30" src="https://github.com/user-attachments/assets/8bfaae3d-60cc-45ad-b0ee-423a06d454c6" />


## Recomendación mas segura 

Knobs conectados a Arduino + Serial Communication a Raspberry Pi 5 
- Evita perdida de lectura de pulso de los sensores (en la Pi, va a tener el OS + Processing). Liberar carga de CPU
- Evitar posibles bloqueos en los visuales de processing
- Hay librerias específicas para encoders (https://github.com/PaulStoffregen/Encoder/tree/master) que se encargan de gestionar interrupciones y lectura de los encoders
- Importante! Usar Arduino que tenga 4 pines con interrupciones por hardware (2 x Knob). Recomendaciones: [Arduino Nano ESP32](https://www.amazon.es/Arduino-Nano-ESP32-cabezales-ABX00083/dp/B0C947BHK5/ref=sr_1_1_sspa?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=2W53AQJBN8CCK&dib=eyJ2IjoiMSJ9.NM1Ut49QGDWFxDCPPkKhn4pMwki8MsyZNECso9nIyzrrnDswSCQXMlUZKzDL-QQ6t066zZJlgj_Eq5eJCK6e4tlobNimIP6dNZZjlBu3pZlEFooQ76osPZZNx0ax6vGj6Jsf19h4vcW93noxmF1kiICrTDM6soI4Gkrwfg2QYOgc2AwKrSgUKAUEL7nimtFTCXClpGmXJ4BcnaZ6ww9BBzWs4RgkxKWSYJCI30RkYl-w-O29OPF164iHs3FNoXmyWfbawAHA1y1lfuLRtBS3k_ZAboFgOV0wgP2vWe0FNQI.7EyY7Lp4mvnLuP3RujSc7SAi7AmdMMq1g_5Ij4npdcA&dib_tag=se&keywords=Arduino%2BNano%2BESP32&qid=1794138257&sprefix=arduino%2Bnano%2Besp32%2Caps%2C195&sr=8-1-spons&aref=sTYeI9JAaO&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1) / Raspberry Pi Pico / Teensy / Arduino Mega 2560
(puedo hacer prototipo con ESP32-S3) 
