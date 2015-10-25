DROP TABLE Wrogowie_Kocurow;
DROP TABLE Kocury;
DROP TABLE Wrogowie;
DROP TABLE Funkcje;
DROP TABLE Bandy;

DELETE FROM Wrogowie_Kocurow;
DELETE FROM Kocury;
DELETE FROM Wrogowie;
DELETE FROM Funkcje;
DELETE FROM Bandy;

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

CREATE TABLE Bandy
	(nr_bandy NUMBER(2) CONSTRAINT bandy_pk PRIMARY KEY,
	nazwa VARCHAR2(20) CONSTRAINT bandy_nazwa_nn NOT NULL,
	teren VARCHAR2(15) CONSTRAINT bandy_teren_unique UNIQUE
	);

CREATE TABLE Funkcje
	(funkcja VARCHAR2(10) CONSTRAINT funkcje_pk PRIMARY KEY,
	min_myszy NUMBER(3) CONSTRAINT funkcje_min_myszy CHECK(min_myszy > 5),
	max_myszy NUMBER(3) CONSTRAINT funkcje_max_myszy CHECK(max_myszy < 200),
	CONSTRAINT funkcje_max_ge_min_myszy CHECK(max_myszy >= min_myszy)
	);

CREATE TABLE Wrogowie
	(imie_wroga VARCHAR2(15) CONSTRAINT wrogowie_pk PRIMARY KEY,
	stopien_wrogosci NUMBER(2) CONSTRAINT wrogowie_stop_wrogosci_between CHECK(stopien_wrogosci BETWEEN 1 AND 10),
	gatunek VARCHAR2(15),
	lapowka VARCHAR2(20)
	);


CREATE TABLE Kocury
	(imie VARCHAR2(15) CONSTRAINT kocury_imie_nn NOT NULL,
	plec VARCHAR2(1) CONSTRAINT kocury_plec_in_ch CHECK(plec IN ('M','D')),
	pseudo VARCHAR2(15) CONSTRAINT kocury_pk PRIMARY KEY,
	funkcja VARCHAR2(10) CONSTRAINT kocury_funkcje_fk REFERENCES Funkcje(funkcja),
	szef VARCHAR2(15) CONSTRAINT kocury_kocury_fk REFERENCES Kocury(pseudo),
	w_stadku_od DATE DEFAULT SYSDATE,
	przydzial_myszy NUMBER(3),
	myszy_extra NUMBER(3),
	nr_bandy NUMBER(2) CONSTRAINT kocury_bandy_fk REFERENCES Bandy(nr_bandy)
	);

CREATE TABLE Wrogowie_Kocurow
	(pseudo VARCHAR2(15) CONSTRAINT wrogowie_kocurow_kocury_fk REFERENCES Kocury(pseudo),
	imie_wroga VARCHAR(15) CONSTRAINT wrogowie_kocurow_wrogowie_fk REFERENCES Wrogowie(imie_wroga),
	data_incydentu DATE CONSTRAINT wrogowie_kocurow_data_inc_nn NOT NULL,
	opis_incydentu VARCHAR2(50)
	);
  
ALTER TABLE Kocury DISABLE CONSTRAINT kocury_bandy_fk;
ALTER TABLE Kocury DISABLE CONSTRAINT kocury_funkcje_fk;
ALTER TABLE Kocury DISABLE CONSTRAINT kocury_kocury_fk;

INSERT INTO Kocury VALUES ('JACEK','M','PLACEK','LOWCZY','LYSY','2008-12-01',67,NULL,2);
INSERT INTO Kocury VALUES ('BARI','M','RURA','LAPACZ','LYSY','2009-09-01',56,NULL,2);
INSERT INTO Kocury VALUES ('MICKA','D','LOLA','MILUSIA','TYGRYS','2009-10-14',25,47,1);
INSERT INTO Kocury VALUES ('LUCEK','M','ZERO','KOT','KURKA','2010-03-01',43,NULL,3);
INSERT INTO Kocury VALUES ('SONIA','D','PUSZYSTA','MILUSIA','ZOMBI','2010-11-18',20,35,3);
INSERT INTO Kocury VALUES ('LATKA','D','UCHO','KOT','RAFA','2011-01-01',40,NULL,4);
INSERT INTO Kocury VALUES ('DUDEK','M','MALY','KOT','RAFA','2011-05-15',40,NULL,4);
INSERT INTO Kocury VALUES ('MRUCZEK','M','TYGRYS','SZEFUNIO',NULL,'2002-01-01',103,33,1);
INSERT INTO Kocury VALUES ('CHYTRY','M','BOLEK','DZIELCZY','TYGRYS','2002-05-05',50,NULL,1);
INSERT INTO Kocury VALUES ('KOREK','M','ZOMBI','BANDZIOR','TYGRYS','2004-03-16',75,13,3);
INSERT INTO Kocury VALUES ('BOLEK','M','LYSY','BANDZIOR','TYGRYS','2006-08-15',72,21,2);
INSERT INTO Kocury VALUES ('ZUZIA','D','SZYBKA','LOWCZY','LYSY','2006-07-21',65,NULL,2);
INSERT INTO Kocury VALUES ('RUDA','D','MALA','MILUSIA','TYGRYS','2006-09-17',22,42,1);
INSERT INTO Kocury VALUES ('PUCEK','M','RAFA','LOWCZY','TYGRYS','2006-10-15',65,NULL,4);
INSERT INTO Kocury VALUES ('PUNIA','D','KURKA','LOWCZY','ZOMBI','2008-01-01',61,NULL,3);
INSERT INTO Kocury VALUES ('BELA','D','LASKA','MILUSIA','LYSY','2008-02-01',24,28,2);
INSERT INTO Kocury VALUES ('KSAWERY','M','MAN','LAPACZ','RAFA','2008-07-12',51,NULL,4);
INSERT INTO Kocury VALUES ('MELA','D','DAMA','LAPACZ','RAFA','2008-11-01',51,NULL,4);

