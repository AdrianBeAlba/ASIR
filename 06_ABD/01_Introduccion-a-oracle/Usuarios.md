# Esquemas de usuario en ORACLE

En ORACLE se denomina esquema al conjunto de objetos que es propiedad de un usuario concreto.
Dichos objetos pueden ser tablas, vistas, índices, procedimientos, funciones, triggers, etc...

Es un planteamiento totalmente distinto al de MySQL, donde un esquema es, a grandes rasgos, una base de datos tal y como se entiende en un SGBD de escritorio.

## Creación, modificación y borrado de usuarios.

~~~sql
    CREATE USER fulanito
    IDENTIFIED BY contraseña
    [DEFAULT TABLESPACE nombre_ts]
    [TEMPORARY TABLESPACE nombre_ts_temp]
    [QUOTA {num {K | M} | UNLIMITED } ON nombre_ts]
    [PROFILE perfil];

    -- Para modificar:
    ALTER USER fulanito ...
    -- Para borrar:
    DROP USER fulanito [CASCADE];

~~~

Las vistas más importantes para un DBA con información de los usuarios son:

* DBA_USERS: Todos los usuarios de la BD.

* DBA_TS_QUOTAS: Cuotas de tablespace de los usuarios.

## Asignación y revocación de privilegios.

Hay dos tipos de privilegios: del **SISTEMA** y sobre **OBJETOS**.

Cuando a un usuario se le da un privilegio sobre un objeto, se le permite hacer algo con ese objeto.

~~~sql
    GRANT privilegio ON propietario.objeto TO [usuario | rol | PUBLIC]
    [WITH GRANT OPTION];

~~~ 

### Privilegios de Objeto
---
- **SELECT**: Permite leer datos de una tabla o vista.
- **INSERT**: Permite insertar nuevas filas en una tabla.
- **UPDATE**: Permite modificar datos existentes en una tabla.
- **DELETE**: Permite eliminar filas de una tabla.
- **ALTER**: Permite modificar la estructura de una tabla (por ejemplo, añadir o eliminar columnas).
- **EXECUTE**: Permite ejecutar procedimientos almacenados o funciones.
- **INDEX**: Permite crear y eliminar índices en las tablas para optimizar el rendimiento de las consultas.
- **REFERENCES**: Permite crear y modificar claves externas (foreign keys) que hacen referencia a otras tablas.
- **ALL**: Otorga todos los privilegios disponibles al usuario, incluyendo SELECT, INSERT, UPDATE, DELETE, etc.
 

### Privilegios de Sistema
---
Permiten realizar una determinada operación o ejecutar un comando concreto. Hay casi 100. Algunos son:

#### Privilegios de SQL para objetos
- **CREATE**: Permite crear un nuevo objeto (tabla, vista, índice, etc.) en la base de datos.
- **ALTER**: Permite modificar la estructura de un objeto existente, como una tabla o vista.
- **DROP**: Permite eliminar un objeto (tabla, vista, índice, etc.) de la base de datos.

#### Globales
- **CREATE ANY**: Permite crear cualquier tipo de objeto en la base de datos.
- **ALTER ANY**: Permite modificar cualquier tipo de objeto en la base de datos.
- **DROP ANY**: Permite eliminar cualquier tipo de objeto de la base de datos.

#### Privilegios sobre cualquier tabla
- **SELECT ANY TABLE**: Permite seleccionar datos de cualquier tabla en la base de datos.
- **INSERT ANY TABLE**: Permite insertar datos en cualquier tabla en la base de datos.
- **UPDATE ANY TABLE**: Permite actualizar datos en cualquier tabla en la base de datos.
- **DELETE ANY TABLE**: Permite eliminar datos de cualquier tabla en la base de datos.



[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
