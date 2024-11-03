# Introduccion a sistemas gestores de bases de datos (SGBD)

* Un **SGBD** es una **conexion de datos relacionados entre si**:
    * Datos estructuradoas y relacionados
    * Un conjunto de lenguajes y procedimientos
    * Permite a los usuarios acceder y gestionar los datos
* La coleccion de datos se denomina Base de datos (BD o DB)

### Funciones de un SGDB:
* Definicion (DDL)
* Manejo (DML)
* Control (DCL)

## Arquitectura de referencia para un SGBD

* 1975 **ANSY/SPARC** propone una arquitectura en tres niveles, esto con la intencio de separar el nivel de applicación con el nivel fisico:
    * Nivel interno o fisico:
        * Referencia el como estan almacenados los datos en el ordenador.
        * Describe la estructura de la BD por un **esquema interno**.
        * EJ: archivos, informacion y estructura de los mismos.
    * Nivel Conceptual:
        * Indica la estructura a partir de un **esquema conceptual** (Entidades con sus atributos y reglas)
        * Oculta los detalles de las estructuras fisicas de almacenamiento.
        * Representa la informacion de la BD.
    * Nivel externo/de visión:
        * Es el mas cercano a los usuarios.
        * Se definen varios esquemas externos.
        * Es la parte de la bd que interesa al usuario.

## Componentes de un SGDB

### Diccionario de datos
---
Consiste en el lugar donde se deposita información de los datos que forman la BD.

#### Proporciona info sobre:
* La estructura logica y fisica de la BD (definicion de datos, espacio asignado)
* Definicion de los objetos de la BD: tablas, vistas, indices,etc...
* Info de restricciones de integridad y que hacer si no se cumplen
* Cuentas y privilegios de usuarios
* Valores por defecto en columnas

#### Ha de cumplir:

* Soportar descripcciones de modelos conceptual, logico, interno y externo.
* Estar integrado en el SGBD.
* Transferencia de info entre modelos externo e interno (execution time).
* Almacenado en soporte de almacenamiento directo.

### Lenguajes
---
* Lenguaje de Definicion de Datos (**DDl**): 
    Especifica el esquema conceptual interno aka, vistasde usuario y estructuras fisicas de almacenamiento. Lo usan diseñadores y administradores.
* Lenguaje de Manipulacion de Datos(**DML**): 
    Realizar consultas, inserciones, modificaciones y eliminaciones de datos.
* Lenguaje de Control de Datos(**DCL**):
    Controla la ejecucion de transacciones y administra permisos.

***Transacción: Conjunto de instrucciones que se tienen que ejecutar de forma atomica o bien no ejecutarse.***

### Gestor
---
Conjunto de programas que se encargan de la seguridad, integridad y administración de la BD.

#### Maneja:
* Control de accesos.
* Implantación de restricciones de integridad.
* Copias de seguridad y restauración de estas.
* Recuperación de la BD en caso de daños.
* Asegurar acceso concurrente (mecanismo que conserva la consistencia cuando varios usuarios acceden a los datos a la vez).

## Administracion de un SGBD
Existen tres categorias de usuarios en Oracle:
* DBA: administrador, mayor nivel de privilegios.
* Resource: Tienen acceso a todos los objetos si tienen los permisos sobre estos, puede crear sus objetos.
* Connect: Lo mismo que el anterior, pero no puede crear objetos.

### Funciones del DBA:

* Instalar el SGBD.
* Crear las BDs.
* Mantener el esquema.
* Gestionar usuarios.
* Arrancar y parar el SGDB.
* Gestion de copias de seguridad.

## Arquitecturas de los SGDB
* Segun quien presta el Servicio:
    * Cliente/Servidor: Arquitectura orientada a generar servicios en un servidor a los que acceden uno o varios clientes.
    * Monolitica: Todos los componentes de una aplicacion enstan englobados en una unica base de datos.
* Segun la residencia fisica de las ocurrencias (entradas en una DB):
    * Distribuida: La base de datos se reparte en varios servidores o nodos.
    * Centralizado: Toda la base de datos se encuentra en un solo servidor.

## Modelos Lógicos de BD

### ¿Que es?
Un modelo de datos es una representación abstracta que permite simplificar y estructurar la información sobre el ***universo de discurso*** o el contexto específico del problema que se quiere resolver. 

