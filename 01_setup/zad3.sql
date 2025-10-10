SET search_path TO ksiegowosc;

CREATE TABLE pracownicy (
id_pracownika SERIAL PRIMARY KEY,
imie VARCHAR(30) NOT NULL,
nazwisko VARCHAR(30) NOT NULL, 
adres TEXT, 
telefon VARCHAR(16));


CREATE TABLE godziny (
id_godziny SERIAL PRIMARY KEY, 
data DATE NOT NULL, 
liczba_godzin NUMERIC(4,2) NOT NULL, 
id_pracownika INT );
 
CREATE TABLE pensja (
id_pensji SERIAL PRIMARY KEY , 
stanowisko VARCHAR(30), 
kwota NUMERIC(10,2) NOT NULL );
  
CREATE TABLE premia (
id_premii SERIAL PRIMARY KEY,
rodzaj VARCHAR(30) NOT NULL, 
kwota NUMERIC(10,2) );

CREATE TABLE wynagrodzenie (
id_wynagrodzenia SERIAL PRIMARY KEY,
data DATE NOT NULL,
id_pracownika INT,
id_godziny INT,
id_pensji INT ,
id_premii INT );

-- dodawanie foreign key

ALTER TABLE godziny 
ADD FOREIGN KEY(id_pracownika) REFERENCES pracownicy(id_pracownika);

ALTER TABLE wynagrodzenie 
ADD FOREIGN KEY(id_pracownika) REFERENCES pracownicy(id_pracownika), 
ADD FOREIGN KEY(id_godziny) REFERENCES godziny(id_godziny),
ADD FOREIGN KEY(id_pensji) REFERENCES pensja(id_pensji),
ADD FOREIGN KEY(id_premii) REFERENCES premia(id_premii);

