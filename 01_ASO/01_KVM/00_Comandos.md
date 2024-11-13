# Comandos Importantes de KVM Agrupados por Tipo
## Instalacion del entorno KVM
~~~bash
# Instalación de paquetes
sudo apt install -y qemu-kvm libvirt-clients libvirt-daemon-system \ bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin virt-manager
# Preparar usuario de entorno
sudo adduser <usuario> libvirt
sudo adduser <usuario> libvirt-qemu
## Aplicar cambios de manera inmediata
newgrp libvirt
newgrp libvirt-quemu

## Configurar permisos
sudo nano /etc/libvirt/qemu.conf
## Dentro del doc añadimos dos lineas
user = "root"
# y
group = "root"

# Esto hará que qemu realice las operaciones como root para que no den problemas los permisos
~~~
## Conexión y Administración de Máquina Virtual

~~~bash
# Conectar con el hipervisor
virsh -c qemu:///system

# Iniciar la máquina virtual
start myserver

# Suspender la máquina virtual
suspend myserver

# Reanudar la máquina virtual
resume myserver

# Reiniciar la máquina virtual
reboot myserver

# Apagar una máquina virtual
shutdown myserver

# Borrar una máquina virtual
undefine myserver

# "Matar" la máquina virtual
destroy myserver
~~~

## Listado e Información de Máquinas Virtuales

~~~bash
# Listar máquinas virtuales en ejecución
virsh list

# Listar todas las máquinas
virsh list --all

# Obtener información sobre una máquina
dominfo myserver

# Ver CPU de la máquina
vcpuinfo hypnos

# Ver el estado de la máquina virtual
domstate myserver
~~~

## Comandos para Almacenamiento

~~~bash
# Listar volúmenes de almacenamiento
pool-list

# Obtener información sobre el volumen físico
pool-info myvol

# Editar las características del volumen
pool-edit myvol

# Listar todos los discos virtuales
vol-list myvol
~~~

## Configuración de Autostart

~~~bash
# Hacer que una máquina inicie automáticamente
virsh autostart myserver

# Hacer que una máquina deje de iniciar al inicio
virsh --disabled autostart myserver
~~~

## Comandos de Redes Virtuales

~~~bash
# Editar información de la máquina virtual
edit myserver

# Ver redes virtuales configuradas
net-list

# Obtener información sobre las redes
net-dumpxml <red>

# Crear una red virtual
net-create /etc/libvirt/qemu/networks/myred.xml
## Nota: Este archivo debe existir, se proporciona una plantilla al final.

# Definir/elegir una red virtual
net-define /etc/libvirt/qemu/networks/myotrared.xml

# Iniciar la red virtual
net-start myotrared

# Iniciar automáticamente una red virtual
net-autostart myred

# Editar una red virtual
net-edit myotrared

# Destruir una red virtual
net-destroy myred
~~~

## Administración de Pools de Almacenamiento

~~~bash
# Listar los pools de almacenamiento definidos
virsh pool-list --all

# Detener el pool de almacenamiento
virsh pool-destroy

# Eliminar el directorio donde reside el pool de almacenamiento (opcional)
# Nota: El directorio debe estar vacío para eliminarlo
virsh pool-delete

# Eliminar la definición del pool de almacenamiento
virsh pool-undefine
~~~

## Tabla resumen

| Comando            | Descripción                                                                                     |
|--------------------|-------------------------------------------------------------------------------------------------|
| help               | Imprime información de ayuda básica.                                                            |
| list               | Lista todos los huéspedes.                                                                      |
| dumpxml            | Entrega el archivo de configuración XML para el huésped.                                        |
| create             | Crea un huésped desde un archivo de configuración XML e inicia el nuevo huésped.                |
| start              | Inicia un huésped inactivo.                                                                     |
| destroy            | Obliga a un huésped a detenerse.                                                                |
| define             | Entrega un archivo de configuración XML para un huésped.                                        |
| domid              | Muestra el ID de huésped.                                                                       |
| domuuid            | Muestra el UUID de huésped.                                                                     |
| dominfo            | Muestra información de huésped.                                                                 |
| domname            | Muestra nombre de huésped.                                                                      |
| domstate           | Muestra el estado de un huésped.                                                                |
| quit               | Sale de la terminal interactiva.                                                                |
| reboot             | Reinicia un huésped.                                                                            |
| restore            | Restaura una sesión guardada anteriormente en un archivo.                                       |
| resume             | Reanuda un huésped en pausa.                                                                    |
| save               | Guarda el estado de un huésped en un archivo.                                                   |
| shutdown           | Apaga un huésped de forma apropiada.                                                            |
| suspend            | Suspende en pausa a un huésped.                                                                 |
| undefine           | Borra todos los archivos asociados con un huésped.                                              |
| migrate            | Migra un huésped a otros host.                                                                  |
| setmem             | Establece la memoria asignada para un huésped.                                                  |
| setmaxmem          | Establece el límite máximo de memoria para el hipervisor.                                       |
| setvcpus           | Cambia el número de CPU virtuales asignadas a un huésped.                                       |
| vcpuinfo           | Muestra información de CPU virtual sobre un huésped.                                            |
| vcpupin            | Controla la afinidad de CPU virtual de un huésped.                                              |
| domblkstat         | Muestra las estadísticas de dispositivo de bloque para un huésped en ejecución.                 |
| domifstat          | Muestra estadísticas de interfaz de red para un huésped en ejecución.                           |
| attach-device      | Conecta un dispositivo a un huésped, mediante la definición de un dispositivo en un archivo XML. |
| attach-disk        | Conecta un nuevo dispositivo de disco para un huésped.                                          |
| attach-interface   | Conecta una nueva interfaz de red para un huésped.                                              |
| detach-device      | Desconecta un dispositivo de un huésped, adaptándose a la misma clase de descripciones del comando `attach-device`. |
| detach-disk        | Desconecta un dispositivo de disco desde un huésped.                                            |
| detach-interface   | Desconecta una interfaz de red de un huésped.                                                   |
| version            | Muestra la versión de `virsh`.                                                                  |
| nodeinfo           | Entrega información acerca del hipervisor.                                                      |

