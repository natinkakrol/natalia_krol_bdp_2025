--zadanie 4
INSERT INTO obiekty (name, geom)
SELECT 'obiekt7',
    ST_Collect(a.geom, b.geom)
FROM obiekty AS a
JOIN obiekty AS b 
ON a.name = 'obiekt3' AND b.name = 'obiekt4';

--sprawdzenie
SELECT name, ST_GeometryType(geom)
FROM obiekty
WHERE name = 'obiekt7';