INSERT INTO Bandy VALUES (1,'SZEFOSTWO','CALOSC');
INSERT INTO Bandy VALUES (2,'CZARNI RYCERZE','POLE');
INSERT INTO Bandy VALUES (3,'BIALI LOWCY','SAD');
INSERT INTO Bandy VALUES (4,'LACIACI MYSLIWI','GORKA');
INSERT INTO Bandy VALUES (5,'ROCKERSI','ZAGRODA');

INSERT INTO Funkcje VALUES ('SZEFUNIO',90,110);
INSERT INTO Funkcje VALUES ('BANDZIOR',70,90);
INSERT INTO Funkcje VALUES ('LOWCZY',60,70);
INSERT INTO Funkcje VALUES ('LAPACZ',50,60);
INSERT INTO Funkcje VALUES ('KOT',40,50);
INSERT INTO Funkcje VALUES ('MILUSIA',20,30);
INSERT INTO Funkcje VALUES ('DZIELCZY',45,55);
INSERT INTO Funkcje VALUES ('HONOROWA',6,25);

INSERT INTO Wrogowie VALUES ('KAZIO',10,'CZLOWIEK','FLASZKA');
INSERT INTO Wrogowie VALUES ('GLUPIA ZOSKA',1,'CZLOWIEK','KORALIK');
INSERT INTO Wrogowie VALUES ('SWAWOLNY DYZIO',7,'CZLOWIEK','GUMA DO ZUCIA');
INSERT INTO Wrogowie VALUES ('BUREK',4,'PIES','KOSC');
INSERT INTO Wrogowie VALUES ('DZIKI BILL',10,'PIES',NULL);
INSERT INTO Wrogowie VALUES ('REKSIO',2,'PIES','KOSC');
INSERT INTO Wrogowie VALUES ('BETHOVEN',1,'PIES','PEDIGRIPALL');
INSERT INTO Wrogowie VALUES ('CHYTRUSEK',5,'LIS','KURCZAK');
INSERT INTO Wrogowie VALUES ('SMUKLA',1,'SOSNA',NULL);
INSERT INTO Wrogowie VALUES ('BAZYLI',3,'KOGUT','KURA DO STADA');

