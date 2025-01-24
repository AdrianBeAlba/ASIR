---- Busca Nombre de empleado por primera letra y numero de departamento.
Set serveroutput on;
create or replace procedure extra1P(numdep dept.deptno%type, letra emp.ename%type)
is
    cursor consulta is select ename from emp where substr(ename,1,1)=letra and deptno=numdep;
begin
    for linea in consulta
    loop
        dbms_output.put_line(linea.ename);
    end loop;
end;
/

execute extra1P(20,'A');