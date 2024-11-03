# 01_Arquitectura de oracle

## Perspectiva logica de la BD
Con la base de datos creada habrá algunos archivos fisicos que se podran ver, esto es la perspectiva fisica.

Usando SQLPLUS, los objetos de la bd que veremos son tablas, vistas y procedimientes, la perspectiva logica de la BD, esta nace de una lectura de la fisica.

### Distribucion de schemas
* Los objetos son propiedad de los usuarios que los creo.
* Todos los objetos creados por un usuario forman un esquema.
* El nombre del esquema es el del usuario.
* Nombres de los objetos en el esquema:
    * Tenemos que referirnos a ellos por el nombre del usuario que los creo.
    * Ejemplo:
        ~~~sql
        select columna from usuario.tabla;
        ~~~
Ver objetos, ejemplo:
~~~sql
--Cuáles son las columnas de la tabla del sistema OBJ$ cuyo nombre = EMP
Select name from COL$ where obj# in (select obj# from obj$ where name ='EMP'); 
~~~

### Esquemas y repositorios
* El usuario SYS tiene propiedad de los objetos de diccionarios y es propietario de los schemas.
* Todos los objetos se distribuyen en esquemas
* El objetivo es diferenciar el punto de vista logico cn los repositorios o sub-BDs.
* Estos ultimos poseen sus squemas y usuarios.
* Permite tener varias aplicaciones usando las mismas tablas pero en squemas diferentes segun permisos.
* Todos los objetos son propiedad del user que creo el Objeto.
* La distribucion en schemas permite la separación administrativa de la BD.

## Diccionario de la base de datos

### Metadatos
Al crear una tabla hay que definir todos sus componentes, con sus tipos de datos, restricciones, propietario, etc...

Esta informacion se les llama metadatos y contienen la definicion de la estructura de los objetos

Los metadatos es de lo que se compone el diccionario en la BD.

### Tablas del sistema
Son tablas del squema de sys y se crean en el momento de creacion de la base de datos.

Estas tablas nos permiten crear mas informacion dentro de la base de datos, no deben de ser alteradas.

### Vistas del diccionario
El diccionario de datos esta compuesto por los metadatos, en resumidas cuentas son datos sobre los datos. 

En el diccionario se describe la BD:
* De manera fisica.
* De manera logica.
* El contenido.
* Información de supervision del rendimiento

Tambien contiene desde la version 10 de oracle:
* Definiciones de usuario.
* Seguridad de la informacion.
* Restricciones de integridad.

El diccionario se almacena en un conjunto de segmentos en los Tablespaces SYSTEM y SYSTEMAUX.

***Tablespace: Unidad logica de almacenamiento en una BD de oracle. Sirve como puente entre el sistema de ficheros del SO y la BD.***

Los segmentis que componen un diccionario son como los demas en la bd, tablas e indices, la unica diferencia es que estos datos no permiten el acceso directo, en caso de que los datos se alteren se pueden causar daños.

La creación del diccionario es pase del proceso de creacion de la DB, tambien se crean entradas al realizar CREATE TABLE/USER o GRANT.


#### Clases de vistas:
* Vistas de rendimiento:
    * Proporcionan info de funcionamiento de la BD
    * Hay mas de 300
    * Son referenciadas con los prefijos $V y $GV.
    * Estan siendo constantemente actualizadas por oracle.
    * Son esenciales para realizar diagnosticos de rendimiento.
    * Ejemplos de vistas:
    ~~~sql
    desc v$instance; --(no hace falta; instrucción sqlplus);
    select status, instance_name from v$instance;
    desc v$database; --información de la base de datos a la que estamos conectada
    ~~~

