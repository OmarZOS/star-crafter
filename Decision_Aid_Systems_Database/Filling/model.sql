
DECLARE
l char(10); m number;
begin
for i in 1..200 loop
   select dbms_random.string('U',8) into l from dual;
   select floor(dbms_random.value(1,20)) into m from dual;
   insert into "MODELE" values(i,m,l);
end loop;
commit;
end;
/