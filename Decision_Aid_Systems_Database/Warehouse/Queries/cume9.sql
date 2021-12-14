SELECT m.DLIBELLEMARQUE,f.FCodeComp
        ,cume_dist() over (partition by t.ANNEE 
            order BY sum(f.F_CA)) as Cum_Dist_CA
FROM FSOUSCRIPTION f, DMODELE m,DTEMPS t
WHERE f.FCodeTemps=t.CODE_TEMPS
AND f.FCODEMODELE=m.DCODEMODELE
GROUP BY t.ANNEE,m.DLIBELLEMARQUE,f.FCodeComp
ORDER BY t.ANNEE,m.DLIBELLEMARQUE,f.FCodeComp;
