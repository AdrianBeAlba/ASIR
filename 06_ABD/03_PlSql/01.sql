Set serveroutput on;
create or replace procedure primeraP
is
nombre emp.ename%type;
begin
select ename into nombre from emp where substr(ename,1,1)='K';
dbms_output.put_line(nombre);
end;
/

EXECUTE primeraP;