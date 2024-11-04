# 02_Servicios de nombres de dominio
## 02.1_Introducción a las DNS
El DNS (Domain Name System) es un sistema que se utiliza para traducir nombres de dominio legibles para los humanos (como www.ejemplo.com) a direcciones IP numéricas que las computadoras pueden entender (como 192.0.2.1). 

El Sistema de Nombres de Dominio de Internet (Internet Domain Name System) es una implementación específica del concepto de servidor de nombres, optimizado a las condiciones de la red de Internet. Dicha implementación cubre tres requisitos:

  *  Necesidad de una jerarquía de nombres.
  *  Necesidad de un balanceo de carga entre los servidores de nombres.
  *  Necesidad de delegar la administración de los servidores de nombres.

El DNS se implementa a través de una estructura de árbol, que es una estructura jerárquica. En el nivel superior se encuentra el nodo raíz, le siguen los nodos de dominios de primer nivel (TLD, Top Level Domain), a continuación vienen los nodos de dominios de segundo nivel (SLD, Second Level Domain), y por último, termina con un número indefinido de nodos de niveles inferiores. Todos estos niveles se separan con un punto al escribirlos.

## 02.2 Busqueda inversa

## 02.3 Trasferencia de zona

Para simplificar el mantenimiento de múltiples servidores DNS, es útil disponer de un único servidor (maestro) a partir del cual se actualice el resto (esclavos). Este proceso involucra la transferencia de ficheros de zona de un servidor maestro a otros esclavos. Todo esto está estandarizado por el protocolo DNS y se realiza por el puerto 53 utilizando TCP como transporte.

### 02.3.1 Transferencia completa "AXFR"

El proceso original de actualización, de las zonas de los servidores esclavos a partir de las zonas del servidor maestro, consistía en que pasado el tiempo de refresco especificado en el RR SOA, el servidor esclavo solicitaba el registro SOA al maestro; una vez recibido, el servidor esclavo comparaba el número de serie del RR SOA recibido con el número de serie del RR SOA de la última transferencia, y si el primero era superior al segundo, quería decir que la zona en el servidor maestro se había modificado desde la última transferencia, por lo que el esclavo solicitaba una nueva transferencia del fichero de zona completo (AXFR).

* ***RR SOA: El registro SOA (Start of Authority) en DNS es como la "tarjeta de presentación" de un dominio o zona en Internet. Sirve para decir quién es el responsable de gestionar ese dominio y cómo deben sincronizarse los servidores que manejan la información sobre ese dominio.***

### 02.3.2 Transferencia incremental, IXFR

Con el crecimiento de Internet, las transferencias AXFR se hicieron lentas y consumían mucho ancho de banda, aparte de que no es muy óptimo hacer un simple cambio en el fichero de zona y transferir el fichero completo. Para solucionar este problema se crearon las transferencias incrementales (IXFR, RFC 1995), con las que solo se enviaban aquellos RR que habían sido modificados desde la última transferencia.

El proceso IXFR, es prácticamente igual que el AXFR, en primer lugar, tras el tiempo de refresco, el servidor esclavo solicita al maestro el RR SOA, y si trae un número de serie superior, el esclavo solicita la transferencia del fichero de zona y además indica si es capaz de aceptar transferencias IXFR; si ambos, el maestro y el esclavo, pueden trabajar con estas transferencias, se produce una transferencia IXFR del fichero de zona, en otro caso, se la transferencia será AXFR.

## 02.4 Comandos

~~~bash
sudo rndc retransfer adrianbeja.local
sudo rndc retransfer 26.172.in-addr.arpa
~~~
----
## Referencias
* [www.fpgenred.com](https://www.fpgenred.es/DNS/)



[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