* Vistas estructuradas de objetos:
    * Permiten acceder a las tablas del diccionarios y conocer datos estructurales.
    * Estas tablas son conocidas como estaticas.
    * Sollo cambian con ciertos eventos transaccionales.
    * Se categorizan en tres grupos:
        * DBA_: info sobre tablas
        ~~~sql
        SQL>Desc dba_tables; --Todas las tablas que hay en esta base de datos.
        SQL>Select * from  dba_tables; --En esta vista encontraré toda las tablas de las base de datos. Sólo lo puede usar un usuario que sea dba.  Para cada objeto habrá un dba, dba_index…
        SQL>Desc dba_views; --Vistas de todas las base de datos.
        --El primer campo es owner, el propietario.
        ~~~
        * User_: Puede ejecutarlo cualquier usuario, pero solo veran las entradas que sean de su propieded
        ~~~sql
        --Nos conectamos como Scott.
        --Tiene acceso a su vista user_tables.
        Desc user_tables
        --Observad que no tiene el campo owner porque todo es de propiedad de Scott.
        Select table_name from user_tables: --Salen los que sean propiedad de él.
        ~~~
        * ALL_: Sirve para ver aquellos objetos que eres propietario y objetos sobre los que tienes permisos.
    * En sqlplus hay una vista dictionary que nos puede ayudar.
    ~~~sql
    Desc dictionary; --Dentro de dictionary quiero encontrar algo sobre columnas
    Select table_name from dictionary where table_name like ‘ %COLS%’; --Me encuentra todas las vistas All_tab_col
    ~~~

## Instancias

Una instancia de una base de datos es el conjunto de procesos y memoria que maneja el acceso a los datos de la base de datos en un sistema de gestión de bases de datos (DBMS).

En términos simples:

* Instancia: Es el software en ejecución y los recursos (como la memoria y procesos) que gestionan y permiten el acceso a los datos.

* Base de datos: Es el almacenamiento físico de los datos, donde se guardan las tablas, índices y otros objetos de datos.

### Archivos de la BD
* PFILE: consiste en un texto plano que contiene parametros esenciales de inicio de la BD.
    * Parametros importantes:
        * Nombre y dominio de la BD
        * Ficheros de control de la BD.
        * Parametros de procesos: importante para inicio y espacio de memoria.

~~~sql
CREATE PFILE='<pfile location>' FROM SPFILE = '<spfile location>';
~~~

* Control Files: Almacenan info en un binario para mantener y verificar la integridad de la bd:
    * Estructura.
    * Nombre.
    * Fecha de creacion de BD.
    * Nombre fichero de datos y de redo log.
    * Info de Sincronización (estado de ficheros, tiempo de cierre,...)

* Data Files
    * Diccionario de datos
    * Objetos de usuarios
    * Imagen anterior de los bloques de datos antes de una transaccion (rollback).
    * Estan divididos en bloques:
        * Un bloque es la unidad minima de info(2-4-8K)
        * Los ficheros se organizan de manera independiente al SO.
        * El primer nloque almacena info de control no almacenan datos (Cabecera del fichero)
    * Para obtener info de los ficheros de datos se consulta DBA_DATA_FILES

* Archivos de registro para rehacer (REDO LOG FILES)
    * Graban todas las modificaciones que sufre la base de datos
    * Funcionan circularmente y se sobrescriben, mínimo debe  existir uno.
    * Se recomienda trabajar en varios discos y ficheros (Multiplexados)
    *  Son n grupos de n miembros a modo de espejo y en discos distintos.
    * Son de acceso secuencial, por lo que interesa ponerlos en dispositivos rápidos.
    * Se graban al hacer COMMIT o cuando se llena el buffer a un tercio
    * Encontramos información sobre ellos en V$LOGFILE y V$LOG.

Los DATA FILES Y REDO LOG FILES son los que contienen la 
esencia de la base de datos, toda la información de la base de datos.

Los CONTROL FILES contienen la lista y ubicación de DATA
FILES y REDO LOG FILES. Si perdemos los CONTROL FILES 
perdemos la manera de encontrar los DATA FILES.

Voy a la carpeta c:\app\oracle\oradata\mi_BD.
* .Log: redo log files.
* .Dbf: los datos.
* .Ctl: Los control files.


### Iniciar y Detener la instancia

