/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  16/11/2022 15:29:22                      */
/*==============================================================*/


alter table Absence
   drop constraint FK_ABSENCE_APPARTENI_TYPEABSE;

alter table Absence
   drop constraint FK_ABSENCE_LIER_DOSSIER;

alter table Absence
   drop constraint FK_ABSENCE_S_ABSENTE_SALARIE;

alter table Agence
   drop constraint FK_AGENCE_ETREMAISO_AGENCE;

alter table Agence
   drop constraint FK_AGENCE_ETRERESPO_SALARIE;

alter table Dossier
   drop constraint FK_DOSSIER_ETRECHEFD_SALARIE;

alter table Dossier
   drop constraint FK_DOSSIER_ETRECHEFE_SALARIE;

alter table Dossier
   drop constraint FK_DOSSIER_ETRECOMME_SALARIE;

alter table Dossier
   drop constraint FK_DOSSIER_FORMULER_CLIENT;

alter table Dossier
   drop constraint FK_DOSSIER_SELECTION_FORMULE;

alter table Immobilisation
   drop constraint FK_IMMOBILI_ETRE_VEHICULE;

alter table Immobilisation
   drop constraint FK_IMMOBILI_GERER_GARAGE;

alter table Salarie
   drop constraint FK_SALARIE_ETRECONCU_SALARIE;

alter table Vehicule
   drop constraint FK_VEHICULE_APPARTENI_TYPEVEHI;

alter table Vehicule
   drop constraint FK_VEHICULE_APPARTENI_AGENCE;

alter table affilierDemenageur
   drop constraint FK_AFFILIER_AFFILIERD_SALARIE;

alter table affilierDemenageur
   drop constraint FK_AFFILIER_AFFILIERD_DOSSIER;

alter table conduire
   drop constraint FK_CONDUIRE_CONDUIRE_SALARIE;

alter table conduire
   drop constraint FK_CONDUIRE_CONDUIRE2_VEHICULE;

alter table conduire
   drop constraint FK_CONDUIRE_CONDUIRE3_DOSSIER;

alter table etreResponsableEnfant
   drop constraint FK_ETRERESP_ETRERESPO_SALARIE;

alter table etreResponsableEnfant
   drop constraint FK_ETRERESP_ETRERESPO_ENFANT;

alter table travailler
   drop constraint FK_TRAVAILL_TRAVAILLE_SALARIE;

alter table travailler
   drop constraint FK_TRAVAILL_TRAVAILLE_AGENCE;

drop index LIER_FK;

drop index S_ABSENTER_FK;

drop index APPARTENIR_FK;

drop table Absence cascade constraints;

drop index ETREMAISONMERE_FK;

drop index ETRERESPONSABLEAG_FK;

drop table Agence cascade constraints;

drop table Client cascade constraints;

drop index FORMULER_FK;

drop index SELECTIONNER_FK;

drop index ETRECHEFEXPLOITATION_FK;

drop index ETRECHEFDEMENAGEUR_FK;

drop index ETRECOMMERCIAL_FK;

drop table Dossier cascade constraints;

drop table Enfant cascade constraints;

drop table Formule cascade constraints;

drop table Garage cascade constraints;

drop index GERER_FK;

drop index ETRE_FK;

drop table Immobilisation cascade constraints;

drop index ETRECONCUBIN_FK;

drop table Salarie cascade constraints;

drop table TypeAbsence cascade constraints;

drop table TypeVehicule cascade constraints;

drop index APPARTENIRFLOTE_FK;

drop index APPARTENIR2_FK;

drop table Vehicule cascade constraints;

drop index AFFILIERDEMENAGEUR2_FK;

drop index AFFILIERDEMENAGEUR_FK;

drop table affilierDemenageur cascade constraints;

drop index CONDUIRE3_FK;

drop index CONDUIRE2_FK;

drop index CONDUIRE_FK;

drop table conduire cascade constraints;

drop index ETRERESPONSABLEENFANT2_FK;

drop index ETRERESPONSABLEENFANT_FK;

drop table etreResponsableEnfant cascade constraints;

drop index TRAVAILLER2_FK;

drop index TRAVAILLER_FK;

drop table travailler cascade constraints;

