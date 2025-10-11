-- Policz sumę wszystkich wynagrodzeń.m
SELECT SUM(pe.kwota + COALESCE(pr.kwota, 0)) AS suma_wynagrodzen --null jako 0 w premii
FROM pensja pe
JOIN wynagrodzenie w ON pe.id_pensji=w.id_pensji
LEFT JOIN premia pr ON w.id_premii=pr.id_premii;
