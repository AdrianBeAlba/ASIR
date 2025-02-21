-- Diseña un procedimiento que tiene como único argumento un código de hospital y que realice las siguientes operaciones:

--     Detectar mediante un mensaje si hay un enfermo  en el hospital  de código introducido por parámetro, notificarlo mediante un mensaje del tipo: 
--     El único enfermo del hospital de código:______ es el paciente de nombre:_____ y apellidos:_____
--     Si no hay datos encontrados notificarlo con el siguiente mensaje: No hay enfermos en el hospital de código:_____
--     Si hay muchos enfermos encontrados se notificará con el mensaje: El hospital de códiglo :_____ tienen: total de enfermos.
--     Probad para los códigos de hospital: 1,6 y 7.

create or replace procedure hosp01(codhospital hospital.codigo%type)
is
    cursor enfermos is select * from enfermo where numsegsocial in (select enf_numsegsocial from hospital_enfermo where hosp_codigo = codhospital);
    contador number;
    pacienteuno enfermo.nombre%type;
    pacienteapellido enfermo.apellidos%type;
begin
    contador := 0;
    for malito in enfermos
    loop
        --dbms_output.put_line(malito.nombre);
        pacienteuno := malito.nombre;
        pacienteapellido := malito.apellidos;
        contador := contador + 1;
    end loop;
    if contador = 1 then
        dbms_output.put_line('El único enfermo del hospital de código: '|| codhospital || ' es el paciente de nombre: ' ||pacienteuno||' y apellido: '||pacienteapellido);
    elsif contador > 1 then
        dbms_output.put_line('El hospital de códiglo : '|| codhospital || ' tiene ' || contador || ' pacientes');
    else
        DBMS_OUTPUT.PUT_LINE('No hay enfermos en el hospital de código: ' || codhospital);
    end if;
    --dbms_output.put_line(contador);
end;
/

set serveroutput on;
exec hosp01(6);
exec hosp01(1);
exec hosp01(7);