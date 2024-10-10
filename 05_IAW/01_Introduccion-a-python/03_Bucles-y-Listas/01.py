#Funcion con el flujo
def tienda():
    x=False #Variable controladora del bucle.
    #Definimos listas con items y stock
    listaTienda=["a","s"]
    listaStock=[12,13]
    #Iniciamos un Bucle indefinido
    while (x!=True):
        #Establecemos una opcion inicial por defecto
        opcion="x"
        #Imprimimos por pantalla las distintas opciones para el usuario
        print("1.- Añadir producto o stock")
        print("2.- Eliminar unidades de un producto.")
        print("3.- Mostrar inventario.")
        print("4.- Salir.")
        opcion=int(input("Elige una opcion: "))
        
        #Iniciamos un case paa manejar cada una de las opciones
        match opcion:
            case 1:
                #Variable que recoge si el producto esta en lista
                enlista=False

                #Obtenemos el item que el cliente añade o modifica.
                nuevoItem=input("Indica el producto a añadir/ya existente (O escriba 'n4' para salir): ")
                #Si el usuario desea salir de esta opcion solo ha dde escribir n4
                if nuevoItem=="n4":
                    print("Volviendo a opciones")
                else:
                    for y, item in enumerate(listaTienda):
                        #Comprobamos si existe producto con el mismo nombre, normalizamos texto para facilitar comparación.
                        if item.lower() == nuevoItem.lower():
                            enlista=True
                            break
                    # Si existe sumamos stock a la posicion de stock asociada al producto
                    if enlista==True:
                        stock = int(input(f"Producto en la lista, indica stock a sumar (stock actual {listaStock[y]}): "))
                        listaStock[y] += stock
                    #Si no existe simplemente añadimos producto y stock al final de las listas
                    else:
                        stock = int(input("Producto no existente, creando nuevo, indica stock:"))
                        listaTienda.append(nuevoItem)
                        listaStock.append(stock)
            case 2:
                #Si la lista esta vacia sale del flujo y notifica al usuario.
                if not listaTienda:
                        print("Lista vacia añade antes un producto")
                else:
                    #Hacemos una comprobación similar que en el caso 1
                    enlista=False
                    while enlista==False:
                        itemT=input("Indica el nombre del producto a reducir (Escribe 'n4' para salir): ")
                        if itemT=="n4":
                            print("Volviendo a opciones")
                            break
                        else:
                            for y, item in enumerate(listaTienda):
                                if item.lower() == itemT.lower():
                                    enlista=True
                                    break
                            #En caso de estar el producto en la lista reducimos su stock.
                            if enlista==True:
                                stock = int(input(f"Producto en la lista, indica stock a reducir (stock actual {listaStock[y]}): "))
                                listaStock[y] -= stock
                            #Si no existe, pide uno que exista
                            else:
                                print("Producto no existente, vuelve a intentarlo (O escriba 'n4' para salir)")
            case 3:
                if len(listaTienda)!= 0:
                    #Imprimimos cada item con su stock
                    print("Listado de items-------------------------------------")
                    #Con ennumerate podemos recibir el stock tambien, como en los casos anteriores
                    for y, item in enumerate(listaTienda):
                        print(f"{y+1}:- {item}: {listaStock[y]} productos en stock")
                    print("-----------------------------------------------------")
                else:
                    print("Lista vacia añade antes un producto")
            case 4:
                x=True 
            case _:
                print("Opción no valida")

tienda()