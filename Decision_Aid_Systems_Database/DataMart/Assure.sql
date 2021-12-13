drop table DASSURE cascade constraints;
CREATE TABLE DAssure(
   DNUMASS               NUMBER(10)           not null,
   DTYPEASS              VARCHAR2(20),
   DNOMASS               VARCHAR2(50),
   DCODEVILLE            NUMBER(3)            not null,
   DNOMVILLE               VARCHAR2(50),
   DCODEWILAYA            NUMBER(3)            not null,
   DNOMWILAYA               VARCHAR2(50),    
   
   constraint PK_DASSURE primary key (DNUMASS)
);

BEGIN
FOR i IN
(SELECT a.NumAss, a.NomAss,
a.TypeAss,v.CODEVILLE,v.NOMVILLE,w.CODEWILAYA,w.NOMWILAYA FROM assure a,ville v,wilaya w WHERE a.CODEVILLE=v.codeville AND v.codewilaya=w.codewilaya ) LOOP
INSERT INTO DAssure VALUES (i.NumAss,i.TypeAss, i.NomAss, i.CodeVille, i.NomVille, i.CodeWilaya,i.NomWilaya) ;
END LOOP ;
COMMIT ;
END ;
/​
