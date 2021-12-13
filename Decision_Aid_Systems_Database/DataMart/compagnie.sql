
drop table DCompagnie cascade constraints;
CREATE TABLE DCompagnie(
   DCODE_COMP            NUMBER(10)           not null,
   DNOM_COMP             VARCHAR2(70),
   DTYPE_COMP            VARCHAR2(20),
   constraint PK_DCOMPAGNIE primary key (DCODE_COMP)
);
BEGIN
FOR i IN
(SELECT c.CODE_COMP, c.NOM_COMP,
c.TYPE_COMP FROM Compagnie c) LOOP
INSERT INTO DCompagnie VALUES (i.CODE_COMP,i.NOM_COMP, i.TYPE_COMP ) ;
END LOOP ;
COMMIT ;
END ;
/