--tworzenie tabel
DROP TABLE IF EXISTS buildings;
CREATE TABLE buildings(
id SERIAL PRIMARY KEY,
name VARCHAR(100),
geometry GEOMETRY(Polygon, 0));

DROP TABLE IF EXISTS roads;
CREATE TABLE roads(
id SERIAL PRIMARY KEY,
name VARCHAR(100),
geometry GEOMETRY(LineString, 0));

DROP TABLE IF EXISTS poi;
CREATE  TABLE poi(
id SERIAL PRIMARY KEY,
name VARCHAR(100),
geometry GEOMETRY(Point, 0));
