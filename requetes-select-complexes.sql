-- 17) Numéro d'employé, Nom, Date d'embauche, Date fin d'emploi, et Années de service 
--      des employés embauchés après 1995, 
--      triés par années de service en ordre descendant.
SELECT  e.num_employe,
        nom,
        date_embauche,
        MAX(date_fin) AS dateFinEmploi,
        if(
            YEAR(MAX(date_fin)) = 9999,
            DATEDIFF(CURDATE(), date_embauche)/365,
            DATEDIFF(MAX(date_fin), date_embauche)/365
        )
        AS anneesDeService
    FROM employe AS e 
        JOIN employe_departement AS ed ON e.num_employe = ed.num_employe 
    WHERE 
        YEAR(date_embauche) > 1995
    GROUP BY e.num_employe
    ORDER BY anneesDeService DESC;

-- 18) Même chose mais seulement pour les employés ayant plus de 25 ans d'années de service
SELECT  e.num_employe,
        nom,
        date_embauche,
        MAX(date_fin) AS dateFinEmploi,
        if(
            YEAR(MAX(date_fin)) = 9999,
            DATEDIFF(CURDATE(), date_embauche)/365,
            DATEDIFF(MAX(date_fin), date_embauche)/365
        ) AS anneesDeService
    FROM employe AS e 
        JOIN employe_departement AS ed ON e.num_employe = ed.num_employe 
    WHERE 
        YEAR(date_embauche) > 1995
    GROUP BY e.num_employe
    HAVING anneesDeService > 25
    ORDER BY anneesDeService DESC;

-- 19) Même chose mais pour les employés ayant entre 20 et 25 ans de services seulement.
SELECT  e.num_employe,
        nom,
        date_embauche,
        MAX(date_fin) AS dateFinEmploi,
        if(
            YEAR(MAX(date_fin)) = 9999,
            DATEDIFF(CURDATE(), date_embauche)/365,
            DATEDIFF(MAX(date_fin), date_embauche)/365
        ) AS anneesDeService
    FROM employe AS e 
        JOIN employe_departement AS ed ON e.num_employe = ed.num_employe 
    WHERE 
        YEAR(date_embauche) > 1995
    GROUP BY e.num_employe
    HAVING anneesDeService BETWEEN 20 AND 25
    ORDER BY anneesDeService DESC;
