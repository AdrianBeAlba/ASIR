-- Diseña un procedimiento que muestre los enfermos del año. Se toma el año como parametro de entrada del procedimiento.

-- De los enfermos se listan los campos:

-- Num_Segsocial:_______________________________________
-- Dirección:___________________________________________
-- Nombre y   Apellidos:___________________________________
-- Fnacimiento:__/__/____  Sexo: ___________________________

-- El sexo puede ser M o F: Se pondrá no la letra sino Masculino o Femenino respectivamente.
-- Haz alguna variación al procedimiento para que logre imprimir sólo los dos enfermos que lleven más tiempo hospitalizado 
-- en el año que se introduce como parámetro de entrada.

----PROCEDIMIENTO BASE
create or replace procedure hospital03(p_año number)
is
cursor enfermos is select * from enfermo where numsegsocial in (select enf_numsegsocial from hospital_enfermo where EXTRACT(year from finscripcion) = p_año);

begin
for v_malito in enfermos
loop
    dbms_output.put_line(' ');
    dbms_output.put_line('----------------------------------------------------------------');
    dbms_output.put_line(' ');
    dbms_output.put_line('Num_Segsocial: '||v_malito.numsegsocial);
    dbms_output.put_line('Dirección: '||v_malito.direccion);
    dbms_output.put_line('Nombre y Apellidos: '||v_malito.nombre||' '||v_malito.apellidos);
    dbms_output.put_line('Fnacimiento: '|| v_malito.fnacimiento ||', Sexo: '||v_malito.sexo);
end loop;

end;
/

--select * from enfermo where numsegsocial in (select enf_numsegsocial from hospital_enfermo where EXTRACT(year from finscripcion) = 2002);
exec hospital03(2002);

-----------------

---PROCEDIMIENTO ALTERADO
create or replace procedure hospitalvar03(p_año number)
is
cursor enfermos is select * from enfermo where numsegsocial in (select enf_numsegsocial from hospital_enfermo where EXTRACT(year from finscripcion) = p_año order by finscripcion asc fetch first 2 rows only);

begin
for v_malito in enfermos
loop
    dbms_output.put_line(' ');
    dbms_output.put_line('----------------------------------------------------------------');
    dbms_output.put_line(' ');
    dbms_output.put_line('Num_Segsocial: '||v_malito.numsegsocial);
    dbms_output.put_line('Dirección: '||v_malito.direccion);
    dbms_output.put_line('Nombre y Apellidos: '||v_malito.nombre||' '||v_malito.apellidos);
    dbms_output.put_line('Fnacimiento: '|| v_malito.fnacimiento ||', Sexo: '||v_malito.sexo);
end loop;

end;
/
exec hospital03(2002);

exec hospitalvar03(2002);