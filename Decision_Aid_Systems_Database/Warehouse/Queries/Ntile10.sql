SELECT t.MOIS,sum(f.F_CA),ntile(3) over (order by sum(f.F_CA)) as tile_3
FROM FSOUSCRIPTION f,DTEMPS t
WHERE f.FCodeTemps=t.CODE_TEMPS
GROUP BY t.MOIS
ORDER BY t.MOIS;
