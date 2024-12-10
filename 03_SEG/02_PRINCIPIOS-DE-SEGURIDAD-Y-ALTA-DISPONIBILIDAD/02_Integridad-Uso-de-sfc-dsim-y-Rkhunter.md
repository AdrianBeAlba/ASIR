# Integridad-Uso-de-sfc-dsim-y-Rkhunter

**1. ¿Qué es y cómo funciona un ROOTKIT?**

    Un rootkit es un tipo de malware diseñado para dar acceso remoto y control total sobre un sistema, sin ser detectado. Una vez instalado, el rootkit permite ocultar otros programas maliciosos, monitorear el sistema y robar información sensible. Funciona modificando el sistema operativo o los archivos críticos, lo que dificulta su detección con herramientas de seguridad tradicionales.

    Los rootkits suelen ser utilizados por atacantes para mantener acceso persistente a un sistema sin que el usuario o administrador se dé cuenta.

**2. Busca algún software de uso libre que permita combatir a los ROOTKIT y especifica la url del autor.**

    Una de las más conocidas es Rootkit Hunter (rkhunter), que es un escáner open-source que busca rootkits, backdoors, y exploits locales en tu sistema. Escanea archivos en busca de modificaciones sospechosas y comprueba si hay permisos inusuales, ficheros ocultos, y configuraciones comprometidas. 

    Malwarebytes Anti-Rootkit es una herramienta gratuita diseñada para detectar y eliminar rootkits. Es un software especializado que escanea el sistema en busca de rootkits ocultos en el kernel, el MBR o en particiones de disco. Además, ofrece reparación para componentes del sistema dañados tras la eliminación del rootkit. Puedes descargarlo desde Malwarebytes Anti-Rootkit​


**3. Busca información e investiga sobre el comando SFC de Windows. Comenta qué significan sus siglas, qué hace el comando, su sintaxis y los parámetros más usuales, y en definitiva todo lo que consideres de interés sobre el mismo. Encuentra información oficial sobre su uso en Windows 11**

    El comando SFC (System File Checker) en Windows es una herramienta que permite verificar y reparar archivos del sistema operativo que estén corruptos o hayan sido modificados. SFC escanea todos los archivos protegidos de Windows y reemplaza los dañados o faltantes con copias correctas de los archivos almacenados en una carpeta protegida del sistema.

~~~PowerShell
    sfc /scannow # Explora de inmediato todos los archivos el sistema protegidos
    sfc /scanboot # Lo preparas para explorar al reiniciar el equipo
    sfc /? # Ayuda
    sfc /verifyonly # Solo verifica los archivos sin realizar reparaciones.
    sfc /scanfile <ruta> # Escanea un archivo específico.
    sfc /offbootdir  /offwindir # Permiten usar SFC en instalaciones de Windows que no estén activas (ideal para rescates desde entornos externos).

~~~


**4. Prueba el comando SFC ejecutándolo en una máquina de Windows y guarda el archivo log resultante (lo necesitarás para subirlo a la plataforma). El archivo log resultante se suele almacenar en el directorio \Windows\Logs\CBS, si ves que el archivo resultante es demasiado grande, bórralo antes de ejecutar el comando SFC.**



**5. Busca información e investiga sobre el comando dism de Windows. Comenta qué significan sus siglas, qué hace el comando, su sintaxis y los parámetros más usuales, y en definitiva todo lo que consideres de interés sobre el mismo.**

El comando DISM (Deployment Imaging Service and Management Tool) es una herramienta en Windows utilizada para gestionar y reparar imágenes del sistema operativo, ya sean imágenes de Windows (.wim), archivos de disco virtual (VHD), o incluso instalaciones en vivo de Windows.

Sintaxis y parámetros más comunes:

~~~powershell
# Reparar la imagen de Windows:
# 1 Verificar si la imagen está dañada:
DISM /Online /Cleanup-Image /CheckHealth

# 2 Escanear la imagen en busca de errores:
DISM /Online /Cleanup-Image /ScanHealth

# 3 Reparar la imagen dañada:
DISM /Online /Cleanup-Image /RestoreHealth
~~~

**6. ¿Qué es Rkhunter? Especifica su sintaxis comentando brevemente algunos de sus parámetros más importantes.**

Rkhunter (Rootkit Hunter) es una herramienta de software libre que se utiliza en sistemas Linux y Unix para detectar rootkits, backdoors, y exploits locales. 

Parámetros más importantes:
~~~bash
# --check: Ejecuta una verificación completa del sistema. Es el comando más utilizado para iniciar el análisis en busca de rootkits.

rkhunter --check

# --sk: Omitir las preguntas que Rkhunter podría hacer durante la ejecución, ideal para la automatización en scripts.

rkhunter --check --sk

# --update: Actualiza las bases de datos de Rkhunter, que incluyen las firmas de rootkits conocidos y otros archivos que pueden ser utilizados para la detección.

rkhunter --update

# --list: Muestra varias categorías de información, como rootkits conocidos (--list rootkits), posibles elementos sospechosos, y archivos de sistema relevantes.

rkhunter --list rootkits

# Un flujo de trabajo típico con Rkhunter sería:

# 1.- Actualizar las definiciones:

rkhunter --update

# 2.- Ejecutar un escaneo completo:

rkhunter --check

# Revisar solo las advertencias con --report-warnings-only:

rkhunter --check --report-warnings-only
~~~

**7. Prueba Rkhunter en una máquina Ubuntu y guarda el informe resultante para subirlo a la plataforma (prueba a buscar su archivo log en /var/log, o crea tu informe en la ruta y archivo que desees utilizando sus parámetros).**




**8. Para terminar, sube a la plataforma los dos archivos resultantes de ejecutar SFC y Rkhunter.**

## Opcional

Existen otras herramientas de detección de rootkits. Por ejemplo GMER: http://www.gmer.net/. o https://es.malwarebytes.com/antirootkit/ Instálala y comprueba su funcionamiento.

--------------


[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
