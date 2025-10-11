

-- Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.h
SELECT p.imie, p.nazwisko
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN godziny g ON w.id_godziny=g.id_godziny
WHERE w.id_premii IS NULL
GROUP BY p.id_pracownika, p.imie, p.nazwisko
HAVING SUM(g.liczba_godzin) > 160;

