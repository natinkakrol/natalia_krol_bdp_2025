-- Uszereguj pracowników według pensji.i
SELECT p.id_pracownika, p.imie, p.nazwisko,  pe.kwota AS pensja
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
ORDER BY pe.kwota; 
