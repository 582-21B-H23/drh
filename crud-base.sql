-- Les 4 commandes de base

-- CRUD : Create, Read, Update, Delete
-- En SQL : INSERT, SELECT, UPDATE, DELETE

-- Ajout de données
-- Insert des enregistrements dans UNE table
-- Commande INSERT
-- INSERT INTO nomDeTable VALUES 
--       (val1, val2, ...),
--       (val1, val2, ...),
--       ...
--       (val1, val2, ...);

-- Exemple : Ajouter un employé nommé masculin Arthur Gagné à 
-- titre d'ingénieur, salaire de 75000 à partir d'aujourd'hui

INSERT INTO employe VALUES 
    (500000, '1991-12-23', 'Arthur', 'Gagné', 'M', CURDATE());

INSERT INTO employe_departement VALUES 
    (500000, 'd005', '2023-02-23', '9999-01-01');

INSERT INTO 'titre' VALUES 
    (500000, 'Engineer', '2023-02-23', '9999-01-01');

INSERT INTO salaire VALUES 
    (500000, 75000, '2023-02-23', '9999-01-01');

-- "Lecture" les données.
-- Commande SELECT
-- Obtient de l'information à partir des enregistrements dans une ou plusieurs tables
-- Syntaxe de base :
--  SELECT col1, col2, ... FROM nomTable1, nomTable2, ... 
--      WHERE (condition)   // Pour filtrer
--      GROUP BY colonne    // Grouper les résultats
--      ORDER BY col1, col2, etc.   // Pour trier
--      LIMIT m,n           // Pour limiter les enregistrements retourner
-- Énormément de variation et d'autres clauses, et fonctions, etc...

-- Exemples

-- 1 : Afficher les titres de postes distincts
SELECT DISTINCT titre FROM titre;

-- Franciser les titres
-- Commande UPDATE : modifier des enregistrements dans UNE table
UPDATE titre SET titre='Ingénieur' WHERE titre='Engineer';
UPDATE titre SET titre='Personnel' WHERE titre='Staff';
UPDATE titre SET titre='Ingénieur principal' WHERE titre='Senior Engineer';
UPDATE titre SET titre='Personnel senior' WHERE titre='Senior Staff';
UPDATE titre SET titre='Ingénieur associé' WHERE titre='Assistant Engineer';
UPDATE titre SET titre='Lead technique' WHERE titre='Technique Leader';
UPDATE titre SET titre='Cadre' WHERE titre='Manager';

-- 2 : Afficher le nom de famille et la date de naissance de tous les employés
SELECT nom, ddn FROM employe;

-- 3: Même chose mais pour les employés embauchés à partir de 1996.
SELECT nom, ddn FROM employe WHERE date_embauche > '1995-12-31';
-- Ou, en utilisant une fonction SQL
SELECT nom, ddn, YEAR(date_embauche) FROM employe WHERE YEAR(date_embauche) > 1995;

