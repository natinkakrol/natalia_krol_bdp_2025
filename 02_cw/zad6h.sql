-- h)Oblicz pole tych części BuildingC i poligonu (4 7, 6 7, 6 8, 4 8, 4 7), które nie są wspólne.
WITH input_polygon AS (
    SELECT 
        ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))') AS poly_geom
)

SELECT 
    ST_Area(
        ST_SymDifference(
            (SELECT geometry FROM buildings WHERE name = 'BuildingC'),
            (SELECT poly_geom FROM input_polygon)
        )
    ) AS non_common_area;

