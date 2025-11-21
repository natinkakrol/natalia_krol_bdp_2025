--zadanie 3: linia musi być zamknięta (pierwszy = ostatni punkt)
UPDATE obiekty
SET geom = ST_MakePolygon(
    CASE 
        WHEN ST_IsClosed(geom) THEN geom
        ELSE ST_AddPoint(geom, ST_StartPoint(geom))
    END)
WHERE name = 'obiekt4';

--spawdzenie
SELECT name, ST_GeometryType(geom)
FROM obiekty
WHERE name = 'obiekt4';