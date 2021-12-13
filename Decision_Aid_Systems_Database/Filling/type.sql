
DECLARE
l char(30);k char(10); m number; I number;
begin
for i in 1..2 loop
   select dbms_random.string('U',8) into l from dual;
   select floor(dbms_random.value(1,20)) into m from dual;
   insert into type values(i,l);
end loop;
commit;
end;

/