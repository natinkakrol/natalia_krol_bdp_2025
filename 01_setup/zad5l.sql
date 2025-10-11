-- Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’l
SELECT
AVG( kwota ) AS srednia,
MIN( kwota ) AS minimalna,
MAX( kwota ) AS maksymalna
FROM pensja
WHERE stanowisko = 'księgowy';
