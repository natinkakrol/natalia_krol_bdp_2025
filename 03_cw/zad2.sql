--zadanie 2
SELECT 
    ST_Area(ST_Buffer(ST_ShortestLine(a.geom, b.geom), 5)) AS buffer_area
FROM obiekty AS a
JOIN obiekty AS b 
  ON a.name = 'obiekt3' 
 AND b.name = 'obiekt4';
