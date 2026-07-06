-- Création de la base de données
CREATE DATABASE TOUR2010;
USE TOUR2010;

-- Création des tables

CREATE TABLE EQUIPE (
    CodeEquipe NUMBER PRIMARY KEY,
    NomEquipe VARCHAR2(50),
    DirecteurSportif VARCHAR2(50),
    SiteWeb VARCHAR2(100),
    Date_creation DATE
);

CREATE TABLE PAYS (
    CodePays NUMBER PRIMARY KEY,
    NomPays VARCHAR2(50)
);

CREATE TABLE TYPE_ETAPE (
    CodeType NUMBER PRIMARY KEY,
    LibelleType VARCHAR2(50)
);

CREATE TABLE ETAPE (
    NumeroEtape NUMBER PRIMARY KEY,
    DateEtape DATE,
    VilleDep VARCHAR2(50),
    VilleArr VARCHAR2(50),
    NbKm NUMBER,
    CodeType NUMBER,
    CONSTRAINT fk_type
        FOREIGN KEY(CodeType)
        REFERENCES TYPE_ETAPE(CodeType)
);

CREATE TABLE COUREUR (
    NumeroCoureur NUMBER PRIMARY KEY,
    NomCoureur VARCHAR2(50),
    CodeEquipe NUMBER,
    CodePays NUMBER,
    CONSTRAINT fk_equipe
        FOREIGN KEY(CodeEquipe)
        REFERENCES EQUIPE(CodeEquipe),
    CONSTRAINT fk_pays
        FOREIGN KEY(CodePays)
        REFERENCES PAYS(CodePays)
);

CREATE TABLE PARTICIPER (
    NumeroCoureur NUMBER,
    NumeroEtape NUMBER,
    TempsRealise NUMBER,
    PRIMARY KEY (NumeroCoureur, NumeroEtape),
    CONSTRAINT fk_coureur
        FOREIGN KEY(NumeroCoureur)
        REFERENCES COUREUR(NumeroCoureur),
    CONSTRAINT fk_etape
        FOREIGN KEY(NumeroEtape)
        REFERENCES ETAPE(NumeroEtape)
);

-- Ajout de l’attribut DATE-NAISSANCE à la relation COUREUR
ALTER TABLE COUREUR
ADD Date_Naissance DATE;

-- verification
DESC COUREUR;

-- supression de la colonne date de création
ALTER TABLE EQUIPE
DROP COLUMN Date_creation;

-- verification de la supression
DESC EQUIPE;

-- colonne recréée
ALTER TABLE EQUIPE
ADD Date_creation DATE;

-- Renommer la colonne DirecteurSportif dans la table EQUIPE par  Dir-SP 
ALTER TABLE EQUIPE
RENAME COLUMN DirecteurSportif TO Dir_SP;

-- vérification
DESC EQUIPE;

-- le nombre de kilomètres dans chaque étape doit être supérieur à 100. 
ALTER TABLE ETAPE
ADD CONSTRAINT ck_nbkms
CHECK (NbKm > 100);

--  la date de création d’une association doit être inférieure à la date actuelle
ALTER TABLE EQUIPE
ADD CONSTRAINT ck_date_creation
CHECK (Date_creation < SYSDATE);

-- chaque étape doit avoir obligatoirement une distance
ALTER TABLE ETAPE
MODIFY NbKm NUMBER NOT NULL;

-- Désactiver une contrainte
ALTER TABLE ETAPE
DISABLE CONSTRAINT ck_nbkms;

-- Réactiver une contrainte
ALTER TABLE ETAPE
ENABLE CONSTRAINT ck_nbkms;

-- Créer la table des erreurs
CREATE TABLE TableErreurs (
    adresse ROWID,
    utilisateur VARCHAR2(30),
    nomTable VARCHAR2(30),
    nomContrainte VARCHAR2(30)
);

