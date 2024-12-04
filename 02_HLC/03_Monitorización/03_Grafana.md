# Grafana y Prometeo
## Instalacion

## Linkeo
1. Vamos a  la pagina principal de grafana > Data Sources.
2. Seleccionamos Prometeus.
3. En conexion añadimos, http://ip-local:9090 y pulsamos "Guardar y probar"

## Configuraciones
### Prometeus
* Dir: /etc/prometeus/prometeus.yml
* Puertos de prometeus: 9090, 9100.

### Grafana
* Dir: /etc/grafana/grafana.ini
* Puerto: 3000
* Base de datos: sqlite3
* Las opciones se activan quitando el ;

## Entorno grafico
### Creacion de dashboard
1. Import Dashboard 
2. Ve a la pagina oficial y escoge la plantilla que mas te guste, ej:1860
3. Pega la id y pulsa importar.

### Uso de un dashboard
***Nota: estamos usando Node exporter Full, id del apartado anterior***

#### Prueba de estres
1. En el terminal de la maquina: `stress --vm 1 --vm-bytes 1G --vm-hang 1m`, est estresa la memoria
2. Vemos en el panel de control el uso de memoria

Otros comandos de stress
~~~bash
stress --cpu $(nproc --all) --vm 1 --vm-bytes 1G --vm-hang 1m

~~~