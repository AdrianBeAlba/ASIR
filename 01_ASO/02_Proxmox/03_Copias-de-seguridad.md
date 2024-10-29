# Copias de seguridad

Se utilizan con la herramienta **vzdump**, creando un archivo con los datos de la MV.

Se pueden realizar copias en caliente en **todos los tipos de almacenamiento**, de manera **rapida y eficaz.**

Se comprime en un archivo el almacenamiento completo de la maquina.

## Tipos:

* **Stop mode**: para la maquina y la copia. Es ligeramente mas lenta y detiene el servidor, lo que reduce disponibiliad.

* **Suspend Mode**: similar pero la maquina no se para, se suspende.

* **Snapshot mode**: No crea ningun tipo de inactividad pero tiene riesgo a inconsistencia.

## Metodos de compresion

* LZO: El mas rapido.
* GZIP: Mas calidad a cambio de velocidad.
* ZSTD: Punto intermedio.

## Proceso de copiado

1. Abre tu proxmox en el navegador.
2. Selecciona la maquina a copiar.
3. Ve a la seccion de backup y selecciona ***"Backup Now"***.
4. Selecciona las opciones deseadas y pulsa ***"Backup"***.
5. Espera que de el ok y entonces cierra la ventana emergente del respaldo. Veras la copia de seguridad en la lista de copias.

***Nota: Realiza las copias de seguridad en un disco a parte de los datos del proxmox.***
### Añadir nuevo disco:


## Restaurar una copia


# Instantaneas

Las ***Snapshot*** nos permiten guardar el estado de la maquina virtual (disco duro y ram), en un momento.

Se suele realizar para guardar el estado de la maqina antes de añadir software.

## Realizar snapshot

1. Abre tu proxmox en el navegador.
2. Selecciona la maquina a instanciar.
3. Ve a la seccion de snapshots y selecciona ***"Take Snapshot"***.
4. Añade nombre y nota a la captura y pulsa ***"Take Snapshot"*** en la ventana emergente.
4. Cuando de TASK OK cierra la ventana emergente la instantanea deberia de aparecer en el listado con el nombre que le diste.


# Clonaciones

Nos deja crear una copia de la maquina, a diferencia de las copias de seguridad, nos crea una maquina a parte que podremos usar directamente.

* **Clonacion completa**: La clonacion completa crea una maquina separada completamente independiente.
* **Clonacion ligera**: La copia esta linkeada a la original usando parte de su almacenamiento.

### Realizar un clonado 

1. Abre tu proxmox en el navegador.
2. Selecciona la maquina a clonar.
3. Click derecho sobre la maquina y selecciona clonar o clone.
4. Selecciona el nodo, ID, Nombre, Nodo y formato de almacenamiento.
5. Pulsa clonar y espera al ok, cuando termine deberia de aparecer la nueva maquina.

## Plantillas

Al clonar podremos convertir la maquina original en una **plantilla**, lo cual nos permitira tener presets de maquinas las cuales podremos clonar rapidamente.

* Las plantillas son solo lectura.
* No se pede realizar en caliente y no puede contener snapshots.
* Este proceso nos imposibilita el uso de la maquina original.

### Realizar ***Plantilla***
1. Abre tu proxmox en el navegador.
2. Selecciona la maquina a clonar.
3. Click derecho > convertir a plantilla.
4. Selecciona ***si*** en la vetana emergente y espera que se convierta en plantilla, sabras que es una plantilla ccuando cambie el icono.


[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
