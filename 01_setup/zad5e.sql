-- Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’. e
SELECT * FROM pracownicy
WHERE imie LIKE '%a' AND nazwisko LIKE '%n%';
