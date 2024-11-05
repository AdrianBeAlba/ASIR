# Gestion de Usuarios

Se permiten 2 tipos de autenticación:

- **Linux PAM (Standart Autentication)**: El usuario root por ejemplo es un usuario **Linux PAM**, en resumen, los linux PAM son usuarios del sistema que sirven para administrar el servidor.
- **Proxmox VE Autentication Server**: No son usuarios fisicos del servidor, por lo que no pueden acceder a la maquina fisica. Estos son los usuarios pensados para el uso del proxmox.

Otras fuentes: LDAP

### Creacion de usuario linux PAM

1. Creas un usuario en la maquina con **_adduser_**.
2. En Datacenter>Permissions>User Selecciona el realm como PAM y busca al usuario creado en la maquina.
3. En Permissions\Add y selecciona el tipo de permiso que quieres dar (por ejemplo, acceso de sólo lectura o administrador).
   Define el Path (puedes seleccionar Datacenter para acceso completo).
   Selecciona el User en formato nombre_usuario@pam.
4. Probar el acceso

### Creacion de usuario PROXMOX

1. DATACENTER> USERS> ADD
2. Añades credenciales entre otras caracteristicas, como grupo, caducidad, etc...
3. Pulsa aregar y prueba el acceso

**_Se recomienda crear grupos antes que usuarios_**

## Grupos

Cada usuario puede ser miembro de varios grupos. Los grupos son la forma preferida de organizar los permisos de acceso.

Para gestionar usuarios, grupos, permisos, ... elegimos la opción Permissions en el nivel del Datacenter:

- **Permissions**: Nos permite gestionar los permisos para limitar las acciones permitidas a usuarios o grupos.
- **Users**: Para gestionar los usuarios.
- **API Tokens**: Generar los tokens para el acceso a la API de Proxmox VE.
- **Groups**: Gestión de los grupos de usuarios.
- **Pools**: Gestión de los Pools de Recursos. Un pool de recursos es un conjunto de máquinas virtuales, contenedores y fuente de almacenamiento.
- **Roles**: Gestiona los Roles. Los Roles son conjuntos de permisos.
- **Authentification**: Nos permite gestionar las fuentes de autentificación disponibles.

#### Crear grupo: Datacenter> Groups> ADD group

## Gestion de permisos

**Privilegio**: Es el derecho a realizar una acción específica.

Para facilitar la gestion los privilegios se agrupan en roles, que luego se pueden utilizar en la tabla de permisos.

Los permisos solo se pueden asignar a roles y estos son la unica manera de otorgar permisos a usuarios y grupos.

### Privilegios

---

#### Privilegios relacionados con el nodo/sistema

- **Permissions.Modify**: modificar los permisos de acceso.
- **Sys.PowerMgmt**: gestión de la energía del nodo (arranque, parada, reinicio, apagado, ...).
- **Sys.Console**: acceso a la consola del nodo.
- **Sys.Syslog**: ver el syslog.
- **Sys.Audit**: ver el estado/configuración del nodo y la configuración del clúster.
- **Sys.Modify**: crear/modificar/eliminar los parámetros de red del nodo.
- **Group.Allocate**: crear/modificar/eliminar grupos.
- **Pool.Allocate**: crear/modificar/eliminar un pool de recursos.
- **Pool.Audit**: ver un pool de recursos.
- **Realm.Allocate**: crear/modificar/eliminar fuentes de autentificación.
- **Realm.AllocateUser**: asignar un usuario a una fuente de autentificación.
- **User.Modify**: crear/modificar/eliminar el acceso y los detalles del usuario.

#### Privilegios relacionados con la máquina virtual o contenedor

- **VM.Allocate**: crear/eliminar máquinas virtuales/contenedores en un servidor.
- **VM.Migrate**: migrar las máquinas virtuales/contenedores a un servidor alternativo en el clúster.
- **VM.PowerMgmt**: gestión de la energía (arranque, parada, reinicio, apagado, ...) de una máquina virtual.
- **VM.Console**: acceso a la consola de las máquinas virtuales/contenedores.
- **VM.Monitor**: acceso al monitor de las máquinas virtuales/contenedores.
- **VM.Backup**: copia de seguridad/restauración de máquinas virtuales/contenedores.
- **VM.Audit**: ver la configuración de las máquinas virtuales/contenedores.
- **VM.Clone**: clonar/copiar máquinas virtuales/contenedores.
- **VM.Config.Disc**: añadir/modificar/eliminar discos.
- **VM.Config.CDROM**: expulsar/cambiar CD-ROM.
- **VM.Config.CPU**: modificar la configuración de la CPU.
- **VM.Config.Memory**: modificar la configuración de la memoria.
- **VM.Config.Network**: añadir/modificar/eliminar dispositivos de red.
- **VM.Config.HWType**: modificar los tipos de hardware emulados.
- **VM.Config.Options**: modificar cualquier otra configuración de las máquinas virtuales/contenedores.
- **VM.Snapshot**: crear/borrar instantáneas de las máquinas virtuales/contenedores.

