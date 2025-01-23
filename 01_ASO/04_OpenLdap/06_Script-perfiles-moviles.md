# Script para crear perfiles móviles

Primero fuera del script introducimos este comando y eliminamos a juan del archivo resultante:

`sudo slapcat |grep -e "uid: " -e "uidNumber" -e "gidNumber" -e "homeDirectory" > temporal.txt`


[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
