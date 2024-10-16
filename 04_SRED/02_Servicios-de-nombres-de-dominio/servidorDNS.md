# Configurar servidor DNS local

Necesitas configurar 3 ficheros: 

* db.nombedominio.x *Ejemplo: db.adrianbeja.local* (dominio)
* db.<ip>.<ip> *Ejemplo: db.172.26* (ip inversos)
* named.conf.local (configuracion local de nombres)

## Configuracion named.conf.local

Necesitaras añadir una entrada para el dominio y los ip inversos

~~~nano
#Dominio
    zone "adrianbeja.local"{
        type master;
        file "/etc/bind/db.adrianbeja.local" #Dirección del archivo
    };
    #Inversos
    zone "26.172.in-addr.arpa"{
        type master;
        file "etc/bind/db.172.26";
    };
~~~

Asi apuntamos a las configuraciones para el dominio e inversos

## Configuracion de dominio

Copiamos la configuracion ya existente del localhost:

~~~bash
    cd /etc/bind
    cp db.local db.adrianbeja.local
    nano db.adrianbeja.local
~~~

Luego entramos y añadimos la config
~~~nano
$TTL    604800
@       IN      SOA     adrianbeja.local.   root.adrianbeja.local.(
                        3               ;   Serial
                        604800          ;   Refresh
                        86400           ;   Retry
                        2419200         ;   Expire
                        604800 )        ;   Negative Cache TTl
;
#Aqui añadimos los registros
@       IN      NS      adrianbeja.local.
@       IN      A       172.26.2.202
ftp     IN      A       172.26.2.202
www     IN      A       172.26.2.202
ns      IN      A       172.26.2.202

~~~
Comprobamos la config con:
~~~bash
named-checkzone adrianbeja.local /etc/bind/db.adrianbeja.local
~~~
## Configuracion de Inversos

Copiamos la configuracion ya existente del localhost:

~~~bash
cd /etc/bind
cp db.127 db.172.26
nano db.172.26
~~~

Luego entramos y añadimos la config
~~~nano
$TTL    604800
@       IN      SOA     adrianbeja.local.   root.adrianbeja.local.(
                        3               ;   Serial
                        604800          ;   Refresh
                        86400           ;   Retry
                        2419200         ;   Expire
                        604800 )        ;   Negative Cache TTl
;
#Aqui añadimos los registros
@       IN      NS      adrianbeja.local.
202.2   IN      PTR     adrianbeja.local.
203.2   IN      PTR     ftp.adrianbeja.local.
204.2   IN      PTR     www.adrianbeja.local.
205.2   IN      PTR     ns.adrianbeja.local.

~~~

Comprobamos la config con:
~~~bash
named-checkzone 26.172.in-addr.arpa /etc/bind/db.172.26
~~~

## Comprobación final

Vamos a una maquina que se encuentre en la misma red que el nuevo servidor local. Despues comprobamos con el comando dig el nombre del dominio usando el nuevo servidor como referencia.

~~~bash
dig @172.26.2.202 www.adrianbeja.local
~~~

Si te devuelve la ip en la respuesta significa que funciona.