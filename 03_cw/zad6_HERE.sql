--zadanie 6 
WITH line_3068 AS (
  SELECT ST_MakeLine(geom ORDER BY id) AS geom
  FROM input_points),
buff200 AS (
  SELECT ST_Buffer(geom, 200) AS geom
  FROM line_3068)
SELECT
  n.gid,
  n.intersect                                    
FROM t2019_kar_street_node AS n
JOIN buff200 b
  ON ST_Intersects( ST_Transform(n.geom, 3068), b.geom )
WHERE n.intersect = 'Y';
