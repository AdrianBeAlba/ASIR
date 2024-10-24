# PRACTICAS TEMA 7.

# USUARIOS, PERFILES, PRIVILEGIOS Y ROLES.

**1. Buscar en la documentación en línea y en bd el contenido de las vistas:**

- **dba_profiles**
- **dba_roles**
- **dba_users**
- **dba_role_privs**
- **dba_tab_privs**
- **dba_sys_privs**

- SQL> DESC DBA_PROFILES
- SQL> DESC DBA_ROLES
- SQL> DESC DBA_USERS
- SQL> DESC DBA_ROLE_PRIVS
- SQL> desc DBA_TAB_PRIVS
- SQL> DESC DBA_SYS_PRIVS

**2. Conectarse como usuario SYSTEM a la base y crear un usuario llamado “administrador” autentificado por la base de datos. Indicar como "tablespace" por defecto USERS y como "tablespace" temporal TEMP; asignar una cuota de 500K en el "tablespace" USERS.**

## SQL> CREATE USER ADMINISTRADOR IDENTIFIED BY ADMIN

## 2 DEFAULT TABLESPACE USERS

## 3 TEMPORARY TABLESPACE TEMP

## 4 QUOTA 500K ON USERS;

User created.

SQL> SELECT USERNAME FROM DBA_USERS WHERE USERNAME='ADMINISTRADOR';

## USERNAME

ADMINISTRADOR

**3. Abrir una sesión sqlplus e intentar conectarse como usuario**
**“administrador”, ¿qué sucede?, ¿por qué?.**

/u01/app/oracle/admin/CURSO01/creacion (CURSO01)> sqlplus

SQL\*Plus: Release 9.2.0.1.0 - Production on Mon Nov 22 12:50:48 2004

Copyright (c) 1982, 2002, Oracle Corporation. All rights reserved.

Enter user-name: administrador
Enter password:
ERROR:
ORA-01045: user ADMINISTRADOR lacks CREATE SESSION privilege; logon denied

**4. Averiguar qué privilegios de sistema, roles y privilegios sobre objetos tiene**
**concedidos el usuario “administrador”.**

SQL> select \* from dba_role_privs where grantee='ADMINISTRADOR';

no rows selected

SQL> select \* from dba_tab_privs where grantee='ADMINISTRADOR';

no rows selected

SQL> select \* from dba_sys_privs where grantee='ADMINISTRADOR';

no rows selected

**5. Otorgar el privilegio “CREATE SESSION” al usuario “administrador” e**
**intentar de nuevo la conexión sqlplus.**

SQL> grant create session to administrador;

Grant succeeded.

SQL> connect administrador
Enter password:
Connected.

**6. Conectarse como usuario “administrador” y crear un usuario llamado**
**“prueba00” que tenga como "tablespace" por defecto USERS y como**
**"tablespace" temporal TEMP; asignar una cuota de 0K en el "tablespace"**
**USERS. ¿Es posible hacerlo?.**

SQL> show user
USER is "ADMINISTRADOR"

SQL> r
1 create user prueba00 identified by prueba
2 default tablespace users
3 temporary tablespace temp
4\* quota 0k on users
create user prueba00 identified by prueba

- ERROR at line 1:
  ORA-01031: insufficient privileges

  **7. Conectado como usuario SYSTEM, otorgar el privilegio “create user” al**
  **usuario “administrador” y repetir el ejercicio anterior.**

/u01/app/oracle/admin/CURSO01 (CURSO01)> sqlplus

SQL\*Plus: Release 9.2.0.1.0 - Production on Mon Nov 22 12:55:31 2004

Copyright (c) 1982, 2002, Oracle Corporation. All rights reserved.

Enter user-name: system
Enter password:

Connected to:
Oracle9i Enterprise Edition Release 9.2.0.1.0 - Production
With the Partitioning and Oracle Label Security options
JServer Release 9.2.0.1.0 - Production

SQL> grant create user to administrador;

Grant succeeded.

SQL> connect administrador
Enter password:
Connected.

SQL> create user prueba00 identified by prueba
2 default tablespace users
3 temporary tablespace temp
4\* quota 0k on users

User created.

**8. Averiguar que usuarios de la base de datos tienen asignado el privilegio**
**“create user” de forma directa, ¿qué vista debe ser consultada?.**

SQL> connect system
Introduzca su clave:
Connected.

SQL> desc dba_sys_privs
Nombre ¿Nulo? Tipo

---

GRANTEE NOT NULL VARCHAR2(30)
PRIVILEGE NOT NULL VARCHAR2(40)
ADMIN_OPTION VARCHAR2(3)

SQL> select \* from dba_sys_privs where privilege ='CREATE USER';

GRANTEE PRIVILEGE ADM

---

DBA CREATE USER YES
ADMINISTRADOR CREATE USER NO
IMP_FULL_DATABASE CREATE USER NO

**9. Hacer lo mismo para el privilegio “create session”.**

SQL> select \* from dba_sys_privs where privilege ='CREATE SESSION';

## GRANTEE PRIVILEGE ADM

