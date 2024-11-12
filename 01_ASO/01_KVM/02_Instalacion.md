# Instalación de KVM
1. Ver Si tenemos soporte de virtualización
2. Activamos virtualizacion anidada en nuestra maquina
    * Windows:
    ~~~powershell
    cd "C:\Program Files\Oracle\VirtualBox"
    VBoxManage modifyvm "NombreDeTuVM" --nested-hw-virt on
    ~~~
    * Linux:
    ~~~bash
    VBoxManage modifyvm NombreDeTuVM --nested-hw-virt on
    ~~~
3. Instalamos paquetes necesarios para virtualizar y realizar bridges dentro de nuestra maquina invitada:
~~~bash
sudo apt install -y qemu-kvm libvirt-clients libvirt-daemon-system \ bridge-utils libguestfs-tools genisoimage virtinst libosinfo-bin virt-manager
~~~
Recomendable instalar ssh: ```apt install ssh```

4. Comprobamos el servicio recien instalado (Libvirtd)
~~~bash
sudo systemctl status libvirtd-service
~~~
5. Añadimos nuestro usuario al grupo de administradores de KVM
~~~bash
sudo adduser <usuario> libvirt
sudo adduser <usuario> libvirt-qemu
## Aplicar cambios de manera inmediata
newgrp libvirt
newgrp libvirt-quemu
~~~
6. En caso de errores es probable que el usuario KVM no tiene acceso a la maquina.
~~~bash
sudo nano /etc/libvirt/qemu.conf
## Dentro del doc añadimos dos lineas
user = "root"
# y
group = "root"

# Esto hará que qemu realice las operaciones como root para que no den problemas los permisos
~~~
7. Se puede leer info de Virt-manager en caso de que lo usemos:
~~~bash
cat /usr/share/doc/virt-manager/README.Debian
~~~
Si nuestro usuario se encuentra en livbirt, ejecutando ```virt-manager``` podremos acceder al entorno grafico.

8. Validaciones de instalación:
~~~bash
virt-host-validate ## Info de validación
virt-host-validate | grep -i 'FALLA\ADVERTENCIA' ## Para ver fallos
~~~

## Mecanismos de conexion con el hipervisor
* Acceso local con usuario no privilegiado:
    * Se accede a las maquinas virtuales de ese usuario.
    * Con este moduo de conexion no se pueden crear conexiones red, por lo que usa la de QEMU(SLIRP)
    * Comando: ```virsh --connect qemu:///session```
* Acceso local privilegiado:
    * Se acceden a las maquinas virtuales de todo el sistema.
    * La puede usar root y todos los que esten en el grupo livbirt
    * Es unica para todo el sistema
    * COmando: ```virsh --connect qemu:///system```
* Acceso remoto privilegiado (SSH):
    * Permite la conexion remota al servicio del entorno virtual
    * Comando: ```virsh --connect qemu+ssh://usuario@ip/system```

## La API de livbirt y aplicaciones
* Virsh:
    * Cliente de comandos oficial
    * Shell completa para el manejo de la API
    * Alternativa al acceso local
* Virt-Manager:
    * Entorno grafico
    * Otorga muchas de las funcionalidades
* Virtinst:
    * Paquete que proporciona los comandos virt-clone/install/xml
    * Util para la creación de copias de VMs
* Gnome-Boxes:
    * Aplicacion grafica para acceso local sin privilegios
    * Gestiona de manera sencilla VMS

Se usa informacion en .xml para comunicarse con la API

## Formas de trabajar con privilegios
* Comando directo en una linea por conexion: ```virsh -c qemu///system <comando>```
* En una linea pero por sudo (ignora la conexion en la sintaxis asumiendo system): ```sudo virsh <comando>```
* Conexion a la linea de comandos:
~~~bash
virsh -c qemu:///system
## Te conecta a la terminal de virsh
<comando>
~~~