#### Privilegios relacionados con el almacenamiento

- **Datastore.Allocate**: crear/modificar/eliminar una fuente de almacenamiento y eliminar volúmenes.
- **Datastore.AllocateSpace**: asignar espacio en una fuente de almacenamiento.
- **Datastore.AllocateTemplate**: asignar/cargar plantillas e imágenes ISO.
- **Datastore.Audit**: ver/examinar una fuente de almacenamiento.

### Roles del sistema:

Como se ha indicado, los privilegios no se asignan directamente. Los roles son conjuntos de privilegios que son los que se van a asignar para otorgar los permisos. Los roles predefinidos que tenemos son los siguientes:

- **Administrator**: tiene todos los privilegios.
- **NoAccess**: no tiene privilegios (se utiliza para prohibir el acceso).
- **PVEAdmin**: puede realizar la mayoría de las tareas, pero no tiene derechos para modificar la configuración del sistema.
- **PVEAuditor**: solo tiene acceso de lectura.
- **PVEDatastoreAdmin**: crea y asigna el espacio y las plantillas de las copias de seguridad.
- **PVEDatastoreUser**: asigna el espacio de copia de seguridad y el uso del almacenamiento.
- **PVEPoolAdmin**: asigna Pools de Recursos.
- **PVEPoolUser**: ver o utilizar Pools de Recursos.
- **PVESysAdmin**: permisos de usuario, auditoría, consola del sistema y registros del sistema.
- **PVETemplateUser**: ver y clonar plantillas de contenedores.
- **PVEUserAdmin**: gestionar usuarios.
- **PVEMAdmin**: administrar completamente las máquinas virtuales/contenedores.
- **PVEMUser**: ver, hacer copias de seguridad, configurar el CD-ROM, acceder a la consola, gestionar la energía de las máquinas virtuales/contenedores.

### Asignar Permisos

Los roles se asignan a un grupo o usuario, utilizamos rutas similares al sistema de archivos para indicar objetos. Cuanto mas alto el nivel mas corta la ruta pues se propagan en forma de arbol:

Ejemplos:

- vms: Indica todas las máquinas virtuales y contenedores.
- /vms/{vmid}: Indica una máquina virtual o contenedor con un id determinado.
- /storage/{storeid}: Indica una fuente de almacenamiento con un id determinado.
- /pool/{poolname}: Indica un pool de recursos con un nombre determinado.

### Crear rol personalizado:

# Creación de Roles Personalizados

Para crear roles personalizados en Proxmox, sigue estos pasos:

1. **Accede a** `Datacenter` > `Permissions` > `Roles`.

2. **Crea un nuevo rol**:

   - Haz clic en el botón **Add** (Agregar) en la parte superior de la lista de roles.
   - En el cuadro de diálogo que aparece, completa los siguientes campos:
     - **Role ID**: asigna un nombre al rol. Este nombre debe ser único y representativo (por ejemplo, `BackupManager` o `ReadOnlyUser`).
     - **Privilegios**: selecciona los permisos específicos que quieres asignar a este rol. Los permisos incluyen opciones como:
       - `VM.PowerMgmt`: permite iniciar y detener máquinas virtuales.
       - `Datastore.AllocateSpace`: permite asignar espacio en el almacenamiento.
       - `Sys.Modify`: permite hacer cambios en el sistema, entre otros.
       - También puedes seleccionar otros permisos según las necesidades específicas del rol.

3. **Guardar el nuevo rol**:

   - Una vez que hayas seleccionado los privilegios adecuados, haz clic en **Create** para guardar el nuevo rol.

4. **Asignar el rol a un usuario**:

   - Ahora que has creado el rol, puedes asignarlo a un usuario:
     - Dirígete a **Permissions** > **Add**.
     - Selecciona el **Path** en el que el rol aplicará (por ejemplo, `Datacenter` o una VM específica).
     - Elige el **User** (en formato `nombre_usuario@realm`, como `user@pam`).
     - Selecciona el **Role** (el nuevo rol que acabas de crear).

5. **Probar el rol**:
   - Asegúrate de que el usuario al que asignaste el rol tenga los permisos deseados al probar sus acciones en la interfaz de Proxmox.

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
