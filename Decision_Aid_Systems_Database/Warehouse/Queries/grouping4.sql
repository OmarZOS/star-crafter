SELECT sum(f.F_CA) as CA, m.LIBELLEMARQUE,GROUPING(m.LIBELLEMARQUE) as Libelle
FROM FSOUSCRIPTION f, DMODELE m,DTEMPS t
WHERE f.FCodeTemps=t.CODE_TEMPS
AND f.FCODEMODELE=m.DCODEMODELE
GROUP BY ROLLUP(t.ANNEE,m.LIBELLEMARQUE)
