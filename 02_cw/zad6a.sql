-- a)Wyznacz całkowitą długość dróg w analizowanym mieście.
SELECT SUM(ST_Length(geometry)) AS total_length
FROM roads;
