-- g)Wybierz te budynki, których centroid (ST_Centroid) znajduje się powyżej drogi o nazwie RoadX.
SELECT 
	b.name, 
	ST_Centroid(b.geometry)
FROM buildings b
JOIN roads r ON r.name='RoadX'
WHERE ST_Y(ST_Centroid(b.geometry)) > ST_Y(ST_Centroid(r.geometry));
