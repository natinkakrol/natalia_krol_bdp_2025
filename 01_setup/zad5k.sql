-- Zlicz i pogrupuj pracowników według pola ‘stanowisko’.k
SELECT pe.stanowisko, COUNT(w.id_wynagrodzenia) AS liczba_pracownikow
FROM pensja pe
JOIN wynagrodzenie w ON pe.id_pensji=w.id_pensji
GROUP BY pe.stanowisko;
