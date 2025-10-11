-- Uszereguj pracowników według pensji i premii malejąco.j
SELECT p.id_pracownika, p.imie, p.nazwisko,  pe.kwota AS pensja, pr.kwota AS premia
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
JOIN premia pr ON w.id_premii=pr.id_premii
ORDER BY pe.kwota DESC, pr.kwota DESC;
