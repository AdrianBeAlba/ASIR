# Documento de Briefing: Configuración y Funcionalidades del Servidor Apache

## AUDIO

(Audio.wav)[https://drive.google.com/file/d/1jszRJoxYWCUNf0iJ_wJtEuGMhc18PC7L/view?usp=drive_link]

## Introducción

Este documento resume los conceptos clave y las prácticas relacionadas con la configuración y el uso del servidor web Apache, basado en los documentos proporcionados. Los temas cubren desde la gestión de directorios, redireccionamientos y páginas de error, hasta el control de acceso, la seguridad con SSL y la gestión de módulos.

---

## 1. Mapeo de URLs

### Opciones de Directorios (Directiva `Options`)
- **All**: Habilita todas las opciones excepto `MultiViews`.
- **FollowSymLinks**: Permite seguir enlaces simbólicos, incluso fuera del directorio `DocumentRoot`. Esto puede ser un riesgo de seguridad.
- **Indexes**: Muestra la lista de archivos si no se encuentra un fichero de índice predeterminado (`index.html`, etc.). *Es una mala práctica de seguridad.*
- **MultiViews**: Permite la negociación de contenido, como diferentes versiones de una página según el idioma del usuario.
- **SymLinksIfOwnerMatch**: Permite seguir enlaces simbólicos solo si el archivo destino pertenece al mismo propietario que el enlace.
- **ExecCGI**: Permite ejecutar scripts CGI.

**Ejemplo Práctico:**  
Si se cambia el nombre de `index.html` a `index.txt`, la página no se muestra porque Apache no encuentra el archivo de índice por defecto.

**Seguridad:**  
Es peligroso mostrar todos los archivos de un directorio web, ya que expone información sensible. *Desactiva `Indexes`.*

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
- La directiva `ErrorDocument` puede configurarse en un virtual host o de forma global.

**Ejemplo:**  
```apache
ErrorDocument 404 /error/404.html
```

---

## 2. Control de Acceso

### Directiva `Require` (Apache 2.4)
- **`Require all granted`**: Permite el acceso incondicionalmente.
- **`Require all denied`**: Deniega el acceso incondicionalmente.
- **`Require user`**: Permite el acceso a usuarios autenticados.
- **`Require group`**: Permite el acceso a grupos específicos.
- **`Require ip`**: Permite el acceso desde IPs específicas.
- **`Require host`**: Permite el acceso desde un dominio específico.
- **`Require local`**: Permite el acceso desde `localhost`.

**Ejemplo:**  
```apache
<Directory "/var/www/html">
    Require ip 192.168.1.0/24
</Directory>
```

---

### Autenticación Básica (`mod_auth_basic`)
- **Directivas:**
  - `AuthType Basic`: Activa la autenticación básica.
  - `AuthName`: Mensaje mostrado en la ventana de autenticación.
  - `AuthUserFile`: Ruta al archivo de usuarios y contraseñas.
  - `Require valid-user`: Requiere usuarios autenticados.

**Herramienta:**  
`htpasswd` para gestionar credenciales.

---

### Autenticación Digest (`mod_auth_digest`)
- Mejora la seguridad al enviar contraseñas como hashes en lugar de texto plano.

---

## 3. Seguridad con HTTP+SSL (HTTPS)

### Seguridad y Confianza
- **SSL/TLS:** Cifra la comunicación entre cliente y servidor.
- **Certificados:** Garantizan la autenticidad del servidor.

### Funcionamiento de HTTPS
1. El cliente se conecta mediante HTTPS.
2. El servidor envía su certificado (clave pública).
3. El cliente valida el certificado.
4. El cliente genera una clave simétrica, la cifra con la clave pública y la envía.

### Certificados
- Generar certificados con herramientas como `OpenSSL`.
- Usar CAs reconocidas como Let's Encrypt para certificados gratuitos.

---

## 4. Módulos de Apache

### Modularidad
- **Directorios:**
  - `/etc/apache2/mods-available/`: Módulos disponibles.
  - `/etc/apache2/mods-enabled/`: Módulos activados.
- **Comandos:**
  - `apache2ctl -l`: Lista módulos del núcleo.
  - `apache2ctl -M`: Lista módulos activos.

### Ejemplos de Módulos
- **`userdir`:** Permite que usuarios tengan una carpeta `public_html`.
- **`dav` y `dav_fs`:** Implementan WebDAV para la gestión de archivos en el servidor.

---

## 5. Configuración General de Apache

### Sitios Virtuales (Virtual Hosting)
- **Por Nombre:** Diferencia sitios por nombre de dominio.
- **Por Puerto:** Cada sitio usa un puerto distinto.
- **Por IP:** Cada sitio usa una IP diferente.

**Ejemplo:**  
```apache
<VirtualHost *:80>
    DocumentRoot "/var/www/site1"
    ServerName site1.example.com
</VirtualHost>
```

---

### Directivas de Conexión
- **`Timeout`:** Tiempo máximo de espera (300s por defecto).
- **`KeepAlive`:** Activa conexiones persistentes.
- **`MaxKeepAliveRequests`:** Máximo de peticiones por conexión persistente (100 por defecto).
- **`KeepAliveTimeout`:** Tiempo de espera entre peticiones (5s por defecto).

---

## Conclusión

Apache es un servidor web robusto con amplias opciones de configuración y seguridad. Es fundamental seguir buenas prácticas para garantizar un entorno eficiente y seguro.

