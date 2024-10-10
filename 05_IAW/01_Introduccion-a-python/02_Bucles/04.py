# EJERCICIO 4: 
# Escribir un programa que pida al usuario un número entero positivo y muestre por 
# pantalla la cuenta atrás desde ese número hasta cero separados por comas.

numero=int(round(float(input("Dame un numero entero positivo: "))))
#Comprobamos mayor a 0, si no lo notificamos
if(numero >= 0):
    #Establecemos variable de bucle
    x=0
    #Mientras numero sea mayor o igual a x ejecuta codigo
    while x<=numero:
        print(numero)
        numero -= 1
else:
    print("Numero no valido")