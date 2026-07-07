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

-- insertion des tables 
-- table PAYS
INSERT INTO PAYS (CodePays, NomPays) VALUES
('GBR', 'Grande Bretagne'),
('ITA', 'Italie'),
('ALL', 'Allemagne'),
('ESP', 'Espagne'),
('FRA', 'France');

-- table EQUIPE
INSERT INTO EQUIPE (CodeEquipe, NomEquipe, DirecteurSportif, DateDeCreation, SiteWeb) VALUES
('CA',  'Crédit Agricole',    'Roger LEGEAY',         '1932-12-08', 'www.au-veloclubdeparis.fr'),
('LIQ', 'Liquigas',           'Roberto AMADIO',       '1955-06-12', 'www.teamliquigas.com'),
('CGE', 'Caisse d''épargne',  'José Miguel CHAVARRI', '1948-02-08', 'www.cyclisme-caisseepargne.fr'),
('FES', 'Festina',            'Stéphane AUGÉ',        '1912-04-24', 'http://festina.ifrance.com');

-- table TYPE_ETAPE
INSERT INTO TYPE_ETAPE (CodeType, LibelléType) VALUES
('PL', 'Plaine'),
('CM', 'Contre-la-montre individuel'),
('MM', 'Moyenne montagne'),
('HM', 'Haute montagne');

-- table PAYS
INSERT INTO COUREUR (NuméroCoureur, NomCoureur, CodeEquipe, CodePays) VALUES
(1, 'Chris Boardman',    'LIQ', 'GBR'),
(2, 'Mario Cipollini',   'FES', 'ITA'),
(3, 'Erik Zabel',        'CGE', 'ALL'),
(4, 'Nicola Minali',     'LIQ', 'ITA'),
(5, 'Cédric Vasseur',    'CA',  'FRA'),
(6, 'Jeroen Blijlevens', 'LIQ', 'ESP'),
(7, 'Laurent Brochard',  'CA',  'FRA'),
(8, 'Jan Ullrich',       'CGE', 'ALL');

-- table ETAPE
INSERT INTO ETAPE (NuméroEtape, DateEtape, VilleDép, VilleArr, NbKm, CodeType) VALUES
(1,  '2010-07-05', 'Rouen',                 'Forges-les-Eaux',              192,   'PL'),
(2,  '2010-07-06', 'St-Valéry-en-Caux',     'Vire',                         262,   'PL'),
(3,  '2010-07-07', 'Vire',                  'Plumelec',                     224,   'PL'),
(4,  '2010-07-08', 'Plumelec',              'Le Puy du Fou',                223,   'CM'),
(5,  '2010-07-09', 'Chantonnay',            'La Châtre',                    261.5, 'PL'),
(6,  '2010-07-10', 'Le Blanc',              'Marennes',                     217.5, 'MM'),
(7,  '2010-07-11', 'Marennes',              'Bordeaux',                     194,   'MM'),
(8,  '2010-07-12', 'Sauternes',             'Pau',                          161.5, 'PL'),
(9,  '2010-07-13', 'Pau',                   'Loudenvielle-Vallée du Louron',182,   'HM'),
(10, '2010-07-14', 'Luchon',                'Andorre-Arcalis',              252.5, 'HM'),
(11, '2010-07-16', 'Andorre',               'Perpignan',                    192,   'MM'),
(12, '2010-07-17', 'Saint-Etienne',         'Saint-Etienne',                55.5,  'PL'),
(13, '2010-07-18', 'Saint-Etienne',         'L''Alpe d''Huez',              203.5, 'PL'),
(14, '2010-07-19', 'Le Bourg-d''Oisans',    'Courchevel',                   148,   'PL'),
(15, '2010-07-20', 'Courchevel',            'Morzine',                      208.5, 'HM'),
(16, '2010-07-22', 'Morzine',               'Fribourg',                     181,   'HM'),
(17, '2010-07-23', 'Fribourg',              'Colmar',                       218.5, 'HM'),
(18, '2010-07-24', 'Colmar',                'Montbéliard',                  175.5, 'MM'),
(19, '2010-07-25', 'Montbéliard',           'Dijon',                        172,   'PL'),
(20, '2010-07-26', 'Disneyland Paris',      'Disneyland Paris',             63,    'CM'),
(21, '2010-07-27', 'Disneyland Paris',      'Paris Champs-Elysées',         149.5, 'PL');

