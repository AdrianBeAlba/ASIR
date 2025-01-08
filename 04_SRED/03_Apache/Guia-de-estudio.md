# Guía de Estudio: Servidor Web Apache

## Cuestionario

**Instrucciones:** Responde las siguientes preguntas de forma concisa (2-3 oraciones cada una).

1. **¿Qué directiva se utiliza en Apache para habilitar la visualización del listado de archivos de un directorio cuando no se encuentra un archivo índice? Explica brevemente por qué se considera generalmente mala práctica activarla en un entorno de producción.**  
   La directiva `Indexes` se utiliza para habilitar la visualización del listado de archivos. Es mala práctica activarla en producción, porque expone la estructura del sitio a posibles atacantes, ofreciendo demasiada información sobre los archivos y directorios.

2. **Describe cómo la directiva Alias permite servir contenido desde ubicaciones fuera del DocumentRoot. Menciona también la necesidad de usar la directiva `<Directory>` conjuntamente.**  
   La directiva `Alias` permite que un URL apunte a un directorio fuera del `DocumentRoot`, facilitando la organización del servidor. La directiva `<Directory>` se utiliza para configurar los permisos de acceso al directorio al que apunta el alias.

3. **¿Cuál es la diferencia entre una redirección permanente (código 301) y una redirección temporal (código 302)? ¿Qué implicaciones tiene esto para los motores de búsqueda?**  
   Una redirección permanente (301) indica que un recurso se ha movido de manera permanente a una nueva URL, y los motores de búsqueda indexan la nueva ubicación. Una redirección temporal (302) indica que el recurso se encuentra temporalmente en otra URL.

4. **¿De qué manera la directiva ErrorDocument permite personalizar las páginas de error en Apache? Da un ejemplo de uso, mencionando un código de error común.**  
   La directiva `ErrorDocument` permite personalizar la respuesta a un error, ya sea mostrando un mensaje, redirigiendo a una URL local o externa. Por ejemplo, `ErrorDocument 404 /error/404.html` personaliza el error 404 (página no encontrada).

5. **¿Qué directiva se utiliza en Apache 2.4 para controlar el acceso a un directorio basándose en la dirección IP del cliente? ¿Cómo se podría denegar el acceso a una IP específica?**  
   La directiva `Require ip` se utiliza para controlar el acceso por IP en Apache 2.4. Se puede usar `Require not ip 192.168.0.1` para denegar el acceso a una IP específica.

6. **Explica el propósito del módulo mod_auth_basic. ¿Cómo almacena las credenciales de usuario y qué herramienta se usa para gestionarlas?**  
   El módulo `mod_auth_basic` permite requerir autenticación básica para acceder a ciertos recursos. Almacena las credenciales en un archivo de texto plano y se gestiona con la herramienta `htpasswd`.

7. **¿En qué se diferencia la autenticación tipo "digest" de la autenticación básica? ¿Qué utilidad se usa para gestionar las credenciales en este método?**  
   La autenticación "digest" soluciona el problema de la autenticación básica al no enviar la contraseña en texto plano. La utilidad utilizada para gestionar las credenciales en este método es `htdigest`.

8. **En Apache 2.4, ¿qué directivas se utilizan para implementar políticas de acceso complejas que requieren que se cumplan varias condiciones, o que se cumpla al menos una de varias condiciones?**  
   En Apache 2.4, se usan las directivas `<RequireAll>` (todas las condiciones deben cumplirse) y `<RequireAny>` (al menos una condición debe cumplirse) para implementar políticas de acceso complejas.

9. **¿Qué protocolo utiliza HTTPS para asegurar la comunicación entre el cliente y el servidor? ¿Por qué es importante la validación del certificado por parte del navegador?**  
   HTTPS utiliza el protocolo TLS (antes SSL) para el cifrado. La validación del certificado es esencial porque permite al navegador verificar la identidad del servidor y asegurarse de que la comunicación sea con el servidor legítimo.

10. **¿Cómo se gestionan los módulos en Apache, y dónde se encuentran almacenados sus archivos de configuración y ejecutables? Menciona los dos directorios principales que se utilizan para gestionar los módulos.**  
   Los módulos se gestionan en Apache a través de los directorios `/etc/apache2/mods-available/` (módulos disponibles) y `/etc/apache2/mods-enabled/` (módulos activos mediante enlaces simbólicos).

