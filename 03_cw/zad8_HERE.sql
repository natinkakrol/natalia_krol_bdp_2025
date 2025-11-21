DROP TABLE IF EXISTS t2019_kar_bridges;
CREATE TABLE t2019_kar_bridges AS
WITH intersections AS (
    SELECT 
        ST_Intersection(r.geom, w.geom) AS geom
    FROM t2019_kar_railways r
    JOIN t2019_kar_water_lines w
        ON ST_Intersects(r.geom, w.geom))
SELECT 
    (ST_Dump(ST_CollectionExtract(geom, 1))).geom::geometry(Point, 4326) AS geom
FROM intersections;

SELECT * FROM t2019_kar_bridges;
