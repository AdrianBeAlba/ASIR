#!/bin/bash

# Función para generar el índice en un directorio específico
generate_index() {
    local dir=$1
    local index_file="${dir}/Index.md"
    local parent_dir=$(dirname "$dir")

    # Omite la creación de Index.md en la carpeta raíz
    if [ "$dir" = "." ]; then
        return
    fi

    # Elimina el Index.md existente, si hay uno
    [ -f "$index_file" ] && rm "$index_file"

    # Inicia el contenido del archivo de índice
    echo "# Índice de $(basename "$dir")" > "$index_file"
    echo "" >> "$index_file"

    # Agrega enlaces a los directorios y archivos .md
    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            # Si es un directorio, añade un enlace a su Index.md
            echo "- [$(basename "$item")](./$(basename "$item")/Index.md)" >> "$index_file"
        elif [ -f "$item" ] && [ "${item##*.}" = "md" ] && [ "$(basename "$item")" != "Index.md" ]; then
            # Si es un archivo .md, añade un enlace directo
            echo "- [$(basename "$item")]($(basename "$item"))" >> "$index_file"
            # Añade navegación al inicio de cada documento que no es Index.md si no existe
            if ! grep -q "\[⬅️ Volver al índice\](./Index.md)" "$item"; then
                echo "" >> "$item"
                echo "[⬅️ Volver al índice](./Index.md)" >> "$item"
                echo "[⬆️ Volver al README](/README.md)" >> "$item"
            fi
        fi
    done

    # Añade los enlaces de navegación al final del archivo índice
    echo "" >> "$index_file"
    if [ "$parent_dir" != "." ]; then
        echo "- [⬅️ Volver al índice superior](../Index.md)" >> "$index_file"
    fi
    echo "- [⬆️ Volver al README](/README.md)" >> "$index_file"

    echo "Generado: $index_file"
}

# Función recursiva para navegar por todos los directorios
traverse_directories() {
    local dir=$1
    generate_index "$dir"
    for subdir in "$dir"/*; do
        if [ -d "$subdir" ]; then
            traverse_directories "$subdir"
        fi
    done
}

# Comienza en el directorio actual y recorre todos los subdirectorios
root_dir="."  # Puedes cambiar este valor por la ruta de inicio deseada
traverse_directories "$root_dir"

echo "Índices generados y actualizados."
