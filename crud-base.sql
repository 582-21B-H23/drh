-- Les 4 commandes de base

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

INSERT INTO titre VALUES 
    (500000, 'Engineer', '2023-02-23', '9999-01-01');

INSERT INTO salaire VALUES 
    (500000, 75000, '2023-02-23', '9999-01-01');

