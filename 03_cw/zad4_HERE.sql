--zadanie 4
DROP TABLE IF EXISTS input_points;
CREATE TABLE input_points (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    geom geometry(Point, 4326));

INSERT INTO input_points (name, geom) VALUES
('point1', ST_SetSRID(ST_MakePoint(8.36093, 49.03174), 4326)),
('point2', ST_SetSRID(ST_MakePoint(8.39876, 49.00644), 4326));

SELECT id, ST_AsText(geom), ST_SRID(geom)
FROM input_points;