-- table ETAPE
INSERT INTO PARTICIPER (NuméroCoureur, NuméroEtape, TempsRéalisé, TempsConvertiSec) VALUES
(1, 1, '3h 58'' 13"', 14293),
(1, 2, '3h 12'' 14"', 11534),
(2, 1, '3h 59'' 15"', 14355),
(2, 3, '3h 21'' 33"', 12093),
(1, 3, '4h 22'' 54"', 15774),
(3, 1, '4h 00'' 34"', 14434),
(4, 1, '4h 18'' 56"', 15536),
(1, 4, '4h 44'' 32"', 17072),
(2, 4, '4h 18'' 11"', 15491),
(3, 2, '3h 50'' 03"', 13803),
(4, 2, '3h 28'' 36"', 12516),
(2, 5, '4h 55'' 59"', 17759),
(3, 3, '4h 05'' 12"', 14712),
(4, 3, '4h 44'' 28"', 17068),
(3, 4, '4h 30'' 46"', 16246),
(4, 4, '4h 25'' 56"', 15956),
(2, 6, '3h 10'' 09"', 11409),
(1, 5, '4h 59'' 05"', 17945),
(1, 6, '3h 12'' 02"', 11522);

--  Modification de l'équipe du coureur Erik Zabel par LIQUIGAS
UPDATE COUREUR
SET CodeEquipe = 'LIQ'
WHERE NuméroCoureur = 3;

--  Modification du le nombre de kilomètres de l'étape 05 à 187 km
UPDATE ETAPE
SET NbKm = 187
WHERE NuméroEtape = 5;

--  Suppression de tous les coureurs de l'équipe « Festina »
-- Étape 1 : supprimer d'abord les participations liées 
DELETE FROM PARTICIPER
WHERE NuméroCoureur IN (
    SELECT NuméroCoureur FROM COUREUR WHERE CodeEquipe = 'FES'
);

-- Étape 2 : supprimer ensuite les coureurs de l'équipe Festina
DELETE FROM COUREUR
WHERE CodeEquipe = 'FES';

-- a) Liste des coureurs du Tour 2010
SELECT NomCoureur
FROM COUREUR;

-- b) Liste des codes et noms des équipes ayant participé au Tour 2010
SELECT CodeEquipe, NomEquipe
FROM EQUIPE;

-- c) Liste des pays qui n'ont pas eu de cyclistes pour les représenter
SELECT CodePays, NomPays
FROM PAYS
WHERE CodePays NOT IN (
    SELECT CodePays
    FROM COUREUR
);

-- d) Liste des étapes ayant une distance d'au moins 100 km et de type Descente
SELECT *
FROM ETAPE
WHERE Distance >= 100
AND TypeEtape = 'Descente';

-- e) Le nombre de coureurs par équipe
SELECT E.CodeEquipe, E.NomEquipe, COUNT(C.NumCoureur) AS NbCoureurs
FROM EQUIPE E
JOIN COUREUR C
ON E.CodeEquipe = C.CodeEquipe
GROUP BY E.CodeEquipe, E.NomEquipe;

-- f) Liste des étapes contenant des cyclistes absents parmi l'ensemble des inscrits
SELECT E.NumEtape
FROM ETAPE E
WHERE (
    SELECT COUNT(*)
    FROM PARTICIPER P
    WHERE P.NumEtape = E.NumEtape
) < (
    SELECT COUNT(*)
    FROM COUREUR
);

-- g) Donner le vainqueur par étape
SELECT E.NumEtape
FROM ETAPE E
WHERE (
    SELECT COUNT(*)
    FROM PARTICIPER P
    WHERE P.NumEtape = E.NumEtape
) < (
    SELECT COUNT(*)
    FROM COUREUR
);

-- h) Donner le vainqueur du Tour 2010
SELECT C.NomCoureur, SUM(P.Temps) AS TempsTotal
FROM COUREUR C
JOIN PARTICIPER P
ON C.NumCoureur = P.NumCoureur
GROUP BY C.NumCoureur, C.NomCoureur
HAVING COUNT(DISTINCT P.NumEtape) = (
    SELECT COUNT(*)
    FROM ETAPE
)
ORDER BY TempsTotal ASC
LIMIT 1;