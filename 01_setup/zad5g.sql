-- Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN.g
SELECT p.imie, p.nazwisko
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
WHERE pe.kwota BETWEEN 1500 AND 3000;

--DRugi podpunkt g
-- Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska. g
SELECT pe.stanowisko, COUNT(w.id_premii) AS liczba_premii_przyznanych
FROM wynagrodzenie w
JOIN pensja pe ON w.id_pensji=pe.id_pensji
LEFT JOIN premia pr ON w.id_premii=pr.id_premii
GROUP BY pe.stanowisko;
