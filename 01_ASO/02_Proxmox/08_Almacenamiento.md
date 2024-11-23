# Almacenamiento en proxmox
## Introducción
Proxmox nos permite el uso de distintas fuentes de almacenamiento, en estas alojamos todos los objetos de nuestro servidor.

### Tipos de almacenamiento
* **Sistemas de ficheros**
* **Dispositivos de bloque**:
    * Dispositivos en bruto, formateables.
    * Los usan las VM
    * Sirven para emular discos duros

### Almacenamiento compartido
* Algunas fuentes de almacenamiento permiten compartir info entre nodos del clúster Proxmox VE.
* Nos permite migrar en vivo en caso de tener estas fuentes de almacenamiento.

### Snapshots
* Guardar estado de nuestra maquina en un momento preciso
* Funetes de almacenamiento especificas

### Aprrovisionamiento Ligero
* Todas las fuentes de almacenamiento que permiten instantaneas permiten esto
* El espacio que ocupa la fuente de almacenamiento es solo igual a lo que use la maquina, ejemplo, preparamos 34G de almacenamiento pero solo usamos 3G, la maquina solo pesara 3G

### Resumen tipos de almacenamiento
| Nombre           | Tipo                         | Compartido | Instantáneas / P.L.              |
|------------------|------------------------------|------------|-----------------------------------|
| ZFS (local)      | Sist. Ficheros               | No         | Sí                               |
| Directory        | Sist. Ficheros               | No         | No (Sí, con ficheros qcow2)      |
| BTRFS            | Sist. Ficheros               | No         | Sí                               |
| NFS              | Sist. Ficheros               | Sí         | No (Sí, con ficheros qcow2)      |
| CIFS             | Sist. Ficheros               | Sí         | No (Sí, con ficheros qcow2)      |
| Proxmox Backup   | Sist. Ficheros / Disp. Bloque| Sí         | No                               |
| GlusterFS        | Sist. Ficheros               | Sí         | No (Sí, con ficheros qcow2)      |
| CephFS           | Sist. Ficheros               | Sí         | Sí                               |
| LVM              | Disp. Bloque                 | No (Sí, usando iSCSI) | No                |
| LVM-thin         | Disp. Bloque                 | No         | Sí                               |
| iSCSI            | Disp. Bloque                 | No         | No                               |
| Ceph/RBD         | Disp. Bloque                 | Sí         | Sí                               |
| ZFS over iSCSI   | Disp. Bloque                 | Sí         | Sí                               |

### Que se oyede guardar en las fuentes de almacenamiento?
* Isos
* Contenedores
* Imagenes de disco
* Templates
* VZDump backup files: ficheros de copia de seguridad

## Creacion de una fuente de almacenamiento (directory)
El tipo **Directory** nos permite guardar la info en un nodo del cluster proxmox.

Vienen dos fuentes configuradas por defecto, local y local-lvm.

### Local
* Se guarda en /var/lib/vz
* Esta configurado para guardar:
    * ISOs
    * Templates de contenedores
    * Ficheros de copia de seguridad

### Crear una fuente de almacenamiento
La fuente a crear almacenará imagenes de disco y contenedores
* Discos:
    * Raw
    * Qcow2
    * vmdk

**Pasos:**
1. Datacentere > Storage > Add > Directory
2. Indicamos:
    * Nombre
    * Directorio
    * Contenido a guardar:
        * Disk Image
        * Container

### Añadir nuevos discos a una maquina virtual
1. Selecciona una maquina > Hardware > Add > Hard Disk
2. Añadimos los datos como tamaño, fuente de almacenamiento y formato.
3. Clicamos add y se añadira a nuestra maquina.

### Gestión de discos de una maquina virtual
Al seleccionar un disco de una maquina virtual podremos acceder a algunas opciones:
* Edit: permite alterar parametros del disco selecconado.
* Detach: desconecta el disco de la maquina sin borrarlo. Se puede borrar a posteriori.
* Resize: aumenta el tamaño del disco.
* Move disk: copia el contenido del disco a otra fuente de almacenamiento. Se puede indicar si se borra el dispositivo original os si no se usa.
* 
