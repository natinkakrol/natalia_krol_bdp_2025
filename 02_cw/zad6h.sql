-- h)Oblicz pole tych części BuildingC i poligonu (4 7, 6 7, 6 8, 4 8, 4 7), które nie są wspólne.
SELECT 
    ST_Area(ST_Difference(geometry, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', 0))) +
    ST_Area(ST_Difference(ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', 0), geometry)) 
    AS non_common_area
FROM buildings
WHERE name = 'BuildingC';
