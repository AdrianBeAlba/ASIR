# Comandos en Proxmox

## Gestionando Máquinas Virtuales con el Comando `qm`

- **Listar todas las MV del host**: `qm list`
- **Eliminar una MV**: `qm destroy <vm id>`
- **Resetear una MV**: `qm reset <vm id>`
- **Apagar una MV**: `qm shutdown <vm id>`
- **Apagar todas las MVs**: `qm shutdown all`
- **Encender/Arrancar una MV**: `qm start <vm id>`
- **Parar una MV de inmediato**: `qm stop <vm id>`
- **Suspender la MV seleccionada**: `qm suspend <vm id>`
- **Desbloquear la MV seleccionada**: `qm unlock <vm id>`
- **Incrementar el tamaño del disco de la MV**: `qm resize <vm id> <disco> <tamaño en GB>`
  - Ejemplo: `qm resize 100 virtio +50G`
- **Ayuda sobre el comando `qm`**: `qm help`
- **Muestra el estado de la MV seleccionada**: `qm status <vm id>`
- **Muestra la configuración de una determinada MV**: `qm config <vm id>`
- **Saber la RAM de una MV determinada**: `grep config vmid | grep ^memory`
- **Acceder a la consola (Terminal) monitor de una MV indicando su ID**: `qm monitor <vm id>`
  - Dentro de la consola puedes usar `info`, `info status` o `info name`.
- **Mostrar información del build de una MV (como la MAC de la tarjeta de red virtual, nombre, unidades, tarjeta gráfica)**: `qm showcmd <vm id>`
- **Cambiar la memoria RAM de una máquina virtual**: `qm set <vm id> --memory <tamaño en mb>`
- **Cambiar el idioma del teclado de una MV**: `qm set <vm id> --keyboard "es"`
- **Proteger una MV para que no se pueda eliminar**: `qm set <vm id> --protection 1`
  - Es booleano: `1` para habilitar y `0` para deshabilitar.
- **Activar el arranque automático de una MV**: `qm set <vm id> --onboot 1`

> Nota: Las configuraciones de las máquinas virtuales están en `/etc/pve/qemu-server/`.

---

## Gestionando Contenedores con el Comando `pct`

- **Consulta del comando `pct`**: `pct --help` o `man pct`
- **Listado de contenedores del nodo**: `pct list`
- **Muestra la configuración de un contenedor**: `pct config <vm id>`
- **Arrancar un contenedor**: `pct start <vm id>`
- **Apagar un contenedor de forma ordenada**: `pct shutdown <vm id>`
- **Detener un contenedor de inmediato**: `pct stop <vm id>`
- **Reiniciar un contenedor**: `pct reboot <vm id>`
- **Acceder al terminal del contenedor**: `pct enter <vm id>`
- **Cambiar la memoria de un contenedor**: `pct set <vm id> --memory <tamaño en mb>`
  - Ejemplo: `pct set <vm id> --memory 1024`

---

## Para las Plantillas

- **Listado de todas las plantillas en el repositorio**: `pveam available`
- **Listado de plantillas en el sistema**: `pveam available --section system`
- **Descargar una plantilla**: `pveam download local <nombre plantilla.tar.gz>`
  - Ejemplo: `pveam download local debian-10.0-standard_10.0-1_amd64.tar.gz`

---

## Para Clonar

- **Clonar una MV indicando su vmid actual y el vmid asignado**: `qm clone <vm id> <vm id-clone>`
- **Ponerle nombre a una máquina virtual**: `qm set <vm id-clone> --name "MV-clonada"`

---

## Para Snapshot (Instantáneas)

- **Realizar Snapshot de una MV incluyendo una descripción**: `qm snapshot <vm id> "<nombre snapshot>" --description "<descripción>"`
- **Eliminar un Snapshot de una MV**: `qm delsnapshot <vm id> "<nombre snapshot>"`
- **Listar Snapshots de una MV**: `qm listsnapshot <vm id>`
- **Restaurar un Snapshot de una MV**: `qm rollback <vm id> "<nombre snapshot>"`

