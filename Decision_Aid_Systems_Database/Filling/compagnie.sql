
DECLARE
l char(70);k char(20); m number; v number;
begin
for i in 1..20 loop
   select dbms_random.string('U',8) into l from dual;
   select dbms_random.string('U',8) into k from dual;
   insert into COMPAGNIE values(i,l,k);
end loop;
commit;
end;