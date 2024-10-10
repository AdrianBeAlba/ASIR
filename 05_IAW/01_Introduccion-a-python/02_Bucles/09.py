# EJERCICIO 9: 
# Escribir un programa que pida al usuario una palabra y luego muestre por pantalla 
# una a una las letras de la palabra introducida empezando por la última.

palabra=input("Dame una palara: ")

for char in reversed(palabra):
    print(char)