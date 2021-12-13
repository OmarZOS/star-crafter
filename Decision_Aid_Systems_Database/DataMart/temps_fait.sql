
drop sequence seqF;

CREATE SEQUENCE seqF
MINVALUE 1
MAXVALUE 400000
START WITH 1
INCREMENT BY 1 ;

drop sequence seq;

CREATE SEQUENCE seq
MINVALUE 1
MAXVALUE 800000
START WITH 1
INCREMENT BY 1 ;

drop table DTEMPS cascade constraints;
CREATE TABLE DTEMPS(
   CODE_TEMPS            number(10) not null,
   MOIS                  date,
   LIB_MOIS              VARCHAR2(20),
   TRIMESTRE             date,
   ANNEE                date,
   constraint PK_DTEMPS primary key (CODE_TEMPS)
);

drop table FSouscription cascade constraints;
CREATE TABLE FSouscription (
   FNumAss            NUMBER(28) ,
   FCODEMODELE           NUMBER(10)            not null,
   FCodeType              NUMBER(10)  ,
   FCodeComp             number(10)  ,
   FCodeTemps             number(28) ,
   F_Nbcontrat             number(28),
   F_CA                    BINARY_DOUBLE,
   constraint PK_FNumAss      primary key (FNumAss,FCODEMODELE,FCodeType,FCodeComp,FCodeTemps)
);  

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