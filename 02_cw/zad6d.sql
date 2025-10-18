-- d)Wypisz nazwy i obwody 2 budynków o największej powierzchni.
SELECT 
	name,
	ST_Area(geometry) AS Area
FROM buildings
ORDER BY Area DESC LIMIT 2;

--lub dense_rank - bo 2 i 3 pozycja mają tę samą powiercnię
SELECT name,area,rank FROM
(SELECT
    name,
	ST_Area(geometry) AS area,
    DENSE_RANK() OVER (ORDER BY ST_Area(geometry) DESC) AS rank
FROM buildings) ranked
WHERE rank<=2; 
