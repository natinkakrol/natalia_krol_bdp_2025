-- b)Wypisz geometrię (WKT), pole powierzchni oraz obwód poligonu reprezentującego budynek o nazwie BuildingA.
SELECT 
	name,
	ST_AsText(geometry) AS WTK,
	ST_Area(geometry), 
	ST_Perimeter(geometry)
FROM buildings
WHERE name='BuildingA';