/*==============================================================*/
/* Table : Absence                                              */
/*==============================================================*/
create table Absence 
(
   n_abs                INTEGER              not null,
   n_tpAbs              INTEGER              not null,
   n_dossier            INTEGER,
   n_personne           INTEGER              not null,
   dateDebAbs           DATE,
   nbJourAbs            INTEGER,
   etatAbs              CHAR(2)             
      constraint CKC_ETATABS_ABSENCE check (etatAbs is null or (etatAbs in ('OK','NO'))),
   dateReponseAbs       DATE,
   dateDemandeAbs       DATE,
   constraint PK_ABSENCE primary key (n_abs)
);

/*==============================================================*/
/* Index : APPARTENIR_FK                                        */
/*==============================================================*/
create index APPARTENIR_FK on Absence (
   n_tpAbs ASC
);

/*==============================================================*/
/* Index : S_ABSENTER_FK                                        */
/*==============================================================*/
create index S_ABSENTER_FK on Absence (
   n_personne ASC
);

/*==============================================================*/
/* Index : LIER_FK                                              */
/*==============================================================*/
create index LIER_FK on Absence (
   n_dossier ASC
);

/*==============================================================*/
/* Table : Agence                                               */
/*==============================================================*/
create table Agence 
(
   n_ag                 INTEGER              not null,
   Age_n_ag             INTEGER,
   n_personne           INTEGER,
   nomAg                VARCHAR2(25),
   adAg                 VARCHAR2(25),
   CPAg                 INTEGER,
   villeAg              VARCHAR2(25),
   longitudeAg          FLOAT,
   latitudeAg           FLOAT,
   constraint PK_AGENCE primary key (n_ag)
);

/*==============================================================*/
/* Index : ETRERESPONSABLEAG_FK                                 */
/*==============================================================*/
create index ETRERESPONSABLEAG_FK on Agence (
   n_personne ASC
);

/*==============================================================*/
/* Index : ETREMAISONMERE_FK                                    */
/*==============================================================*/
create index ETREMAISONMERE_FK on Agence (
   Age_n_ag ASC
);

/*==============================================================*/
/* Table : Client                                               */
/*==============================================================*/
create table Client 
(
   n_personne           INTEGER              not null,
   emailClient          VARCHAR2(50),
   nomPersonne          VARCHAR2(25),
   prenomPersonne       VARCHAR2(25),
   adPersonne           VARCHAR2(25),
   CPPersonne           INTEGER,
   villePersonne        VARCHAR2(25),
   telPersonne          INTEGER,
   sexePersonne         CHAR(1)             
      constraint CKC_SEXEPERSONNE_CLIENT check (sexePersonne is null or (sexePersonne in ('H','F'))),
   dateNaisPersonne     DATE,
   constraint PK_CLIENT primary key (n_personne)
);

/*==============================================================*/
/* Table : Dossier                                              */
/*==============================================================*/
create table Dossier 
(
   n_dossier            INTEGER              not null,
   n_form               INTEGER,
   n_personne           INTEGER              not null,
   Sal_n_personne       INTEGER,
   Sal_n_personne2      INTEGER,
   Sal_n_personne3      INTEGER,
   etatDossier          VARCHAR2(15)         default 'CONTACT'
      constraint CKC_ETATDOSSIER_DOSSIER check (etatDossier is null or (etatDossier in ('CONTACT','DEMOK','AVISITER','VISITEOK','PLAN','PLANOK','CLOS'))),
   dateDemandeDossier   DATE,
   dateVisiteDossier    DATE,
   dateClotureDossier   DATE,
   conditionAccesDossier VARCHAR2(100),
   dateDptDossier       DATE,
   adDptDossier         VARCHAR2(25),
   CPDptDossier         INTEGER,
   villeDptDossier      VARCHAR2(25),
   latitudeDptDossier   FLOAT,
   longituteDptDossier  FLOAT,
   dateArrDossier       DATE,
   adArrDossier         VARCHAR2(25),
   CPArrDossier         INTEGER,
   villeArrDossier      VARCHAR2(25),
   latitudeArrDossier   FLOAT,
   longitudeArrDossier  FLOAT,
   volumeADeplacerDossier FLOAT,
   constraint PK_DOSSIER primary key (n_dossier)
);

/*==============================================================*/
/* Index : ETRECOMMERCIAL_FK                                    */
/*==============================================================*/
create index ETRECOMMERCIAL_FK on Dossier (
   Sal_n_personne ASC
);

/*==============================================================*/
/* Index : ETRECHEFDEMENAGEUR_FK                                */
/*==============================================================*/
create index ETRECHEFDEMENAGEUR_FK on Dossier (
   Sal_n_personne2 ASC
);

