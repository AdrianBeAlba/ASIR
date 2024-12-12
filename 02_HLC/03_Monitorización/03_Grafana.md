# Grafana y Prometeo
## Instalacion
# Install Prometheus and NodeExporter
apt update && upgrade
apt install prometheus
systemctl daemon-reload
systemctl status prometheus
systemctl enable prometheus
systemctl list-unit-files | grep prometheus
# Install Grafana
# Permite instalar desde https
apt install -y apt-transport-https
# Instalamos wget
apt install -y software-properties-common wget
# Nos descargamos la key de grfana para poder descargar sus paquetes
wget -q -O - https://packages.grafana.com/gpg.key |apt-key add -
# Añadimos repositorios de grafana
echo "deb https://packages.grafana.com/oss/deb stable main" |tee -a /etc/apt/sources.list.d/grafana.list

# Comprobaciones
* apt-key list | grep grafana # Lista de keys, filtrado para que muestre grafana

* cat etc/apt/sources.list.d/grafana.list # Lista repositorios de grafana

* apt update # Para que lea el repositorio

apt install grafana

systemctl daemon-reload
systemctl status grafana-server
systemctl enable grafana-server
systemctl start grafana-server
systemctl status grafana-server

#Por el navegador
http://<ipmaquina>:3000
## Usuario: admin , Contraseña: admin
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

yes > /dev/null & # & Lo pone en segundo plano

ping -s 1472 clear
apt update

~~~
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
