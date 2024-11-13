## Entrar a sql
````sql
sqlplus /nolog
connect <usuario>[/<contraseña>][ as (sysdba/sysoper)]
````
## Promp
```sql
set sqlprompt 'Prompt';
clear screen;
```
## Consultas de diccionario
~~~sql
clear screen -- Limpia pantalla
SELECT TABLE_NAME FROM USER_TABLES /*TODAS LAS TABLAS PROPIEDAD DEL USUARIO CONECTADO A ORACLE*/
--TABLAS RELACIONADAS:
--DBA_TABLES: /* Todas las tablas de la base de datos*/
--ALL_TABLES: /* Todas las tablas accesibles por el usuario*/

SELECT * FROM USER_VIEWS /* VISTAS QUE ES PROPIEDAD DEL USUARIO CONECTADO*/
/*TABLAS RELACIONADAS:
DBA_VIEWS:  Todas las vistas de la base de datos.
ALL_VIEWS: Todas las vistas accesibles por el usuario.*/

SELECT * FROM  DBA_INDEXES /*CONSULTAR TODOS LOS  INDICES DE LA BASE DE DATOS*/
/*TABLAS RELACIONADAS
ALL_INDEXES: Todas los índices accesibles por el usuario conectado
USER_INDEXES:  Todos lo índices propiedad del usuario conectado.*/

SELECT * FROM  DBA_USERS; /*CONSULTAR  TODOS LOS USUARIOS DE LA BASE DE DATOS*/
~~~
## Instancia
~~~sql
-- Detener la instancia
--- Forma 1 no espera cerrar sesiones ni transacciones
SHUTDOWN immediate;
--- Forma 2 espera cerrar sesiones y transacciones
shutdown normal;
--- Forma 3 (poco recomendada) no espera a nada solo para la instancia. Obliga activar modo recuperación.
shutdown abort;
--- Forma 4 espera a transacciones pero no sesiones.
shutdown transactional;

-- Iniciamos la instancia
startup nomount;
--o
startup [pfile='<pfile_location>']
----Inicializa la base de datos sin montarla con PFILE
STARTUP NOMOUNT PFILE='<ruta_del_pfile>';
----Inicializa pero en modo restringido
STARTUP RESTRICT;

-- La montamos si hicimos nomount, coje el Control FIle del Pfile: app/oracle/oradata/ORCL/control/nombre.ctl
Alter database mount;

---La abrimos, usa los datos de los data file y rerdo log file app/oracle/oradata/ORCL/datafile/nombre.dbf y ../onlinelog/nombre
Alter database open;
-- Para solo lectura, tiene que estar cerrado
ALTER DATABASE OPEN READ ONLY;

-- Quitar modo restringido 
ALTER SYSTEM DISABLE RESTRICTED SESSION; /*o*/ ALTER SYSTEM ENABLE RESTRICTED SESSION; /*para activarlo otra vez*/

-- Modo quesieced, no cierra transacciones;
Alter system quiesce restricted;
Alter system  unquiesce; --Lo desactiva

--Suspender session;
Alter system suspend;
Alter system resume;
~~~
## Usuarios y permisos
~~~sql
-- Crear usuario
CREATE USER <nombreusuario> IDENTIFIED BY <contraseña>       
DEFAULT TABLESPACE <tablespace> --Normalmente users
TEMPORARY TABLESPACE TEMP
QUOTA <cifra K> ON <tablespace>;

-- Ver cuotas en tablespaces, o tablespace en especifico
select * from DBA_TS_QUOTAS [where tablespace_name ='tablespace'];

--- Cambiar cuota en un tablespace
ALTER USER <nombre_usuario> 
QUOTA <cifra K> ON <tablespace>;

-- Forzar cambio de contraseña
alter user <USUARIO>
password expire;

-- Comprueba existencia de un usuario
SELECT username, account_status FROM dba_users WHERE username = 'usuario';
-- Desbloquea usuario
ALTER USER <usuario> ACCOUNT UNLOCK;
-- Bloquea usuario
ALTER USER <usuario> ACCOUNT LOCK;
-- Consultar datos de tabla de otro usuario
select * from usuario.tabla;

