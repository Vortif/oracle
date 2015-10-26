--17
SELECT k.pseudo "POLUJE W POLU", k.przydzial_myszy, b.nazwa
FROM Kocury k JOIN Bandy b on k.nr_bandy=b.nr_bandy
WHERE NVL(k.przydzial_myszy,0) > 50 AND (b.teren='POLE' OR b.teren='CALOSC');
--
--select k1.pseudo "sz", k1.nr_bandy "b" from
--Kocury k1 join Kocury k2 on k1.szef=k2.pseudo and k2.pseudo='TYGRYS' and k1.NR_BANDY<>k2.NR_BANDY;
--
--

--18
SELECT k1.imie, k1.w_stadku_od "POLUJE OD"
FROM Kocury k1, Kocury k2 
WHERE k1.w_stadku_od < k2.w_stadku_od AND k2.imie='JACEK'
ORDER BY 2 DESC;

--19
--ZAPYTAÆ O DZIALANIE JOIN == RIGHT JOIN
SELECT k1.imie, k1.funkcja, NVL(k2.imie, ' ') "Szef 1", NVL(k3.imie, ' ') "Szef 2", NVL(k4.imie, ' ') "Szef 3"
FROM Kocury k1 
LEFT JOIN Kocury k2 on k1.szef = k2.pseudo
LEFT JOIN Kocury k3 on k2.szef = k3.pseudo
LEFT JOIN Kocury k4 on k3.szef = k4.pseudo
WHERE k1.funkcja = 'KOT' OR k1.funkcja = 'MILUSIA';

--20