DBA CREATE SESSION YES
CONNECT CREATE SESSION NO
ADMINISTRADOR CREATE SESSION NO
RECOVERY_CATALOG_OWNER CREATE SESSION NO

**10.Crear dos "tablespace" llamados NOMINA y ACADEMO, que contendrán datos
relativos a las aplicaciones de nomina y datos académicos de los empleados
de una empresa, según las siguientes características:**

## ACADEMO NOMINA

```
Tamaño inicial 1M 1M
Autoextensible SI SI
Extensión 200K 100K
Tamaño
máximo
```

## 1400K 1500K

```
Parámetros
almacenamiento
```

```
Initial 16K 16K
```

```
Next 16K 16K
Minextents 1 1
Maxextents 3 3
```

```
Localización /u02/oradata/<bd> /u02/oradata/<bd>
```

**Consulte la ayuda en línea si no recuerda la sintaxis exacta de la
sentencia.**

SQL> create tablespace academo datafile '/u02/oradata/CURSO01/academo01.dbf'
size 1M
2 autoextend on next 200k maxsize 1400K
3 default storage (initial 16k next 16k
4 minextents 1 maxextents 3);

Tablespace created.

SQL> create tablespace nomina datafile '/u02/oradata/CURSO01/nomina01.dbf'
size 1M
2 autoextend on next 100K maxsize 1500K
3 default storage (initial 16k next 16k
4 minextents 1 maxextents 3);

Tablespace created.

**11.Crear dos "tablespace" temporales, manejados de forma local, llamados
TEMP_NOMINA y TEMP_ACADEMO con las siguientes características:**

## TEMP_ACADEMO TEMP_NOMINA

```
Tamaño inicial 500K 600K
Autoextensible SI SI
Extensión 50K 50K
Tamaño máximo 600K 700K
```

```
Localización /u04/oradata/<bd> /u04/oradata/<bd>
```

SQL> create temporary tablespace temp_academo
2 tempfile '/u04/oradata/CURSO01/temp_academo01.dbf'
3 size 500k autoextend on next 50k maxsize 600k
4 extent management local uniform size 100k;

Tablespace created.

SQL> create temporary tablespace temp_nomina
2 tempfile '/u04/oradata/CURSO01/temp_nomina01.dbf'
3 size 600k autoextend on next 50k maxsize 700k
4 extent management local uniform size 100k;

Tablespace created.

**12.Estando conectado como usuario “administrador” probar a crear un rol
llamado “administrador”, ¿qué ocurre?.**

SQL> connect administrador
Enter password:
Connected.

SQL> create role administrador;
create role administrador

- ERROR at line 1:
  ORA-01031: insufficient privileges

  **13.Idem estando conectado como usuario SYSTEM, ¿qué sucede?, ¿por qué?.**

SQL> connect system
Enter password:
Connected.

SQL> create role administrador;
create role administrador

- ERROR at line 1:
  ORA-01921: role name 'ADMINISTRADOR' conflicts with another user or role name

  **14.Comprobar en el diccionario de datos los usuarios o roles que poseen el
  privilegio “CREATE ROLE”.**

SQL> select \* from dba_sys_privs where privilege ='CREATE ROLE';

## GRANTEE PRIVILEGE ADM

DBA CREATE ROLE YES
IMP_FULL_DATABASE CREATE ROLE NO

**15.Crear un rol llamado “ADMIN”, asignarle los privilegios “create session”,
“create user” y “CREATE ROLE”. Asignarlo al usuario administrador.**

SQL> create role admin;

Role created.

SQL> grant create session to admin;

Grant succeeded.

SQL> c.session.user.
1* grant create user to admin
SQL> r
1* grant create user to admin

Grant succeeded.

SQL> c.user.role.

1* grant create role to admin
SQL> r
1* grant create role to admin

Grant succeeded.

SQL> grant admin to administrador;

Grant succeeded.

**16.Consultar los privilegios de sistema que tiene asignados de forma directa el
usuario “administrador”, revocarlos y asignarle el rol “admin.”.**

SQL> select \* from dba_sys_privs where grantee ='ADMINISTRADOR'

## GRANTEE PRIVILEGE ADM

ADMINISTRADOR CREATE SESSION NO
ADMINISTRADOR CREATE USER NO

SQL> revoke create session from administrador;

Revoke succeeded.

SQL> c.session.user.
1* revoke create user from administrador
SQL> r
1* revoke create user from administrador

Revoke succeeded.

SQL> grant admin to administrador;

Grant succeeded.

**17.Crear, conectado como SYSTEM, un usuario llamado “prueba01” autenticado
por base de datos al que no se le asigne "tablespace" por defecto ni
temporal.**

SQL> create user prueba01 identified by prueba01;

User created.

**18.Consultar en las vistas correspondientes los "tablespaces" y la quota en cada
uno de ellos que tiene los usuarios SYS, SYSTEM, “administrador”,
“prueba00” y “prueba01”. ¿Qué ha ocurrido con el usuario “prueba01”?.**

SQL> select substr(username,1,15) usuario, DEFAULT_TABLESPACE ,
TEMPORARY_TABLESPACE
2 from dba_users
3 where username in ('SYS','SYSTEM','ADMINISTRADOR','PRUEBA00','PRUEBA01');

