
-- Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska. o
SELECT pe.stanowisko, COUNT(w.id_premii) AS liczba_premii_przyznanych
FROM wynagrodzenie w
JOIN pensja pe ON w.id_pensji=pe.id_pensji
LEFT JOIN premia pr ON w.id_premii=pr.id_premii
GROUP BY pe.stanowisko;
