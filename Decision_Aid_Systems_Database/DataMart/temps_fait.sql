DECLARE
   id number;
   
BEGIN
FOR i IN (select c.NUMASS,c.MATRICULE,v.CODETYPE,c.CODE_COMP,c.DATESOUSCRIPTION,count(*) as nb,sum(c.mantant) as ca
      from contrat c,vehicule v
      where v.MATRICULE=c.MATRICULE
      GROUP BY c.NUMASS,c.MATRICULE,v.CODETYPE,c.CODE_COMP,c.DATESOUSCRIPTION ) LOOP
    
  select seq.nextVAL  into id from dual;

  INSERT INTO DTEMPS VALUES (id,
      trunc(i.DATESOUSCRIPTION,'MM'),
      to_char(trunc(i.DATESOUSCRIPTION,'MONTH')),
      trunc(i.DATESOUSCRIPTION,'Q'),
      trunc(i.DATESOUSCRIPTION,'YYYY')) ;

  INSERT INTO FSouscription(FNumAss,           
   FCODEMODELE  ,        
   FCodeType     ,       
   FCodeComp      ,      
   FCodeTemps     ,        
   F_Nbcontrat    ,       
   F_CA ) VALUES (i.NumAss,
      i.MATRICULE,
      i.CODETYPE,
      i.CODE_COMP,
      to_number(id),
      i.nb,
      i.ca);


END LOOP ;
COMMIT ;
END ;
/