## USUARIO DEFAULT_TABLESPACETEMPORARY_TABLESPACE

PRUEBA01 SYSTEM SYSTEM
PRUEBA00 USERS TEMP
ADMINISTRADOR USERS TEMP
SYSTEM SYSTEM TEMP
SYS SYSTEM TEMP

SQL> select substr(username,1,15) usuario, tablespace_name, max_bytes from
dba_ts_quotas where username in
('SYS','SYSTEM','ADMINISTRADOR','PRUEBA00','PRUEBA01')

## USUARIO TABLESPACE_NAME MAX_BYTES

ADMINISTRADOR USERS 512000

**19.Crear un usuario llamado “prueba02” autenticado por base de datos,
asignando como "tablespace" por defecto NOMINA y como "tablespace"
temporal TEMP_NOMINA (no se le asignara cuota en NOMINA).**

SQL> create user prueba02 identified by prueba
2 default tablespace nomina
3 temporary tablespace temp_nomina;

User created.

**20.Asignar al usuario “prueba01” los "tablespace" ACADEMO y TEMP_ACADEMO
como "tablespace" de trabajo y temporal respectivamente (sin especificar
cuota).**

SQL> alter user prueba01 temporary tablespace temp_academo;

User altered.

SQL> alter user prueba01 default tablespace academo;

User altered.

**21.Consultar en las vistas correspondientes los "tablespace" y la cuota en cada
uno de ellos que tiene los usuarios “prueba01” y “prueba02”.**

SQL> select \* from dba_ts_quotas where username in ('PRUEBA01','PRUEBA02');

no rows selected

**22.Crear un rol llamado “CONEXIÓN” y asignarle el permiso “CREATE SESSION”.**

SQL> create role conexion;

Role created.

SQL> grant create session to conexion;

Grant succeeded.

**23.Asignar el rol “CONEXIÓN” a los usuarios “prueba00”, “prueba01” y
“prueba02”.**

SQL> grant conexion to prueba00, prueba01, prueba02;

Grant succeeded.

**24.Comprobar en la vista correspondiente cuales son los roles asignados a los
usuarios “prueba00”, “prueba01” y “prueba02”.**

SQL> select \* from dba_role_privs where grantee in
('PRUEBA00','PRUEBA01','PRUEBA02');

## GRANTEE GRANTED_ROLE ADM DEF

PRUEBA00 CONEXION NO YES

## PRUEBA01 CONEXION NO YES

## PRUEBA02 CONEXION NO YES

**25.Conectarse como usuario “prueba01” y crear la tabla siguiente en el
"tablespace" ACADEMO:**

```
CREATE TABLE CODIGOS
(CODIGO varchar2(3),
DESCRIPCION varchar2(20))
TABLESPACE ACADEMO
STORAGE (INITIAL 64K
NEXT 64K
MINEXTENTS 5
MAXEXTENTS 10);
```

```
¿Es posible hacerlo?, ¿falta algún permiso?.
```

SQL> connect prueba
Enter password:
Connected.

SQL> CREATE TABLE CODIGOS
2 (CODIGO varchar2(3),
3 DESCRIPCION varchar2(20))
4 TABLESPACE ACADEMO
5 STORAGE (INITIAL 64K
6 NEXT 64K
7 MINEXTENTS 5
8\* MAXEXTENTS 10)
CREATE TABLE CODIGOS

- ERROR at line 1:
  ORA-01031: insufficient privileges

  **26.Crear un rol llamado “DESARROLLO” y asignarle los permisos "CREATE
  SEQUENCE", "CREATE SESSION", "CREATE SYNONYM", "CREATE TABLE" y
  "CREATE VIEW". Asignar el rol “DESARROLLO” a los usuarios “prueba00”,
  “prueba01” y “prueba02”.**

SQL> connect system
Enter password:
Connected.

SQL> create role desarrollo;

Role created.

SQL> grant create sequence, create session, create synonym, create table, create
view to desarrollo;

Grant succeeded.

SQL> grant desarrollo to prueba00, prueba01, prueba02;

Grant succeeded.

**27.Volver a conectarse como usuario “prueba01” y crear la tabla anterior en el
"tablespace" ACADEMO.**

SQL> connect prueba
Introduzca su clave:
Connected.

SQL> CREATE TABLE CODIGOS
2 (CODIGO varchar2(3),
3 DESCRIPCION varchar2(20))
4 TABLESPACE ACADEMO
5 STORAGE (INITIAL 64K
6 NEXT 64K
7 MINEXTENTS 5
8\* MAXEXTENTS 10)
CREATE TABLE CODIGOS

- ERROR at line 1:
  ORA-01950: no privileges on tablespace 'ACADEMO'

  **28.Asignar cuota ilimitada al usuario “prueba01” en el "tablespace" ACADEMO.
  Volver a repetir el ejercicio 26.**

SQL> connect system
Enter password:
Connected.

SQL> alter user prueba01 quota unlimited on academo;

User altered.

SQL> connect prueba
Enter password:
Connected.

