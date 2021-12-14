DECLARE
lib char(10); nat char(10);
BEGIN
    for codemarq in 1..20 loop
    select dbms_random.string('U',8) into lib from dual;
    select dbms_random.string('U',8) into nat from dual;
    insert into "MARQUE" values (codemarq,lib,nat);
end loop;
commit;
end;
/