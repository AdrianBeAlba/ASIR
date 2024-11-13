# Snapshots en KVM
## Introducción
Una instantánea consiste en la captura del estado de una maquina virtual en un determinado momento.

El la captura, se guardda el estado del disco y la memoria, con la intención, de ser necesario, retornar la maquina al mismo estado en el que se encontraba al tomar la captura.

Para podr realizar ese proceso necesitamos que nuestros almacenamientos esten en forrmato qcow2.

## Creación de un snapshot
Comando:
~~~bash
virsh snapshot-create-as <nombremaquina> --name <nombresnap> --description "<Descript>" --atomic ## --atomic nos evita corrupcion durante el tomado de la instantanea.
~~~
Comandos para revision:
~~~bash
# Listado snapshots maquina especifica
virsh snapshot-list --domain <nombremaquina>

# Consulta todos los snapshots por nombre
virsh snapshot-info --name <nombresnap>

# Info detallada de snapshot
virsh snapshot-info <nombremaquina> <num-snap>

# Revertir maquina a un snap
virsh snapshot-revert <nombremaquina> <nombresnap>

# Info XML del snap
virsh -c qemu:///system snapshot-dumpxml <nombremaquina> <nombresnap>

# Formas de eliminar snaps
virsh snapshot-delete <nombremaquina> <nombresnap>
virsh snapshot-delete <nombremaquina> <num-snap>
~~~
***Nota: se pueden crear snaps sobre otros snaps, pero cuanto mas hagas peor sera el rendimiento de la maquina***

## Tipos de snapshots
* Interno de KVM:
    * Los cambios de despues del Snap se almacenan en el mismo disco que la VM
    * Se guarda como info adicional
    * No da conflicto con el disco original
    * Eliminar el snap y volver al snap hacen lo mismo
* Externo en kvm:
    * El disco original se preserva
    * El snap genera un disco nuevo
    * Es mas pesado

**RESUMEN:**
* VOLVER AL ESTADO ANTERIOR:
    1. Hago un reverte (te apaga la máquina si está encendida)
    2. Elimino snapshot.
* HACER LOS CAMBIOS PERMANENTES
    * Boro snap