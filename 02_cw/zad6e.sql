-- e)Wyznacz najkrótszą odległość między budynkiem BuildingC a punktem K.
SELECT 
	b.name AS building,
	p.name AS point,
	ST_Distance(b.geometry, p.geometry) AS distance
FROM buildings b
JOIN poi p ON p.name='K'
WHERE b.name='BuildingC';
