# EJERCICIO 7: 
# Escribir un programa que almacene la cadena de caracteres contraseña en una 
# variable, pregunte al usuario por la contraseña hasta que introduzca la contraseña 
# correcta.

PASSWD="casados2"

x=3
while x>0:
    usrtry=input("Introduce la contraseña: ")
    if usrtry==PASSWD:
        print("Bienvenido usuario.")
        break
    else:
        x-=1
        print(f"Contraseña incorrecta (Intentos restantes: {x})")
        