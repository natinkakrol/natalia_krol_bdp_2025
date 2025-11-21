SELECT * FROM t2018_kar_buildings;
SELECT * FROM t2019_kar_buildings;

--zadanie 1
SELECT b19.*
FROM t2019_kar_buildings b19
LEFT JOIN t2018_kar_buildings b18
	ON b19.polygon_id = b18.polygon_id
WHERE b18.polygon_id IS NULL
	OR NOT ST_Equals(b19.geom, b18.geom)
	OR b19.height <> b18.height;
