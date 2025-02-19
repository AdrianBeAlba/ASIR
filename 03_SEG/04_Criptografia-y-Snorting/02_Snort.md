# Instalación y Configuración de Snort

## 1. Instalación de Snort

Para instalar Snort en una máquina Linux desde los repositorios, ejecutamos:

```sh
sudo apt update && sudo apt install snort -y  # Para Debian/Ubuntu
```

Verificamos que la instalación fue exitosa:

```sh
snort -V
```

**Captura de pantalla:** Tomar una captura mostrando la versión instalada de Snort.

---

## 2. Configuración en modo Sniffer y Registro de Paquetes

Ejecutamos el siguiente comando para activar Snort en modo sniffer:

```sh
sudo snort -dev -l /etc/snort/log -h 192.168.2.0/24
```

### Explicación de los parámetros:
- `-d`: Captura la carga útil de los paquetes.
- `-e`: Muestra la información de la capa de enlace.
- `-v`: Muestra los paquetes capturados en tiempo real.
- `-l /etc/snort/log`: Define el directorio donde se guardarán los logs.
- `-h 192.168.2.0/24`: Indica la red de origen para la captura de paquetes.

**Captura de pantalla:** Mostrar la ejecución del comando y los primeros paquetes capturados.

---

## 3. Filtrado de Tráfico por Puerto

Para monitorizar el tráfico HTTP (puerto 80), usamos:

```sh
sudo snort -vd host <tu_ip> and dst port 80
```

Donde `<tu_ip>` es la dirección IP del equipo que estamos monitorizando.

**Prueba:** Navegar por internet desde otro equipo de la red y observar los paquetes registrados en la terminal.

**Captura de pantalla:** Tomar una captura de los paquetes HTTP capturados.

---

## 4. Activación del Modo de Detección de Intrusos

Ejecutamos el siguiente comando para activar Snort en modo NIDS:

```sh
sudo snort -dev -l /etc/snort/log -h 192.168.2.0/24 -c /etc/snort/snort.conf
```

### Explicación:
- `-c /etc/snort/snort.conf`: Utiliza el archivo de configuración donde se definen las reglas de detección de intrusos.

**Captura de pantalla:** Mostrar la ejecución del comando y la detección de tráfico malicioso si es posible.

---

## 5. Configuración de Salida de Alertas

Snort puede registrar alertas en diferentes formatos. Para activar el modo de alerta completa:

```sh
sudo snort -A full -dev -l /etc/snort/log -h 192.168.2.0/24 -c /etc/snort/snort.conf
```

Las alertas se guardarán en el archivo `alerts.ids` dentro del directorio `/etc/snort/log`.

**Captura de pantalla:** Mostrar el contenido del archivo `alerts.ids` después de generar alertas.

---

## Conclusión
Con esta configuración básica, hemos instalado, configurado y probado Snort en distintos modos. Se recomienda seguir explorando sus opciones avanzadas, como la integración con herramientas de monitoreo y respuesta a incidentes.

