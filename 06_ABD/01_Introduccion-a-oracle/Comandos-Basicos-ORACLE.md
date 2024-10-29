# Usuarios
~~~sql 
    -- Crear usuario
    CREATE USER usuario 
    IDENTIFIED BY contraseña
    [DEFAULT TABLESPACE nombre_ts]
    [TEMPORARY TABLESPACE nombre_ts_temp]
    [QUOTA {num {K | M} | UNLIMITED } ON nombre_ts]
    [PROFILE perfil];
~~~

### Comando para crear un usuario en SQL

#### `CREATE USER usuario IDENTIFIED BY contraseña`:
Crea un nuevo usuario llamado `usuario` en la base de datos y lo asocia con una contraseña específica definida como `contraseña`. Este es el primer paso para otorgar acceso a un nuevo usuario en la base de datos.

#### `[DEFAULT TABLESPACE nombre_ts]`:
Define el **tablespace predeterminado** para el usuario. Un tablespace es una estructura de almacenamiento en la base de datos donde se guardarán los objetos creados por el usuario, como tablas e índices. Si no se especifica, el usuario utilizará el tablespace predeterminado de la base de datos.
**Ejemplo**: Si especificas `DEFAULT TABLESPACE users_ts`, los objetos del usuario se almacenarán en el tablespace `users_ts`.

#### `[TEMPORARY TABLESPACE nombre_ts_temp]`:
Establece el **tablespace temporal** para el usuario. Este tablespace es utilizado por el usuario para operaciones temporales, como ordenar grandes conjuntos de datos o realizar operaciones JOIN. El tablespace temporal no guarda datos permanentemente.
**Ejemplo**: `TEMPORARY TABLESPACE temp_ts` asigna un tablespace temporal llamado `temp_ts` al usuario.

#### `[QUOTA {num {K | M} | UNLIMITED } ON nombre_ts]`:
Define la **cuota de almacenamiento** que el usuario puede utilizar en el tablespace especificado. El valor `num` define la cantidad de espacio en kilobytes (`K`) o megabytes (`M`) que el usuario puede usar en ese tablespace. También puedes especificar `UNLIMITED` si no deseas imponer un límite de espacio.
**Ejemplo**: `QUOTA 100M ON users_ts` limita al usuario a utilizar 100 MB en el tablespace `users_ts`.

#### `[PROFILE perfil]`:
Asigna un **perfil de recursos** al usuario. Los perfiles controlan los límites de uso de recursos y las políticas de seguridad, como la cantidad de intentos de inicio de sesión fallidos, tiempo máximo de conexión, uso de CPU, entre otros.
**Ejemplo**: `PROFILE dev_profile` asigna al usuario el perfil `dev_profile`, que podría establecer restricciones de tiempo de conexión o uso de recursos del sistema.

## Privilegios de usuarios
~~~sql
-- Ver privilegios de usuario.

select * from dba_sys_privs where grantee='USUARIO'; --Privilegios de sistema del usuario USUARIO.

select * from dba_tab_privs where grantee='USUARIO'; --Privilegios de objetos del usuario USUARIO.

-- Otorgar Privilegios
grant <PRIVILEGIO> to USUARIO;

-- Alterar usuarios
alter user USUARIO <PARAMETRO> <VALORES>;
---EJ:
alter user usuario quota on users;

~~~



[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
