--Dado el número de departamento dame el sumatorio de salario
Set serveroutput on;
create or replace procedure quintp(numdep dept.deptno%type)
is
sumsal emp.sal%type;
begin
select sum(sal) into sumsal from emp where deptno = numdep;
dbms_output.put_line(sumsal);
end;
/