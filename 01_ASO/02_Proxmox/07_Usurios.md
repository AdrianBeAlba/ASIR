# Usuarios en Proxmox
## Introducción 
Proxmox contiene dos tipos de usuarios:
* Linux PAM Standart auth: 
    * Usuarios fisicos del servidor
    * Pueden entrar por la terminal
* Proxmox VE auth server: 
    * No son usuarios fisicos del server
    * Se usan solo para el acceso por la GUI
    * Pueden cambiar su contraseña por la GUI

Cada usuario puede ser miembro de uno o varios **grupos**:
* Los grupos son la manera estandar de organizar permisos de acceso.
* Se recomienda dar permisos a los grupos en vez de a usuarios individuales.
* Manera sencilla de gestionar y listar los controles de acceso.

### Pasos para crear un grupo
1. Nos dirigimos al Datacenter > Permissions > Groups
2. Pulsamos create e introducimos el nombre del grupo a crear

### Pasos para crear un usuario
1. Nos dirigimos al Datacenter > Permissions > Users
2. Pulsamos create
3. Le asignamos un nombre, contraseña y grupo. 

## Pools de recursos

Un pool de recursos consiste en un conjunto de objetos (maquinas, contenedores y fuentes de almacenamiento), se usa para juntar los recursos y asignar permisos de manera simultanea. 

### Pasos para crear un pool
1. Selecciona Datacenter > Permissions > Pools > Create
2. Añade datos al pool (nombre y comentario) y pulsa OK.
3. Teniendo la vista en **Pool View**, ve al pool recien creado > add y selecciona el objeto a añadir al pool.

**Nota: se puede seleccionar a que pool pertenece un objeto en la creación/clonación del mismo**

## Permisos
A los permisos en proxmox se les llama privilegios y permiten la realización de una acción especifica.

Para simplificar su gestion se agrupan en roles y estos se otorgan despues a Usuarios o Grupos.

### Privilegios
* Privilegios relacionados con el nodo/sistema:
    * Permissions.Modify: modificar los permisos de acceso.
    * Sys.PowerMgmt: gestión de la energía del nodo (arranque, parada, reinicio, apagado, ...).
    * Sys.Console: acceso a la consola del nodo.
    * Sys.Syslog: ver el syslog.
    * Sys.Audit: ver el estado/configuración del nodo, la configuración del clúster.
    * Sys.Modify: crear/modificar/eliminar los parámetros de red del nodo.
    * Group.Allocate: crear/modificar/eliminar grupos.
    * Pool.Allocate: crear/modificar/eliminar un pool de recursos.
    * Pool.Audit: ver un pool de recursos.
    * Realm.Allocate: crear/modificar/eliminar fuentes de autentificación.
    * Realm.AllocateUser: asignar un usuario a una fuente de autentificación.
    * User.Modify: crear/modificar/eliminar el acceso y los detalles del usuario.
* Privilegios relacionados con la máquina virtual o contenedor:
    * VM.Allocate: crear/eliminar máquinas virtuales/contenedores en un servidor.
    * VM.Migrate: migrar las máquinas virtuales/contenedores a un servidor alternativo en el clúster.
    * VM.PowerMgmt: gestión de la energía (arranque, parada, reinicio, apagado, ...) de una máquina virtual.
    * VM.Console: acceso a la consola de las máquinas virtuales/contenedores.
    * VM.Monitor: acceso al monitor de las máquinas virtuales/contenedores.
    * VM.Backup: copia de seguridad/restauración de máquinas virtuales/contenedores.
    * VM.Audit: ver la configuración de las máquinas virtuales/contenedores.
    * VM.Clone: clonar/copiar máquinas virtuales/contenedores.
    * VM.Config.Disc: añadir/modificar/eliminar discos.
    * VM.Config.CDROM: expulsar/cambiar CD-ROM.
    * VM.Config.CPU: modificar la configuración de la CPU.
    * VM.Config.Memory: modificar la configuración de la memoria.
    * VM.Config.Network: añadir/modificar/eliminar dispositivos de red.
    * VM.Config.HWType: modificar los tipos de hardware emulados.
    * VM.Config.Options: modificar cualquier otra configuración de las máquinas virtuales/contenedores.
    * VM.Snapshot: crear/borrar instantáneas de las máquinas virtuales/contenedores.
* Privilegios relacionados con el almacenamiento:
    * Datastore.Allocate: crear/modificar/eliminar una fuente de almacenamiento y eliminar volúmenes.
    * Datastore.AllocateSpace: asignar espacio en una fuente de almacenamiento.
    * Datastore.AllocateTemplate: asignar/cargar plantillas e imágenes ISO.
    * Datastore.Audit: ver/examinar una fuente de almacenamiento.

### Roles
* Administrator: tiene todos los privilegios.
* NoAccess: no tiene privilegios (se utiliza para prohibir el acceso).
* PVEAdmin: puede realizar la mayoría de las tareas, pero no tiene derechos para modificar la configuración del sistema.
* PVEAuditor: sólo tiene acceso de lectura.
* PVEDatastoreAdmin: crea y asigna el espacio y las plantillas de las copias de seguridad.
* PVEDatastoreUser: asigna el espacio de copia de seguridad y ve el almacenamiento.
* PVEPoolAdmin: asigna Pools de Recursos.
* PVEPoolUser: ver o utilizar Pools de Recursos.
* PVESysAdmin: permisos de usuario, auditoría, consola del sistema y registros del sistema.
* PVETemplateUser: ver y clonar plantillas de contenedores.
* PVEUserAdmin: gestionar usuarios.
* PVEVMAdmin: administrar completamente las máquinas virtuales/contenedores.
* PVEVMUser: ver, hacer copias de seguridad, configurar el CD-ROM, acceder a la consola, gestionar la energía de las máquinas virtuales/contenedores

**Nota: Podemos crear nuestros propios roles**

## Asignar permisos
Los roles se asignan sobre un objeto a un usuario o grupo, el objeto u objetos se representan en forma de rutas, por ejemplo, si queremos otorgar un permiso a un usuario sobre todas las maquinas usariamos la ruta **/vms**, pero si el privilegio es unicamente sobre una maquina especifica la ruta cambia a **/vms/{id_vm}**.

### Ejemplo asignación de un permiso
Queremos otorgar al *grupo1* el rol de *PVEAuditor* sobre  todas las VMs.

1. Vamos a Datacenter > Permission > Group Permission
2. Indicamos el objeto */vms* (todas las VMs), el rol y el grupo.
3. Pulsamos Add y se asignara el permiso

**Nota: No se pueden gestionar permisos relacionados con redes ni bridges**

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