Básicamente, el modelo de datos ayuda a organizar cómo se almacenará, estructurará y accederá a la información en la base de datos, de manera que refleje de manera fiel la realidad que se quiere representar.

### Estructura del modelo lógico
* Esquema conceptual: Diagrama entidad-relacion junto a las restricciones de información.
* Esquema logico: Esquema relacional + esquema relacional de vistas de los usuarios + restricciones de integridad.
* Esquema fisico: El script de creación de cada tabla y restricciones + programacion de reglas de negocio.

### Esquema fisico:
* Organización de datos y ficheros.
* Creacion de indices de busqueda.
* Posibilidad de introduccir redundancias controladas.
* Estimaciones del espacio en disco.
* Estimaciones del numero de accesos: tablas, ficheros, discos, clesters, etc...
* Acceso restringido a usuario.
* Eficiencia de las transacciones.
* Seguridad

Ejemplo:
~~~sql
CREATE TABLE empleado (ci NUMBER(8) CONSTRAINT pk_empleado PRIMARY KEY, nombre VARCHAR2(20) NOT NULL CONSTRAINT may CHECK (nombre=UPPER(nombre)), cargo VARCHAR2(9), jefe NUMBER CONSTRAINT fk_jefe REFERENCES empleado(ci), ingreso DATE, sueldo NUMBER(10,2), dpto NUMBER(2) NOT NULL CONSTRAINT fk_dpto REFERENCES depto(nro)
); 

CREATE TABLESPACE MD_DATA DATAFILE 'mddata01.dbf' SIZE 1000M, 'mddata02.dbf' SIZE 1000M AUTOEXTEND ON NEXT 5M MAXSIZE 200000M;
~~~

## SGBD Relacionales

### Codigo cerrado:
* Oracle: 
    * El mas veterano e influyente.
    * La mayoria de Mejoras de SQL se adaptaron a el.
    * De los mas utilizados.
    * Gran conexion con Java, son de la misma empresa.
    * Estable y escalable.
    * Control de transacciones.
    * Lenguaje PL/SQL.
    * Multiplataforma, compatible con distribuciones de linux.

### Codigo abierto:
* MySQL: 
    * Principal SGBD para programadores de codigo abierto.
    * El mas usado para aplicaciones Web.
    * Licencia GPL: permite a los usuarios usar, estudiar, modificar y distribuir software libremente. Obliga a productos creados con la licencia que se mantengan como GPL.
    * Completamente Multiplataforma.
* PostgreSQL: 
    * Licencia MIT: completamente libre.
    * Mas potente y estandarizado.
    * La mas potente de todos los gestores de codigo abierto.
* Firebird:
    * No muy escalable
    * Licencia MPL: Similar al GPL, pero permite combinar codigo propio con el producto original.

### Bases de datos no SQL
* Cuando se usan es por que se prefiere velocidad antes de intrgridad
* **Se saltan restricciones de integridad** y optan por sacar ingentes cantidades de datos lo antes posible.
* Se basa en el teorema **CAP**:
    * Consistencia (C)
    * Disponibilidad(A)
    * Tolerancia (P)

    Las bases de datos SQL no pueden garantizar A por lo que sacrifican C.

    En resumen: SQL= CP, NoSQL=AP.
    
* **No realizan JOINs**: no se validan relaciones entre otras tablas.
* **No utilizan SQL como lenguaje de consulta**, usan lenguajes de programacion para consultasy y xml o json para los metadatos.
* **Sirven para bases de datos mas simples**, con escasas reglas.
* **Clave/Valor**: Basicamente el sistema se estructura en indexes que combinan una clave con su valor. Los gestores mas conocidos son:
    * **Amazon Dynamo BD**: Creado para que amazon pueda gestionar su inmenso numero de transacciones.
    * **Google Big Table**: El modelo fisico se basa en google file sistem, los datos se estructuran en tres claves: fila, columna, fecha.
    * **Apache cassandra**: Es la mas popular y potente. A parte de ser de codigo abierto.
    * **Azure tables**: Creada para la computación en la nube de microsoft.
    * **Berkley DB**: Utilizada por su facilidad para comunicarse con cualquier lenguaje. Es de codigo abierto que permite uso comercial.
