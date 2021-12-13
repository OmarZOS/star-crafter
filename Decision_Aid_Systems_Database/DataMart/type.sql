
    drop table DTYPE cascade constraints;
CREATE TABLE DTYPE(
   DCODETYPE           NUMBER(2)            not null,
   DLIBELLETYPE        VARCHAR2(50),  
   
   constraint PK_DTYPE primary key (DCODETYPE)
);
BEGIN
FOR i IN
(SELECT t.CODETYPE, t.LIBELLETYPE FROM TYPE t ) LOOP
INSERT INTO DTYPE VALUES (i.CODETYPE,i.LIBELLETYPE) ;
END LOOP ;
COMMIT ;
END ;
/