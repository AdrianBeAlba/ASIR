#Definimos función.
def asistencia():
    #Lista de los alumnos.
    listaAlumnos=["Pepe", "Antonio","Jesus","Ilde", "Manuel", "Rodrigo"]
    #Asistencia a rellenar.
    listaAsistencia=[]
    #Buvle para asignar asistencia, solo admite s o n, sino vuelve a preguntar.
    for alumno in  listaAlumnos:
        siguiente=False
        while siguiente == False:
            asistencia=input(f"{alumno} esta presente? (s/n):")
            if asistencia== "s":
                listaAsistencia.append("Presente")
                siguiente=True
            elif asistencia== "n":
                listaAsistencia.append("No presente")
                siguiente=True
            else:
                print("No valido, solo s o n")
    #Por ultimo imprimimos lista con uso de un contador para poder linkear las listas.
    print("")
    print("ASISTENCIA")
    print("--------------------------------------------------------------")
    for x, alumno in enumerate(listaAlumnos):
        print(f"{alumno}: {listaAsistencia[x]}")
    print("--------------------------------------------------------------")

asistencia()