# Instalación de Apache Directory Studio en una Máquina con Interfaz Gráfica

## 1. Introducción
Apache Directory Studio es una herramienta de administración de directorios LDAP basada en Eclipse. Se puede utilizar para gestionar servidores OpenLDAP de manera visual y sencilla. Esta guía explica cómo instalar Apache Directory Studio en un sistema operativo con interfaz gráfica.

## 2. Requisitos Previos
- Un sistema operativo con entorno gráfico.
- Conexión a internet.
- Java instalado en el sistema.

## 3. Instalación en Linux (Ubuntu/Debian con GUI)

### 3.1. Instalar Java
Apache Directory Studio requiere Java para ejecutarse. Para instalar Java, ejecute los siguientes comandos:

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
```

Verifique que Java esté instalado correctamente:

```bash
java -version
```

Debe mostrar una salida similar a:

```
openjdk version "17.0.x"
```

### 3.2. Descargar Apache Directory Studio
Descargue la última versión del software desde la página oficial de Apache:

```bash
wget https://dlcdn.apache.org/directory/studio/2.0.0.v20210717-M17/ApacheDirectoryStudio-2.0.0.v20210717-M17-linux.gtk.x86_64.tar.gz
```

### 3.3. Extraer e Instalar
Extraiga el archivo descargado:

```bash
tar -xvzf ApacheDirectoryStudio-2.0.0.v20210717-M17-linux.gtk.x86_64.tar.gz
```

Mueva la carpeta extraída a `/opt/`:

```bash
sudo mv ApacheDirectoryStudio /opt/apache-directory-studio
```

### 3.4. Crear un Acceso Directo
Para facilitar la ejecución del programa, cree un enlace simbólico:

```bash
sudo ln -s /opt/apache-directory-studio/ApacheDirectoryStudio /usr/local/bin/apache-directory-studio
```

Ahora puede ejecutar Apache Directory Studio con el siguiente comando:

```bash
apache-directory-studio
```

Si prefiere instalarlo en formato `.deb`, descárgelo desde la página oficial:
[Apache Directory Studio - Descargas](https://directory.apache.org/studio/downloads.html)

## 4. Instalación en Windows
1. Descargue Apache Directory Studio desde:
   [Apache Directory Studio - Descargas](https://directory.apache.org/studio/downloads.html)
2. Ejecute el instalador y siga las instrucciones.
3. Abra el programa y conéctese a su servidor LDAP.

## 5. Conectar Apache Directory Studio a un Servidor LDAP
1. **Abrir Apache Directory Studio**.
2. **Crear una nueva conexión LDAP** (`New LDAP Connection`).
3. Introducir los siguientes datos:
   - **Host:** `192.168.1.55` (o la IP de su servidor LDAP)
   - **Puerto:** `389`
   - **Encryption:** `No encryption` (o `SSL/TLS` si configuró LDAPS en el servidor)
   - **Bind DN or user:** `cn=admin,dc=barcelona,dc=techservices,dc=com`
   - **Password:** `(su contraseña de administrador de LDAP)`
4. **Guardar y conectar**.

Si la conexión es correcta, podrá ver y administrar las entradas de su servidor LDAP desde la interfaz de **Apache Directory Studio**.

---

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
