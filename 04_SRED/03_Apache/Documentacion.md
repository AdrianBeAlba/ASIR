# Documento de Briefing: Configuración y Funcionalidades del Servidor Apache

## AUDIO

### [Audio](https://drive.google.com/file/d/1jszRJoxYWCUNf0iJ_wJtEuGMhc18PC7L/view?usp=drive_link)

# Configuración y Funcionalidades del Servidor Apache

## 1. Mapeo de URLs

### Opciones de Directorios (Directiva `Options`)
- **All:** Habilita todas las opciones excepto `MultiViews`.
- **FollowSymLinks:** Permite seguir enlaces simbólicos, incluso fuera del directorio `DocumentRoot`. Esto puede ser un riesgo de seguridad.
  - *"Si esta opción está activada, podemos acceder a través de enlaces simbólicos a archivos que estén fuera del directorio `DocumentRoot`."*
- **Indexes:** Muestra la lista de archivos si no se encuentra un fichero de índice predeterminado (`index.html`, etc.). Mostrar la lista de archivos es una mala práctica de seguridad.
- **MultiViews:** Permite la negociación de contenido, por ejemplo, ofrecer diferentes versiones de una página según el idioma del usuario.
- **SymLinksIfOwnerMatch:** Permite seguir enlaces simbólicos solo si el archivo destino pertenece al mismo propietario que el enlace.
- **ExecCGI:** Permite ejecutar scripts CGI.

**Ejemplo Práctico:**  
Si se cambia el nombre de `index.html` a `index.txt`, la página no se muestra porque Apache no encuentra el archivo de índice por defecto.

**Seguridad:**  
Es peligroso mostrar todos los archivos de un directorio web, ya que expone información sensible a posibles atacantes. *Se deben desactivar `Indexes`.*

---

### Alias (Directiva `Alias`)
- Permite servir archivos desde cualquier ubicación del sistema, incluso fuera del `DocumentRoot`.
- Es necesario dar permisos de acceso al directorio destino del Alias mediante `<Directory>`.

**Ejemplo:**  
```apache
Alias "/image" "/ftp/pub/image"
```
Esto permite acceder a las imágenes en `/ftp/pub/image` mediante la URL `www.pagina1.org/image/`.

---

### Redireccionamiento (Directiva `Redirect`)
- **Redirecciones Permanentes (Código 301):** Indican que el recurso se ha movido permanentemente. *Los buscadores indexan estas redirecciones.*
- **Redirecciones Temporales (Código 302):** Indican que el recurso se encuentra temporalmente en otra ubicación.

**Ejemplo:**  
```apache
Redirect "/service" "http://www.pagina.com/service"
```

---

### Páginas de Errores (Directiva `ErrorDocument`)
Apache permite personalizar las páginas de error (404, 500, etc.).

- Se puede mostrar un mensaje de texto, redirigir a una URL local o a una URL externa.
- La directiva `ErrorDocument` puede configurarse en un virtual host o de forma global en un archivo de configuración como `/etc/apache2/conf-available/localized-error-pages.conf`.

**Ejemplo:**  
```apache
ErrorDocument 404 /error/404.html
```

---

## 2. Control de Acceso

### Directiva `Require` (Apache 2.4)
- **`Require all granted`:** Permite el acceso incondicionalmente.
- **`Require all denied`:** Deniega el acceso incondicionalmente.
- **`Require user`:** Permite el acceso a usuarios autentificados.
- **`Require group`:** Permite el acceso a grupos de usuarios específicos.
- **`Require valid-user`:** Permite el acceso a cualquier usuario autenticado.
- **`Require ip`:** Permite el acceso desde las IPs especificadas.
- **`Require host`:** Permite el acceso desde el dominio especificado.
- **`Require local`:** Permite el acceso desde `localhost`.

**Ejemplo:**  
Para denegar el acceso a una IP específica:  
```apache
Require not ip 192.168.0.1
```

---

### Directivas Obsoletas (Apache 2.2)
- **`Order deny,allow`:** Por defecto, se permite el acceso, pero se debe revisar `allow`.
- **`Order allow,deny`:** Por defecto, se deniega el acceso, pero se debe revisar `allow`.
- **`Allow from`:** Permite acceso desde las IPs o dominios definidos.
- **`Deny from`:** Deniega el acceso desde las IPs o dominios definidos.

---

### Autenticación Básica (`mod_auth_basic`)
Requiere usuario y contraseña para acceder a un recurso.

- Los usuarios y contraseñas se almacenan en un fichero de texto plano, aunque las contraseñas se guardan hasheadas.
- **Directivas:**
  - `AuthType Basic`: Activa la autenticación básica.
  - `AuthName`: Define el mensaje que se mostrará en la ventana de autenticación.
  - `AuthUserFile`: Indica la ruta del fichero con las credenciales.
  - `Require valid-user` o `Require user usuario1`: Define quién tiene acceso.