#### Fases del proceso de inicio
1. Iniciar la Instancia: Reserva memoria y espacio para la instancia, tambien inicializa procesos, para esto se llama al PFILE, tembien se inicia el Area Global del Sistema(SGA), los procesos background y se abre el fichero alert$ORACLE_SID.log.

2. Montado de la BD: Se leen los **Control Files**.

3. Apertura de la BD: Se leen los **DATA FILES** y **REDO LOG FILES**, bloqueandolos, en este punto los usuarios ya pueden acceder a la BD. El servidor Oracle comprueba la consistencia de los datos
y si es necesario el proceso SMON inicia la recuperación de la
instancia.

Al tener Instalado un servidor Oracle y una instancia el equipo realiza estos tres pasos por si solo.

Modos de inicio
* NOMOUNT: Inicia la instancia sin montar la base de datos, útil para ciertas operaciones de mantenimiento (como creación de base de datos).
* MOUNT: La instancia se inicia y se monta la base de datos (se leen los archivos de control), pero no se abre. Este modo se utiliza para tareas como la recuperación de la base de datos.
* OPEN: La base de datos se abre y está lista para ser utilizada por los usuarios.
~~~sql
-- Iniciar la instancia en modo NOMOUNT
STARTUP NOMOUNT;

-- Montar la base de datos (lectura del archivo de control)
STARTUP MOUNT;

-- Abrir la base de datos (disponible para los usuarios)
STARTUP;

-- Detener la instancia
SHUTDOWN;

~~~

### Inicio Paso a paso de la Bd
~~~sql
-- Iniciamos la instancia
startup nomount;

-- La montamos
Alter database mount;

---La abrimos, podemos añadir la clausula pfile para indicar cual ora usar en la inicializacion.
Alter database open [pfile='<pfile_location>'];
~~~
## 01.1_Arquitectura de oracle

~~~sql
set sqlprompt 'Prompt';
clear screen;
~~~
### Acceso restringido

1. Levantarla con acceso restringido
~~~sql
startup restrict pfile=c\app\oracle\admin\init.ora
~~~
No te permite conectar como ningun usuario.

**Si quiero volver en estado original**
~~~sql
alter system disable restricted session;
~~~
Te permitira conectarte como usuario.

### Quescied

El término quiesce en Oracle se refiere a poner la base de datos en un estado "silencioso" o "pausado", donde solo los administradores (SYSDBA) pueden realizar operaciones. Esto permite a los DBA realizar tareas de mantenimiento, como cambios de esquema o actualizaciones, sin interferencias de usuarios regulares que podrían estar ejecutando transacciones activas.

***Hay que abrir 2 terminales.***

En uno entras como sys e introduces:
~~~sql
alter system quiesce restricted;

--Voy al otro terminal:
alter system uniquiesce;

--Suspender bd

alter system suspend;

--Ver estado de bd
select database status from v$instance;
~~~

### Modificar parametros

Hay que ver si son dinamicos o no.

Processes y sessions son staticos.

~~~sql
show paramter sessions;
show paramter processes;
~~~
La diferencia es que los dinamicos son modificables en medio de ejecuicon de la base de datos.
~~~sql
show paramter job_queue_processes; --Enseña el 1000
alter system set job_queue_processes=900; --Lo modifica al 900
~~~

Los cambios no se quedan entre ejecuciones y al lebantar la bd se resetea.

Puedes cambiar los metodos de cambio en el propio comando en este caso spfile. Hay que revisar siemre cual es el quee tienees por defecto, en mi caso es siempre spfile, por lo que lo omitiré.
~~~sql
alter system set job_queue_processes=5 scope=spfile;
~~~

Para tocar los staticos como processes, tienes que alterar el .ora que configura los paramatetros a la hora de lanzar la bd. 

Despues hay que apagarla y relanzarla. Al entrar tendra el parametro cambiado.
~~~sql
shutdown immediate;
--Alteras el .ora
startup pfile=c\app\oracle\admin\init.ora;
show parameter processes;
~~~



[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
