# 07_Discos Volumenes y Clonaciones

## 07.1_Volumnes
Hay dos tipos de **Pool**:

* Tipo **dir**: Directorios dentro del sistema de ficheros del host.
* Tipo **logical**: gestiona un grupo de volúmenes LVM, el volumen corresponderá a un volumen lógico LVM.

Obtener los volúmenes de un determinado pool (por ejemplo el pool ***default***): 

~~~bash
## La opcion "--details" da mas detalles
virsh -c qemu:///system vol-list default --details

~~~

Los volumenes listados se encuentran  en /var/lib/libvirt/images

El formato de imagen qcow2 tiene la característica de aprovisionamiento ligero, en la que el fichero tiene un tamaño virtual (el que hemos indicado en su creación y el que verá la máquina virtual que lo utilice) y el espacio ocupado en el disco del host (que irá creciendo conforme vayamos guardando información en la imagen).

Información de un determinado volumen (comando ***vol-info***): 

~~~bash
virsh -c qemu:///system vol-info volume-name.qcow2 default
~~~

### 07.1.1_Crear volumenes
Crear discos en KVM (Formato raw): Para crear un disco (un volumen), usamos el comando ***vol-create-as***

~~~bash
virsh vol-create-as default vdisk-b12447 1G
~~~

Para crear un disco en formato qcow2, debemos especificarlo durante la creación del disco: 
~~~bash
#Con --pool especificamos el pool donde queremos que se almacene, con --format especificamos el formato del disco
virsh vol-create-as --pool default --format qcow2 new-volumen.qcow2 1G
~~~

Aunque los dos discos tienen una capacidad de 1GB, el disco en formato qcow2 consume sólo 196KB en disco, a diferencia del disco en formato raw, que consume en disco el 1GB.

### 07.1.2_Asociar volumenes
Podemos asociar discos a maquinas virtuales existentes con el comando attach-disk.

~~~bash
# --persistent: evita que se dsconecte al apagar la maquina virtual
# --subdriver: especifica formato del disco duro
virsh attach-disk maquina-virtual --source /var/lib/libvirt/images/new-volumen.qcow2 vdb --persistent --subdriver qcow2
~~~

### 07.1.3_Redimensionar volumenes
Formas de redimensionar un disco:

* Con la maquina parada
    ~~~bash
    virsh -c qemu:///system vol-resize volume-name.qcow2 20G --pool pool-name
    ~~~
* Con la maquina encendida ***en caliente*** :
    ~~~bash
    virsh -c qemu:///system blockresize maq-nombre /srv/images/volumen-name.qcow2 20G
    ~~~

### 07.1.4_Clonar Maquinas

La clonación de una máquina virtual copia la configuración XML de la máquina de origen y sus imágenes de disco, y realiza ajustes en las configuraciones para asegurar la unicidad de la nueva máquina.

* Para clonar un disco
    ~~~bash
    # Especificamos el pool, el nombre del disco a clonar y el nombre del disco clonado:
    virsh vol-clone --pool default new-volumen.qcow2 new-volumen-clon.qcow2
    ~~~

#### Clonacion de maquinas virtuales
* Clonacion rapida:
    ~~~bash
    #Le asigna un nombre automaticamente.
    virt-clone --original machine-name --auto-clone
    ~~~
* Clonacion con nuevo nombre:
    ~~~bash
    #Con --file especifica el nuevo volumen tambien
    virt-clone --original machine-name --name cloned-machine-name --file /var/lib/libvirt/images/new-volume-name.qcow2 --auto-clone
    ~~~
Las máquinas clonadas son idénticas a las originales y que habrá cosas que deberás cambiar en ella una vez la inicies, como por ejemplo el nombre interno de la misma, que está en el fichero /etc/hostname.

El comando virt-sysprep “generalizar” las máquinas clonadas: Elimina todas las configuraciones específicas para la máquina, de manera que podemos usar esta MV como base para generar nuevas máquinas virtuales. 

~~~bash
#Comando base
virt-sysprep -d cloned-machine-name

#Se puede establecer el hostname de la máquina, --hostname, o la contraseña del root, --root "contraeña".
virt-sysprep -d nom-maq-image --hostname nom-maq-image --root password

#Despues dse puede customizar mas
virt-customize -d nom-maq --hostname nom-maq-01 --password nom-usuario:password:SecretPassword
~~~




[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
