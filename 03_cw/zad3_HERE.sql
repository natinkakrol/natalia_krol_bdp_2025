CREATE TABLE streets_reprojected AS
SELECT
     gid,
	 link_id,
	 st_name,
	 ref_in_id,
	 nref_in_id,
	 func_class,
	 speed_cat,
	 fr_speed_l,
	 to_speed_l,
	 dir_travel,
	 ST_Transform(geom, 3068) AS geom
FROM t2019_kar_streets;

--SELECT ST_SRID(geom) 
--FROM  streets_reprojected 
--LIMIT 5;

ALTER TABLE streets_reprojected
ALTER COLUMN geom TYPE geometry(MultiLineString, 3068)
USING ST_SetSRID(geom, 3068);
