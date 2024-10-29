# Roles

Son conjuntos de privilegios. Se pueden crear desde cero, pero hay algunos predefinidos. Los más importantes son:

* **CONNECT**
* **RESOURCE**
* **DBA**

Hay otros roles predefinidos para la realización de copias de seguridad, importaciones y exportaciones, etc...

~~~sql
--Para crear un rol: 
CREATE ROLE nombre;
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
~~~

Los roles se almacenan en varias tablas:

### Tablas de roles:

* **DBA_ROLES**: Todos los roles de la BD.
* **DBA_ROLE_PRIVS**: Roles concedidos a usuarios.
* **ROLE_ROLE_PRIVS**: Roles concedidos a otros roles.
* **ROLE_SYS_PRIVS**: Privilegios de sistema concedidos a los roles.
* **ROLE_TAB_PRIVS**: Privilegios sobre objetos concedidos a los roles.



[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
