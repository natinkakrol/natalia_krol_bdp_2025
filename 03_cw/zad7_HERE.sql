-- zadanie 7
WITH parks AS (
  SELECT geom FROM t2019_kar_land l
  WHERE type = 'Park (City/County)'),
shops AS (
  SELECT gid, geom
  FROM t2019_kar_poi_table p
  WHERE type = 'Sporting Goods Store')
SELECT 
  COUNT(DISTINCT s.gid) AS sports_shops_within_300m_of_parks
FROM shops s
JOIN parks p
  ON ST_DWithin(ST_Transform(s.geom, 3068), ST_Transform(p.geom, 3068),300);
