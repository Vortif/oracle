SELECT k.pseudo "POLUJE W POLU", k.przydzial_myszy, b.nazwa
FROM Kocury k JOIN Bandy b on k.nr_bandy=b.nr_bandy
WHERE k.przydzial_myszy > 50 AND (b.teren='POLE' OR b.nazwa='SZEFOSTWO');