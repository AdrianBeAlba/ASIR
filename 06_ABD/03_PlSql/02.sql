------ Para dep 10, sacar empleados que empiezan por k (usa parametro)
Set serveroutput on;
create or replace procedure segundaP(numdep dept.deptno%type)
is
nombre emp.ename%type;
begin
select ename into nombre from emp where substr(ename,1,1)='K' and deptno=numdep;
dbms_output.put_line(nombre);
end;
/

execute segundap(10);