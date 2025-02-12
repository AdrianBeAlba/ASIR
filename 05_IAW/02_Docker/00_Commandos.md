# Comandos
~~~bash
# Iniciar un .yml
docker compose up -d

# Pararlo
docker compose down
~~~
## Docker run
~~~bash

docker run ubuntu echo "Hola Docker"
## Explicación:

#docker run: Crea y ejecuta un nuevo contenedor.
#ubuntu: Usa la imagen oficial de Ubuntu. Si no está en tu sistema, la descargará de Docker Hub.
#echo "Hola Docker": Ejecuta el comando echo, que imprimirá el mensaje en la consola.
#Cuando el comando finaliza, el contenedor se detiene automáticamente.

docker run -it ubuntu bash
# -it: Ejecuta en modo interactivo (-i) y con terminal (-t).
# ubuntu: Usa la imagen de Ubuntu.
# bash: Inicia una sesión interactiva con Bash dentro del contenedor.

# Para salir del contenedor:
exit

# Ejecuta un contenedor con Nginx exponiendo el puerto 8080:
docker run -d -p 8080:80 nginx
# -d: Ejecuta el contenedor en segundo plano (modo demonio).
# -p 8080:80: Mapea el puerto 80 del contenedor al puerto 8080 del host.
# nginx: Usa la imagen oficial de Nginx.

# Crea un contenedor con una variable de entorno:
docker run -e MI_VARIABLE=Hola -it ubuntu bash

# Crear container con nombre personalizado 
docker run --name mi_contenedor -d nginx

# Ejecución de comandos dentro del contenedor
docker exec mi_contenedor nginx -v

# Inspección de contenedores
docker inspect mi_contenedor

## Esto muestra:
## Configuración del contenedor.
## Direcciones IP.
## Variables de entorno.

# Detener contenedor
docker stop mi_contenedor

# Borrar contenedor
docker rm mi_contenedor

# Mete el contenido de la carpeta actual (pwd) en la carpeta de destino del contenedor (/usr/share/nginx/html)
docker run -d -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx

# Con -v podemos copiar el contenido de un archivo dentro de otro archivo en el contenedor
docker run -d -p 8080:80 -v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf nginx

# Crear contenedor con php y apache
docker run -d --name web -p 8181:80 php:7.3-apache

# Crear y configurar servidor mariadb
docker run -d --name bbdd -p 3336:3306 \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=pruebas \
    -e MYSQL_USER=invitado \
    -e MYSQL_PASSWORD=invitado \
    mariadb

# Ejecutar comandos en mariadb  
docker exec -it bbdd mariadb -u invitado -pinvitado -e "SHOW DATABASES;"

# Descarga imagen de contenedor
docker pull ubuntu:20.04

# Listar imagenes en el sistema
docker images

# Inspeccionar imagen en especifico
docker inspect ubuntu:20.04

# Eliminar imagen (requiere de eliminar contenedores que la usen)
docker rmi ubuntu:20.04

# Crear una imagen basada en un contenedor
docker commit a61 TuNombreUsuarioDockerHub/a61

# Inicio de sesion en docker hub (necesario para el push)
docker login

# Enviar la imagen a tu docker hub (pull funciona igual)
docker push TuNombreUsuarioDockerHub/a61

# Crea imagen a partir de Dockerfile que se encuentre en el directorio . (Dockerfile se tiene que llamar asi)
docker build -t <nombreimagen> .


~~~

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
