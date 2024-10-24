# Perfiles

Un perfil es un conjunto de límites de uso de los recursos del sistema y/o un conjunto de características que debe cumplir una contraseña.

El perfil por defecto no establece ningún límite al uso de los recursos.

Los perfiles de usuario vienen deshabilitados al instalar ORACLE, para habilitarlos hay que usar el comando:
~~~sql
ALTER SYSTEM SET RESOURCE_LIMIT=TRUE;

-- La sintaxis para crear un perfil es la siguiente:

CREATE PROFILE nombreperfil LIMIT
{parametrorecurso | parametrocontraseña} [valor [K|M] | UNLIMITED]
{parametrorecurso | parametrocontraseña} [valor [K|M] | UNLIMITED]
~~~

## Parametros alterables

### Limite de recursos
---
* **SESSIONS_PER_USER**: Máximo número de sesiones concurrentes.
* **CONNECT_TIME**: Duración máxima de una sesión.
* **IDLE_TIME**: Máximo tiempo de inactividad del usuario.
* **CPU_PER_SESSION**: Tiempo máximo de uso de la CPU por sesión. En centésimas de segundo.
* **CPU_PER_CALL**: Tiempo máximo de uso de la CPU por llamada. En centésimas de segundo.
* **LOGICAL_READS_PER_SESSION**: Máximo nº de bloques de datos leídos en una sesión.
* **LOGICAL_READS_PER_CALL**: Tiempo máximo de uso de la CPU por sesión. En centésimas de segundo.
* **PRIVATE_SGA**: Cantidad de SGA para la sesión (para opción de procesos de servidor compartidos).
* **COMPOSITE_LIMIT**: Número adimensional basado en los límites anteriores.

### Contraseñas
---
* **FAILED_LOGIN_ATTEMPTS**: Número máximo de intentos fallidos antes de bloquear la cuenta.
* **CONNECT_TIME**: Duración máxima de una sesión.
* **PASSWORD_LIFE_TIME**: Número de días de vida de la contraseña.
* **PASSWORD_REUSE_TIME**: Número de días que deben transcurrir para reutilizar una contraseña.
* **PASSWORD_REUSE_MAX**: Número de veces que se debe cambiar una contraseña antes de reutilizarla
* **PASSWORD_LOCK_TIME**: Número de días que queda bloqueada la cuenta.
* **PASSWORD_GRACE_TIME**: Periodo de gracia de contraseñas caducadas.
* **PASSWORD_VERIFY_FUNCTION**: Función PL/SQL que dará el visto bueno a la complejidad de la contraseña.

## Comandos para perfiles
~~~sql
-- Para asignar un perfil a un usuario:
ALTER USER fulanito PROFILE nombreperfil;

-- Para modificar un perfil
ALTER PROFILE nombreperfil {parametrorecurso|parametrocontraseña}[valor [K|M]|UNLIMITED];

-- Para borrar un perfil:
DROP PROFILE nombreperfil;
~~~
Vistas del diccionario de datos:
DBA_PROFILES: Muestra los perfiles existentes con sus límites.
DBA_USERS: Muestra los perfiles de los usuarios