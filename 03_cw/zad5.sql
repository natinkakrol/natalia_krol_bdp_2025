--zadanie 5

--spawdzenie
SELECT name
FROM obiekty 
WHERE NOT ST_HasArc(geom);

SELECT 
	SUM(ST_Area(ST_Buffer(geom, 5))) as collective_area
FROM obiekty 
WHERE NOT ST_HasArc(geom);