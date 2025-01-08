Aquí tienes un ejemplo de cómo podría ser un archivo de configuración para `pagina1.com` en Apache2, con comentarios explicativos para cada opción. Este archivo de configuración se guarda típicamente en `/etc/apache2/sites-available/pagina1.conf`.

```apache
# Configuración del sitio virtual para pagina1.com

<VirtualHost *:80>
    # Esta directiva define que este bloque de configuración se aplica a un sitio virtual
    # que escucha en cualquier dirección IP (*) en el puerto 80 (puerto por defecto para HTTP).

    ServerName www.pagina1.org
    # Esta directiva especifica el nombre de dominio principal para este sitio virtual.
    # Los clientes que soliciten www.pagina1.org serán dirigidos a este sitio.

    ServerAlias pagina1.org
    # Esta directiva define nombres alternativos que también apuntarán a este sitio virtual.
    # En este caso, cualquier petición a pagina1.org también será manejada por este sitio.

    DocumentRoot /var/www/pagina1
    # Esta directiva indica la ruta en el sistema de archivos donde se encuentran los
    # archivos del sitio web (HTML, CSS, imágenes, etc.).
    # En este caso, los archivos de pagina1.org se encuentran en /var/www/pagina1.

    <Directory /var/www/pagina1>
        # Este bloque define las opciones de configuración para el directorio
        # especificado (y sus subdirectorios).

        Options Indexes FollowSymLinks
        # Esta directiva controla varias opciones del directorio:
        # - Indexes: Permite mostrar una lista de los archivos del directorio si no se encuentra
        # un archivo índice como index.html.
        # - FollowSymLinks: Permite seguir enlaces simbólicos, lo que significa que se pueden
        # usar enlaces simbólicos para acceder a archivos fuera del DocumentRoot.

        AllowOverride None
        # Esta directiva impide que los archivos .htaccess dentro del directorio modifiquen
        # la configuración del servidor.

        Require all granted
        # Esta directiva permite el acceso al directorio a todos los clientes. Es el equivalente a
        # "Allow from all" en versiones anteriores de Apache.
        # Para restringir el acceso, se podría utilizar "Require ip" o "Require host".
    </Directory>


    #Configuración de Alias
    Alias "/image" "/ftp/pub/image"
    #Esta directiva permite que el servidor sirva ficheros desde cualquier ubicación del sistema
    #de archivos aunque esté fuera del DocumentRoot. En este caso, las peticiones a
    #www.pagina1.org/image/ se redirigen a la ruta /ftp/pub/image

    <Directory "/ftp/pub/image">
        Require all granted
        #Esta directiva otorga permisos de acceso al directorio definido por el alias.
     </Directory>



    #Configuración de Redirecciones
    Redirect "/service" "http://www.pagina.com/service"
    #Esta directiva realiza una redirección temporal de /service a la URL especificada.
    #Para realizar una redirección permanente se puede usar 'Redirect permanent'.


    #Configuración de Páginas de Error Personalizadas
    ErrorDocument 404 /error/404.html
    #Esta directiva define una página personalizada para el error 404 (página no encontrada).
    #Cuando se solicite una página que no existe, Apache mostrará el archivo /error/404.html.


    #Configuración de un directorio privado con Autenticación Básica
    <Directory "/var/www/pagina1/privado">
        AuthType Basic
        #Indica el tipo de autenticación a utilizar, en este caso, autenticación básica.
        AuthName "Acceso Restringido"
        #Este mensaje aparecerá en la ventana que pide las credenciales.
        AuthUserFile "/etc/apache2/claves/passwd.txt"
        #Define la ruta del archivo que contiene los usuarios y contraseñas.
        Require valid-user
        #Indica que solo los usuarios definidos en el fichero pueden acceder.
    </Directory>


    #Configuración para un directorio con autenticación Digest
    <Directory "/var/www/pagina1/privado_digest">
         AuthType Digest
         #Indica el tipo de autenticación a utilizar, en este caso, autenticación digest.
         AuthName "dominio"
         #Define el realm o dominio de los usuarios para la autenticación Digest.
         AuthUserFile "/etc/claves/digest.txt"
         #Define la ruta del archivo que contiene los usuarios y contraseñas para digest.
         Require valid-user
         #Indica que solo los usuarios definidos en el fichero pueden acceder.
    </Directory>



    # Configuración del Log
    ErrorLog ${APACHE_LOG_DIR}/error_pagina1.log
    # Define la ruta donde se guardarán los errores del servidor para este sitio virtual.

    CustomLog ${APACHE_LOG_DIR}/access_pagina1.log combined
    # Define la ruta donde se guardarán los registros de acceso al sitio web.
    # El formato "combined" incluye información detallada de cada solicitud.


    #Ejemplo de como denegar el acceso a un directorio a una red
    <Directory "/var/www/pagina1/privado_ip">
        Require not ip 192.168.0
        #Deniega el acceso al directorio privado a las ips del tipo 192.168.0
    </Directory>

   #Ejemplo de como definir politicas de acceso complejas
   <Directory "/var/www/pagina1/dashboard">
        <RequireAny>
             Require ip 10.1
             Require group admins
       </RequireAny>
    </Directory>
    #Este bloque define una política de acceso al directorio /var/www/pagina1/dashboard, donde se
    #permite el acceso si se cumple al menos una de las dos condiciones:
    #1) Que la petición provenga de la IP 10.1.
    #2) Que el usuario pertenezca al grupo "admins".

</VirtualHost>
```

**Consideraciones Importantes:**

*   **Rutas:** Asegúrate de que las rutas como `/var/www/pagina1`, `/ftp/pub/image`, `/error/404.html`, `/etc/apache2/claves/passwd.txt` y `/etc/claves/digest.txt`  sean correctas en tu sistema.
*   **Creación de directorios:** Debes crear los directorios `/var/www/pagina1`, `/var/www/pagina1/privado`,  `/var/www/pagina1/privado_digest`, `/var/www/pagina1/privado_ip`  y `/var/www/pagina1/dashboard` y el fichero `/error/404.html` si no existen. También debes colocar el contenido web de tu página en `/var/www/pagina1`.
*   **Archivos de contraseñas:**  Los archivos `/etc/apache2/claves/passwd.txt` y `/etc/claves/digest.txt` se crean usando las utilidades `htpasswd` y `htdigest` respectivamente.
*   **Módulos:** Asegúrate de que los módulos necesarios (como `mod_alias`, `mod_auth_basic`, `mod_auth_digest`, `mod_dir`, `mod_autoindex`, etc.) estén habilitados en Apache.
*   **Activación:** Para activar este sitio virtual, deberás crear un enlace simbólico desde `/etc/apache2/sites-available/pagina1.conf` a `/etc/apache2/sites-enabled/`, usando el comando `a2ensite pagina1.conf`, y luego recargar la configuración de Apache con `systemctl reload apache2`.
*   **DNS:**  Para que el dominio `www.pagina1.org` apunte a tu servidor, debes configurar el DNS o el archivo `/etc/hosts` de tu máquina cliente.

Este archivo de configuración te proporciona un punto de partida completo para tu sitio web. Recuerda que puedes personalizarlo y añadir más directivas según tus necesidades.

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
