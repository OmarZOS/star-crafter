DECLARE
d date; mat number; comp number; m number; assure number;
BEGIN
    for i in 1..800000 loop
    select floor (dbms_random.value(1,200000)) into assure from dual;
    select floor (dbms_random.value(1,20)) into comp from dual;
    select to_date(trunc(dbms_random.value(to_char(date '2015-01-01','J'),
    to_char(date '2017-12-31','J'))),'J') into d from dual;
    select trunc (dbms_random.value(50000,100000),2) into m from dual;
    select floor (dbms_random.value(1,40000)) into mat from dual;
    insert into "CONTRAT" values (i,assure,comp,mat,d,m);
end loop;
commit;
end;
/