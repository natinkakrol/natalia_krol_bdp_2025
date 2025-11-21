CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_raster;

SELECT schema_name FROM information_schema.schemata;

SELECT table_schema, table_name 
FROM information_schema.tables 
WHERE table_schema IN ('public','vectors','rasters','schema_name');

ALTER SCHEMA schema_name RENAME TO krol;

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'rasters';

SELECT table_name FROM information_schema.tables WHERE table_schema = 'rasters';

SELECT rid, ST_Width(rast) AS width, ST_Height(rast) AS height, ST_SRID(rast) AS srid
FROM rasters.dem
LIMIT 5;

SELECT * FROM public.raster_columns;

-- 1. ST_Intersects
CREATE TABLE krol.intersects AS
SELECT a.rast, b.municipality
FROM rasters.dem AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(a.rast, b.geom)
WHERE b.municipality ILIKE 'porto';

ALTER TABLE krol.intersects
ADD COLUMN rid SERIAL PRIMARY KEY;

CREATE INDEX idx_intersects_rast_gist 
ON krol.intersects
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('krol'::name, 'intersects'::name, 'rast'::name);

-- 2. ST_Clip
CREATE TABLE krol.clip AS
SELECT ST_Clip(a.rast, b.geom, true) AS rast, b.municipality
FROM rasters.dem AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(a.rast, b.geom)
WHERE b.municipality LIKE 'PORTO';

-- 3. ST_Union
CREATE TABLE krol.union AS
SELECT ST_Union(ST_Clip(a.rast, b.geom, true)) AS rast
FROM rasters.dem AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(a.rast, b.geom)
WHERE b.municipality ILIKE 'porto';

-- 4. ST_AsRaster
CREATE TABLE krol.porto_parishes AS
WITH r AS (
  SELECT rast FROM rasters.dem LIMIT 1
)
SELECT ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767) AS rast
FROM vectors.porto_parishes AS a, r
WHERE a.municipality ILIKE 'porto';

-- 5. ST_Union
DROP TABLE IF EXISTS krol.porto_parishes;

CREATE TABLE krol.porto_parishes AS
WITH r AS (
  SELECT rast FROM rasters.dem LIMIT 1
)
SELECT ST_Union(ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767)) AS rast
FROM vectors.porto_parishes AS a, r
WHERE a.municipality ILIKE 'porto';

-- 6. ST_Tile
DROP TABLE IF EXISTS krol.porto_parishes;

CREATE TABLE krol.porto_parishes AS
WITH r AS (
  SELECT rast FROM rasters.dem LIMIT 1
)
SELECT ST_Tile(
         ST_Union(ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767)),
         128, 128, true, -32767
       ) AS rast
FROM vectors.porto_parishes AS a, r
WHERE a.municipality ILIKE 'porto';

-- 7. ST_Intersection
CREATE TABLE krol.intersection AS
SELECT a.rid, 
       (ST_Intersection(b.geom, a.rast)).geom, 
       (ST_Intersection(b.geom, a.rast)).val
FROM rasters.landsat8 AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(b.geom, a.rast)
WHERE b.parish ILIKE 'paranhos';

-- 8. ST_DumpAsPolygons
CREATE TABLE krol.dumppolygons AS
SELECT a.rid, 
       (ST_DumpAsPolygons(ST_Clip(a.rast, b.geom))).geom, 
       (ST_DumpAsPolygons(ST_Clip(a.rast, b.geom))).val
FROM rasters.landsat8 AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(b.geom, a.rast)
WHERE b.parish ILIKE 'paranhos';

-- 9. ST_Band
CREATE TABLE krol.landsat_nir AS
SELECT rid, ST_Band(rast, 4) AS rast
FROM rasters.landsat8;

-- 10. ST_Clip
CREATE TABLE krol.paranhos_dem AS
SELECT a.rid, ST_Clip(a.rast, b.geom, true) AS rast
FROM rasters.dem AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(a.rast, b.geom)
WHERE b.parish ILIKE 'paranhos';

-- 11. ST_Slope
CREATE TABLE krol.paranhos_slope AS
SELECT a.rid, ST_Slope(a.rast, 1, '32BF', 'PERCENTAGE') AS rast
FROM krol.paranhos_dem AS a;

