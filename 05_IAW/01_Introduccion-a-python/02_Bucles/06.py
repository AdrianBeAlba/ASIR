# EJERCICIO 6: 
# Escribir un programa que muestre por pantalla la tabla de multiplicar del 1 al 10. 

x=1
y=1
while x<=10:
    while y<=10:
        print(f"{x}*{y} = {x*y}")
        y+=1
    x+=1
    y=1