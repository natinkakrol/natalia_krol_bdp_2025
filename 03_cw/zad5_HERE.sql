--zadanie 5
ALTER TABLE input_points
ALTER COLUMN geom TYPE geometry(Point, 3068)
USING ST_Transform(geom, 3068);

UPDATE input_points
SET geom = ST_Transform(geom, 3068);

SELECT id, ST_AsText(geom), ST_SRID(geom)
FROM input_points;
