--uzpełnianie tabel rekordami
INSERT INTO pracownicy (imie, nazwisko, adres, telefon)
VALUES 
('Jan', 'Kowal', 'Długa 4a 43-400 Cieszyn', '643843232'),
('Jan', 'Byk', 'Wakacyjna 78 38-938 Kraków', '643843232'),
('Irena', 'Paw', 'Dmowskiego 28/14 38-938 Kraków', '644843232'),
('Jan', 'Długosz', 'Droga 3 38-938 Kraków', '782343234'),
('Alicja', 'Konewka', 'Kochanowskiego 36 38-938 Kraków', '434820992'),
('Ignacy', 'Kawka', 'Niewinna 40 438-938 Kraków', '328293022'),
('Dorota', 'Panel', 'Długa 49/3 38-938 Kraków', '643543232'),
('Elżbieta', 'Irytujący', 'Budryka 5 38-938 Kraków', '232930303'),
('Anna', 'Pocierz', 'Biała 4a 38-938 Kraków', '890378392'),
('Daniel', 'Demon', 'Krótka 4a 43-400 Cieszyn', '644444444');

INSERT INTO godziny (data, liczba_godzin, id_pracownika)
VALUES
('2022-12-01', 10, 1),
('2022-12-02', 8, 1),
('2022-12-01', 9, 2),
('2022-12-01', 7, 3),
('2022-12-03', 10, 3),
('2022-12-01', 9, 4),
('2022-12-14', 10, 4),
('2022-12-03', 8, 5),
('2022-12-02', 5, 6),
('2022-12-03', 12, 6);

INSERT INTO pensja (stanowisko, kwota)
VALUES  
('księgowy', 5012),
('księgowy', 5012),
('asystent', 3500),
('manager', 7480),
('dyrektor', 9000),
('specjalista', 6500),
('starszy specjalista', 7000),
('młodszy specjalista', 6000),
('główny księgowy', 5800),
('wicedyrektor', 8500);


INSERT INTO premia (rodzaj, kwota)
VALUES 
('uznaniowa', 1200),
('regulaminowa', 600),
('uznaniowa', 1000),
('uznaniowa', 1150),
('regulaminowa', 300),
('regulaminowa', 550),
('uznaniowa', 1300),
('uznaniowa', 1400),
('uznaniowa', 1200),
('za frekwencję', 980);


INSERT INTO wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
('2022-12-03', 1, 1, 6, 1),   -- Jan Kowal, 10h, specjalista, premia uznaniowa
('2022-12-03', 2, 3, 10, 2),  -- Jan Byk, wicedyrektor, premia regulaminowa
('2022-12-03', 3, 4, 9, 3),   -- Irena Paw, główny księgowy, premia uznaniowa
('2022-12-03', 4, 6, 5, 4),   -- Jan Długosz, dyrektor, premia uznaniowa
('2022-12-03', 5, 8, 3, NULL),   -- Alicja Konewka, asystent, brak premii
('2022-12-03', 6, 10, 1, 6),  -- Ignacy Kawka, księgowy, premia regulaminowa
('2022-12-03', 7, 7, 4, 7),   -- Dorota Panel, manager, premia uznaniowa
('2022-12-03', 8, 9, 7, 8),   -- Elżbieta Irytujący, starszy specjalista, premia uznaniowa
('2022-12-03', 9, 2, 8, NULL),   -- Anna Pocierz, młodszy specjalista, brak premii
('2022-12-03', 10, 5, 2, 10); -- Daniel Demon, księgowy, premia za frekwencję