SQL> CREATE TABLE CODIGOS
(CODIGO varchar2(3),
DESCRIPCION varchar2(20))
TABLESPACE ACADEMO
STORAGE (INITIAL 64K
NEXT 64K
MINEXTENTS 5
MAXEXTENTS 10);

Table created.

**29.Asignar cuota ilimitada al usuario “prueba02” en el "tablespace" NOMINA.**

SQL> connect system
Introduzca su clave:
Connected.

SQL> alter user prueba02 quota unlimited on academo;

User altered.

**30.Obtener información sobre roles, privilegios de sistema, "tablespace" y
cuotas para los usuarios “prueba00”, “prueba01” y “prueba02”.**

SQL> select \* from dba_role_privs where grantee in
('PRUEBA00','PRUEBA01','PRUEBA02');

## GRANTEE GRANTED_ROLE ADM DEF

PRUEBA00 CONEXION NO YES
PRUEBA00 DESARROLLO NO YES
PRUEBA01 CONEXION NO YES
PRUEBA01 DESARROLLO NO YES
PRUEBA02 CONEXION NO YES
PRUEBA02 DESARROLLO NO YES

6 rows selected.

SQL> select \* from dba_sys_privs where grantee in
('PRUEBA00','PRUEBA01','PRUEBA02');

no rows selected

SQL> select USERNAME , TABLESPACE_NAME , BYTES from dba_ts_quotas where
username in ('PRUEBA00','PRUEBA01','PRUEBA02');

## USERNAME TABLESPACE_NAME BYTES

PRUEBA02 ACADEMO 0
PRUEBA01 ACADEMO 327680

**31.Asignar cuota cero en el "tablespace" por defecto para el usuario
“prueba01”, ¿siguen estando sus objetos?, ¿es posible crear algún otro?
(probad a crear un tabla).**

SQL> alter user prueba01 quota 0k on academo;

User altered.

SQL> select owner, table_name from dba_tables where owner='PRUEBA01';

OWNER TABLE_NAME

---

PRUEBA01 CODIGOS

SQL> connect prueba
Enter password:
Connected.

