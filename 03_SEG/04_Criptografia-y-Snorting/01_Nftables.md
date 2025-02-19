# Configuración de Firewall con nftables

## 1. Introducción
nftables es el reemplazo moderno de iptables para la gestión de firewall en Linux. Ofrece una sintaxis más flexible, mejor rendimiento y una configuración más sencilla mediante el uso de tablas y conjuntos de reglas.

Este documento detalla la configuración de reglas de firewall para un servidor, permitiendo conexiones seguras y bloqueando accesos no autorizados.

---

## 2. Vaciar las Reglas Actuales
Antes de establecer nuevas reglas, es recomendable limpiar la configuración previa:
```bash
nft flush ruleset
```
---

## 3. Creación de Tabla y Cadenas
Se define una tabla `inet my_filter` y se crean cadenas para gestionar las conexiones entrantes (INPUT), salientes (OUTPUT) y de reenvío (FORWARD).
```bash
nft add table inet my_filter
nft add chain inet my_filter input { type filter hook input priority 0 \; }
nft add chain inet my_filter output { type filter hook output priority 0 \; }
nft add chain inet my_filter forward { type filter hook forward priority 0 \; }
```

---

## 4. Configuración de Reglas

### 4.1. Aceptar Tráfico Local
```bash
nft add rule inet my_filter input iif lo accept
```

### 4.2. Permitir Todo el Tráfico desde una IP Específica
```bash
nft add rule inet my_filter input ip saddr 192.168.0.1 accept
```

### 4.3. Permitir Conexión SSH y Telnet desde un Host Específico
```bash
nft add rule inet my_filter input ip saddr 192.168.0.37 tcp dport {22, 23} accept
```

### 4.4. Permitir Acceso FTP desde un Host Específico
```bash
nft add rule inet my_filter input ip saddr 192.168.0.45 tcp dport {20, 21} accept
```

### 4.5. Abrir el Puerto 80 (HTTP) para un Servidor Web
```bash
nft add rule inet my_filter input tcp dport 80 accept
```

### 4.6. Bloquear el Resto de los Puertos Específicos
```bash
nft add rule inet my_filter input tcp dport {20, 21, 22, 23, 6061} drop
```

---

## 5. Guardar la Configuración
Para hacer persistentes estas reglas, se deben guardar en un archivo de configuración:
```bash
nft list ruleset > /etc/nftables.conf
```

Para asegurarse de que nftables cargue automáticamente al inicio en Debian/Ubuntu:
```bash
systemctl enable nftables
```

---

## 6. Conclusión
Esta configuración de firewall con nftables permite gestionar el tráfico de red de manera segura, garantizando el acceso solo a servicios esenciales y bloqueando el tráfico no deseado.

Con estas reglas, se permite el acceso controlado a servicios como SSH, Telnet, FTP y HTTP, asegurando que solo usuarios autorizados puedan conectarse según las direcciones IP definidas.

-------------------------------------------

# Configuración de Logs en nftables

## PASO 1: Configurando los archivos logs

A diferencia de `iptables`, `nftables` ofrece un mecanismo más moderno y eficiente para el filtrado de paquetes y la generación de logs. Para habilitar los registros de tráfico, seguimos estos pasos:

### 1.1 Definir reglas de registro en nftables
En `nftables`, el equivalente a `-j LOG` de `iptables` es la acción `log prefix`. Para ello, creamos las siguientes reglas en la tabla de `nftables`:

```sh
nft add table inet firewall
nft add chain inet firewall input { type filter hook input priority 0 \; }
nft add chain inet firewall forward { type filter hook forward priority 0 \; }
nft add chain inet firewall output { type filter hook output priority 0 \; }

nft add rule inet firewall input log prefix \"NFTABLES_INPUT\"
nft add rule inet firewall forward log prefix \"NFTABLES_FORWARD\"
nft add rule inet firewall output log prefix \"NFTABLES_OUTPUT\"
```

Con esto, cada paquete que pase por las cadenas `input`, `forward` y `output` generará un log con los respectivos prefijos.

### 1.2 Configurar rsyslog para capturar los logs

Editamos el archivo `/etc/rsyslog.d/50-default.conf` y añadimos la siguiente línea:

```
kern.warning   /var/log/nftables.log
```

Esta configuración redirige los mensajes de nivel `warning` del núcleo (incluyendo los logs de `nftables`) al archivo `/var/log/nftables.log`.

### 1.3 Reiniciar rsyslog
Para aplicar los cambios, reiniciamos el servicio `rsyslog`:

```sh
systemctl restart rsyslog
```

En algunos casos, puede ser necesario reiniciar el sistema:

```sh
reboot
```

### 1.4 Verificar la generación de logs
Una vez reiniciado el servicio, podemos comprobar si los registros se están generando con:

```sh
tail -f /var/log/nftables.log
```

## PASO 2: Entendiendo las líneas del log

Cada línea de log generada por `nftables` sigue un formato específico que incluye los siguientes datos:

1. **Fecha y hora:** Cuándo se generó el log.
2. **Nombre de la máquina:** El hostname del sistema que generó el log.
3. **Código del log del núcleo:** Indica que proviene del subsistema de red.
4. **Prefijo definido en la regla de nftables:** ("NFTABLES INPUT", "NFTABLES FORWARD", etc.).
5. **Interfaz de red:** La interfaz por donde entró y salió el paquete.
6. **Direcciones MAC:** MAC de origen y destino.
7. **Direcciones IP:** IP de origen y destino.
8. **Longitud del paquete:** Tamaño total del datagrama.
9. **Tipo de servicio (TOS):** Información de la cabecera IP.
10. **TTL e identificador de fragmentación.**
11. **Protocolo de transporte:** TCP, UDP, ICMP, etc.
12. **Puertos de origen y destino.**

### Ejemplo de log generado por nftables

```sh
Feb 19 14:35:21 server kernel: [12345.678901] NFTABLES INPUT: IN=eth0 OUT= MAC=aa:bb:cc:dd:ee:ff SRC=192.168.1.100 DST=192.168.1.1 LEN=60 TOS=0x00 TTL=64 ID=54321 DF PROTO=TCP SPT=443 DPT=56789 WINDOW=29200 RES=0x00 ACK URGP=0
```

### Análisis del log

- **Fecha y hora:** `Feb 19 14:35:21`
- **Nombre de la máquina:** `server`
- **Código del log del núcleo:** `[12345.678901]`
- **Prefijo:** `NFTABLES INPUT`
- **Interfaz de red:** `IN=eth0 OUT=` (no hay salida porque es tráfico entrante)
- **MAC:** `MAC=aa:bb:cc:dd:ee:ff`
- **IP de origen:** `SRC=192.168.1.100`
- **IP de destino:** `DST=192.168.1.1`
- **Longitud del paquete:** `LEN=60`
- **Tipo de servicio:** `TOS=0x00`
- **TTL:** `TTL=64`
- **Identificador de fragmentación:** `ID=54321 DF`
- **Protocolo:** `PROTO=TCP`
- **Puerto de origen:** `SPT=443`
- **Puerto de destino:** `DPT=56789`

### Captura de pantalla del log

(Se debe incluir una captura de pantalla del contenido del archivo `/var/log/nftables.log` mostrando líneas de registro generadas por `nftables`).

