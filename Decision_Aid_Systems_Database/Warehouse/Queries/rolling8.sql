SELECT f.FCodeComp
        ,AVG(sum(f.F_CA)) over (order by t.ANNEE rows 3 PRECEDING ) as Rolling
FROM FSOUSCRIPTION f,DTEMPS t
WHERE f.FCodeTemps=t.CODE_TEMPS
AND f.FCodeComp=6
GROUP BY f.FCodeComp,t.ANNEE
ORDER BY t.ANNEE;