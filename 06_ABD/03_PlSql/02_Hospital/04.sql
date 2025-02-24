-- Diseñar un procedimiento que admita los siguientes parámetros de entrada:
-- Nombre de enfermo
-- Apellidos del mismo.
-- Dicrección donde reside
-- Mostrar un texto con la siguiente información: 'Nº de filas en tabla enfermo antes de insertar=', concatenado con el resultado de contar el número de filas que hay en la tabla enfermo.
-- Insertar en la tabla ENFERMO un registro con la siguiente información:
--     NUMSEGSOCIAL = 280862486
--     FECHA NACIMIENTO: 01/01/2000
--     NOMBRE ='el nombre por pantalla
--     APELLIDOS = los apellidos por pantala
--     DIRECCION = la que se ha introducido por pantalla
--     SEXO='M'
--     Insertar en la tabla HOSPITAL_ENFERMO mediante un bucle repetitivo, diez lineas en la tabla HOSPITAL _ENFERMO con la siguiente información del mismo:
--         HOSP_CODIGO=6
--         INSCRIPCION =seq_inscripcion.nextval
--         ENF_NUMSEGSOCIAL =280862486
--         FINSCRIPCION = TO_DATE ('01012000','dd/mm/yyyy') + seq_inscripcion.nextval
create or replace procedure hospital04(p_enfno enfermo.nombre%type, p_enfapell enfermo.apellidos%type, p_enfdir enfermo.direccion%type)
is
v_numenfermos number;


begin
select count(numsegsocial) into v_numenfermos from enfermo;
dbms_output.put_line('Nº de filas en tabla enfermo antes de insertar= '||v_numenfermos);
insert into enfermo (numsegsocial,nombre,apellidos,direccion,sexo) values (280862486,p_enfno,p_enapell,p_enfdir,'M');

for i in 1..10
loop
insert into hospital_enfermo values (6,seq_inscripcion.nextval,280862486,TO_DATE ('01012000','dd/mm/yyyy') + seq_inscripcion.nextval);
end loop;

end;
/