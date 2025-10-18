-- f)Wypisz pole powierzchni tej części budynku BuildingC, która znajduje się w odległości większej niż 0.5 od budynku BuildingB.
SELECT 
	ST_Area( ST_Difference(c.geometry, ST_Buffer(b.geometry,0.5))) as area_bigger_than_0_5
FROM buildings c
JOIN buildings b ON b.name = 'BuildingB'
WHERE c.name = 'BuildingC';
