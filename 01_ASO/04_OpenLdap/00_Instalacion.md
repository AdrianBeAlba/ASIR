# Instalación y Configuración Básica de un Servidor LDAP (Ubuntu 22.04 o similar)

Un servidor LDAP (Lightweight Directory Access Protocol) es útil para gestionar y centralizar datos de usuarios, autenticación y permisos en redes. A continuación, te muestro los pasos básicos para instalar y configurar un servidor LDAP en un sistema basado en Linux, como Ubuntu o CentOS.

1. **Preparar el sistema**

Primero, asegúrate de que tu sistema esté actualizado:
~~~bash
sudo apt update && sudo apt upgrade -y

## Cambiar hostname
sudo hostnamectl set-hostname <host>
## Añadir a /etc/hosts
127.0.1.1 <host>.<dominio> <host>

~~~

**2. Instalar el servidor OpenLDAP y las herramientas necesarias**

Ejecuta el siguiente comando para instalar el servidor LDAP y sus herramientas:
~~~bash
apt install slapd ldap-utils  -y
~~~

**3. Configurar slapd**

Una vez instalada la herramienta, se inicia automáticamente el asistente de configuración. Si no aparece, puedes iniciarlo manualmente:

~~~bash
sudo dpkg-reconfigure slapd
~~~

Durante la configuración:

- Omitir configuración de la base de datos? → No
- Nombre de dominio DNS: → barcelona.teckservice.com
- Nombre de la organización: → TeckService
- Contraseña de administrador: → (Introduce una contraseña segura y confírmala)
- Base de datos backend: → MDB
- Eliminar la base de datos al purgar OpenLDAP? → No
- Mover la antigua base de datos? → Sí
- Habilitar el protocolo LDAPv2? → No

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
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
