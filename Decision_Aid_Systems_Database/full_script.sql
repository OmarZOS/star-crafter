


/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de cr�ion :  07/11/2021 11:02:38                      */
/*==============================================================*/


alter table ASSURE
   drop constraint FK_ASSURE_HABITE_VILLE;

alter table CONTRAT
   drop constraint FK_CONTRAT_CONCERNE_ASSURE;

alter table CONTRAT
   drop constraint FK_CONTRAT_COUVRE_VEHICULE;

alter table CONTRAT
   drop constraint FK_CONTRAT_ETABLIT2_COMPAGNI;

alter table METTRE_EN_JEU
   drop constraint FK_METTRE_E_METTRE_EN_GARANTIE;

alter table METTRE_EN_JEU
   drop constraint FK_METTRE_E_METTRE_EN_SINISTRE;

alter table MODELE
   drop constraint FK_MODELE_APPARTIEN_MARQUE;

alter table SINISTRE
   drop constraint FK_SINISTRE_A_LIEU_VILLE;

alter table SINISTRE
   drop constraint FK_SINISTRE_RATTACHE__CONTRAT;

alter table SINISTRE
   drop constraint FK_SINISTRE_SUIVI_PAR_EXPERT;

alter table SOUSCRIRE
   drop constraint FK_SOUSCRIR_SOUSCRIRE_CONTRAT;

alter table SOUSCRIRE
   drop constraint FK_SOUSCRIR_SOUSCRIRE_GARANTIE;

alter table VEHICULE
   drop constraint FK_VEHICULE_APPARTIEN_MODELE;

alter table VEHICULE
   drop constraint FK_VEHICULE_EST_TYPE;

alter table VILLE
   drop constraint FK_VILLE_SE_TROUVE_WILAYA;

drop table ASSURE cascade constraints;

drop table COMPAGNIE cascade constraints;

drop table CONTRAT cascade constraints;

drop table EXPERT cascade constraints;

drop table GARANTIES cascade constraints;

drop table MARQUE cascade constraints;

drop table METTRE_EN_JEU cascade constraints;

drop table MODELE cascade constraints;

drop table SINISTRE cascade constraints;

drop table SOUSCRIRE cascade constraints;

drop table TYPE cascade constraints;

drop table VEHICULE cascade constraints;

drop table VILLE cascade constraints;

drop table WILAYA cascade constraints;

/*==============================================================*/
/* Table : ASSURE                                               */
/*==============================================================*/
create table ASSURE
(
   NUMASS               NUMBER(10)           not null,
   CODEVILLE            NUMBER(2)            not null,
   NOMASS               VARCHAR2(50),
   TYPEASS              VARCHAR2(20),
   constraint PK_ASSURE primary key (NUMASS)
);

/*==============================================================*/
/* Table : COMPAGNIE                                            */
/*==============================================================*/
create table COMPAGNIE
(
   CODE_COMP            NUMBER(10)           not null,
   NOM_COMP             VARCHAR2(70),
   TYPE_COMP            VARCHAR2(20),
   constraint PK_COMPAGNIE primary key (CODE_COMP)
);

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create table CONTRAT
(
   NUMPOLICE            NUMBER(10)           not null,
   NUMASS               NUMBER(10)           not null,
   CODE_COMP            NUMBER(10)           not null,
   MATRICULE            NUMBER(10)           not null,
   DATESOUSCRIPTION     DATE,
   MANTANT              BINARY_DOUBLE,
   constraint PK_CONTRAT primary key (NUMPOLICE)
);

/*==============================================================*/
/* Table : EXPERT                                               */
/*==============================================================*/
create table EXPERT
(
   CODEEXPERT           NUMBER(4)            not null,
   NOMEXPERT            VARCHAR2(50),
   ADRESSEEXPERT        VARCHAR2(100),
   TELEXP               NUMBER(10),
   constraint PK_EXPERT primary key (CODEEXPERT)
);

/*==============================================================*/
/* Table : GARANTIES                                            */
/*==============================================================*/
create table GARANTIES
(
   CODEGAR              NUMBER(10)           not null,
   LIBELLEGAR           VARCHAR2(50),
   MONTANT_PLAFOND      BINARY_DOUBLE,
   constraint PK_GARANTIES primary key (CODEGAR)
);

