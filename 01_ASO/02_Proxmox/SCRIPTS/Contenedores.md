# Crear contenedor
## Paso 1: Definicion de paratros ddel contenedor
### Codigo en bash
~~~bash
#!/bin/bash
vzctl set 101 --name "sv1" --description "Mi primer servidor" --cpus 1 --cpulimit 100% \
--diskspace 1G:4G --ram 512M --swap 768M --diskinodes 90000:200000 --quotatime 600 \
--ipadd 192.168.100.101 --hostname "sv1" --searchdomain midominio.cu \
--nameserver 127.0.0.1 --nameserver 200.55.128.3 --nameserver 200.55.128.4 \
--nameserver 169.158.128.136 --nameserver 169.158.128.88 \
--netif_add eth0 --save
~~~

### Desglose de cada parámetro

- **`vzctl set 101`**: Configura el contenedor con el ID `101`. Cada contenedor en OpenVZ tiene un ID único.

- **`--name "sv1"`**: Asigna el nombre `sv1` al contenedor. Este nombre es solo para fines de identificación dentro del sistema de administración de contenedores.

- **`--description "Mi primer servidor"`**: Agrega una descripción al contenedor. En este caso, la descripción es `"Mi primer servidor"`.

- **`--cpus 1`**: Asigna 1 CPU virtual al contenedor. Esto significa que el contenedor solo podrá usar 1 CPU.

- **`--cpulimit 100%`**: Limita el uso de la CPU al 100% del núcleo asignado. Si `--cpus` es 1 y `--cpulimit` es 100%, entonces el contenedor puede usar hasta el 100% de la capacidad de ese único núcleo.

- **`--diskspace 1G:4G`**: Establece un límite de espacio en disco de **1 GB** y un límite de **burst** (pico) de **4 GB**. Esto significa que el contenedor puede utilizar hasta 1 GB de espacio en disco normalmente, y bajo ciertas condiciones, puede usar hasta 4 GB temporalmente.

- **`--ram 512M`**: Asigna 512 MB de memoria RAM al contenedor.

- **`--swap 768M`**: Configura el espacio de swap para el contenedor en **768 MB**. Este es un espacio de memoria virtual que se usa cuando la RAM asignada se agota.

- **`--diskinodes 90000:200000`**: Establece los límites de inodos para el contenedor. Los inodos son entradas en el sistema de archivos para cada archivo o directorio.
    - `90000` es el límite estándar.
    - `200000` es el límite de burst, que permite exceder temporalmente el límite estándar.

- **`--quotatime 600`**: Configura el tiempo (en segundos) para el límite de burst del uso de disco y de inodos. Aquí, el contenedor puede exceder los límites estándar durante 600 segundos.

- **`--ipadd 192.168.100.101`**: Asigna la dirección IP `192.168.100.101` al contenedor.

- **`--hostname "sv1"`**: Establece el nombre de host del contenedor como `sv1`. Este es el nombre que el contenedor usará en su red local.

- **`--searchdomain midominio.cu`**: Especifica `midominio.cu` como el dominio de búsqueda para el contenedor. Cuando el contenedor realiza consultas DNS, usará este dominio de búsqueda.

- **`--nameserver 127.0.0.1`, `--nameserver 200.55.128.3`, ...**: Define una lista de servidores de nombres (DNS) para el contenedor. Se especifican varios servidores DNS en caso de que alguno no responda:
    - `127.0.0.1` (localhost),
    - `200.55.128.3`, `200.55.128.4`, `169.158.128.136`, `169.158.128.88`.

- **`--netif_add eth0`**: Añade una interfaz de red `eth0` al contenedor para conectarlo a la red.

- **`--save`**: Guarda esta configuración en el archivo de configuración del contenedor. Esto asegura que los cambios se apliquen de forma permanente, incluso después de reiniciar el contenedor.

## Paso 2: Creacion de conenedor/Parametros adicionales
### Codigo
~~~bash
vzctl create 101 --ostemplate debian-7.0-standard_7.0-1_i386
vzctl set 101 --userpasswd root:secreto --onboot yes --save
vzctl set 101 --iptables ipt_TCPMSS --iptables ipt_LOG --iptables ipt_TOS \
--iptables iptable_nat --iptables ipt_multiport --iptables ipt_state  \
--iptables ipt_limit --iptables ipt_recent --iptables ipt_owner \
--iptables ipt_REDIRECT --iptables ipt_length --iptables ipt_tcpmss \
--iptables iptable_mangle --iptables ipt_tos --iptables iptable_filter \
--iptables ipt_ttl --iptables ipt_REJECT --setmode restart --save
~~~

* vzctl create 101: Crea un contenedor con el ID 101.
* --ostemplate debian-7.0-standard_7.0-1_i386: Utiliza la plantilla de sistema operativo Debian 7.0 estándar (arquitectura i386).

~~~bash
vzctl set 101 --userpasswd root:secreto --onboot yes --save
~~~
* vzctl set 101: Configura el contenedor con ID 101.
* --userpasswd root:secreto: Establece la contraseña para el usuario root como secreto.
* --onboot yes: Configura el contenedor para que se inicie automáticamente al arrancar el sistema.
* --save: Guarda esta configuración.
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
