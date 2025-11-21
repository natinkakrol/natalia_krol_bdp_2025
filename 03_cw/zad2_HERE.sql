--zadanie 2
WITH budynki_zmiany AS (
    SELECT b19.geom
    FROM t2019_kar_buildings b19
    LEFT JOIN t2018_kar_buildings b18
        ON b19.polygon_id = b18.polygon_id
    WHERE b18.polygon_id IS NULL
        OR NOT ST_Equals(b19.geom, b18.geom)
        OR b19.height <> b18.height),
nowe_poi AS (
    SELECT p19.*
    FROM t2019_kar_poi_table p19
    LEFT JOIN t2018_kar_poi_table p18
        ON p19.poi_id = p18.poi_id
    WHERE p18.poi_id IS NULL)
SELECT 
    p.type,
    COUNT(*) AS liczba_poi
FROM nowe_poi p
JOIN budynki_zmiany b
	ON ST_DistanceSphere(p.geom, b.geom) <= 500
GROUP BY p.type
ORDER BY liczba_poi DESC;
