-- Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł. p
DELETE FROM pracownicy
WHERE id_pracownika IN (
SELECT p.id_pracownika FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN pensja pe ON w.id_pensji = pe.id_pensji
WHERE pe.kwota < 1200 );
