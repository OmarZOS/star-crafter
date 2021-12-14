SELECT m.DLIBELLEMARQUE
        ,sum(f.F_CA) as CA
        , rank() over (order by (sum(f.F_CA)) Desc )
        , DENSE_RANK() over (order by (sum(f.F_CA)) Desc )
FROM FSOUSCRIPTION f, DMODELE m,DTEMPS t
WHERE f.FCodeTemps=t.CODE_TEMPS
AND f.FCODEMODELE=m.DCODEMODELE
GROUP BY ROLLUP(t.ANNEE,m.DLIBELLEMARQUE)
