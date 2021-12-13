
DECLARE
l char(10);k char(10); m number; v number;
begin
for i in 1..40000 loop
   select dbms_random.string('U',8) into k from dual;
   select floor(dbms_random.value(1,20)) into m from dual;
   select floor(dbms_random.value(1,2)) into v from dual;
   insert into VEHICULE values(i,v,m,k);
end loop;
commit;
end;
/