-- 2 podpunkty h oraz i,j,k,l,m

-- Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.h
SELECT p.imie, p.nazwisko
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN godziny g ON w.id_godziny=g.id_godziny
WHERE w.id_premii IS NULL
GROUP BY p.id_pracownika, p.imie, p.nazwisko
HAVING SUM(g.liczba_godzin) > 160;

-- Uszereguj pracowników według pensji.i
SELECT p.id_pracownika, p.imie, p.nazwisko,  pe.kwota AS pensja
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
ORDER BY pe.kwota; 

-- Uszereguj pracowników według pensji i premii malejąco.j
SELECT p.id_pracownika, p.imie, p.nazwisko,  pe.kwota AS pensja, pr.kwota AS premia
FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika=w.id_pracownika
JOIN pensja pe ON w.id_pensji=pe.id_pensji
JOIN premia pr ON w.id_premii=pr.id_premii
ORDER BY pe.kwota DESC, pr.kwota DESC;

-- Zlicz i pogrupuj pracowników według pola ‘stanowisko’.k
SELECT pe.stanowisko, COUNT(w.id_wynagrodzenia) AS liczba_pracownikow
FROM pensja pe
JOIN wynagrodzenie w ON pe.id_pensji=w.id_pensji
GROUP BY pe.stanowisko;

-- Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’l
SELECT
AVG( kwota ) AS srednia,
MIN( kwota ) AS minimalna,
MAX( kwota ) AS maksymalna
FROM pensja
WHERE stanowisko = 'księgowy';

-- Policz sumę wszystkich wynagrodzeń.m
SELECT SUM(pe.kwota + COALESCE(pr.kwota, 0)) AS suma_wynagrodzen --null jako 0 w premii
FROM pensja pe
JOIN wynagrodzenie w ON pe.id_pensji=w.id_pensji
LEFT JOIN premia pr ON w.id_premii=pr.id_premii;

-- Drugi podpunkt h

-- Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł. h
DELETE FROM pracownicy
WHERE id_pracownika IN (
SELECT p.id_pracownika FROM pracownicy p
JOIN wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN pensja pe ON w.id_pensji = pe.id_pensji
WHERE pe.kwota < 1200 );
