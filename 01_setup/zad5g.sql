-- Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN.g
SELECT p.imie, p.nazwisko
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
WHERE pe.kwota BETWEEN 1500 AND 3000;