/*==============================================================*/
/* Index : ETRECHEFEXPLOITATION_FK                              */
/*==============================================================*/
create index ETRECHEFEXPLOITATION_FK on Dossier (
   Sal_n_personne3 ASC
);

/*==============================================================*/
/* Index : SELECTIONNER_FK                                      */
/*==============================================================*/
create index SELECTIONNER_FK on Dossier (
   n_form ASC
);

/*==============================================================*/
/* Index : FORMULER_FK                                          */
/*==============================================================*/
create index FORMULER_FK on Dossier (
   n_personne ASC
);

/*==============================================================*/
/* Table : Enfant                                               */
/*==============================================================*/
create table Enfant 
(
   n_personne           INTEGER              not null,
   nomPersonne          VARCHAR2(25),
   prenomPersonne       VARCHAR2(25),
   adPersonne           VARCHAR2(25),
   CPPersonne           INTEGER,
   villePersonne        VARCHAR2(25),
   telPersonne          INTEGER,
   sexePersonne         CHAR(1)             
      constraint CKC_SEXEPERSONNE_ENFANT check (sexePersonne is null or (sexePersonne in ('H','F'))),
   dateNaisPersonne     DATE,
   constraint PK_ENFANT primary key (n_personne)
);

/*==============================================================*/
/* Table : Formule                                              */
/*==============================================================*/
create table Formule 
(
   n_form               INTEGER              not null,
   libForm              VARCHAR2(25),
   prixHTForm           FLOAT,
   constraint PK_FORMULE primary key (n_form)
);

/*==============================================================*/
/* Table : Garage                                               */
/*==============================================================*/
create table Garage 
(
   n_garage             INTEGER              not null,
   adGarage             VARCHAR2(25),
   CPGarage             INTEGER,
   villeGarage          VARCHAR2(25),
   telGarage            INTEGER,
   constraint PK_GARAGE primary key (n_garage)
);

/*==============================================================*/
/* Table : Immobilisation                                       */
/*==============================================================*/
create table Immobilisation 
(
   n_immobilisation     INTEGER              not null,
   n_garage             INTEGER              not null,
   n_vhc                INTEGER              not null,
   tpImmobilisation     VARCHAR2(20)        
      constraint CKC_TPIMMOBILISATION_IMMOBILI check (tpImmobilisation is null or (tpImmobilisation in ('entretien','contrôle technique','réparation'))),
   nbKmImmobilisation   FLOAT,
   dateDebImmobilisation DATE,
   dateFinImmobilisation DATE,
   infoSupImmobilisation VARCHAR2(100),
   constraint PK_IMMOBILISATION primary key (n_immobilisation)
);

/*==============================================================*/
/* Index : ETRE_FK                                              */
/*==============================================================*/
create index ETRE_FK on Immobilisation (
   n_vhc ASC
);

/*==============================================================*/
/* Index : GERER_FK                                             */
/*==============================================================*/
create index GERER_FK on Immobilisation (
   n_garage ASC
);

/*==============================================================*/
/* Table : Salarie                                              */
/*==============================================================*/
create table Salarie 
(
   n_personne           INTEGER              not null,
   Sal_n_personne       INTEGER,
   dateEmbaucheSal      DATE                 not null,
   numPermisSal         INTEGER,
   capaciteMeneurSal    CHAR(3)              not null
      constraint CKC_CAPACITEMENEURSAL_SALARIE check (capaciteMeneurSal in ('oui','non')),
   typeSal              VARCHAR2(12)         not null
      constraint CKC_TYPESAL_SALARIE check (typeSal in ('chef d''Exploitation','commercial','demenageur')),
   nomPersonne          VARCHAR2(25),
   prenomPersonne       VARCHAR2(25),
   adPersonne           VARCHAR2(25),
   CPPersonne           INTEGER,
   villePersonne        VARCHAR2(25),
   telPersonne          INTEGER,
   sexePersonne         CHAR(1)             
      constraint CKC_SEXEPERSONNE_SALARIE check (sexePersonne is null or (sexePersonne in ('H','F'))),
   dateNaisPersonne     DATE,
   constraint PK_SALARIE primary key (n_personne)
);

/*==============================================================*/
/* Index : ETRECONCUBIN_FK                                      */
/*==============================================================*/
create index ETRECONCUBIN_FK on Salarie (
   Sal_n_personne ASC
);

/*==============================================================*/
/* Table : TypeAbsence                                          */
/*==============================================================*/
create table TypeAbsence 
(
   n_tpAbs              INTEGER              not null,
   libTpAbs             VARCHAR2(25),
   constraint PK_TYPEABSENCE primary key (n_tpAbs)
);

