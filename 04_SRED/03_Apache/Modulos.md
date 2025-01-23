# Modulos de Apache

Apache es un sistema modular, nos permite añadir o eliminar características según queramos.

Estos se guardan en dos directorios:

* mods-available: Contiene los módulos instalados
* mods-enabled: Contiene los activos

Cada vez que se cambien los módulos usados se ha de reiniciar apache, igual que con los sitios virtuales.

`apache2ctl -M`: Muestra los módulos activos.

`apache2ctl -l`: Módulos que se cargan con apache2ctl (núcleo de apache)

## Modulo userdir

Userdir es un módulo de apache que hace posible que todos los usuarios con acceso a un servidor tengan una carpeta llamada public_html en la cual puedan alojar sus páginas y archivos.

## WebDav
WebDAV (“Edición y versionado distribuidos sobre la web“) es un protocolo para hacer que la www sea un medio legible y editable. 
Este protocolo proporciona funcionalidades para crear, cambiar y mover documentos en un servidor remoto (típicamente un servidor web).
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
