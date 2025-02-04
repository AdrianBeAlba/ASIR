set serveroutput on;
create or replace procedure procC02 (numdep dept.deptno%type)
is
    cursor empleados is select ename from emp where deptno  = numdep;
    nomdep dept.dname%type;
    v_ind number(8);
begin

    select dname into nomdep from dept where deptno=numdep;
    dbms_output.put_line('El departamento: '|| nomdep);
    dbms_output.put_line('----------------------------');
    for empleado in empleados
    loop
        dbms_output.put_line(empleado.ename);
        v_ind := 1;
    end loop;
    if v_ind = 0 then
        dbms_output.put_line('No existe el departamento');
    end if;
end;
/

---Forma 2

set serveroutput on;
create or replace procedure procC02 (numdep dept.deptno%type)
is
    cursor empleados is select ename from emp where deptno  = numdep;
    nomdep dept.dname%type;
begin
    BEGIN
        SELECT dname INTO nomdep FROM dept WHERE deptno = numdep;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No existe el departamento con número: ' || numdep);
        RETURN;  
    END;
    DBMS_OUTPUT.PUT_LINE('El departamento: ' || nomdep);
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    FOR empleado IN empleados LOOP
        DBMS_OUTPUT.PUT_LINE(empleado.ename);
    END LOOP;
END;
/
exec procc02(30);