INSERT INTO Wrogowie_Kocurow VALUES ('TYGRYS','KAZIO','2004-10-13','USILOWAL NABIC NA WIDLY');
INSERT INTO Wrogowie_Kocurow VALUES ('ZOMBI','SWAWOLNY DYZIO','2005-03-07','WYBIL OKO Z PROCY');
INSERT INTO Wrogowie_Kocurow VALUES ('BOLEK','KAZIO','2005-03-29','POSZCZUL BURKIEM');
INSERT INTO Wrogowie_Kocurow VALUES ('SZYBKA','GLUPIA ZOSKA','2006-09-12','UZYLA KOTA JAKO SCIERKI');
INSERT INTO Wrogowie_Kocurow VALUES ('MALA','CHYTRUSEK','2007-03-07','ZALECAL SIE');
INSERT INTO Wrogowie_Kocurow VALUES ('TYGRYS','DZIKI BILL','2007-06-12','USILOWAL POZBAWIC ZYCIA');
INSERT INTO Wrogowie_Kocurow VALUES ('BOLEK','DZIKI BILL','2007-11-10','ODGRYZL UCHO');
INSERT INTO Wrogowie_Kocurow VALUES ('LASKA','DZIKI BILL','2008-12-12','POGRYZL ZE LEDWO SIE WYLIZALA');
INSERT INTO Wrogowie_Kocurow VALUES ('LASKA','KAZIO','2009-01-07','ZLAPAL ZA OGON I ZROBIL WIATRAK');
INSERT INTO Wrogowie_Kocurow VALUES ('DAMA','KAZIO','2009-02-07','CHCIAL OBEDRZEC ZE SKORY');
INSERT INTO Wrogowie_Kocurow VALUES ('MAN','REKSIO','2009-04-14','WYJATKOWO NIEGRZECZNIE OBSZCZEKAL');
INSERT INTO Wrogowie_Kocurow VALUES ('LYSY','BETHOVEN','2009-05-11','NIE PODZIELIL SIE SWOJA KASZA');
INSERT INTO Wrogowie_Kocurow VALUES ('RURA','DZIKI BILL','2009-09-03','ODGRYZL OGON');
INSERT INTO Wrogowie_Kocurow VALUES ('PLACEK','BAZYLI','2010-07-12','DZIOBIAC UNIEMOZLIWIL PODEBRANIE KURCZAKA');
INSERT INTO Wrogowie_Kocurow VALUES ('PUSZYSTA','SMUKLA','2010-11-19','OBRZUCILA SZYSZKAMI');
INSERT INTO Wrogowie_Kocurow VALUES ('KURKA','BUREK','2010-12-14','POGONIL');
INSERT INTO Wrogowie_Kocurow VALUES ('MALY','CHYTRUSEK','2011-07-13','PODEBRAL PODEBRANE JAJKA');
INSERT INTO Wrogowie_Kocurow VALUES ('UCHO','SWAWOLNY DYZIO','2011-07-14','OBRZUCIL KAMIENIAMI');

ALTER TABLE Kocury ENABLE CONSTRAINT kocury_bandy_fk;
ALTER TABLE Kocury ENABLE CONSTRAINT kocury_funkcje_fk;
ALTER TABLE Kocury ENABLE CONSTRAINT kocury_kocury_fk;

SELECT imie_wroga "WROG", opis_incydentu "PRZEWINA" FROM Wrogowie_Kocurow WHERE EXTRACT(YEAR FROM data_incydentu) = 2009;

SELECT imie, funkcja, w_stadku_od "Z NAMI OD"
FROM Kocury
WHERE plec='D' AND w_stadku_od BETWEEN TO_DATE('2005-09-01','yyyy-mm-dd') AND TO_DATE('2007-07-31','yyyy-mm-dd');

SELECT imie_wroga "WROG", gatunek, stopien_wrogosci "STOPIEN WROGOSCI"
FROM wrogowie
WHERE lapowka IS NULL
ORDER BY stopien_wrogosci;

SELECT imie||' zwany '||pseudo||' (fun. '||funkcja||') lowi myszki w bandzie '||nr_bandy||' od '||w_stadku_od "WSZYSTKO O KOCURACH"
FROM Kocury
WHERE plec='M'
ORDER BY w_stadku_od DESC, pseudo;

--(string, match, replace, start_char, how_many_occurences)
SELECT pseudo, REGEXP_REPLACE(REGEXP_REPLACE(pseudo, 'L', '%', 1, 1), 'A','#',1,1) "Po wymianie A na # oraz L na %"
FROM Kocury
WHERE pseudo LIKE '%A%L%' OR pseudo LIKE '%L%A%';

SELECT imie, w_stadku_od "W stadku", ROUND(0.9 * NVL(przydzial_myszy, 0), 0) "Zjadal", ADD_MONTHS(w_stadku_od, 6) "Podwyzka", NVL(przydzial_myszy, 0) "Zjada"
FROM Kocury
WHERE (TO_DATE('2015-08-01', 'YYYY-MM-DD') - w_stadku_od)/365 >= 6 
AND EXTRACT(MONTH FROM w_stadku_od) BETWEEN 3 AND 9;

SELECT imie, NVL(przydzial_myszy, 0)*3 "MYSZY KWARTALNE", NVL(myszy_extra, 0)*3 "KWARTALNE_DODATKI"
FROM Kocury
WHERE NVL(przydzial_myszy, 0) > NVL(myszy_extra, 0)*2 AND NVL(przydzial_myszy, 0) >= 55;

SELECT imie, 
CASE
WHEN (NVL(przydzial_myszy, 0)+NVL(myszy_extra, 0)) * 12 > 660 THEN TO_CHAR((przydzial_myszy+NVL(myszy_extra, 0)) * 12)
WHEN (NVL(przydzial_myszy, 0)+NVL(myszy_extra, 0)) * 12 = 660 THEN 'LIMIT'
ELSE 'Ponizej 660'
END "Zjada rocznie"
FROM Kocury;

