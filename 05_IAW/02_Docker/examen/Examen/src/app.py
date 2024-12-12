from flask import Flask, render_template, request, redirect, url_for
import os
import database as db
#prueba 5dic
template_dir = os.path.dirname(os.path.abspath(os.path.dirname(__file__)))
template_dir = os.path.join(template_dir, 'src', 'templates')

app = Flask(__name__, template_folder = template_dir)

# Funcion creada para que el error muestre la lista tambien
def loaddata():
    cursor = db.database.cursor()
    cursor.execute("SELECT * FROM bejarano")
    myresult = cursor.fetchall()
    #Convertir los datos a diccionario
    insertObject = []
    columnNames = [column[0] for column in cursor.description]
    for record in myresult:
        insertObject.append(dict(zip(columnNames, record)))
    cursor.close()
    return insertObject

#Rutas de la aplicación
@app.route('/')
def home():
    #Se ha movido el codigo de aqui a la funcion
    return render_template('index.html', data=loaddata())

# Excepcion ejercicio2 examen
def validate_num(valor):
    # Intenta convertir el valor a numero (en este caso nota)
    try:
        valor = int(valor)
    except ValueError:
        # Si falla (causando una excepcion) la funcion devuelve un bool falso
        return False
    else:
        # En caso contrario lo devuelve verdadero
        return True

## Fin vallidacion


#Ruta para guardar alumnos en la bdd
@app.route('/alumno', methods=['POST'])
def addAlumno():
    nombre = request.form['nombre']
    asignatura = request.form['asignatura']
    nota = request.form['nota']

    # En caso de que la funcion devuelva falso se le da texto al error y la ejecucion de addAlumno() se detiene, 
    # volviendo al render de la lista de registros de la bd.
    if not validate_num(nota):
        error = "La nota ha de ser un numero!!"
        # Devuelve el texto de error al html y se renderiza de nuevo la lista
        return render_template('index.html', error=error, data=loaddata())

    if nombre and asignatura and nota:
        cursor = db.database.cursor()
        sql = "INSERT INTO bejarano (nombre, asignatura, nota) VALUES (%s, %s, %s)"
        data = (nombre, asignatura, nota)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('home'))

@app.route('/delete/<string:id>')
def delete(id):
    cursor = db.database.cursor()
    sql = "DELETE FROM bejarano WHERE id=%s"
    data = (id,)
    cursor.execute(sql, data)
    db.database.commit()
    return redirect(url_for('home'))

@app.route('/edit/<string:id>', methods=['POST'])
def edit(id):
    nombre = request.form['nombre']
    asignatura = request.form['asignatura']
    nota = request.form['nota']

    if nombre and asignatura and nota:
        cursor = db.database.cursor()
        sql = "UPDATE bejarano SET nombre = %s, asignatura = %s, nota = %s WHERE id = %s"
        data = (nombre, asignatura, nota, id)
        cursor.execute(sql, data)
        db.database.commit()
    return redirect(url_for('home'))

## Mandar a Jugar
@app.route('/jugar', methods=['POST'])
def homeJugar():
    # Renderiza juega.html
    return render_template('juega.html')

@app.route('/jugando', methods=['POST'])
def jugar():
    num1 = request.form['num1']
    num2 = request.form['num2']
    if validate_num(num1) and validate_num(num2):
        num1=int(num1)
        num2=int(num2)
        if num1 > num2:
            numeroalto=num1
        elif num2 > num1:
            numeroalto=num2
        else:
            numeroalto=num1
    else:
        return render_template('juega.html', error="Numero no valido en alguno de los valores.")
    return render_template('juega.html',numeroalto=numeroalto)



if __name__ == '__main__':
    app.run(debug=True, port=5500)