-- 4: Même chose mais avec le nom complet (prénom suivi d'un espace suivi du nom)
SELECT 
    CONCAT(prenom, ' ', nom) AS `nom complet`, 
    ddn,
    YEAR(date_embauche) AS `annee d'embauche`
        FROM employe 
            WHERE YEAR(date_embauche) > 1995;

-- 5: Afficher le nombre d'employés *actuels* de la compagnie
-- Remarquez l'utilisation de la fonction D'AGGRÉGAT : COUNT()
SELECT COUNT(num_employe) FROM titre WHERE YEAR(date_fin) > 3000;
SELECT COUNT(num_employe) FROM salaire WHERE YEAR(date_fin) > 3000;
-- Avec un alias
SELECT COUNT(num_employe) AS compteEmployesActuels FROM salaire WHERE YEAR(date_fin) > 3000;

-- 6 : Afficher la moyenne des salaires des employés actuels arrondie à l'entier le plus proche
SELECT ROUND(AVG(salaire)) AS salaireMoyenArrondi 
    FROM salaire 
        WHERE date_fin = '9999-01-01';
-- Défi : Afficher le salaire moyen de chaque employé (identifié par son numéro) actuel sur les années de service
-- Essai erroné : 
-- SELECT num_employe, ROUND(AVG(salaire)) AS salaireMoyenArrondi 
--     FROM salaire;

-- 7: Afficher le nombre d'employés embauchés dans les années 90.
SELECT COUNT(num_employe) AS nbEmployes 
    FROM employe  
        WHERE YEAR(date_embauche) >= 1990 
            AND YEAR(date_embauche) < 2000;

-- 8: Afficher le salaire le plus bas et le salaire le plus haut parmis les employés actuels
SELECT  MIN(salaire) AS salaireLePlusBas,
        MAX(salaire) AS salaireLePlusHaut
            FROM salaire 
                WHERE date_fin > '3000-05-23';

-- Grouper les enregistrements dans une requête SELECT
-- Clause GROUP BY
-- 9 : Nombre d'employés par sexe
SELECT  sexe, 
        COUNT(num_employe) AS nbEmployes 
            FROM employe
                GROUP BY sexe;

-- 10 : Nombre d'employés par âge

-- a) Afficher les noms d'employés et leurs âges
SELECT  DATEDIFF(CURDATE(), ddn) DIV 365 AS age,
        nom
            FROM employe;
-- b) Nombre d'employés par âge
SELECT  DATEDIFF(CURDATE(), ddn) DIV 365 AS age,
        COUNT(num_employe)  nombreEmployes
            FROM employe
                GROUP BY age;

-- 11 : Nombre d'employés par âge et sexe
SELECT  DATEDIFF(CURDATE(), ddn) DIV 365 AS age,
        sexe,
        COUNT(num_employe)  nombreEmployes
            FROM employe
                GROUP BY age,sexe;

-- -----------------------------------------------------
-- JOINDRE des tables
-- Clause JOIN
-- -----------------------------------------------------

-- 12: Afficher le numéro d'employé, nom, et numéro de département 
-- de chaque employé actuel

SELECT  employe.num_employe,
        nom,
        num_departement
            FROM employe
                JOIN employe_departement 
                    ON employe.num_employe = employe_departement.num_employe;

-- OU, plus simplement avec des alias
SELECT  e.num_employe,
        nom,
        num_departement
            FROM employe AS e
                JOIN employe_departement AS ed
                    ON e.num_employe = ed.num_employe;

-- 13 : nom de l'employé et nom de son département
SELECT nom, nom_departement
    FROM employe AS e 
        JOIN employe_departement AS ed 
            ON e.num_employe = ed.num_employe
        JOIN departement AS d
            ON ed.num_departement = d.num_departement;

-- 14 : Le salaire moyen actuel par sexe
SELECT sexe, AVG(salaire) AS salaireMoyen
    FROM employe 
        JOIN salaire ON employe.num_employe = salaire.num_employe
        WHERE date_fin > '9000-01-01'
    GROUP BY sexe;


-- 15 : Obtenir le nom, sexe, date d'embauche, dernier titre, 
-- et dernier salaire des 8 employés actuels les mieux payés dans la compagnie
SELECT 
    nom,
    sexe, 
    date_embauche,
    titre,
    salaire
    FROM employe AS e 
        JOIN titre AS t on e.num_employe = t.num_employe
        JOIN salaire AS s ON e.num_employe = s.num_employe 
    WHERE 
        YEAR(s.date_fin) = 9999
        AND
        YEAR(t.date_fin) = 9999
    ORDER BY salaire DESC
    LIMIT 8;

-- 16: même chose mais les 13e, 14e, 15e les mieux payés
SELECT 
    nom,
    sexe, 
    date_embauche,
    titre,
    salaire
    FROM employe AS e 
        JOIN titre AS t on e.num_employe = t.num_employe
        JOIN salaire AS s ON e.num_employe = s.num_employe 
    WHERE 
        YEAR(s.date_fin) = 9999
        AND
        YEAR(t.date_fin) = 9999
    ORDER BY sexe, salaire DESC
    LIMIT 1000;