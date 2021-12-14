SELECT sum(f.F_CA) as CA, m.DLIBELLEMARQUE
FROM FSOUSCRIPTION f, DMODELE m,DTEMPS t
WHERE f.FCodeTemps=t.CODE_TEMPS
AND f.FCODEMODELE=m.DCODEMODELE
GROUP BY CUBE(t.ANNEE,m.DLIBELLEMARQUE)
