# Almacenamiento en KVM (POOLS)
## Introducción
Libvirt proporciona una gestion de almacenamiento, el metodo por el que lo hace es a traves de ***Pools*** de almacenamiento y volumnes.

* Pools de almacenamiento:
    * Funete de almacenamiento
    * Tamaño decidido por host
    * Se usa por las maquinas virtuales
* Volumenes:    
    * Los Pools de almacenamiento se dividen en estos.
    * Las VM los usan como discos

Disponemos de distintas **tecnologias de almacenamiento** permitiendo crear distintos tipos de Pools:
* Tipo de almacenamiento:
    * Se puede trabajar con sistemas de fichero
    * Permite acceso a una parte del sistema
    * Gestion completa de un dispositivo en **bruto**, pertifionable y formateable.
* Almacenamiento compartido:
    * Permiten compartir info entre servidores.
    * Han de tener QEMU/KVM+libvirt
    * Permite la migracion en vivo
* Snapshots
    * Permite el guardado del estado actual del disco de una maquina en un pool.
* Aprovisiionamiento ligero (**AL**):
    * Permite que no se ocupe el espacio completo asignado de un disco de inmediato. 
    * Ejemplo: creamos disco de 30H solo usamos 3G solo ocupara 3G.
* Dir:
    * Ofrece directorio del host.
    * No ofrece almacenamiento compartido.
    * Los discos se guardan como imagen de disco.
    * Formatos:
        * Raw: 
            * Se ocupa todo el espacio de inmediato
            * Acceso mas eficiente.
            * No proporciona snapshots
        * Qcow2:
            * Aprovisionamiento ligero
            * Menos eficiente.
            * Proporciona snapshots
* Logical
    * Controla un grupo de volumenes logicos
    * Admite snapshots
    * Si usamos LVM-Thin permite AL
* nefts:
    * Monta el dir en un servidor NAS
    * Obtenemos comparticion y migracion en vivo.
    * Usa ficheros de imagenes del disco
## Storage Pool en KVM
Si usamos almacenamiento local, tendre que crear un pool para las ISO

La creacion de pools adicionales en mi disco permite separar facetas de KVM como los discos y las maquinas.

### Comandos basicos
~~~bash
# Listado de Pools existentes
virsh pool-list
# Examinar pool-especifico
virsh pool-info <pool> ## Podemos usar default

### Creacion de nuevo pool
# Copiamos el pool por defecto de KVM
virsh pool-dumpxml default >> mipool.xml
nano mipool.xml
~~~
~~~xml
<pool type='dir'>
  <!-- Nombre del pool de almacenamiento -->
  <name>default</name>
  <uuid><!--Hay que definir un nuevo UUID aquí--></uuid>
  <!-- Capacidad total del pool en bytes -->
  <capacity unit='bytes'><!--CAPACIDAD--></capacity>
  <!-- Cantidad de espacio asignado del pool en bytes -->
  <allocation unit='bytes'><!--CAPACIDAD--></allocation>
  <!-- Espacio disponible en el pool en bytes -->
  <available unit='bytes'><!--CAPACIDAD--></available>
  <!-- Fuente del almacenamiento (no utilizada en este caso para un directorio local) -->
  <source>
  </source>
  <!-- Configuración del destino del almacenamiento -->
  <target>
    <path>/lugar/del/pool</path>
    <!-- Permisos de acceso al directorio del pool -->
    <permissions>
      <!-- Modo de permisos en formato octal (0711) -->
      <mode>0711</mode>
      <!-- ID de propietario del directorio, donde '0' suele indicar el usuario root -->
      <owner>0</owner>
       <!-- ID de grupo del directorio, donde '0' suele indicar el grupo root -->
      <group>0</group>
    </permissions>
  </target>
</pool>
~~~
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
