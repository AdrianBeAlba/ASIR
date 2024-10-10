#Definimos una funcion para llamarla con facilidad
def pregunta_tributaria():
    #Preguntamos valores a procesar
    edad=int(input("Di tu edad: "))
    dinero=int(input("Cuanto cobras?: "))
    #Si tienes 16 años y cobras 1000 mensuales tributas, si una de las condicionales no se cumple en el and el resultado sera falso, por lo que pasa al else.
    if (edad >= 16 and dinero >= 1000):
        print("Tributas")
    else:
        print("No tributas")
#Llamamos a la funcion
pregunta_tributaria()