/*==============================================================*/
/* Table : MARQUE                                               */
/*==============================================================*/
create table MARQUE
(
   CODEMARQUE           NUMBER(4)            not null,
   LIBELLEMARQUE        VARCHAR2(50),
   NATIONALITE          VARCHAR2(50),
   constraint PK_MARQUE primary key (CODEMARQUE)
);

/*==============================================================*/
/* Table : METTRE_EN_JEU                                        */
/*==============================================================*/
create table METTRE_EN_JEU
(
   CODESINISTRE         NUMBER(4)            not null,
   CODEGAR              NUMBER(10)           not null,
   MONTANT_REMBOURSSE   FLOAT,
   constraint PK_METTRE_EN_JEU primary key (CODESINISTRE, CODEGAR)
);

/*==============================================================*/
/* Table : MODELE                                               */
/*==============================================================*/
create table MODELE
(
   CODEMODELE           NUMBER(4)            not null,
   CODEMARQUE           NUMBER(4)            not null,
   LIBELLEMODELE        VARCHAR2(70),
   constraint PK_MODELE primary key (CODEMODELE)
);

/*==============================================================*/
/* Table : SINISTRE                                             */
/*==============================================================*/
create table SINISTRE
(
   CODESINISTRE         NUMBER(4)            not null,
   NUMPOLICE            NUMBER(10)           not null,
   CODEEXPERT           NUMBER(4)            not null,
   CODEVILLE            NUMBER(2)            not null,
   DATESINISTRE         DATE,
   RUE                  VARCHAR2(100),
   ETATDOSSIER          VARCHAR2(20),
   constraint PK_SINISTRE primary key (CODESINISTRE)
);

/*==============================================================*/
/* Table : SOUSCRIRE                                            */
/*==============================================================*/
create table SOUSCRIRE
(
   CODEGAR              NUMBER(10)           not null,
   NUMPOLICE            NUMBER(10)           not null,
   constraint PK_SOUSCRIRE primary key (CODEGAR, NUMPOLICE)
);

/*==============================================================*/
/* Table : TYPE                                                 */
/*==============================================================*/
create table TYPE
(
   CODETYPE             NUMBER(2)            not null,
   LIBELLETYPE          VARCHAR2(50),
   constraint PK_TYPE primary key (CODETYPE)
);

/*==============================================================*/
/* Table : VEHICULE                                             */
/*==============================================================*/
create table VEHICULE
(
   MATRICULE            NUMBER(10)           not null,
   CODETYPE             NUMBER(2)            not null,
   CODEMODELE           NUMBER(4)            not null,
   COULEUR              VARCHAR2(30)         not null,
   constraint PK_VEHICULE primary key (MATRICULE)
);

/*==============================================================*/
/* Table : VILLE                                                */
/*==============================================================*/
create table VILLE
(
   CODEVILLE            NUMBER(2)            not null,
   CODEWILAYA           NUMBER(2)            not null,
   NOMVILLE             VARCHAR2(50),
   constraint PK_VILLE primary key (CODEVILLE)
);

/*==============================================================*/
/* Table : WILAYA                                               */
/*==============================================================*/
create table WILAYA
(
   CODEWILAYA           NUMBER(2)            not null,
   NOMWILAYA            VARCHAR2(50),
   constraint PK_WILAYA primary key (CODEWILAYA)
);

alter table ASSURE
   add constraint FK_ASSURE_HABITE_VILLE foreign key (CODEVILLE)
      references VILLE (CODEVILLE);

alter table CONTRAT
   add constraint FK_CONTRAT_CONCERNE_ASSURE foreign key (NUMASS)
      references ASSURE (NUMASS);

alter table CONTRAT
   add constraint FK_CONTRAT_COUVRE_VEHICULE foreign key (MATRICULE)
      references VEHICULE (MATRICULE);

alter table CONTRAT
   add constraint FK_CONTRAT_ETABLIT2_COMPAGNI foreign key (CODE_COMP)
      references COMPAGNIE (CODE_COMP);

alter table METTRE_EN_JEU
   add constraint FK_METTRE_E_METTRE_EN_GARANTIE foreign key (CODEGAR)
      references GARANTIES (CODEGAR);

alter table METTRE_EN_JEU
   add constraint FK_METTRE_E_METTRE_EN_SINISTRE foreign key (CODESINISTRE)
      references SINISTRE (CODESINISTRE);

alter table MODELE
   add constraint FK_MODELE_APPARTIEN_MARQUE foreign key (CODEMARQUE)
      references MARQUE (CODEMARQUE);