-- 12. ST_Reclass
CREATE TABLE krol.paranhos_slope_reclass AS
SELECT a.rid, ST_Reclass(a.rast, 1, ']0-15]:1, (15-30]:2, (30-9999:3', '32BF', 0)
FROM krol.paranhos_slope AS a;

-- 13. Stats
SELECT ST_SummaryStats(a.rast) AS stats
FROM krol.paranhos_dem AS a;

-- 14. Stats with UNION
SELECT ST_SummaryStats(ST_Union(a.rast))
FROM krol.paranhos_dem AS a;

-- 15. Stats extract
WITH t AS (
  SELECT ST_SummaryStats(ST_Union(a.rast)) AS stats
  FROM krol.paranhos_dem AS a
)
SELECT (stats).min, (stats).max, (stats).mean
FROM t;

-- 16. Summary by parish
WITH t AS (
  SELECT b.parish AS parish, 
         ST_SummaryStats(ST_Union(ST_Clip(a.rast, b.geom, true))) AS stats
  FROM rasters.dem AS a
  JOIN vectors.porto_parishes AS b
    ON ST_Intersects(b.geom, a.rast)
  WHERE b.municipality ILIKE 'porto'
  GROUP BY b.parish
)
SELECT parish, (stats).min, (stats).max, (stats).mean
FROM t;

-- 17. ST_Value
SELECT b.name, ST_Value(a.rast, (ST_Dump(b.geom)).geom)
FROM rasters.dem AS a
JOIN vectors.places AS b
  ON ST_Intersects(a.rast, b.geom)
ORDER BY b.name;

-- 18. TPI
CREATE TABLE krol.tpi30 AS
SELECT ST_TPI(a.rast, 1) AS rast
FROM rasters.dem AS a;

CREATE INDEX idx_tpi30_rast_gist ON krol.tpi30
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('krol'::name, 'tpi30'::name, 'rast'::name);

-- 19. TPI Porto
CREATE TABLE krol.tpi30_porto AS
SELECT ST_TPI(a.rast, 1) AS rast
FROM rasters.dem AS a
JOIN vectors.porto_parishes AS b
  ON ST_Intersects(a.rast, b.geom)
WHERE b.municipality ILIKE 'porto';

CREATE INDEX idx_tpi30_porto_rast_gist ON krol.tpi30_porto
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('krol'::name, 'tpi30_porto'::name, 'rast'::name);

-- 20. NDVI algebra (expression)
CREATE TABLE krol.porto_ndvi AS
WITH r AS (
  SELECT a.rid, ST_Clip(a.rast, b.geom, true) AS rast
  FROM rasters.landsat8 AS a
  JOIN vectors.porto_parishes AS b
    ON ST_Intersects(b.geom, a.rast)
  WHERE b.municipality ILIKE 'porto'
)
SELECT r.rid, ST_MapAlgebra(
           r.rast, 1,
           r.rast, 4,
           '([rast2.val] - [rast1.val]) / ([rast2.val] + [rast1.val])::float',
           '32BF'
         ) AS rast
FROM r;

CREATE INDEX idx_porto_ndvi_rast_gist ON krol.porto_ndvi
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('krol'::name, 'porto_ndvi'::name, 'rast'::name);

-- 21. NDVI (function)
CREATE OR REPLACE FUNCTION krol.ndvi(
  value double precision[][][][],
  pos integer[][],
  VARIADIC userargs text[]
) RETURNS double precision AS
$$
BEGIN
  RETURN (value[2][1][1] - value[1][1][1]) / (value[2][1][1] + value[1][1][1]);
END;
$$ LANGUAGE 'plpgsql' IMMUTABLE COST 1000;

CREATE TABLE krol.porto_ndvi2 AS
WITH r AS (
  SELECT a.rid, ST_Clip(a.rast, b.geom, true) AS rast
  FROM rasters.landsat8 AS a
  JOIN vectors.porto_parishes AS b
    ON ST_Intersects(b.geom, a.rast)
  WHERE b.municipality ILIKE 'porto'
)
SELECT r.rid, ST_MapAlgebra(
           r.rast, ARRAY[1,4],
           'krol.ndvi(double precision[], integer[], text[])'::regprocedure,
           '32BF'
         ) AS rast
FROM r;

CREATE INDEX idx_porto_ndvi2_rast_gist ON krol.porto_ndvi2
USING gist (ST_ConvexHull(rast));

SELECT AddRasterConstraints('krol'::name, 'porto_ndvi2'::name, 'rast'::name);
