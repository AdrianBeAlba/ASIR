#Solcicitar numero
#Equivalente a read, muestra texto por pantalla y permite escribir, lo escrito se guarda en la variable como int (numero) si es posible.
numero1 = int(input("introduce un numero: ")) 
numero2 = int(input("introduce otro numero: ")) 
#Comprobacion, dentro de los () se encuentra la condicion
if (numero1>numero2):
        #Todo lo tabulado a partir del : cuenta como resultado de que la condicional sea true
        #Si la condicional es = a Verdadero(true) ocurre lo siguiente
        print(f"La variable 2: {numero2} es el mas pequeno")
else:
        #Else sirve para definir que ocurre en caso de que la condicional (o condicionales) anterior es Falso(false)
        print(f"La variable 1: {numero1} es el mas pequeno")