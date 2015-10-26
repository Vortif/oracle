ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

--17
SELECT k.pseudo "POLUJE W POLU", k.przydzial_myszy, b.nazwa
FROM Kocury k JOIN Bandy b ON k.nr_bandy=b.nr_bandy
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
SELECT k.imie "Imie kotki", b.nazwa "Nazwa bandy", w.imie_wroga "Imie wroga", w.stopien_wrogosci "Ocena wroga", wk.data_incydentu "Data inc."
FROM Kocury k
LEFT JOIN Bandy b ON k.nr_bandy = b.nr_bandy
LEFT JOIN Wrogowie_Kocurow wk ON k.pseudo = wk.pseudo
LEFT JOIN Wrogowie w ON wk.imie_wroga = w.imie_wroga
WHERE plec = 'D' and data_incydentu > TO_DATE('2007-01-01','yyyy-mm-dd')
ORDER BY k.imie;

--21
SELECT b.nazwa "Nazwa bandy", COUNT(DISTINCT k.pseudo) "Koty z wrogami"
FROM Wrogowie_Kocurow wk
LEFT JOIN Kocury k ON wk.pseudo = k.pseudo
LEFT JOIN Bandy b ON k.nr_bandy = b.nr_bandy
GROUP BY b.nazwa;

--22 ogarn¹æ HAVING
SELECT k.funkcja, k.pseudo "Pseudonim kota", COUNT(*) "Liczba wrogow"
FROM Wrogowie_Kocurow wk
LEFT JOIN Kocury k ON wk.pseudo = k.pseudo
GROUP BY k.funkcja, k.pseudo
HAVING COUNT(*) > 1;

--23
SELECT imie, ((NVL(przydzial_myszy,0) + myszy_extra)*12) "DAWKA ROCZNA", 'powyzej 864' "DAWKA"
FROM Kocury
WHERE ((NVL(przydzial_myszy,0) + myszy_extra)*12) > 864
UNION
SELECT imie, ((NVL(przydzial_myszy,0) + myszy_extra)*12) "DAWKA ROCZNA", '        864' "DAWKA"
FROM Kocury
WHERE ((NVL(przydzial_myszy,0) + myszy_extra)*12) = 864
UNION
SELECT imie, ((NVL(przydzial_myszy,0) + myszy_extra)*12) "DAWKA ROCZNA", 'ponizej 864' "DAWKA"
FROM Kocury
WHERE ((NVL(przydzial_myszy,0) + myszy_extra)*12) < 864
ORDER BY 2 DESC;

--24
--bez podzapytan
SELECT nr_bandy "NR BANDY", nazwa, teren
FROM Bandy