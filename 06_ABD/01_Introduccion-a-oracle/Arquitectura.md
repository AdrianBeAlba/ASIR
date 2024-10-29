# 01_Introducción  a oracle
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
