set serveroutput on;
create or replace procedure mostraremp(p_dptno emp.deptno%type)
is
    cursor c_empleados is select ename from emp where deptno=p_dptno;
    v_empleados c_empleados%rowtype;
begin
    open c_empleados;
    fetch c_empleados into v_empleados;
    while c_empleados%found loop
        dbms_output.put_line(v_empleados.ename);
        fetch c_empleados into v_empleados;
    end loop;
    close c_empleados;
end;
/
exec mostraremp(20);