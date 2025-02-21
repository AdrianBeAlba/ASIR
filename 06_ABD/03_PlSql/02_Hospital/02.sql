-- Diseñar un procedimento sobre la base de datos de hospitales que haga un recuento de empleados por departamento, asimismo visualizará la ocupación del departamento.
-- Si la  ocupación es < 10 debe aparecer el literal de 'BAJA'.
-- Si la ocupación está entre 10 y 19 el literal de la ocupación ha de ser 'MEDIA'.
-- En cualquier otro caso debe aparecer el literal :'ALTA'.
-- La salida ha de ser:
-- Un título :'DATOS DE OCUPACIÓN DEL DEPARTAMENTO' : el departamento
-- ______________________________________________
-- Ocupación actual : Tipo_ocupación (el literal arriba de ocupación) y el número de empleados por departamento.
-- Para que la salida te salga correcta debe aparecer agrupado por departamento.
-- IMPORTANTE!! DEBE USARSE LA CLÁUSULA WHEN PARA EL MANEJO DE LAS CONDICIONES.
-- IMPORTANTE: MANEJAR EXCEPCIONES PARA EL CURSOR!
create or replace procedure hospital02
is
    cursor c_empdep is select count(e.emp_nif) as total_emp, d.nombre from departamento_empleado e join departamento d on e.dept_codigo=d.codigo group by e.dept_codigo, d.nombre;
    v_numdep number;
    v_depname departamento.nombre%type;
begin
OPEN c_empdep;
    LOOP
        FETCH c_empdep INTO v_numdep, v_depname;
        EXIT WHEN c_empdep%NOTFOUND;
        CASE 
            WHEN v_numdep < 10 THEN dbms_output.put_line('DATOS DE OCUPACIÓN DEL DEPARTAMENTO :'|| v_depname ||', Nivel de Ocupacion: Baja, empleados: '||v_numdep);
            WHEN v_numdep between 10 and 19 THEN dbms_output.put_line('DATOS DE OCUPACIÓN DEL DEPARTAMENTO :'|| v_depname ||', Nivel de Ocupacion: Medio, empleados: '||v_numdep);
            ELSE dbms_output.put_line('DATOS DE OCUPACIÓN DEL DEPARTAMENTO :'|| v_depname ||', Nivel de Ocupacion: Alta, empleados: '||v_numdep);
        END CASE;
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    CLOSE c_empdep;

end;
/
--select count(e.emp_nif) as total_emp, d.nombre from departamento_empleado e join departamento d on e.dept_codigo=d.codigo group by e.dept_codigo, d.nombre;
exec hospital02;