# Contenedores

Son alternativas rapidas y ligeras alas MVs. Utiliza el nucleo del sistema anfitrión lo que optimiza recursos.

Los principales inconvenientes consisten en los SO compatibles, pues la tecnologia solo permite usar sistemas basados en linux.

Para crear contenedores necesitas crear una plantilla en proxmox, las plantillas se han de descargar. Las plantillas consisten en sistemas de ficheros que se copian, arrancando el so usando elkernel de proxmox que es linux. De ahi la limitacion de SO.

## Preparar plantillas

1. Entra en proxmox y selecciona uno de sus almacenamientos.
2. Ve a la seccion de "***CT Templates***"
3. Selecciona "***Templates***" y elije la plantilla que quieras descargar.
4. Una vez terminada la descarga (tienes que ver el *TASK OK*) puedes crear CTs con esa plantilla.

***Nota: puedes añadir mas templates manualmente, puedes descargarlos [aqui](http://download.proxmox.com/images/system/)***

## Caracteristicas

* Puedes añadir volumenes al  directorio del contenedor para aumentar el almacenamiento. Esto lo haces seleccionando el contenedor y añadienddo un punto de montaje, ahi puedes donde se monta el volumen en la maquina.



[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