SQL> CREATE TABLE CODIGOS2(CODIGO varchar2(3),
DESCRIPCION varchar2(20))
TABLESPACE ACADEMO
STORAGE (INITIAL 64K
NEXT 64K
MINEXTENTS 5
MAXEXTENTS 10);
CREATE TABLE CODIGOS2(CODIGO varchar2(3),

- ERROR at line 1:

ORA-01536: space quota exceeded for tablespace 'ACADEMO'

**32.Conectarse como usuario “prueba01” e intentar modificar su cuota en el
"tablespace" ACADEMO, ¿es posible?.**

SQL> connect prueba
Introduzca su clave:
Connected.

SQL> alter user prueba01 quota unlimited on academo;
alter user prueba01 quota unlimited on academo

- ERROR at line 1:
  ORA-01031: insufficient privileges

33. **Conectarse como usuario “prueba01” y modificar su clave, ¿es posible?.**

SQL> alter user prueba01 identified by probando01;

User altered.

**34.Averiguar que usuarios o roles de base de datos tienen asignado el privilegio
ALTER USER.**

SQL> connect system
Introduzca su clave:
Conectado.

SQL> select \* from dba_sys_privs where privilege='ALTER USER';

## GRANTEE PRIVILEGE ADM

DBA ALTER USER YES

**35.Abrir una sesión con el usuario “administrador” y otra con el usuario
“prueba02”. Siendo el usuario “administrador”, intentar borrar el usuario
“prueba02”.**

SQL> show user
USER es "SYSTEM"

SQL> drop user prueba02;
drop user prueba

- ERROR en línea 1:
  ORA-01940: no se puede borrar un usuario conectado actualmente

  **36.Asignar el permiso DROP USER al rol ADMIN.**

SQL> grant drop user to admin;

Grant succeeded.

**37.Averiguar que usuarios o roles de base de datos tienen asignado el privilegio
DROP USER.**

SQL> select \* from dba_sys_privs where privilege='DROP USER';

## GRANTEE PRIVILEGE ADM

ADMIN DROP USER NO
DBA DROP USER YES
IMP_FULL_DATABASE DROP USER NO

**38.Conectado como usuario "administrador", crear el usuario “prueba03”
autentificado por base de datos y asignando cuotas en el "tablespace"
ACADEMO (500K) y NOMINA (200K). Su "tablespace" temporal será TEMP.**

SQL> connect administrador
Enter password:
Connected.

SQL> create user prueba03 identified by prueba

default tablespace academo
temporary tablespace temp
quota 500k on academo
quota 200k on nomina

User created.

**39.Comprobar en el fichero de inicialización si está activado el modo de
limitación de recursos.**

Editar con el editor vi, por ejemplo, el fichero de inicializacion.

**40.Averiguar que usuarios de base de datos o que roles tienen asignado el
privilegio “CREATE PROFILE”.**

SQL> connect system
Enter password:
Connected.
SQL> select \* from dba_sys_privs where privilege='CREATE PROFILE';

## GRANTEE PRIVILEGE ADM

DBA CREATE PROFILE YES
IMP_FULL_DATABASE CREATE PROFILE NO

**41.Asignar el permiso “CREATE PROFILE” al rol ADMIN.**

SQL> grant create profile to admin;

Grant succeeded.

**42.Averiguar que perfiles están definidos en la base de datos y que límites de
recursos fija cada uno de ellos.**

SQL> select substr(profile,1,12) perfil, substr(resource_name,1,25) recurso,
resource_type, substr(limit,1,10) limite from dba_profiles order by profile,
resource_name;

## PERFIL RECURSO RESOURCE LIMITE

## ---------------------------------------------------------------------------------------

## DEFAULT COMPOSITE_LIMIT KERNEL UNLIMITED

## DEFAULT CONNECT_TIME KERNEL UNLIMITED

## DEFAULT CPU_PER_CALL KERNEL UNLIMITED

## DEFAULT CPU_PER_SESSION KERNEL UNLIMITED

## DEFAULT FAILED_LOGIN_ATTEMPTS PASSWORD UNLIMITED

## DEFAULT IDLE_TIME KERNEL UNLIMITED

## DEFAULT LOGICAL_READS_PER_CALL KERNEL UNLIMITED

## DEFAULT LOGICAL_READS_PER_SESSION KERNEL UNLIMITED

## DEFAULT PASSWORD_GRACE_TIME PASSWORD UNLIMITED

## DEFAULT PASSWORD_LIFE_TIME PASSWORD UNLIMITED

## DEFAULT PASSWORD_LOCK_TIME PASSWORD UNLIMITED

## DEFAULT PASSWORD_REUSE_MAX PASSWORD UNLIMITED

## DEFAULT PASSWORD_REUSE_TIME PASSWORD UNLIMITED

## DEFAULT PASSWORD_VERIFY_FUNCTION PASSWORD NULL

## DEFAULT PRIVATE_SGA KERNEL UNLIMITED

## DEFAULT SESSIONS_PER_USER KERNEL UNLIMITED

16 rows selected.

**43.Consultar que perfiles tiene asignados cada usuario de la base de datos.**

SQL> select username, profile from dba_users order by username;

## USERNAME PROFILE

ADMINISTRADOR DEFAULT
DBSNMP DEFAULT
OUTLN DEFAULT
PRUEBA00 DEFAULT
PRUEBA01 DEFAULT
PRUEBA03 DEFAULT
SCOTT DEFAULT
SYS DEFAULT
SYSTEM DEFAULT

9 rows selected.

**44.Crear un perfil llamado “DESARROLLO” con las siguientes especificaciones:**

```
Sessions_per_user 2
Cpu_per_session unlimited
Cpu_per_call 6000
Connect_time 480
Idle_time 2
Failed_login_attempts 2
Password_life_time 120
```

SQL> create profile desarrollo limit sessions_per_user 2 cpu_per_session unlimited
cpu_per_call 6000 connect_time 480 idle_time 2 failed_login_attempts 2
password_life_time 120;

Profile created.

**45.Asignar el perfil anterior a los usuarios “prueba00”, “prueba01”,
“prueba02” y “prueba03”.**

SQL> alter user prueba00 profile desarrollo;

User altered.

SQL> c.00.
1* alter user prueba01 profile desarrollo
SQL> r
1* alter user prueba01 profile desarrollo

User altered.

SQL> c.01.
1* alter user prueba02 profile desarrollo
SQL> r
1* alter user prueba02 profile desarrollo

User altered.

SQL> c.02.
1* alter user prueba03 profile desarrollo
SQL> r
1* alter user prueba03 profile desarrollo

User altered.

**46.Intentar la conexión dos veces como usuario “prueba01” fallando la
contraseña, ¿qué sucede?. Comprobar si la cuenta ha sido bloqueada en la
vista de base de datos correspondiente.**

SQL> connect prueba
Enter password:
ERROR:
ORA-01017: invalid username/password; logon denied

Warning: You are no longer connected to ORACLE.

...

SQL> connect prueba
Enter password:
ERROR:
ORA-28000: the account is locked

SQL> select username, lock_date from dba_users where username like 'PRUEBA%';

## USERNAME LOCK_DATE

PRUEBA
PRUEBA
PRUEBA01 22-NOV-

**47.Crear un usuario “prueba04” con el parámetro “password expire”, sus
"tablespace" por defecto y temporal serán USERS (cuota 0k) y TEMP. Asignar
los roles CONEXIÓN y DESARROLLO. Conectarse como usuario “prueba04”,
¿qué sucede?.**

SQL> create user prueba04 identified by prueba
2 default tablespace users
3 temporary tablespace temp
4 quota 0k on users
5\* password expire

User created.

SQL> grant conexion, desarrollo to prueba04;

Grant succeeded.

SQL> connect prueba04
Enter password:
ERROR:
ORA-28001: the password has expired

Changing password for prueba04
New password:
Retype new password:
Password changed
Connected.

**48.Bloquear la cuenta del usuario “prueba04”, ¿qué sucede al conectarse de
nuevo?.**

SQL> connect system
Enter password:
Connected.

SQL> alter user prueba04 account lock;

User altered.

SQL> connect prueba04
Enter password:
ERROR:
ORA-28000: the account is locked

Warning: You are no longer connected to ORACLE.

**49.Modificar el "tablespace" por defecto y el temporal del usuario “prueba01”
de forma que sean NOMINA y TEMP_NOMINA.**

SQL> connect system
Enter password:
Connected.

SQL> alter user prueba04 default tablespace nomina;

User altered.

SQL> alter user prueba04 temporary tablespace temp_nomina;

User altered.

**50.Comprobar cual es el valor del parámetro OS_AUTHENT_PREFIX en la base
de datos.**

Editar con vi o ejecutar la sentencia pg sobre el fichero de parametros de
inicializacion (init<SID>.ora).

**51.Cambia la identificación del usuario “prueba01” de forma que sea
identificado por el sistema operativo.**

```
SQL> alter user prueba01 identified externally;
```

```
User altered.
```

```
SQL> set head off
SQL> select * from dba_users where username='PRUEBA01'
```

```
PRUEBA01 26 EXTERNAL
LOCKED(TIMED) 22-NOV-04 22-MAR-05
ACADEMO TEMP_ACADEMO 22-NOV-04
DESARROLLO DEFAULT_CONSUMER_GROUP
```

**52.Modificar el parámetro OS_AUTHENT_PREFIX de forma que, en adelante, la
cadena que identifique a un usuario externo sea “” (cadena vacía).**

Editar con vi o ejecutar la sentencia pg sobre el fichero de parametros de
inicializacion (init<SID>.ora). Indicar:

```
os_authent_prefix = ""
```

**53.Desbloquear la cuenta del usuario “prueba04”.**

SQL> alter user prueba03 account unlock;

**54.Modificar los valores del perfil DEFAULT según se indica en la siguiente
tabla:**

```
Sessions_per_user 5
Cpu_per_session unlimited
Cpu_per_call 6000
Connect_time 480
Idle_time 60
Failed_login_attempts 3
Password_life_time 180
```

```
SQL> alter profile default
2 limit
3 sessions_per_user 5
4 cpu_per_session unlimited
5 cpu_per_call 6000
6 connect_time 480
7 idle_time 60
8 failed_login_attempts 3
9 password_life_time 180;
```

```
Profile altered.
```

**55.Averiguar que usuarios o roles tienen asignado el privilegio “ALTER
PROFILE”.**

```
SQL> select * from dba_sys_privs where privilege='ALTER PROFILE';
```

```
GRANTEE PRIVILEGE ADM
----------------------------------------------------------------------
DBA ALTER PROFILE YES
```

**56.Asignar el privilegio anterior al rol ADMIN.**

```
SQL> grant alter profile to admin;
```

```
Grant succeeded.
```

**57.Comprobar los valores asignados al perfil “DESARROLLO”. Modificar el perfil
“DESARROLLO”, desde el usuario “administrador”, según la siguiente tabla:**

```
Sessions_per_user 5
Connect_time DEFAULT
Idle_time 30
```

**¿Qué ha sucedido con el resto de los parámetros?. ¿Coincide el valor de
“Connect_time” en este perfil con el que tiene en el perfil DEFAULT?.**

SQL> select profile, substr(resource_name,1,25) nombre_recurso,
substr(limit,1,20) limite from dba_profiles where profile = 'DESARROLLO';

```
PROFILE NOMBRE_RECURSO LIMITE
----------------------------------------------------------------------------------------------
DESARROLLO COMPOSITE_LIMIT DEFAULT
DESARROLLO SESSIONS_PER_USER 2
DESARROLLO CPU_PER_SESSION UNLIMITED
DESARROLLO CPU_PER_CALL 6000
DESARROLLO LOGICAL_READS_PER_SESSION DEFAULT
DESARROLLO LOGICAL_READS_PER_CALL DEFAULT
DESARROLLO IDLE_TIME 2
DESARROLLO CONNECT_TIME 480
DESARROLLO PRIVATE_SGA DEFAULT
DESARROLLO FAILED_LOGIN_ATTEMPTS 2
DESARROLLO PASSWORD_LIFE_TIME 120
DESARROLLO PASSWORD_REUSE_TIME DEFAULT
DESARROLLO PASSWORD_REUSE_MAX DEFAULT
DESARROLLO PASSWORD_VERIFY_FUNCTION DEFAULT
DESARROLLO PASSWORD_LOCK_TIME DEFAULT
DESARROLLO PASSWORD_GRACE_TIME DEFAULT
```

```
16 rows selected.
```

```
SQL> alter profile desarrollo
2 limit SESSIONS_PER_USER 5
3 connect_time default
4 idle_time 30;
```

```
Profile altered.
```

**58.Averiguar los privilegios de sistema y sobre objetos, así como los roles, que
tiene asignados los roles por defecto “CONNECT”, “RESOURCE”, “DBA”,
“EXP_FULL_DATABASE” e “IMP_FULL_DATABASE”.
¿Considera una buena política de seguridad asignar el rol “CONNECT” a
todos los usuarios que precisan conectarse a la base de datos?.**

SQL> select \* from dba_role_privs where grantee in
('CONNECT','RESOURCE','DBA','EXP_FULL_DATABASE','IMP_FULL_DATABASE') order by
grantee, granted_role

## GRANTEE GRANTED_ROLE ADM DEF

## -----------------------------------------------------------------------------------------------

## DBA DELETE_CATALOG_ROLE YES YES

## DBA EXECUTE_CATALOG_ROLE YES YES

## DBA EXP_FULL_DATABASE NO YES

## DBA GATHER_SYSTEM_STATISTICS NO YES

## DBA IMP_FULL_DATABASE NO YES

## DBA SELECT_CATALOG_ROLE YES YES

## EXP_FULL_DATABASE EXECUTE_CATALOG_ROLE NO YES

## EXP_FULL_DATABASE SELECT_CATALOG_ROLE NO YES

## IMP_FULL_DATABASE EXECUTE_CATALOG_ROLE NO YES

## IMP_FULL_DATABASE SELECT_CATALOG_ROLE NO YES

```
10 rows selected.
```

SQL> select \* from dba_sys_privs where grantee in
('CONNECT','RESOURCE','DBA','EXP_FULL_DATABASE','IMP_FULL_DATABASE') order by
grantee,privilege;

```
GRANTEE PRIVILEGE ADM
------------------------------------------------------------------------------------------
CONNECT ALTER SESSION NO
CONNECT CREATE CLUSTER NO
CONNECT CREATE DATABASE LINK NO
CONNECT CREATE SEQUENCE NO
CONNECT CREATE SESSION NO
CONNECT CREATE SYNONYM NO
CONNECT CREATE TABLE NO
CONNECT CREATE VIEW NO
DBA ADMINISTER DATABASE TRIGGER YES
DBA ADMINISTER RESOURCE MANAGER YES
DBA
```

## ...

SQL> select grantee, table_name, privilege from dba_tab_privs where grantee
in ('CONNECT','RESOURCE','DBA','EXP_FULL_DATABASE','IMP_FULL_DATABASE') order
by grantee, table_name, privilege

```
DBA DBMS_DEFER_QUERY EXECUTE
```

```
DBA DBMS_DEFER_SYS EXECUTE
```

**59.¿Puede asignarse el perfil “DESARROLLO” al rol “CONNECT”?. ¿Y el perfil
“DEFAULT” al perfil “DESARROLLO”?:**

```
No.
```

**60.Averiguar que usuarios o roles de la base de datos tienen asignado el
privilegio “DROP PROFILE”.**

```
SQL> select * from dba_sys_privs where privilege='DROP PROFILE';
```

```
GRANTEE PRIVILEGE ADM
--------------------------------------------------------------------------------
DBA DROP PROFILE YES
IMP_FULL_DATABASE DROP PROFILE NO
```

**61.Asignar el privilegio “DROP PROFILE” al rol “ADMIN.”.**

```
SQL> grant drop profile to admin;
```

```
Grant succeeded.
```

**62.Conectarse como usuario “administrador” e intentar eliminar el perfil
“DEFAULT”, ¿qué ocurre?.**

```
SQL> connect administrador
Enter password:
Connected.
```

```
SQL> drop profile default;
drop profile default
*
ERROR at line 1:
ORA-00931: missing identifier
```

```
SQL> drop profile default cascade;
drop profile default cascade
*
ERROR at line 1:
ORA-00931: missing identifier
```

**63.Como usuario “administrador” crear el rol “SECRETO” identificado por la
contraseña “total” y asignarlo al usuario “prueba04”.**

```
SQL> connect administrador
Enter password:
Connected.
```

```
SQL> create role secreto identified by total;
```

```
Role created.
```

```
SQL> grant secreto to prueba04;
```

```
Grant succeeded.
```

**64.Averiguar que usuarios poseen el privilegio “ALTER ANY ROLE” (de forma
directa o a través de roles).**

```
SQL> select * from dba_sys_privs where privilege='ALTER ANY ROLE';
```

```
DBA ALTER ANY ROLE YES
```

**65.¿Qué valor tiene en la base de datos el parámetro MAX_ENABLED_ROLES?.
Modificar su valor para que, en adelante, valga 40. Comprobar esta
modificacion.**

```
SQL> show parameters max_enabled_roles
```

```
max_enabled_roles integer 30
```

**66.Averiguar que usuarios poseen el privilegio “GRANT ANY ROLE” (de forma
directa o a través de roles).**

```
SQL> select * from dba_sys_privs where privilege='GRANT ANY ROLE';
```

```
DBA GRANT ANY ROLE YES
```

**67.Como usuario “administrador”, deasignar el rol “SECRETO” al usuario
“prueba04”.**

```
SQL> revoke secreto from prueba04;
```

```
Revoke succeeded.
```

**68.Asignar el privilegio “GRANT ANY ROLE” al rol “ADMIN.”.**

```
SQL> connect system
Enter password:
Connected.
```

```
SQL> grant grant any role to admin;
```

```
Grant succeeded.
```

**69.Averiguar de nuevo que usuarios poseen el privilegio “GRANT ANY ROLE” (de
forma directa o a través de roles).**

```
SQL> select * from dba_sys_privs where privilege='GRANT ANY ROLE';
```

## ADMIN GRANT ANY ROLE NO

## DBA GRANT ANY ROLE YES

**70.Averiguar que usuarios poseen el privilegio “DROP ANY ROLE” (de forma
directa o a través de roles).**

```
SQL> select * from dba_sys_privs where privilege='DROP ANY ROLE';
```

```
DBA DROP ANY ROLE YES
IMP_FULL_DATABASE DROP ANY ROLE NO
```

**71.Asignar permiso de conexión al usuario "prueba03", asignar el rol “SECRETO”
al mismo usuario. Conectarse como este usuario e intentar borrar el rol.**

```
SQL> connect system
Enter password:
Connected.
```

```
SQL> grant conexion to prueba03;
```

```
Grant succeeded.
```

```
SQL> grant secreto to prueba03;
```

```
Grant succeeded.
```

```
SQL> connect prueba03
Enter password:
Connected.
```

```
SQL> drop role secreto;
drop role secreto
*
ERROR at line 1:
ORA-01031: insufficient privileges
```

**72.En caso de que no lo tenga asignado, asignar el rol “CONEXION” y el rol
“DESARROLLO” al usuario “prueba04”. Hacer que solo el rol “CONEXIÓN”
este activo cuando se conecte.**

SQL> select \* from dba_role_privs where grantee='PRUEBA04';

## GRANTEE GRANTED_ROLE ADM DEF

PRUEBA04 CONEXION NO YES
PRUEBA04 DESARROLLO NO YES

SQL> alter user prueba04 default role conexion;

User altered.

**73.Comprobar en la vista apropiada del diccionario de datos los roles activos en
la sesión.**

SQL> select \* from dba_role_privs where grantee='PRUEBA04';

## GRANTEE GRANTED_ROLE ADM DEF

PRUEBA04 CONEXION NO YES
PRUEBA04 DESARROLLO NO NO

**74.Conectado como usuario “prueba04”, activar el rol “DESARROLLO” y
comprobar de nuevo en la vista apropiada del diccionario de datos los roles
activos en la sesión.**

SQL> connect prueba04
Enter password:
Connected.

SQL> select \* from session_roles;

## ROLE

CONEXION

SQL> set role all;

Role set.

SQL> select \* from session_roles;

## ROLE

CONEXION
DESARROLLO

**75.Asignar el rol "CONNECT" al usuario "ADMIN". ¿Es preciso asignarle los
permisos "CREATE PROCEDURE", "CREATE PUBLIC SYNONYM", "CREATE ROLE",
"CREATE TRIGGER"?, ¿Los tiene ya asignados?.**

SQL> grant connect to admin;

Grant succeeded.

SQL> select \* from dba_sys_privs where grantee='CONNECT';

## GRANTEE PRIVILEGE ADM

- CONNECT CREATE VIEW NO
- CONNECT CREATE TABLE NO
- CONNECT ALTER SESSION NO
- CONNECT CREATE CLUSTER NO
- CONNECT CREATE SESSION NO
- CONNECT CREATE SYNONYM NO
- CONNECT CREATE SEQUENCE NO
- CONNECT CREATE DATABASE LINK NO

8 rows selected.

**76.Conectarse como usuario SYSTEM y otorgar al usuario "prueba02" el permiso
para seleccionar datos de la tabla códigos (pertenece al usuario "prueba01").
¿Qué sucede?, ¿por qué?.**

SQL> show user
USER es "SYSTEM"

SQL> grant select on prueba01.codigos to prueba02;
grant select on prueba01.codigos to prueba02

- ERROR en línea 1:

ORA-01031: privilegios insuficientes

**77.Conectarse como usuario "prueba01" y otorgar al usuario "prueba02" el
permiso para seleccionar datos de la tabla códigos; hacerlo de forma que
"prueba02" también pueda otorgar el permiso a otros usuarios (opción
ADMIN).**

SQL> connect prueba01
Introduzca su clave:
Connected.

SQL> grant select on prueba01.codigos to prueba02 with grant option;

Grant succeeded.

**78.Conectarse como usuario "prueba02" y otorgar al usuario "prueba03" el
permiso para seleccionar datos de la tabla códigos.**

SQL> connect prueba02
Enter password:
Connected.

SQL> grant select on prueba01.codigos to prueba03 ;

Grant succeeded.

SQL> connect prueba03
Enter password:
Connected.

SQL> select \* from prueba01.codigos;

no rows selected

**79.Conectarse como usuario "prueba01" y revocar al usuario "prueba02" el
permiso para seleccionar datos de la tabla códigos.**

SQL> connect prueba01
Enter password:
Connected.

SQL> revoke select on prueba01.codigos from prueba02;

Revoke succeeded.

**80.Conectarse como usuario "prueba03" e intentar consultar la tabla códigos.
¿Qué ocurre?, ¿por qué?.**

SQL> connect prueba03
Enter password:
Connected.

SQL> select _ from prueba01.codigos;
select _ from prueba01.codigos

- ERROR at line 1:
  ORA-00942: table or view does not exist
