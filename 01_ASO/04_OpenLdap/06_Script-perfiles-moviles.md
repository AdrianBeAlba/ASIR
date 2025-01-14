# Script para crear perfiles móviles

Primero fuera del script introducimos este comando y eliminamos a juan del archivo resultante:

`sudo slapcat |grep -e "uid: " -e "uidNumber" -e "gidNumber" -e "homeDirectory" > temporal.txt`

~~~ bash
#!/bin/bash
INPUT_FILE="temporal.txt"
while IFS= read -r line
do
    
    echo "$line"

done < $INPUT_FILE
~~~