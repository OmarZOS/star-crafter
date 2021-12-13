
drop table DMODELE cascade constraints;
CREATE TABLE DMODELE(
   DCODEMODELE           NUMBER(4)            not null,
   DLIBELLEMODELE        VARCHAR2(70),
   DCODEMARQUE           NUMBER(4)            not null,
   DLIBELLEMARQUE        VARCHAR2(50),
   DNATIONALITE          VARCHAR2(50),  
   
   constraint PK_DMODELE primary key (DCODEMODELE)
);
BEGIN
FOR i IN
(SELECT m.CODEMODELE, m.LIBELLEMODELE,
marq.CODEMARQUE,marq.LIBELLEMARQUE,marq.NATIONALITE FROM modele m, marque marq WHERE marq.codemarque=m.codemarque ) LOOP
INSERT INTO DMODELE VALUES (i.CODEMODELE,i.LIBELLEMODELE, i.CODEMARQUE, i.LIBELLEMARQUE, i.NATIONALITE ) ;
END LOOP ;
COMMIT ;
END ;
/
    