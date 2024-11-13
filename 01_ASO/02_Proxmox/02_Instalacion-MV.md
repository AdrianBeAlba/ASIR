# Creación de Máquinas Virtuales

Este documento describe los pasos y configuraciones necesarios para crear máquinas virtuales (VMs) en un entorno de virtualización con Proxmox.

## Gestión de Imágenes ISO

Antes de crear una VM, es necesario subir imágenes ISO del sistema operativo a utilizar:

1. En el almacenamiento local de Proxmox, selecciona la opción **ISO images**.
2. Sube los archivos ISO necesarios o proporciona una URL para descargarlos.
3. Verifica que las ISO estén en la lista de imágenes disponibles en Proxmox.

## Dispositivos Paravirtualizados (VirtIO)

Para mejorar el rendimiento de la VM, se recomienda usar dispositivos paravirtualizados, conocidos como **virtIO**. Estos dispositivos requieren menos recursos y son recomendables para operaciones intensivas de E/S, como la red y el acceso a discos duros.

- **Compatibilidad**: Linux tiene soporte nativo para virtIO. En Windows, es necesario instalar los controladores virtIO durante la instalación del sistema operativo.

## Creación de Máquinas Virtuales Linux

1. **Crear la VM**: Selecciona la opción de crear una nueva máquina virtual.
2. **Identificar la VM**: Define el nodo, el ID, y el nombre de la VM.
3. **Seleccionar el Sistema Operativo**: Elige la ISO y el tipo de sistema operativo.
4. **Configuración del Sistema**: Selecciona tarjeta gráfica y controlador SCSI VirtIO.
5. **Configurar Disco**: Define el almacenamiento y tamaño del disco raíz.
6. **CPU y Memoria**: Define el número de sockets y núcleos de la CPU, y la cantidad de memoria (en MiB).
7. **Red**: Conéctate al bridge `vmbr0` para obtener IP de DHCP.

## Creación de Máquinas Virtuales Windows

1. **Seleccionar la ISO de Windows** y define el sistema operativo como Microsoft Windows.
2. **Controladores VirtIO**: Incluye un CD-ROM con la ISO de los controladores virtIO para que Windows reconozca el almacenamiento y la red.
3. **Configuración de Red**: Actualiza el controlador de red Ethernet usando los drivers virtIO.

## Instalación de Qemu-guest-agent

El `Qemu-guest-agent` permite una comunicación optimizada entre Proxmox y la VM, proporcionando mejor gestión de apagado y visibilidad de IP de la máquina.

### Instalación
Normalmente, se instala automáticamente. Si no, usa:
~~~bash
apt install qemu-guest-agent
~~~
## Acceso a las Máquinas Virtuales
* Linux: Usa SSH para acceder a la VM. Instala el servidor SSH si es necesario:
~~~bash
apt install ssh

ssh usuario@IP_VM
~~~


[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
