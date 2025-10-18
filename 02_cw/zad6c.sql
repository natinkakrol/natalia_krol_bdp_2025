-- c)Wypisz nazwy i pola powierzchni wszystkich poligonów w warstwie budynki, wyniki posortuj alfabetycznie.
SELECT 
	name,
	ST_Area(geometry)
FROM buildings
ORDER BY name;
