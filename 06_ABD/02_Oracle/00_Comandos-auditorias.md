# Comandos
## Introduccion
~~~sql
connect sys as sysdba;

--Activamos auditorias
alter system set audit_trail='DB' scope=spfile;
--Reiniciamos para que tenga vigencia
shutdown inmmediate;
startup;
--Revision
show parameter Audit_trail;
~~~
## Opciones de auditorias y resultados
Para ver resultados de auditorias se usan las siguientes vistas
* DBA_AUDIT_TRAIL: entradas de la pista de auditorias
* DBA_AUDIT_OBJECTS: entradas sobre objetos, esquemas y privilegios
* DBA_AUDIT_SESSION: entradas sobre conexiones y desconexiones de la base de datos

Las vistas contienen información de las opciones de auditorias activas:

* ALL_DEF_AUDIT_OPTS: opciones por defecto
* ALL_STMT_AUDIT_OPTS: opciones de auditoria de sentencias
* DBA_PRIV_AUDIT_OPTS: opciones de auditorias de privilegios
* DBA_OBJ_AUDIT_OPTS: opciones de auditoria sobre objetos. Por ejemplo inserciones y updates.

### Ejemplo de insercion y updates
~~~sql
--Si queremos auditar todos los accesos a la tabla CLIENTES:
AUDIT SELECT, INSERT, UPDATE, DELETE ON SCOTT.CLIENTES;ç
--Para consultar qué auditoría está activa en la tabla:
SELECT * FROM DBA_OBJ_AUDIT_OPTS WHERE OWNER = 'SCOTT' AND OBJECT_NAME = 'CLIENTES';
--Para ver los registros auditados:
SELECT * FROM DBA_AUDIT_TRAIL WHERE OBJECT_NAME = 'CLIENTES';
~~~
## Aditorias de Inicio de Sesion
Esta opción audita cada intento de conectarse a la base de datos.
~~~sql
--Activar auditoria de sesion.
Audit Session;
--Para las conexiones correctas.
AUDIT SESSION WHENEVER SUCCESSFUL;
--Para las conexiones fallidas.
AUDIT SESSION WHENEVER NOT SUCCESSFUL;
--Dejar de auditar
Noaudit session;

-- Revisar auditoria
SELECT 
    OS_USERNAME,         -- Usuario del sistema operativo
    USERNAME,            -- Usuario de la base de datos
    TERMINAL,            -- Dispositivo desde el que se conectó
    TIMESTAMP,           -- Momento de inicio de la sesión
    LOGOFF_TIME,         -- Momento en que se cerró la sesión
    DECODE(RETURNCODE, 
        '0', 'CONECTADO', 
        '1005', 'NO TECLEÓ CLAVE', 
        '1017', 'USUARIO O CLAVE ERRÓNEA', 
        RETURNCODE) AS ESTADO_CONEXION  -- Interpretación de códigos de error
FROM DBA_AUDIT_SESSION;

--Version simplificado sin interpretar codigos de error
SELECT OS_USERNAME, USERNAME, TERMINAL, TIMESTAMP, LOGOFF_TIME, RETURNCODE 
FROM DBA_AUDIT_SESSION;
~~~

## Auditorias de sentencias y privilegios
Esta auditoria contempla cualquier accion que afecte a un objeto (tabla, tablespace, sinonimo, usuario, indice, etc,...).

~~~sql
--Audita todas las sentencias relacionadas con roles
Audit role;
--Audita las sentencias relacionadas con usuarios
Audit User;

--Revisar registros de la auditoria de sentencias y privilegios
select * from audit_actions;

--El formato para activar las opciones de auditoría de privilegios o sentencias es el siguiente:
AUDIT {sentencia | privilegio_de_sistema}[,{sentencia | privilegio_de_sistema}]...
[BY usuario [, usuario ]...]
--By session indica que el registro de auditoría se escribe una sola vez por sesión (éste es el valor por defecto), by acces genera muchas entradas se usa poco.
[BY {SESSION | ACCESS} ] 
[WHENEVER [NOT] SUCCESSFUL] --especifica que la auditoría se lleva a cabo cuando se completen las sentencias SQL de forma correcta o incorrecta, el valor por defecto incluye las dos opciones

--Ejemplo
AUDIT CREATE TABLE BY SCOTT;
--Despeus de crear una tabla con scott podemos comprobarlo
SELECT TERMINAL, OWNER, USERNAME, OBJ_NAME, TO_CHAR(TIMESTAMP,'DD/MON/YY HH24:MI:SS'), RETURNCODE, ACTION_NAME FROM DBA_AUDIT_OBJECT;
~~~
## Auditoria de objetos
Se pueden registrar las acciones que ocurren sobre objetos especificos como tablas
~~~sql
--Sentencia
AUDIT sentencia [,sentencia]...
ON {[esquema.]objeto | DEFAULT}
[BY {SESSION | ACCESS} ]
[WHENEVER [NOT] SUCCESSFUL]

-- Ejemplo
AUDIT INSERT ON SCOTT.NUEEMPLE; 
--Despues de realizar inserciones podemo comprobbar la auditoria asi
SELECT TERMINAL, OWNER, OBJ_NAME, TO_CHAR(TIMESTAMP,'DD/MON/YY HH24:MI:SS'), ACTION_NAME FROM DBA_AUDIT_OBJECT WHERE USERNAME='SCOTT';
~~~