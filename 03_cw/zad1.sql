--tworzenie tabel
DROP TABLE IF EXISTS obiekty;
CREATE TABLE obiekty(
id SERIAL PRIMARY KEY,
name VARCHAR(100),
geom GEOMETRY );


--obiekt 1
INSERT INTO obiekty(name,geom) VALUES
('obiekt1', ST_GeomFromText('COMPOUNDCURVE( (0 1, 1 1),                       
            CIRCULARSTRING(1 1, 2 0, 3 1),    
            CIRCULARSTRING(3 1, 4 2, 5 1),    
            (5 1, 6 1))'));

--obiekt2
INSERT INTO obiekty(name, geom) VALUES  
('obiekt2', ST_GeomFromText(
        'CURVEPOLYGON(
            COMPOUNDCURVE((10 6, 10 2),
                CIRCULARSTRING(10 2, 12 0, 14 2),
                CIRCULARSTRING(14 2, 16 4, 14 6),
                (14 6, 10 6)),
            COMPOUNDCURVE(
                CIRCULARSTRING(11 2, 12 1, 13 2),
				CIRCULARSTRING(13 2, 12 3, 11 2) ) )'));
				
--obiekt3	
INSERT INTO obiekty(name,geom) VALUES
('obiekt3', ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))'));

--obiekt4
INSERT INTO obiekty(name,geom) VALUES
('obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)'));

--obiekt5
INSERT INTO obiekty(name,geom) VALUES
('obiekt5', ST_GeomFromText('MULTIPOINT Z( (30 30 59), (38 32 234))'));

--obiekt6
INSERT INTO obiekty(name,geom) VALUES 
('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION( LINESTRING(1 1, 3 2), POINT(4 2))'));

--sprawdzenie łuków
SELECT name
FROM obiekty 
WHERE ST_HasArc(geom);
