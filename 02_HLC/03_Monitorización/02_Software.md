# Software de monitorización

tcpdump saca toda la info en tiempo real del estado de la red, esto es filtrable:

* tcpdump -i `<nic>`: saca info que transite por la interfaz seleccionada 
* -v: da mas informacion, "verbose".
* -w `<diectorio>`: manda la infoa directorio en vez de por pantalla.
* -r: para leer el directorio encriptado. Los saca perteneciendo al usuario tcpdump.
* tcptrack -i nic: igual que tcpdump, pero mas claro.
* iptraf: se instala con iptraf-ng, paquete muy intuitivo para revisar trafico en red, entre otras opciones.
* bmon: paquete intuitivo para monitorizar trafico. 
* ss: ver puertos
    - tnl: puertos escuchando
    - tnp: puertos establecidos
## Grafana
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
