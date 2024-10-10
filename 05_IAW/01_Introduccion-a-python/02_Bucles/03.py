#Pedimos numero
numero=int(round(float(input("Dame un numero entero positivo: "))))
#Comprobamos que sea mayor a 0, si no lo notificamos
if(numero >= 0):
    #Establecemos variable dde bucle
    x=1
    #Mientras x sea menor o igual a numero ejecuta codigo
    while x<=numero:
        #Si el numero es impar imprimelo
        if x % 2 != 0:
            print(x)
        #Aumenta en 1 variable de bucle
        x += 1
else:
    print("Numero no valido")