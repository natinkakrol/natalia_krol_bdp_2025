-- Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000. c
SELECT p.id_pracownika FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
WHERE pe.kwota >2000 AND w.id_premii IS NULL;
