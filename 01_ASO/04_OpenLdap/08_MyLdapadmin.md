# Instalación y Configuración de MyLDAPAdmin

## 1. Introducción
MyLDAPAdmin es una herramienta gráfica para la administración de directorios LDAP, facilitando la gestión de usuarios, grupos y atributos en entornos OpenLDAP.

## 2. Requisitos Previos
- Un servidor con **Debian** o **Ubuntu**.
- Un servidor **OpenLDAP** previamente instalado y configurado.
- Acceso con privilegios de superusuario (**root** o sudo).

## 3. Instalación de MyLDAPAdmin

### 3.1. Instalar dependencias necesarias
Ejecuta los siguientes comandos para instalar las dependencias:

```bash
sudo apt update
sudo apt install apache2 php php-ldap php-xml libapache2-mod-php
```

### 3.2. Descargar e Instalar MyLDAPAdmin
Descarga el paquete de MyLDAPAdmin desde el repositorio oficial:

```bash
wget https://sourceforge.net/projects/phpldapadmin/files/latest/download -O myldapadmin.tar.gz
```

Extrae el contenido y muévelo a la carpeta de Apache:

```bash
tar -xvzf myldapadmin.tar.gz
sudo mv phpldapadmin /var/www/html/myldapadmin
```

Otorga los permisos correctos:

```bash
sudo chown -R www-data:www-data /var/www/html/myldapadmin
sudo chmod -R 755 /var/www/html/myldapadmin
```

### 3.3. Configurar Apache
Habilita el sitio web y reinicia Apache:

```bash
sudo a2enmod rewrite
sudo systemctl restart apache2
```

## 4. Configuración de MyLDAPAdmin

### 4.1. Editar el Archivo de Configuración
Abre el archivo de configuración:

```bash
sudo nano /var/www/html/myldapadmin/config.php
```

Modifica las siguientes líneas según tu configuración de OpenLDAP:

```php
$servers->setValue('server','host','ldap://localhost');
$servers->setValue('server','base',array('dc=barcelona,dc=techservices,dc=com'));
$servers->setValue('login','bind_id','cn=admin,dc=barcelona,dc=techservices,dc=com');
```

Guarda los cambios (**Ctrl+X**, luego **Y** y Enter).

### 4.2. Reiniciar Apache

```bash
sudo systemctl restart apache2
```

### 4.3. Acceder a la Interfaz Web
Abre tu navegador y accede a:

```
http://localhost/myldapadmin
```

Inicia sesión con:
- **Usuario:** `cn=admin,dc=barcelona,dc=techservices,dc=com`
- **Contraseña:** *(la configurada en OpenLDAP)*

## 5. Funciones Básicas en MyLDAPAdmin

### 5.1. Buscar Objetos en LDAP
- Navega por la estructura de directorios en la interfaz web.
- Utiliza la barra de búsqueda para encontrar entradas específicas.

### 5.2. Modificar la Contraseña de un Usuario
1. Selecciona el usuario en la lista.
2. Edita el campo `userPassword`.
3. Guarda los cambios y confirma.

### 5.3. Crear un Nuevo Usuario
1. Dirígete a `Crear nueva entrada` → `Cuenta de Usuario`.
2. Introduce los datos del usuario.
3. Establece la contraseña y confirma.

### 5.4. Añadir un Atributo a un Usuario
1. Selecciona el usuario.
2. Agrega un nuevo atributo (Ejemplo: `email`).
3. Guarda los cambios.

### 5.5. Crear un Grupo en LDAP
1. Dirígete a `Crear nueva entrada` → `Grupo`.
2. Introduce el nombre del grupo.
3. Guarda los cambios.

### 5.6. Exportar Datos de LDAP
- Utiliza la opción de exportación en la interfaz para realizar copias de seguridad de usuarios y grupos.

## 6. Conclusión
Con esta instalación, MyLDAPAdmin queda listo para gestionar OpenLDAP de manera gráfica y sencilla. Si tienes problemas, revisa los logs de Apache:

```bash
sudo tail -f /var/log/apache2/error.log
```

¡Ahora puedes administrar tu servidor LDAP fácilmente desde el navegador! 🚀






[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
