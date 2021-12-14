SELECT m.DNATIONALITE
                               ,sum(f.F_CA) as Chiffre_global
                               
                               FROM DMODELE m ,FSOUSCRIPTION f, DASSURE a
       where m.DCODEMODELE=f.FCODEMODELE
       AND f.FNUMASS=a.DNUMASS
       
   GROUP BY m.DNATIONALITE