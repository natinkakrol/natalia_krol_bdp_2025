-- Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, czas pracy to 160 h miesięcznie. f
SELECT p.imie, p.nazwisko, SUM(g.liczba_godzin) - 160 AS nadgodziny
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN godziny g ON w.id_godziny=g.id_godziny
GROUP BY p.id_pracownika, p.imie, p.nazwisko
HAVING SUM(g.liczba_godzin) > 160;

-- drugi podpunkt f
-- Policz sumę wynagrodzeń w ramach danego stanowiska. f
SELECT
	pe.stanowisko, 
	SUM(pe.kwota + COALESCE(pr.kwota, 0)) AS suma_wynagrodzen --null jako 0 w premii
FROM pensja pe
JOIN wynagrodzenie w ON pe.id_pensji=w.id_pensji
LEFT JOIN premia pr ON w.id_premii=pr.id_premii
GROUP BY pe.stanowisko;
