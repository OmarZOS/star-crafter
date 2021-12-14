DECLARE
h number;
BEGIN
FOR i IN (SELECT a.NumAss, a.NomAss,a.TypeAss,v.CODEVILLE,v.NOMVILLE,w.CODEWILAYA,w.NOMWILAYA
FROM assure a,ville v,wilaya w 
WHERE a.CODEVILLE=v.codeville 
AND v.codewilaya=w.codewilaya ) LOOP
INSERT INTO DAssure VALUES (i.NumAss,i.TypeAss,i.NomAss,i.CodeVille,i.NomVille,i.CodeWilaya,i.NomWilaya);
END LOOP ;
COMMIT ;
END ;
/