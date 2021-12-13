
drop MATERIALIZED VIEW VMCAVilleModele;


CREATE MATERIALIZED VIEW VMCAVilleModele
     PARALLEL 4
     BUILD IMMEDIATE
     REFRESH COMPLETE
     AS SELECT m.DLibellemodele,a.DNOMWILAYA
                               ,sum(f.F_CA) as Chiffre_global
                               ,sum(f.F_NBCONTRAT) as Nombre_de_contrats
        from DMODELE m ,FSOUSCRIPTION f, DASSURE a
        where m.DCODEMODELE=f.FCODEMODELE
              AND f.FNUMASS=a.DNUMASS
        GROUP BY m.DLibellemodele,a.DNOMWILAYA;