/*==============================================================*/
/* Table : TypeVehicule                                         */
/*==============================================================*/
create table TypeVehicule 
(
   n_tpVhc              INTEGER              not null,
   libTpVhc             VARCHAR2(25),
   marqueVhc            VARCHAR2(25),
   PTACVhc              FLOAT,
   constraint PK_TYPEVEHICULE primary key (n_tpVhc)
);

/*==============================================================*/
/* Table : Vehicule                                             */
/*==============================================================*/
create table Vehicule 
(
   n_vhc                INTEGER              not null,
   n_tpVhc              INTEGER              not null,
   n_ag                 INTEGER              not null,
   volumeVhc            FLOAT,
   hayonVhc             CHAR(3)             
      constraint CKC_HAYONVHC_VEHICULE check (hayonVhc is null or (hayonVhc in ('OUI','NON'))),
   couchetteVhc         CHAR(3)             
      constraint CKC_COUCHETTEVHC_VEHICULE check (couchetteVhc is null or (couchetteVhc in ('OUI','NON'))),
   nbPlaceVhc           INTEGER,
   immatriculationVhc   CHAR(9)              not null,
   frequenceEntretien   INTEGER,
   prixKmVhc            FLOAT,
   dateMiseCirculationVhc DATE,
   constraint PK_VEHICULE primary key (n_vhc)
);

/*==============================================================*/
/* Index : APPARTENIR2_FK                                       */
/*==============================================================*/
create index APPARTENIR2_FK on Vehicule (
   n_tpVhc ASC
);

/*==============================================================*/
/* Index : APPARTENIRFLOTE_FK                                   */
/*==============================================================*/
create index APPARTENIRFLOTE_FK on Vehicule (
   n_ag ASC
);

/*==============================================================*/
/* Table : affilierDemenageur                                   */
/*==============================================================*/
create table affilierDemenageur 
(
   n_personne           INTEGER              not null,
   n_dossier            INTEGER              not null,
   constraint PK_AFFILIERDEMENAGEUR primary key (n_personne, n_dossier)
);

comment on table affilierDemenageur is
'salarié de type "déménagueur"';

/*==============================================================*/
/* Index : AFFILIERDEMENAGEUR_FK                                */
/*==============================================================*/
create index AFFILIERDEMENAGEUR_FK on affilierDemenageur (
   n_personne ASC
);

/*==============================================================*/
/* Index : AFFILIERDEMENAGEUR2_FK                               */
/*==============================================================*/
create index AFFILIERDEMENAGEUR2_FK on affilierDemenageur (
   n_dossier ASC
);

/*==============================================================*/
/* Table : conduire                                             */
/*==============================================================*/
create table conduire 
(
   n_personne           INTEGER              not null,
   n_vhc                INTEGER              not null,
   n_dossier            INTEGER              not null,
   nbKmConduir          FLOAT,
   tempsConduir         FLOAT,
   constraint PK_CONDUIRE primary key (n_personne, n_vhc, n_dossier)
);

/*==============================================================*/
/* Index : CONDUIRE_FK                                          */
/*==============================================================*/
create index CONDUIRE_FK on conduire (
   n_personne ASC
);

/*==============================================================*/
/* Index : CONDUIRE2_FK                                         */
/*==============================================================*/
create index CONDUIRE2_FK on conduire (
   n_vhc ASC
);

/*==============================================================*/
/* Index : CONDUIRE3_FK                                         */
/*==============================================================*/
create index CONDUIRE3_FK on conduire (
   n_dossier ASC
);

/*==============================================================*/
/* Table : etreResponsableEnfant                                */
/*==============================================================*/
create table etreResponsableEnfant 
(
   Sal_n_personne       INTEGER              not null,
   n_personne           INTEGER              not null,
   constraint PK_ETRERESPONSABLEENFANT primary key (Sal_n_personne, n_personne)
);

/*==============================================================*/
/* Index : ETRERESPONSABLEENFANT_FK                             */
/*==============================================================*/
create index ETRERESPONSABLEENFANT_FK on etreResponsableEnfant (
   Sal_n_personne ASC
);

/*==============================================================*/
/* Index : ETRERESPONSABLEENFANT2_FK                            */
/*==============================================================*/
create index ETRERESPONSABLEENFANT2_FK on etreResponsableEnfant (
   n_personne ASC
);

