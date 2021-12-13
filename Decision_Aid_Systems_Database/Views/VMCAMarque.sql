
CREATE MATERIALIZED VIEW VMCAMarque
     PARALLEL 4
     BUILD IMMEDIATE
     REFRESH COMPLETE
     AS SELECT m.DLibellemodele,a.DNOMWILAYA
                               ,sum(f.F_CA) as Chiffre_global
                               ,sum(f.F_NBCONTRAT) as Nombre_de_contrats
                               FROM DMODELE m ,FSOUSCRIPTION f, DASSURE a,DTEMPS t
       where m.DCODEMODELE=f.FCODEMODELE
       AND f.FNUMASS=a.DNUMASS
       AND t.CODE_TEMPS=f.FCODETEMPS
   GROUP BY t.ANNEE,m.DLibellemodele,a.DNOMWILAYA;​