SELECT pseudo, w_stadku_od "W STADKU", 
CASE 
WHEN EXTRACT(DAY FROM w_stadku_od) <= 15 THEN 
CASE WHEN (EXTRACT(DAY FROM NEXT_DAY(TO_DATE('2015-11-24', 'YYYY-MM-DD'), 3)) < 8) THEN NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2015-11-24', 'YYYY-MM-DD'),1))-7, 3)
  ELSE NEXT_DAY(LAST_DAY(TO_DATE('2015-11-24', 'YYYY-MM-DD'))-7, 3)
  END
ELSE NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2015-11-24', 'YYYY-MM-DD'),1))-7, 3)
END "WYPLATA"
FROM Kocury;

SELECT pseudo, w_stadku_od "W STADKU", 
CASE WHEN EXTRACT(DAY FROM w_stadku_od) <= 15 AND (EXTRACT(DAY FROM NEXT_DAY(TO_DATE('2015-11-24', 'YYYY-MM-DD'), 3)) > EXTRACT(DAY FROM TO_DATE('2015-11-24', 'YYYY-MM-DD')))
  THEN NEXT_DAY(LAST_DAY(TO_DATE('2015-11-24', 'YYYY-MM-DD'))-7, 3)
  ELSE NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2015-11-24', 'YYYY-MM-DD'), 1))-7, 3)
END "WYPLATA"
FROM Kocury;

SELECT pseudo, w_stadku_od "W STADKU", 
CASE WHEN EXTRACT(DAY FROM w_stadku_od) <= 15 AND (EXTRACT(DAY FROM NEXT_DAY(TO_DATE('2015-11-27', 'YYYY-MM-DD'), 3)) > EXTRACT(DAY FROM TO_DATE('2015-11-27', 'YYYY-MM-DD')))
  THEN NEXT_DAY(LAST_DAY(TO_DATE('2015-11-27', 'YYYY-MM-DD'))-7, 3)
  ELSE NEXT_DAY(LAST_DAY(ADD_MONTHS(TO_DATE('2015-11-27', 'YYYY-MM-DD'), 1))-7, 3)
END "WYPLATA"
FROM Kocury;

SELECT
CASE WHEN COUNT(pseudo) > 1 THEN pseudo||' - nieunikalny'
ELSE pseudo||' - Unikalny'
END "Unikalnosc atr. PSEUDO"
FROM Kocury
GROUP BY pseudo
HAVING COUNT(pseudo) > 0;

SELECT
CASE WHEN COUNT(szef) > 1 THEN szef||' - nieunikalny'
ELSE szef||' - Unikalny'
END "Unikalnosc atr. SZEF"
FROM Kocury
GROUP BY szef
HAVING COUNT(szef) > 0;

SELECT pseudo "Pseudonim", COUNT(imie_wroga) "Liczba wrogow"
FROM Wrogowie_Kocurow
GROUP BY pseudo
HAVING COUNT(imie_wroga) > 1;

SELECT 'Liczba kotow= '||COUNT(*)||' lowi jako '||funkcja||' i zjada max '||MAX(NVL(przydzial_myszy, 0)+NVL(myszy_extra,0))||' myszy miesiecznie'
FROM Kocury
WHERE funkcja!='SZEFUNIO' AND plec='D'
GROUP BY funkcja
HAVING AVG(NVL(przydzial_myszy, 0)+NVL(myszy_extra,0)) > 50;

SELECT nr_bandy "Nr bandy", plec, MIN(NVL(przydzial_myszy, 0)) "Minimalny przydzial"
FROM Kocury
GROUP BY nr_bandy, plec;

SELECT level "Poziom", pseudo "Pseudonim", funkcja, nr_bandy "Nr bandy"
FROM Kocury
WHERE plec='M'
CONNECT BY PRIOR pseudo=szef
START WITH funkcja='BANDZIOR'
ORDER BY nr_bandy, level;
--LPAD(string to concat from left, final length, (opt) string to
SELECT LPAD(level-1, (level-1)*4+1, '===>')||'         '||imie "Hierarchia", pseudo "Pseudo szefa", funkcja
FROM Kocury
WHERE NVL(myszy_extra, 0) > 0
CONNECT BY PRIOR pseudo=szef
START WITH szef IS NULL;

SELECT LPAD(pseudo, length(pseudo)+(level-1)*4) "Droga sluzbowa"
FROM Kocury
CONNECT BY PRIOR szef=pseudo AND pseudo!='RAFA'
START WITH szef IS NOT NULL AND plec='M' AND NVL(myszy_extra, 0) = 0 AND (TO_DATE('2015-08-01', 'YYYY-MM-DD') - w_stadku_od)/365 >= 6;