-- Wyświetl id pracowników, których płaca jest większa niż 1000. b
SELECT p.id_pracownika
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
WHERE pe.kwota >1000;