---

## Creación de Usuarios

- **Crear un usuario**: `pveum useradd "<user id>@pve"`
- **Asignar contraseña a un usuario**: `pvesh set /access/password --userid "<user id>@pve" --password "<password>"`
- **Crear un pool y asignarlo a un usuario**: `pvesh create pools --poolid "<nombre pool>"`
- **Dar permisos a un usuario sobre el pool**: `pvesh set /access/acl --path /pool/<nombre pool> --roles PVEVMAdmin --users "<user id>@pve"`

---

## Creación de Copias de Seguridad

- **Crear un backup de una MV**: `vzdump <ID>`
- **Restaurar un backup de una MV**: `vzrestore <ID>`
- **Otra forma de restaurar un backup de una MV**: `qmrestore <ID>`

---

## Gestionando el Clúster con Comandos

### Administración del Sistema

- **Obtener la versión de Proxmox**: `pvesh get /version`
- **Información del estado del clúster**: `pvesh get /cluster/status`
- **Obtener información de los logs**: `pvesh get /cluster/log`
- **Mostrar todos los recursos del clúster**: `pvesh get /cluster/resources`
- **Mostrar información de los nodos**: `pvesh get /nodes`
- **Crear un nuevo clúster**: `pvecm create <nombre cluster>`
- **Añadir un nodo al clúster**: `pvecm add <IP NODE o DNS>`
- **Ver estado de los nodos**: `pvecm nodes`
- **Realizar un test del host físico**: `pveperf`

### Administración de Máquinas Virtuales

- **Mostrar los recursos del clúster**: `pvesh get /cluster/resources`
- **Obtener un listado de todas las máquinas virtuales de un nodo**: `pvesh get /nodes/<node id>/qemu`
- **Arrancar una MV**: `pvesh create /nodes/<node id>/qemu/<vm id>/status/start`
  - Ejemplo: `pvesh create /nodes/virtual1/qemu/100/status/start`
- **Obtener la configuración de una MV**: `pvesh get /nodes/<node id>/qemu/<vm id>/config`
- **Borrar una MV**: `pvesh delete /nodes/<node id>/qemu/<vm id>`

### Administración de Usuarios y Grupos

- **Obtener información de los usuarios**: `pvesh get /access/users`
- **Crear un usuario con contraseña**: `pvesh create /access/users --userid <user id>@pve --password "<password>"`
- **Borrar un usuario**: `pvesh delete /access/users/<user id>@pve`
- **Obtener información de los grupos**: `pvesh get /access/groups`
- **Crear un grupo**: `pvesh create /access/groups --groupid <nombre grupo>`
- **Eliminar un grupo**: `pvesh delete /access/groups/<nombre grupo>`
- **Añadir un usuario a un grupo**: `pvesh set /access/users/<user id>@pve --groups <nombre grupo>`

### Administración de Pools y Almacenamiento

- **Mostrar los pools existentes**: `pvesh get pools`
- **Crear un pool**: `pvesh create /pools --poolid "<pool id>"`
- **Borrar un pool (si está vacío)**: `pvesh delete /pools/<pool id>`
- **Asignar almacenamiento a un pool**: `pvesh set /pools/<nombre pool> --storage local,local-lvm`

### Gestión de Roles

- **Visualizar los roles existentes**: `pvesh get /access/roles/`
- **Crear un rol y asignar permisos**: `pvesh create /access/roles --roleid <role id> --privs <nombre-privilegio>`
- **Asignar roles a un pool para que accedan los usuarios**: `pvesh set /access/acl --path /pool/<nombre pool> --roles <nombre-rol> --users "<user id>@pve"`
- **Asignar un rol a un grupo en un pool**: `pvesh set /access/acl --path /pool/<nombre pool> --roles <nombre-rol> --groups <nombre-grupo>`
- **Eliminar un rol**: `pvesh delete /access/roles/<rol id>`

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
