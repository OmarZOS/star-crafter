DECLARE
mat number; typeASS char(20); m number; NomAss char(20);
BEGIN
    for i in 1..200000 loop
    select dbms_random.string('U',8) into NomAss from dual;
    select floor (dbms_random.value(1,400)) into mat from dual;
    select dbms_random.string('U',8) into typeASS from dual;
    insert into "ASSURE" values (i,mat,NomAss,typeASS);
end loop;
commit;
end;
/