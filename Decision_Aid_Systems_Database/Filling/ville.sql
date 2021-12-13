
DECLARE
l char(50); m number;
begin
for i in 1..400 loop
   select dbms_random.string('U',8) into l from dual;
   select floor(dbms_random.value(1,48)) into m from dual;
   insert into ville values(i,m,l);
end loop;
commit;
end;
