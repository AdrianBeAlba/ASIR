# Script Para añadir usuarios
~~~ bash
#!/bin/bash

# Este script genera archivos LDIF para usuarios a partir de un archivo de datos.

# Variables de configuración
INPUT_FILE="script_usuarios/datos.txt" # Ruta al archivo con los datos de los usuarios
OUTPUT_DIR="script_usuarios"          # Carpeta donde se generarán los archivos LDIF
IMAGES_DIR="$OUTPUT_DIR/imagenes"    # Carpeta para almacenar las imágenes de los usuarios
UID_START=2006                        # Primer UID que se asignará a los usuarios
GID=2000                              # GID del grupo al que pertenecerán los usuarios
LDIF_FILE="$OUTPUT_DIR/ejercicio4.ldif" # Ruta del archivo LDIF que se generará

echo "" >$LDIF_FILE
# Verificar si el archivo de datos existe
if [ ! -f "$INPUT_FILE" ]; then
    echo "El archivo $INPUT_FILE no existe." # Mensaje de error si no encuentra el archivo
    exit 1                                   # Salida del script con código de error
fi

# Crear la carpeta de salida si no existe
mkdir -p "$OUTPUT_DIR" # Crea la carpeta para los archivos LDIF

# Inicializar el UID_NUMBER
UID_NUMBER=$UID_START # Inicializamos el primer UID en el valor de UID_START

# Leer el archivo datos.txt y procesar cada línea
while IFS="," read -r NOMBRE APELLIDO MAIL PHOTO USUARIO; do
    # Omitir la cabecera del archivo (la primera línea)
    if [ "$NOMBRE" = "Nombre" ]; then
        continue # Si el campo Nombre es igual a "Nombre", pasamos a la siguiente línea
    fi

    # Crear el archivo LDIF para el usuario
    cat <<EOL >> "$LDIF_FILE"
dn: uid=$USUARIO,ou=people,dc=megainfo202,dc=com
objectClass: top
objectClass: posixAccount
objectClass: inetOrgPerson
objectClass: shadowAccount
uid: $USUARIO
sn: $APELLIDO
givenName: $NOMBRE
cn: $NOMBRE $APELLIDO
uidNumber: $UID_NUMBER
gidNumber: $GID
userPassword: $(sudo slappasswd -h {MD5} -s $USUARIO)
homeDirectory: /home/$USUARIO
loginShell: /bin/bash
mail: $MAIL
jpegPhoto: < file: $PHOTO

EOL

    echo "Archivo LDIF generado: $LDIF_FILE" # Confirmación de que se generó el archivo

    # Incrementar el UID para el siguiente usuario
    UID_NUMBER=$((UID_NUMBER + 1)) # Sumar 1 al valor actual de UID_NUMBER

done < "$INPUT_FILE" # Cierra el bucle y termina de leer el archivo de datos

# Mensaje final al completar el proceso
echo "Proceso completado. Verifique la carpeta $OUTPUT_DIR para los archivos generados."
ldapadd -x -W -D cn=admin,dc=megainfo202,dc=com -f $LDIF_FILE
~~~