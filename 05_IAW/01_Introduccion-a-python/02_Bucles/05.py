# EJERCICIO 5: 
# Escribir un programa que pregunte al usuario una cantidad a invertir, el interés anual 
# y el número de años, y muestre por pantalla el capital obtenido en la inversión cada 
# año que dura la inversión.

numero=int(input("Dame un numero a invertir: "))
interes=int(input("Dame un interes anual: "))
anyos=int(input("Dame un numero años: "))

x=1
while x<=anyos:
    numero=round(numero+((numero*interes)/100),2)
    anyo=2024+x
    print(f"En el año {anyo} tendras {numero}€")
    x+=1