-- Borrar usuario
drop user <usuario> [cascade]; -- Cascade borra sus tablas;

------Permisos--------
select * from dba_sys_privs where [grantee='usuario'];-- Ver permisos del sistema, se puede filtrar por usuario
select * from dba_tab_privs where [grantee='usuario'];-- Ver permisos de objetos
select grantee from dba_(sys/tab)_privs where privilege=<privilegio>;--Averiguar que usuarios de base de datos o que roles tienen asignado un privilegio
-- Otorgar permisos.
grant <privilegio> [<entidad>] to <usuario>; --Ej grant create table to scott;, "grant create to scott" le daria la posiblidad de crear cosas en general
-- Otorgar permisos de objeto
grant <privilegio> on <objeto> to <usuario>; -- Eje grant select on scott.dept to usuario1;

-- Otorgar permisos a todo el mundo.
grant <privilegio> [<entidad>] to public; 

-- Quitar permisos
revoke <privilegio> [<entidad>] from <usuario>;
revoke <privilegio> ok <tabla> from <usuario>;
~~~
| **Privilegio** | **Sentencia SQL Permitida**                      | **Objetos Afectados**                   |
|----------------|--------------------------------------------------|-----------------------------------------|
| **ALTER**      | `ALTER objeto`                                   | Tabla, Secuencia                       |
| **DELETE**     | `DELETE FROM objeto`                             | Tabla, Vista                           |
| **EXECUTE**    | `EXECUTE objeto`                                 | Procedimiento                          |
| **INDEX**      | `CREATE INDEX ON`                                | Sólo Tablas                            |
| **INSERT**     | `INSERT INTO objeto`                             | Tabla, Vista                           |
| **REFERENCES** | `CREATE` o `ALTER TABLE` (definir restricción de clave ajena) | Sólo Tablas                            |
| **SELECT**     | `SELECT ... FROM objeto`                         | Tabla, Vista                           |
| **UPDATE**     | `UPDATE objeto`                                  | Tabla, Vista                           |
## Roles y perfiles
~~~sql
------ Perfiles------
-- Comprobar perfiles de la base de datos 
select username, profile from dba_users order by username;
--Comprobar quien puede alterar perfiles
select * /*o grantee*/ from dba_sys_privs where privilege='ALTER PROFILE' or privilege='DROP PROFILE';
-- Dar permiso de alterar perfiles
grant alter profile to <usuario>;

-- Crear perfil
CREATE PROFILE <perfil> LIMIT -- Crea un perfil con el nombre <perfil> y establece límites para los usuarios asignados a este perfil.
  SESSIONS_PER_USER x -- Limita el número de sesiones concurrentes que un usuario puede tener. 'x' es el valor máximo de sesiones permitidas.
  CPU_PER_SESSION UNLIMITED -- Establece el tiempo máximo de CPU que una sesión puede consumir. 'UNLIMITED' significa que no hay límite en el uso de CPU por sesión.
  CPU_PER_CALL x -- Limita la cantidad de tiempo de CPU que se puede usar en una sola llamada de base de datos. 'x' es el valor máximo de CPU permitido por llamada.
  CONNECT_TIME x -- Limita el tiempo máximo (en minutos) que un usuario puede estar conectado a la base de datos. 'x' es el valor de tiempo en minutos.
  IDLE_TIME x  -- Define el tiempo máximo (en minutos) que una sesión puede permanecer inactiva (sin realizar ninguna operación) antes de ser desconectada. 'x' es el valor en minutos.
  FAILED_LOGIN_ATTEMPTS x -- Limita el número de intentos fallidos de inicio de sesión antes de que la cuenta sea bloqueada. 'x' es el número de intentos permitidos.
  PASSWORD_LIFE_TIME x; -- Establece el tiempo máximo (en días) que una contraseña de usuario puede ser válida. 'x' es el número de días hasta que la contraseña expire.

-- Cambiar perfil a usuario
alter user prueba00 profile desarrollo
-- Alterar perfil
ALTER PROFILE nombreperfil {parametrorecurso|parametrocontraseña}[valor [K|M]|UNLIMITED];
-- Borrar un perfil:
DROP PROFILE nombreperfil;
-- Fecha de bloqueo de una cuenta
select username, lock_date from dba_users where username like '<Usuario>';
/*Vistas del diccionario de datos para perfiles:
DBA_PROFILES: Muestra los perfiles existentes con sus límites.
DBA_USERS: Muestra los perfiles de los usuarios*/

