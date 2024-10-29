#!/bin/bash

# Mensaje de inicio
echo "Eliminando enlaces antiguos de navegación en archivos .md..."

# Recorre todos los archivos .md en el directorio actual y subdirectorios
find . -type f -name "*.md" | while read -r file; do
    # Elimina las líneas que contienen los enlaces de navegación especificados
    sed -i '/\[⬅️ Volver al índice\](.\/Index.md)/d' "$file"
    sed -i '/\[⬆️ Volver al README\](.\/README.md)/d' "$file"
    sed -i '/\[⬆️ Volver al README\](\/README.md)/d' "$file"
    echo "Limpiado: $file"
done

# Mensaje de finalización
echo "Limpieza de enlaces antiguos completada."
