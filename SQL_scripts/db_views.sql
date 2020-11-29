--CREATING VIEWS TO DATABASE

--Creating view to show available vehicles
CREATE OR REPLACE VIEW show_available_vehicles AS
SELECT  pojazdy.id_pojazdu, pojazdy.id_modelu, modele.model,
        pojazdy.rocznik, modele.pojemnoscsilnika, modele.kategoriaprawajazdy
FROM pojazdy
INNER JOIN modele ON pojazdy.id_modelu = modele.id_modelu
FULL OUTER JOIN wypozyczenia ON pojazdy.id_pojazdu = wypozyczenia.id_pojazdu
WHERE (SELECT COUNT(wypozyczenia.id_pojazdu) 
        FROM wypozyczenia
        WHERE id_zwrotu IS NULL
            AND pojazdy.id_pojazdu = wypozyczenia.id_pojazdu) = 0;
            
COMMIT;