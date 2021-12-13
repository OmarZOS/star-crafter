

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

