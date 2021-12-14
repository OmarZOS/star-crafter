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


drop table DTYPE cascade constraints;
CREATE TABLE DTYPE(
   DCODETYPE           NUMBER(2)            not null,
   DLIBELLETYPE        VARCHAR2(50),  
   
   constraint PK_DTYPE primary key (DCODETYPE)
);



drop table DMODELE cascade constraints;
CREATE TABLE DMODELE(
   DCODEMODELE           NUMBER(4)            not null,
   DLIBELLEMODELE        VARCHAR2(70),
   DCODEMARQUE           NUMBER(4)            not null,
   DLIBELLEMARQUE        VARCHAR2(50),
   DNATIONALITE          VARCHAR2(50),  
   constraint PK_DMODELE primary key (DCODEMODELE)
);


drop table DCompagnie cascade constraints;
CREATE TABLE DCompagnie(
   DCODE_COMP            NUMBER(10)           not null,
   DNOM_COMP             VARCHAR2(70),
   DTYPE_COMP            VARCHAR2(20),
   constraint PK_DCOMPAGNIE primary key (DCODE_COMP)
);

drop sequence seq;

CREATE SEQUENCE seq
MINVALUE 1
MAXVALUE 1000000
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













