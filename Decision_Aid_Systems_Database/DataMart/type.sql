
BEGIN
FOR i IN
(SELECT t.CODETYPE, t.LIBELLETYPE FROM TYPE t ) LOOP
INSERT INTO DTYPE VALUES (i.CODETYPE,i.LIBELLETYPE) ;
END LOOP ;
COMMIT ;
END ;
/