#Definimos una fucion al que le pasamos la variable dia y la procesamos
def mostrar_mensaje(dia):
#Match nos permite revisar varias casuisticas de manera mas eficiente definiendo en cada case que resultado queremos, incluso definiendo un caso por defecto en "case _".
#Con return definimos que queremos que devuelva la funcion dependiendo de cada case
    match dia:
        case "LUNES":
            return "Hoy es lunes"
        case "VIERNES":
            return "Hoy es viernes"
        case "SABADO":
            return "Hoy es sábado"
        case "DOMINGO":
            return "Hoy es domingo"
        case _:
            return "Día inválido"
#El usuario escribe el dia y lo pasamos a mayuscula para normalizar los datos
dia_actual = input("Di un dia de la semana: ").upper()
#Imprimimos por pantalla el resultado de nuestra funcion al procesar el dia escrito por el cliente. De forma resumida, lo que nos devuelve "return" es lo que se imprime.
print(mostrar_mensaje(dia_actual))