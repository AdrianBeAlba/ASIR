# Instalación y Configuración Básica de un Servidor LDAP (Ubuntu 22.04 o similar)

Un servidor LDAP (Lightweight Directory Access Protocol) es útil para gestionar y centralizar datos de usuarios, autenticación y permisos en redes. A continuación, te muestro los pasos básicos para instalar y configurar un servidor LDAP en un sistema basado en Linux, como Ubuntu o CentOS.

1. **Actualizar el sistema**

Primero, asegúrate de que tu sistema esté actualizado:
~~~bash
sudo apt update && sudo apt upgrade -y
~~~

**2. Instalar el servidor OpenLDAP y las herramientas necesarias**

Ejecuta el siguiente comando para instalar el servidor LDAP y sus herramientas:
~~~bash
apt install libnss-ldap libpam-ldap ldap-utils nscd -y
~~~

**3. Configurar slapd**

Una vez instalada la herramienta, se inicia automáticamente el asistente de configuración. Si no aparece, puedes iniciarlo manualmente:

~~~bash
sudo dpkg-reconfigure slapd
~~~

Durante la configuración:

Nombre de dominio (DNS): Introduce el nombre de tu dominio. Por ejemplo, si tu dominio es example.com, el DN base será dc=example,dc=com.

Contraseña del administrador (admin): Configura una contraseña para el usuario administrador (cn=admin).

Estructura de base de datos: Selecciona la opción por defecto (MDB).

Purgar la base de datos al eliminar slapd: Generalmente, selecciona "No".

Habilitar compatibilidad con ldif: Selecciona "Sí".

**4. Verificar la instalación**

Una vez completada la configuración, verifica que el servidor LDAP esté funcionando:

~~~bash
sudo systemctl status slapd
~~~

Debe mostrarse como "active (running)".

**5. Probar la conexión LDAP**

Puedes usar el comando ldapsearch para probar la conexión al servidor:

~~~bash
ldapsearch -x -LLL -H ldap:/// -b dc=example,dc=com
~~~

Sustituye dc=example,dc=com por tu dominio base configurado.