alter table SINISTRE
   add constraint FK_SINISTRE_A_LIEU_VILLE foreign key (CODEVILLE)
      references VILLE (CODEVILLE);

alter table SINISTRE
   add constraint FK_SINISTRE_RATTACHE__CONTRAT foreign key (NUMPOLICE)
      references CONTRAT (NUMPOLICE);

alter table SINISTRE
   add constraint FK_SINISTRE_SUIVI_PAR_EXPERT foreign key (CODEEXPERT)
      references EXPERT (CODEEXPERT);

alter table SOUSCRIRE
   add constraint FK_SOUSCRIR_SOUSCRIRE_CONTRAT foreign key (NUMPOLICE)
      references CONTRAT (NUMPOLICE);

alter table SOUSCRIRE
   add constraint FK_SOUSCRIR_SOUSCRIRE_GARANTIE foreign key (CODEGAR)
      references GARANTIES (CODEGAR);

alter table VEHICULE
   add constraint FK_VEHICULE_APPARTIEN_MODELE foreign key (CODEMODELE)
      references MODELE (CODEMODELE);

alter table VEHICULE
   add constraint FK_VEHICULE_EST_TYPE foreign key (CODETYPE)
      references TYPE (CODETYPE);

alter table VILLE
   add constraint FK_VILLE_SE_TROUVE_WILAYA foreign key (CODEWILAYA)
      references WILAYA (CODEWILAYA);



DECLARE
lib char(10); nat char(10);
BEGIN
    for codemarq in 1..20 loop
    select dbms_random.string('U',8) into lib from dual;
    select dbms_random.string('U',8) into nat from dual;
    insert into "MARQUE" values (codemarq,lib,nat);
end loop;
commit;
end;
/

DECLARE
l char(10); m number;
begin
for i in 1..200 loop
   select dbms_random.string('U',8) into l from dual;
   select floor(dbms_random.value(1,20)) into m from dual;
   insert into "MODELE" values(i,m,l);
end loop;
commit;
end;
/

DECLARE
l char(30);k char(10); m number; I number;
begin
for i in 1..2 loop
   select dbms_random.string('U',8) into l from dual;
   select floor(dbms_random.value(1,20)) into m from dual;
   insert into type values(i,l);
end loop;
commit;
end;

/

DECLARE
l char(10);k char(10); m number; v number;
begin
for i in 1..40000 loop
   select dbms_random.string('U',8) into k from dual;
   select floor(dbms_random.value(1,20)) into m from dual;
   select floor(dbms_random.value(1,2)) into v from dual;
   insert into VEHICULE values(i,v,m,k);
end loop;
commit;
end;
/

INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(1,'ADRAR');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(2,'CHLEF');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(3,'LAGHOUAT');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(4,'OUM BOUAGHI');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(5,'BATNA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(6,'BEJAIA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(7,'BISKRA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(8,'BECHAR');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(9,'BLIDA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(10,'BOUIRA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(11,'TAMANRASSET');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(12,'TEBESSA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(13,'TLEMCEN');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(14,'TIARET');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(15,'TIZI OUZOU');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(16,'ALGER');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(17,'DJELFA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(18,'JIJEL');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(19,'SETIF');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(20,'SAIDA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(21,'SKIKDA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(22,'SIDI BEL ABBES');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(23,'ANNABA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(24,'GUELMA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(25,'CONSTANTINE');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(26,'MEDEA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(27,'MOSTAGANEM');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(28,'MSILA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(29,'MASCARA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(30,'OUARGLA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(31,'ORAN');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(32,'EL BAYDH');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(33,'ILLIZI');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(34,'BORDJ BOU ARRERIDJ');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(35,'BOUMERDES');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(36,'EL TAREF');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(37,'TINDOUF');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(38,'TISSEMSILT');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(39,'EL OUED');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(40,'KHENCHLA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(41,'SOUK AHRASS');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(42,'TIPAZA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(43,'MILA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(44,'AÏN DEFLA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(45,'NÂAMA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(46,'AÏN TEMOUCHENT');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(47,'GHARDAÏA');
INSERT INTO WILAYA(CODEWILAYA,NOMWILAYA) VALUES(48,'RELIZANE');​

DECLARE
l char(50); m number;
begin
for i in 1..400 loop
   select dbms_random.string('U',8) into l from dual;
   select floor(dbms_random.value(1,48)) into m from dual;
   insert into ville values(i,m,l);
end loop;
commit;
end;

DECLARE
l char(70);k char(20); m number; v number;
begin
for i in 1..20 loop
   select dbms_random.string('U',8) into l from dual;
   select dbms_random.string('U',8) into k from dual;
   insert into COMPAGNIE values(i,l,k);
end loop;
commit;
end;


DECLARE
l char(70);k char(20); m number; v number;
begin
for i in 1..20 loop
   select dbms_random.string('U',8) into l from dual;
   select dbms_random.string('U',8) into k from dual;
   insert into COMPAGNIE values(i,l,k);
end loop;
commit;
end;


DECLARE
d date; mat number; comp number; m number; assure number;
BEGIN
    for i in 1..800000 loop
    select floor (dbms_random.value(1,200000)) into assure from dual;
    select floor (dbms_random.value(1,20)) into comp from dual;
    select to_date(trunc(dbms_random.value(to_char(date '2015-01-01','J'),
    to_char(date '2017-12-31','J'))),'J') into d from dual;
    select trunc (dbms_random.value(50000,100000),2) into m from dual;
    select floor (dbms_random.value(1,40000)) into mat from dual;
    insert into "CONTRAT" values (i,assure,comp,mat,d,m);
end loop;
commit;
end;
/

drop table DASSURE cascade constraints;
CREATE TABLE DAssure(
   DNUMASS               NUMBER(10)           not null,
   DTYPEASS              VARCHAR2(20),
   DNOMASS               VARCHAR2(50),
   DCODEVILLE            NUMBER(3)            not null,
   DNOMVILLE               VARCHAR2(50),
   DCODEWILAYA            NUMBER(3)            not null,
   DNOMWILAYA               VARCHAR2(50),    
   
   constraint PK_DASSURE primary key (DNUMASS)
);

BEGIN
FOR i IN
(SELECT a.NumAss, a.NomAss,
a.TypeAss,v.CODEVILLE,v.NOMVILLE,w.CODEWILAYA,w.NOMWILAYA FROM assure a,ville v,wilaya w WHERE a.CODEVILLE=v.codeville AND v.codewilaya=w.codewilaya ) LOOP
INSERT INTO DAssure VALUES (i.NumAss,i.TypeAss, i.NomAss, i.CodeVille, i.NomVille, i.CodeWilaya,i.NomWilaya) ;
END LOOP ;
COMMIT ;
END ;
/​

drop table DMODELE cascade constraints;
CREATE TABLE DMODELE(
   DCODEMODELE           NUMBER(4)            not null,
   DLIBELLEMODELE        VARCHAR2(70),
   DCODEMARQUE           NUMBER(4)            not null,
   DLIBELLEMARQUE        VARCHAR2(50),
   DNATIONALITE          VARCHAR2(50),  
   
   constraint PK_DMODELE primary key (DCODEMODELE)
);
BEGIN
FOR i IN
(SELECT m.CODEMODELE, m.LIBELLEMODELE,
marq.CODEMARQUE,marq.LIBELLEMARQUE,marq.NATIONALITE FROM modele m, marque marq WHERE marq.codemarque=m.codemarque ) LOOP
INSERT INTO DMODELE VALUES (i.CODEMODELE,i.LIBELLEMODELE, i.CODEMARQUE, i.LIBELLEMARQUE, i.NATIONALITE ) ;
END LOOP ;
COMMIT ;
END ;
/
    
    drop table DTYPE cascade constraints;
CREATE TABLE DTYPE(
   DCODETYPE           NUMBER(2)            not null,
   DLIBELLETYPE        VARCHAR2(50),  
   
   constraint PK_DTYPE primary key (DCODETYPE)
);
BEGIN
FOR i IN
(SELECT t.CODETYPE, t.LIBELLETYPE FROM TYPE t ) LOOP
INSERT INTO DTYPE VALUES (i.CODETYPE,i.LIBELLETYPE) ;
END LOOP ;
COMMIT ;
END ;
/
    
drop table DCompagnie cascade constraints;
CREATE TABLE DCompagnie(
   DCODE_COMP            NUMBER(10)           not null,
   DNOM_COMP             VARCHAR2(70),
   DTYPE_COMP            VARCHAR2(20),
   constraint PK_DCOMPAGNIE primary key (DCODE_COMP)
);
BEGIN
FOR i IN
(SELECT c.CODE_COMP, c.NOM_COMP,
c.TYPE_COMP FROM Compagnie c) LOOP
INSERT INTO DCompagnie VALUES (i.CODE_COMP,i.NOM_COMP, i.TYPE_COMP ) ;
END LOOP ;
COMMIT ;
END ;
/

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
    
​UPDATE Dmodele
SET DLIBELLEMODELE='Seat Alhambra'
WHERE DCODEMODELE=1 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Altea'
WHERE DCODEMODELE=2 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Altea XL'
WHERE DCODEMODELE=3 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Arosa'
WHERE DCODEMODELE=4 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Cordoba'
WHERE DCODEMODELE=5 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Cordoba Vario'
WHERE DCODEMODELE=6 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Exeo'
WHERE DCODEMODELE=7 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Ibiza'
WHERE DCODEMODELE=8 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Ibiza ST'
WHERE DCODEMODELE=9 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Exeo ST'
WHERE DCODEMODELE=10 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Leon'
WHERE DCODEMODELE=11 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Leon ST'
WHERE DCODEMODELE=12 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Inca'
WHERE DCODEMODELE=13 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Seat Mii'
WHERE DCODEMODELE=14 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Renault Captur'
WHERE DCODEMODELE=15 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Clio'
WHERE DCODEMODELE=16 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='Clio Grandtour'
WHERE DCODEMODELE=17 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioEspace'
WHERE DCODEMODELE=18 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioExpress'
WHERE DCODEMODELE=19 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioFluence'
WHERE DCODEMODELE=20 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioGrand Espace'
WHERE DCODEMODELE=21 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioGrand Modus'
WHERE DCODEMODELE=22 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioGrand Scenic'
WHERE DCODEMODELE=23 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioKadjar'
WHERE DCODEMODELE=24 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioKangoo'
WHERE DCODEMODELE=25 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioKangoo Express'
WHERE DCODEMODELE=26 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioKoleos'
WHERE DCODEMODELE=27 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioLaguna'
WHERE DCODEMODELE=28 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioLaguna Grandtour'
WHERE DCODEMODELE=29 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioLatitude'
WHERE DCODEMODELE=30 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMascott'
WHERE DCODEMODELE=31 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMégane'
WHERE DCODEMODELE=32 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMégane CC'
WHERE DCODEMODELE=33 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMégane Combi'
WHERE DCODEMODELE=34 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMégane Grandtour'
WHERE DCODEMODELE=35 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMégane Coupé'
WHERE DCODEMODELE=36 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioMégane Scénic'
WHERE DCODEMODELE=37 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioScénic'
WHERE DCODEMODELE=38 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioTalisman'
WHERE DCODEMODELE=39 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioTalisman Grandtour'
WHERE DCODEMODELE=40 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='ClioThalia'
WHERE DCODEMODELE=41 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioTwingo'
WHERE DCODEMODELE=42 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='ClioWind'
WHERE DCODEMODELE=43 ;
   
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 1007'
WHERE DCODEMODELE=44 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 107'
WHERE DCODEMODELE=45 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 106'
WHERE DCODEMODELE=46 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 108'
WHERE DCODEMODELE=47 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 2008'
WHERE DCODEMODELE=48 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 205'
WHERE DCODEMODELE=49 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 205 Cabrio'
WHERE DCODEMODELE=50 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 206'
WHERE DCODEMODELE=51 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 206 CC'
WHERE DCODEMODELE=52 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 206 SW'
WHERE DCODEMODELE=53 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 207'
WHERE DCODEMODELE=54 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 207 CC'
WHERE DCODEMODELE=55 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 207 SW'
WHERE DCODEMODELE=56 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 306'
WHERE DCODEMODELE=57 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 307'
WHERE DCODEMODELE=58 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 307 CC'
WHERE DCODEMODELE=59 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 307 SW'
WHERE DCODEMODELE=60 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 308'
WHERE DCODEMODELE=61 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 308 CC'
WHERE DCODEMODELE=62 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 308 SW'
WHERE DCODEMODELE=63 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 309'
WHERE DCODEMODELE=64 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 4007'
WHERE DCODEMODELE=65 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 4008'
WHERE DCODEMODELE=66 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 405'
WHERE DCODEMODELE=67 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 406'
WHERE DCODEMODELE=68 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 407'
WHERE DCODEMODELE=69 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 407 SW'
WHERE DCODEMODELE=70 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 5008'
WHERE DCODEMODELE=71 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 508'
WHERE DCODEMODELE=72 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 508 SW'
WHERE DCODEMODELE=73 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 605'
WHERE DCODEMODELE=74 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 806'
WHERE DCODEMODELE=75 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 607'
WHERE DCODEMODELE=76 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot 807'
WHERE DCODEMODELE=77 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Peugeot Bipper'
WHERE DCODEMODELE=78 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Dokker'
WHERE DCODEMODELE=79 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Duster'
WHERE DCODEMODELE=80 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Lodgy'
WHERE DCODEMODELE=81 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Logan'
WHERE DCODEMODELE=82 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Logan MCV'
WHERE DCODEMODELE=83 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Logan Van'
WHERE DCODEMODELE=84 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Dacia Sandero'
WHERE DCODEMODELE=85 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Berlingo'
WHERE DCODEMODELE=86 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C-Crosser'
WHERE DCODEMODELE=87 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C-Elissée'
WHERE DCODEMODELE=88 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C-Zero'
WHERE DCODEMODELE=89 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C1'
WHERE DCODEMODELE=90 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C2'
WHERE DCODEMODELE=91 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C3'
WHERE DCODEMODELE=92 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C3 Picasso'
WHERE DCODEMODELE=93 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C4'
WHERE DCODEMODELE=94 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C4 Aircross'
WHERE DCODEMODELE=95 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C4 Cactus'
WHERE DCODEMODELE=96 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C4 Coupé'
WHERE DCODEMODELE=97 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C4 Grand Picasso'
WHERE DCODEMODELE=98 ;
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C4 Sedan'
WHERE DCODEMODELE=99 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C5'
WHERE DCODEMODELE=100 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C5 Break'
WHERE DCODEMODELE=101 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C5 Tourer'
WHERE DCODEMODELE=102 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C6'
WHERE DCODEMODELE=103 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën C8'
WHERE DCODEMODELE=104 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën DS3'
WHERE DCODEMODELE=105 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën DS4'
WHERE DCODEMODELE=106 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën DS5'
WHERE DCODEMODELE=107 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Evasion'
WHERE DCODEMODELE=108 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Jumper'
WHERE DCODEMODELE=109 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Jumpy'
WHERE DCODEMODELE=110 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Saxo'
WHERE DCODEMODELE=111 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Nemo'
WHERE DCODEMODELE=112 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Citroën Xantia'
WHERE DCODEMODELE=113 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Agila'
WHERE DCODEMODELE=114 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Ampera'
WHERE DCODEMODELE=115 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Antara'
WHERE DCODEMODELE=116 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Astra'
WHERE DCODEMODELE=117 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Astra cabrio'
WHERE DCODEMODELE=118 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Astra caravan'
WHERE DCODEMODELE=119 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Astra coupé'
WHERE DCODEMODELE=120 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Calibra'
WHERE DCODEMODELE=121 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Campo'
WHERE DCODEMODELE=122 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Cascada'
WHERE DCODEMODELE=123 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Corsa'
WHERE DCODEMODELE=124 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Frontera'
WHERE DCODEMODELE=125 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Insignia'
WHERE DCODEMODELE=126 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Insignia kombi'
WHERE DCODEMODELE=127 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Kadett'
WHERE DCODEMODELE=128 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Meriva'
WHERE DCODEMODELE=129 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Mokka'
WHERE DCODEMODELE=130 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Movano'
WHERE DCODEMODELE=131 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Omega'
WHERE DCODEMODELE=132 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Signum'
WHERE DCODEMODELE=133 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Vectra'
WHERE DCODEMODELE=134 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Vectra Caravan'
WHERE DCODEMODELE=135 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Vivaro'
WHERE DCODEMODELE=136 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Opel Vivaro Kombi'
WHERE DCODEMODELE=137 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 145'
WHERE DCODEMODELE=138 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 146'
WHERE DCODEMODELE=139 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 147'
WHERE DCODEMODELE=140 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 155'
WHERE DCODEMODELE=141 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 156'
WHERE DCODEMODELE=142 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 156 Sportwagon'
WHERE DCODEMODELE=143 ;
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 159'
WHERE DCODEMODELE=144 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 159 Sportwagon'
WHERE DCODEMODELE=145 ;
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 164'
WHERE DCODEMODELE=146 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 166'
WHERE DCODEMODELE=147 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo 4C'
WHERE DCODEMODELE=148 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo Brera'
WHERE DCODEMODELE=149 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo GTV'
WHERE DCODEMODELE=150 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo MiTo'
WHERE DCODEMODELE=151 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo Crosswagon'
WHERE DCODEMODELE=152 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo Spider'
WHERE DCODEMODELE=153 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo GT'
WHERE DCODEMODELE=154 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Alfa Romeo Giulietta'
WHERE DCODEMODELE=155 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Favorit'
WHERE DCODEMODELE=156 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Felicia'
WHERE DCODEMODELE=157 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Citigo'
WHERE DCODEMODELE=158 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Fabia'
WHERE DCODEMODELE=159 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Fabia Combi'
WHERE DCODEMODELE=160 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Fabia Sedan'
WHERE DCODEMODELE=161 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Felicia Combi'
WHERE DCODEMODELE=162 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Octavia'
WHERE DCODEMODELE=163 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Octavia Combi'
WHERE DCODEMODELE=164 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Roomster'
WHERE DCODEMODELE=165 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Yeti'
WHERE DCODEMODELE=166 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Rapid'
WHERE DCODEMODELE=167 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Rapid Spaceback'
WHERE DCODEMODELE=168 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Škoda Superb'
WHERE DCODEMODELE=169 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Alero'
WHERE DCODEMODELE=170 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Aveo'
WHERE DCODEMODELE=171 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Camaro'
WHERE DCODEMODELE=172 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Captiva'
WHERE DCODEMODELE=173 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Corvette'
WHERE DCODEMODELE=174 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Cruze'
WHERE DCODEMODELE=175 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Cruze SW'
WHERE DCODEMODELE=176 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Epica'
WHERE DCODEMODELE=177 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Equinox'
WHERE DCODEMODELE=178 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Evanda'
WHERE DCODEMODELE=179 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet HHR'
WHERE DCODEMODELE=180 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Kalos'
WHERE DCODEMODELE=181 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Lacetti'
WHERE DCODEMODELE=182 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Lacetti SW'
WHERE DCODEMODELE=183 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Lumina'
WHERE DCODEMODELE=184 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Malibu'
WHERE DCODEMODELE=185 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Matiz'
WHERE DCODEMODELE=186 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Monte Carlo'
WHERE DCODEMODELE=187 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Nubira'
WHERE DCODEMODELE=188 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Chevrolet Orlando'
WHERE DCODEMODELE=189 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Accord Coupé'
WHERE DCODEMODELE=190 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Accord Tourer'
WHERE DCODEMODELE=191 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Honda City'
WHERE DCODEMODELE=192 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Civic'
WHERE DCODEMODELE=193 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Civic Aerodeck'
WHERE DCODEMODELE=194 ;
 
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Civic Type R'
WHERE DCODEMODELE=195 ;
UPDATE Dmodele
SET DLIBELLEMODELE='Honda CR-V'
WHERE DCODEMODELE=196 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Honda HR-V'
WHERE DCODEMODELE=197 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Insight'
WHERE DCODEMODELE=198 ;
  
UPDATE Dmodele
SET DLIBELLEMODELE='Honda Integra'
WHERE DCODEMODELE=199 ;

UPDATE DMODELE
SET DLIBELLEMODELE='HONDA JAZZ')
WHERE DCODEMODELE=200;
​
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

​drop MATERIALIZED VIEW VMCATrimestriel;


CREATE MATERIALIZED VIEW VMCATrimestriel
     PARALLEL 4
     BUILD IMMEDIATE
     REFRESH COMPLETE
     AS SELECT t.TRIMESTRE,m.DLibellemodele,a.DNOMWILAYA
                               ,sum(f.F_CA) as Chiffre_global
                               ,sum(f.F_NBCONTRAT) as Nombre_de_contrats
                               FROM DMODELE m ,FSOUSCRIPTION f, DASSURE a,DTEMPS t
       where m.DCODEMODELE=f.FCODEMODELE
       AND f.FNUMASS=a.DNUMASS
       AND t.CODE_TEMPS=f.FCODETEMPS
   GROUP BY t.ANNEE,t.TRIMESTRE,m.DLibellemodele,a.DNOMWILAYA;​

drop MATERIALIZED VIEW VMCAMarque;


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













