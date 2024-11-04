# Redes en Proxmoox

Las Redes son gestionables a dos niveles:
* **Configuracion red el servidor Proxmox VE**: Determina que tipo de conexion tnedra el servidor con el exterior.

* **Configuracion de las maquinas virtualizadas y contenedores**: Esto se gestiona en el propio Proxmox

**Bridge**: Consiste en un dispositivo de interconexion de redes. Linux Brige funciona igual que un puente fisico.

### Configuracion de red del servidor Proxmox

***Nota: cada nodo puede tener una red configurada: Nodo>System>Network***

* La interfaz del servidor proxmox corresponde coin la interfaz del servidor. (Editable por /etc/network/interfaces)
* Un linux bridge (vmbr0 por ejemplo): esta conectado a la interfaz del server y toma ip a traves de dhcp. Esta es igual a la ip del server.
* Por defecto las VM usaran el bridge y tomaran ip a traves del DHCP-Server fisico.(Cualquier maquina es accesible en mi red local por defecto)
 ***Nota: al haber mas de una interfaz este proceo se puede complicsar con vlans y Link Aggregation***

### Conexión servicios virtualizdos con el brige

* Por defecto se conectan al bridge virtual creado en la instalación.
* Las maquinas usaran el dhcp que tengamos configurado en nuestra red local.

* Se nos permite crear nuevos vmbr para conectar las maquinas, la intencion es la creacion de redes internas. Esto nos podria servir en varios escenarios de ejemplo:
    * Varias maquinas conectadas al exterior  con una interfaz conectada a vmbr0 y otra a otro bridge.  Esto crea la red privada.
    * Un equipo que funcione como cortafuegos o nat, conectado al bridge por defecto y al nuevo, teniendo las otras maquinas en la red interna.
    * Laboratorio de maquinas sin conexion al exterior.

### Creacion de un bridge
1. System > Network > Create > LinuxBridge
2. Configura la red interna.
3. Otras configuraciones (Nombre, IP, gateway, autostart)

### Conectar maquinas al nuevo bridge
Tenemos dos opciones:

* Crear interfaces en maquinas ya exstentes que se conecten al nuevo bridge.
* Crear maquinas nuevas conectadas al bridge.

#### Añadiendo nueva interfaz
1. Maquina > Hardware > ADD > Network Device
2. Configuramos Bridge al que conectar el nuevo NIC(interfaz)
3. Configuramos Ip statica en caso de carencia de DHCP-SERVER

## Cortafuegos Proxmox VE
Proxmox nos ofrece un sistema para asegurar el acceso.

### Activación del cortafuegos
Se ha de activar en **Tres niveles**:

* Nivel de Datacenter: 
    1. Datacenter > Firewall > Options
    2. Lo activamos
    3. Podemos tambien cambiar ciertas configuraciones.
        * Security group: Conjunto de reglasdel corrtafuegos.
        * Alias: Permite nombrar IPS, ayuda con la administración de reglas.
        * IPSec: Permite crear grupos de IP.
* Nivel de Nodo
    1. Nodo > Firewall > Options
    2. Lo activamos. Se usan las mismas politicas que en el Datacenter.
* Nivel de maquina:
    1. Maquina > Firewall > Options
    2. Lo activamos.
    3. Podemos destacar politicas adicionales:
        * **Input policy**: **DROP**, es decir se deniega todo el tráfico de entrada (y tenemos que crear reglas de cortafuegos para permitir el tráfico que nos interese).
        * **Output Policy**: **ACCEPT**, se acepta todo el tráfico de salida de la máquina (y tenemos que indicar las reglas de cortafuegos para denegar el tráfico que no permitamos).
        Teniendo esto en cuenta, si queremos restringir mas el cortafuegs podemos configurar ambas como **DROP**
    ***Nota: A cada interfaz se le puede configurar el cortafuegos por separado.***

### Creacion de reglas de cortafuegos
Si habilitamos el cortafuegos para una máquina tendrá permitido el tráfico hacia el exterior (Output Policy: **ACCEPT**) y tendrá denegado el tráfico desde el exterior a la máquina (Input policy: **DROP**).

Partimos de una máquina que tiene un servidor ssh instalado. Está máquina tendrá conectividad al exterior, pero no tendrá conectividad desde el exterior. 

Vamos a poner un ejemplo de reglas (Maquina > Firewall >> ADD):

* Regla para permitir conexiones SSH a la maquina:
    * Accion: **ACCEPT** (Permitir)
    * Direccion: IN (Entrada)
    * Enable: Marcado
    * Dest.port: 22
    * Protocolo: TCP