---

## Preguntas para Ensayo

**Instrucciones:** Desarrolla un ensayo que aborde cada una de las siguientes preguntas.

1. Compara y contrasta las distintas formas de virtual hosting disponibles en Apache (por nombre, por puerto, por dirección IP), destacando las ventajas y desventajas de cada enfoque en diferentes escenarios.

2. Describe el proceso completo de configuración de un sitio web con autenticación básica en Apache, desde la creación del archivo de contraseñas hasta la configuración de las directivas necesarias, incluyendo consideraciones de seguridad.

3. Analiza el papel de los certificados digitales y el protocolo HTTPS en la seguridad de las comunicaciones web. Explica cómo funciona el proceso de verificación de un certificado y las implicaciones para la confianza del usuario.

4. Explora en profundidad el sistema de módulos de Apache, ilustrando con ejemplos cómo se utilizan diferentes módulos (como `mod_userdir`, `mod_dav`, `mod_auth_digest`) para extender la funcionalidad del servidor web.

5. Describe el proceso de configuración de un servidor WebDAV en Apache, incluyendo la activación de los módulos necesarios, la configuración de los permisos de acceso y la prueba de la funcionalidad mediante un cliente WebDAV.

---

## Glosario de Términos

- **DocumentRoot:** El directorio principal del sistema de archivos donde se almacenan los archivos de un sitio web.
- **Virtual Host:** Un método para alojar múltiples sitios web en un solo servidor, permitiendo que cada sitio tenga su propia configuración y contenido.
- **Directiva:** Una instrucción de configuración en Apache que define el comportamiento del servidor web.
- **mod_dir:** Módulo de Apache que gestiona la visualización de los archivos por defecto en un directorio.
- **mod_autoindex:** Módulo de Apache que muestra el listado de archivos de un directorio.
- **mod_negotiation:** Módulo de Apache que gestiona la negociación de contenido, como el idioma.
- **mod_cgi:** Módulo de Apache que permite ejecutar scripts CGI.
- **Alias:** Directiva que permite mapear una URL a un directorio fuera del `DocumentRoot`.
- **Redirección:** Proceso de enviar a un usuario de una URL a otra.
- **HTTP Status Code:** Código de tres dígitos que indica el resultado de una petición HTTP (ej: 301, 302, 404).
- **ErrorDocument:** Directiva que permite personalizar las páginas de error que se muestran a los usuarios.
- **Require:** Directiva en Apache 2.4 para controlar el acceso a recursos, basada en criterios como IP, usuario o grupo.
- **AuthType:** Directiva que define el tipo de autenticación a utilizar (ej: Basic, Digest).
- **AuthUserFile:** Directiva que especifica la ubicación del archivo que contiene la lista de usuarios y contraseñas.
- **mod_auth_basic:** Módulo que proporciona la funcionalidad de autenticación básica de Apache.
- **htpasswd:** Herramienta para generar archivos de contraseñas para la autenticación básica.
- **mod_auth_digest:** Módulo que proporciona la funcionalidad de autenticación "digest".
- **htdigest:** Herramienta para generar archivos de contraseñas para la autenticación "digest".
- **RequireAll:** Directiva que exige que todas las condiciones dentro del bloque se cumplan.
- **RequireAny:** Directiva que exige que al menos una condición dentro del bloque se cumpla.
- **TLS/SSL:** Protocolos criptográficos que proveen comunicación segura en la red. TLS es la evolución del protocolo SSL.
- **HTTPS:** Protocolo de transferencia segura de hipertexto que combina HTTP con TLS/SSL.
- **Certificado Digital:** Un archivo que verifica la identidad de un servidor web.
- **Autoridad Certificadora (CA):** Entidad que emite y gestiona certificados digitales.
- **mod_userdir:** Módulo de Apache que permite a los usuarios alojar sitios web personales en su directorio home.
- **WebDAV:** Un protocolo que permite la edición y versionado de documentos en un servidor web.
- **mod_dav:** Módulo de Apache que implementa el protocolo WebDAV.
- **mod_dav_fs:** Módulo que permite el acceso a archivos locales a través de WebDAV.
- **a2enmod:** Comando que activa un módulo de Apache.
- **a2dissite:** Comando que desactiva un sitio virtual de Apache.
- **apache2ctl:** Comando para gestionar el servidor web Apache.

