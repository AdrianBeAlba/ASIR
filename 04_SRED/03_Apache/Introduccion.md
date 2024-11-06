# Introducción a Apache2
## Instalación
~~~bash
# Actualizamos los repositorios
apt update&&upgrade
#Instalamos el paquete
apt install apache2
~~~

Se nos crearan varios ficheros de configuración.
* Sites available: configuracones de ssitios, por defecto te viene una para el puerto 80 y 443.
* Sites enabled: sitios abiertos y disponibles.
* /var/www/html: aqui se encuentran los archivos de las paginas. De base hay un index.html con la pagina por defecto.
Actualmente el unico accesible es el configurade

Modulos: fragmentos de codigo que dan utilidades

## Comandos:
* a2enmod <modulo>: levanta <modulo> un uso seria *adenmod ssl* que levantaria la conexion encriptada
* a2ensite <sitio>: levanta el sitio web que marquemos, buscara su fichero de configuración
    * Crea un soft link de el documento de configuracion de la carpeta sites-available en sites-enabled
*  a2dissite <sitio>: exactamenteo opuesto a lo anterior.
* apache2ctl: 
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