**Herramienta:**  
Se utiliza `htpasswd` para gestionar el archivo de usuarios y contraseñas.

---

### Autenticación Digest (`mod_auth_digest`)
Soluciona el problema de las contraseñas en texto plano de la autenticación básica.

- Utiliza un hash de la contraseña antes de enviarla por la red.
- **Directivas:**
  - `AuthType Digest`: Activa la autenticación digest.
  - `AuthName`: Identifica un nombre de dominio (`realm`) que debe coincidir con el archivo de contraseñas.
  - `AuthUserFile`: Indica la ruta del fichero con las credenciales.
  - `Require valid-user`: Define quién tiene acceso.

**Herramienta:**  
Se utiliza `htdigest` para gestionar el archivo de usuarios y contraseñas.

---

## 3. Seguridad con HTTP+SSL (HTTPS)

### Seguridad y Confianza
- El protocolo SSL/TLS cifra la comunicación entre el cliente y el servidor para evitar que se capture información sensible.
- Los certificados garantizan la autenticidad del servidor. *"Estos certificados son ficheros que otorgan entidades reconocidas donde se asegura que el servidor es un servidor legítimo."*

### HTTPS
- Utiliza SSL/TLS para cifrar datos.
- Utiliza el puerto `443/tcp` por defecto.
- Los certificados son emitidos por una Autoridad de Certificación (CA).
- El navegador confía en una lista de certificados de CA.

### Funcionamiento de HTTPS
1. El cliente se conecta al servidor mediante HTTPS.
2. El servidor envía su certificado (clave pública) al cliente.
3. El cliente valida el certificado.
4. El cliente genera una clave simétrica, la cifra con la clave pública del servidor y la envía.

### Certificados
- Se necesitan un certificado y una clave privada.
- Herramientas como `OpenSSL` se utilizan para generar certificados.
- Existen autoridades de certificación gratuitas como Let's Encrypt y CAcert.

---

## 4. Módulos de Apache

### Modularidad
- Apache carga en memoria solo los módulos necesarios para ser más eficiente.
- **Directorios:**
  - `/etc/apache2/mods-available/`: Módulos disponibles.
  - `/etc/apache2/mods-enabled/`: Módulos activados (enlaces simbólicos).

### Comandos
- `apache2ctl -l`: Lista los módulos cargados con Apache (núcleo).
- `apache2ctl -M`: Lista los módulos activos.

### Ejemplos de Módulos
- **`userdir`:** Permite que cada usuario tenga una carpeta `public_html` para alojar sus páginas web.
- **`dav` y `dav_fs`:** Implementan el protocolo WebDAV para la gestión de archivos en el servidor.
  - WebDAV permite editar y versionar documentos directamente desde el navegador o un explorador de archivos.

---

## 5. Configuración General de Apache

### Sitios Virtuales (Virtual Hosting)
Permiten alojar múltiples sitios web en un mismo servidor.

- **Por Nombre:** Se accede por el nombre de dominio, compartiendo una misma IP y puerto.
- **Por Puerto:** Cada sitio usa la misma IP, pero un puerto diferente.
- **Por IP:** Cada sitio utiliza una IP distinta. *"Cada sitio web tiene una dirección IP diferente."*

### Directiva `DocumentRoot`
Indica la ruta de los archivos del sitio virtual.

### Comandos útiles
- `apache2ctl -t`: Comprueba la sintaxis de la configuración.
- `apache2ctl -M`: Lista los módulos cargados.
- `apache2ctl -S`: Lista los sitios virtuales y sus opciones.
- `apache2ctl -V`: Muestra las opciones de compilación.

### Directivas de Conexión
- **`Timeout`:** Tiempo máximo de espera para recibir y transmitir datos (300 segundos por defecto).
- **`KeepAlive`:** Activa/desactiva conexiones persistentes (activado por defecto).
- **`MaxKeepAliveRequests`:** Número máximo de peticiones por conexión persistente (100 por defecto).
- **`KeepAliveTimeout`:** Tiempo que el servidor espera por peticiones en una conexión persistente (5 segundos por defecto).

### Otras Directivas
- **`User` y `Group`:** Usuario y grupo que ejecutan los procesos de Apache (`www-data`).
- **`LogLevel`:** Controla el nivel de información de los logs.
- **`LogFormat`:** Formato de los logs.
- **`Directory` y `DirectoryMatch`:** Opciones para directorios.
- **`Files` y `FilesMatch`:** Opciones para archivos.

---

## Conclusión

Los documentos cubren un amplio rango de configuraciones de Apache. Desde la configuración básica hasta la implementación de seguridad y funcionalidades avanzadas. Es importante seguir las buenas prácticas para asegurar un entorno de servidor web seguro y eficiente.


[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
