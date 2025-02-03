---Reciba Número de departamento y muestre los nombres de empleados.
set serveroutput on;
create or replace procedure procC01 (numdep dept.deptno%type)
is
    cursor empleados is select ename from emp where deptno = numdep;
    nomdep dept.dname%type;
begin
    select dname into nomdep from dept where deptno=numdep;
    dbms_output.put_line('Empleados del departamento: '||nomdep);
    dbms_output.put_line('----------------------------');
    for entrada in empleados
    loop
        dbms_output.put_line(entrada.ename);
    end loop;
end;
/
exec procC01(10);