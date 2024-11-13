# Conexion remota por SSH
Para conectarnos remotamente a QEMU existen diversos métodos: SSH, TCP, SSL/TLS. 

## Conexion por SSH
### Preparativos
1. La maquina remota tiene que tener instalado SSH.`apt install ssh`.
2. Tenemos que conectarnos como root, por lo que la clausula `PermitRootLogin` tiene que estar activada con un yes. Archivo de configuración `/etc/ssh/sshd_config`. `systemctl restart ssh`.
3. En el sevidor tambien añadimos un usuario para la conexion remota.
    ~~~bash
    # Crear usuario
    adduser prueba
    # Lo añadimos a los grupos correspondientes para el uso de kvm
    adduser prueba libvirt
    adduser prueba libvirt-qemu
    ~~~
4. En cliente añadimos ssh-askpass y askpass-gnome, ambos con `apt install`.


### Conexion por entorno grafico
1. Abrimos virt-manager
2. Archivo>Nueva Conexion, selecccionamos SSH como metodo
3. Nombre de usuario: root, Equipo: `<ip  del equipo>`
Nota: en caso de no conectar usamos el usuario que hemos creado para la conexion y ejecutamos ssh-askpass> permitir.
4. Introducimos la conraseña en el prompt

### Conexion sin entorno grafico
~~~bash
# Esto abrira la linea de comandos de QEMU en la maquina destino
virsh -c  qemu+ssh://usuario@ip/System
~~~
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
