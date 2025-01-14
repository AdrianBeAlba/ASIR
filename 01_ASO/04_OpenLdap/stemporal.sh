#!/bin/bash
INPUT_FILE="temporal.txt"
while IFS= read -r line
do
    if [[ -n $(echo $line | grep uid:) ]]; then
        # Procesar solo las líneas que comienzan con "uid:"
        echo "$line"
    fi
done < $INPUT_FILE