-------Roles--------
--Para crear un rol: 
CREATE ROLE nombre; --NO PUEDE COINCIDIR CON NOMBRE DE USUARIO
--Para añadir privilegios: 
GRANT priv [ON obj] TO nombrerol;
--Para quitar privilegios: 
REVOKE priv FROM nombrerol;
--Para dárselo a un usuario; 
GRANT nombrerol TO usuario;
--Para quitárselo a un usuario: 
REVOKE nombrerol FROM usuario;
--Para borrarlo: 
DROP ROLE nombrerol;
--Para añadir un rol a otro: 
GRANT nombrerol TO nombrerol;

select * from DBA_ROLES -- Todos los roles de la BD.
select * from DBA_ROLE_PRIVS -- Roles concedidos a usuarios.
select * from ROLE_ROLE_PRIVS -- Roles concedidos a otros roles.
select * from ROLE_SYS_PRIVS -- Privilegios de sistema concedidos a los roles.
select * from ROLE_TAB_PRIVS -- Privilegios sobre objetos concedidos a los roles.
~~~
## Tablespaces e Indices
~~~sql
----Tablespaces----
--Creacion completa de tabla
CREATE TABLE nombretabla (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    fecha_creacion DATE DEFAULT SYSDATE
)
STORAGE (
    INITIAL 10M
    NEXT 5M
    PCTINCREASE 10
    MINEXTENTS 1
    MAXEXTENTS 50
)
TABLESPACE nombre_ts;---Definimos tablespace donde se encontrara la tabla

-- Creación de tablespace
CREATE [TEMPORARY|UNDO] TABLESPACE nombrets
[DATAFILE|TEMPFILE] ruta_absoluta_fichero [SIZE nº [K|M]][REUSE][AUTOEXTEND ON [NEXT K N][MAXSIZE n M]]
… (podemos añadir más ficheros separando con comas)...
[LOGGING|NOLOGGING]
[PERMANENT|TEMPORARY]
[DEFAULT STORAGE
(clausulas de almacenamiento)]
[extent management local uniform size k M;] -- Para temporales
[OFFLINE];

--Ejemplo
CREATE TEMPORARY TABLESPACE nombrets
    datafile '/ruta/a/tu/fichero/temp01.dbf' SIZE 100M REUSE AUTOEXTEND ON MAXSIZE 500M, datafile '/ruta/a/tu/fichero/temp02.dbf' SIZE 50M REUSE AUTOEXTEND ON MAXSIZE 500M
    DEFAULT STORAGE (
        INITIAL 10M
        NEXT 5M
        PCTINCREASE 10
        MINEXTENTS 1
        MAXEXTENTS 50
    )
--Para ponerlo OFFLINE (útil para restaurar o realizar ciertas operaciones):
ALTER TABLESPACE nombrets OFFLINE;
ALTER TABLESPACE nombrets Online;
--Para añadirle otro datafile solo en offline:
ALTER TABLESPACE nombrets ADD DATAFILE '/ruta/a/tu/fichero/temp03.dbf'
--Para cambiar la ruta de un fichero solo en offline:
ALTER TABLESPACE nombrets RENAME DATAFILE '/ruta/a/tu/fichero/temp01.dbf' TO '/ruta/a/tu/fichero/temp04.dbf'
--Para borrarlo:
DROP TABLESPACE nombrets [INCLUDING CONTENTS][AND DATAFILES];

-- Consultar tablespaces.
SELECT * FROM DBA_TABLESPACES;
-- VER QUOTAS DE TABLESPACES
SELECT USERNAME, TABLESPACE_NAME, MAX_BYTES FROM DBA_TS_QUOTAS WHERE USERNAME = '<USUARIO>';
-- Consultar por usuario
SELECT USERNAME, DEFAULT_TABLESPACE, temporary_tablespace FROM dba_users WHERE USERNAME = '<usuario>';
~~~
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
