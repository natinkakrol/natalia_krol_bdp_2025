-- Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, czas pracy to 160 h miesięcznie. f
SELECT p.imie, p.nazwisko, SUM(g.liczba_godzin) - 160 AS nadgodziny
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN godziny g ON w.id_godziny=g.id_godziny
GROUP BY p.id_pracownika, p.imie, p.nazwisko
HAVING SUM(g.liczba_godzin) > 160;