/*==============================================================*/
/* Table : travailler                                           */
/*==============================================================*/
create table travailler 
(
   n_personne           INTEGER              not null,
   n_ag                 INTEGER              not null,
   tauxPresenceTravailler INTEGER,
   constraint PK_TRAVAILLER primary key (n_personne, n_ag)
);

/*==============================================================*/
/* Index : TRAVAILLER_FK                                        */
/*==============================================================*/
create index TRAVAILLER_FK on travailler (
   n_personne ASC
);

/*==============================================================*/
/* Index : TRAVAILLER2_FK                                       */
/*==============================================================*/
create index TRAVAILLER2_FK on travailler (
   n_ag ASC
);

alter table Absence
   add constraint FK_ABSENCE_APPARTENI_TYPEABSE foreign key (n_tpAbs)
      references TypeAbsence (n_tpAbs);

alter table Absence
   add constraint FK_ABSENCE_LIER_DOSSIER foreign key (n_dossier)
      references Dossier (n_dossier);

alter table Absence
   add constraint FK_ABSENCE_S_ABSENTE_SALARIE foreign key (n_personne)
      references Salarie (n_personne);

alter table Agence
   add constraint FK_AGENCE_ETREMAISO_AGENCE foreign key (Age_n_ag)
      references Agence (n_ag);

alter table Agence
   add constraint FK_AGENCE_ETRERESPO_SALARIE foreign key (n_personne)
      references Salarie (n_personne);

alter table Dossier
   add constraint FK_DOSSIER_ETRECHEFD_SALARIE foreign key (Sal_n_personne2)
      references Salarie (n_personne);

alter table Dossier
   add constraint FK_DOSSIER_ETRECHEFE_SALARIE foreign key (Sal_n_personne3)
      references Salarie (n_personne);

alter table Dossier
   add constraint FK_DOSSIER_ETRECOMME_SALARIE foreign key (Sal_n_personne)
      references Salarie (n_personne);

alter table Dossier
   add constraint FK_DOSSIER_FORMULER_CLIENT foreign key (n_personne)
      references Client (n_personne);

alter table Dossier
   add constraint FK_DOSSIER_SELECTION_FORMULE foreign key (n_form)
      references Formule (n_form);

alter table Immobilisation
   add constraint FK_IMMOBILI_ETRE_VEHICULE foreign key (n_vhc)
      references Vehicule (n_vhc);

alter table Immobilisation
   add constraint FK_IMMOBILI_GERER_GARAGE foreign key (n_garage)
      references Garage (n_garage);

alter table Salarie
   add constraint FK_SALARIE_ETRECONCU_SALARIE foreign key (Sal_n_personne)
      references Salarie (n_personne);

alter table Vehicule
   add constraint FK_VEHICULE_APPARTENI_TYPEVEHI foreign key (n_tpVhc)
      references TypeVehicule (n_tpVhc);

alter table Vehicule
   add constraint FK_VEHICULE_APPARTENI_AGENCE foreign key (n_ag)
      references Agence (n_ag);

alter table affilierDemenageur
   add constraint FK_AFFILIER_AFFILIERD_SALARIE foreign key (n_personne)
      references Salarie (n_personne);

alter table affilierDemenageur
   add constraint FK_AFFILIER_AFFILIERD_DOSSIER foreign key (n_dossier)
      references Dossier (n_dossier);

alter table conduire
   add constraint FK_CONDUIRE_CONDUIRE_SALARIE foreign key (n_personne)
      references Salarie (n_personne);

alter table conduire
   add constraint FK_CONDUIRE_CONDUIRE2_VEHICULE foreign key (n_vhc)
      references Vehicule (n_vhc);

alter table conduire
   add constraint FK_CONDUIRE_CONDUIRE3_DOSSIER foreign key (n_dossier)
      references Dossier (n_dossier);

alter table etreResponsableEnfant
   add constraint FK_ETRERESP_ETRERESPO_SALARIE foreign key (Sal_n_personne)
      references Salarie (n_personne);

alter table etreResponsableEnfant
   add constraint FK_ETRERESP_ETRERESPO_ENFANT foreign key (n_personne)
      references Enfant (n_personne);

alter table travailler
   add constraint FK_TRAVAILL_TRAVAILLE_SALARIE foreign key (n_personne)
      references Salarie (n_personne);

alter table travailler
   add constraint FK_TRAVAILL_TRAVAILLE_AGENCE foreign key (n_ag)
      references Agence (n_ag);

