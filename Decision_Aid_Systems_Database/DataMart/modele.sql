BEGIN
FOR i IN
(SELECT m.CODEMODELE, m.LIBELLEMODELE
                    ,marq.CODEMARQUE
                    ,marq.LIBELLEMARQUE
                    ,marq.NATIONALITE 
FROM modele m
    ,marque marq 
WHERE marq.codemarque=m.codemarque ) LOOP
INSERT INTO DMODELE VALUES (i.CODEMODELE,i.LIBELLEMODELE, i.CODEMARQUE, i.LIBELLEMARQUE, i.NATIONALITE ) ;
END LOOP ;
COMMIT ;
END ;
/
    