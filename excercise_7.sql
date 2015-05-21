-- Aufgabe 1
-- 1.  Geben Sie eine Liste aller Autoren aus.
-- 2.  Geben Sie eine Liste aller Titel aus.
-- 3.  Gibt es Autoren, die in San Francisco wohnen? Welche?
-- 4.  Wieviele Titel sind gespeichert?
-- 5.  Wieviele Autoren sind gespeichert?
-- 6.  Geben Sie eine Liste aller Titel die mit ‚S’ beginnen aus.
-- 7.  Bestimmen Sie den durchschnittlichen Preis eines Titels.
-- 8.  Geben Sie das Datum aller Verkäufe des Ladens 'Bookbeat' an.
-- 9.  Geben Sie alle Titel aus, die im Laden 'Bookbeat' verkauft wurden.
-- 10. Geben Sie den Discounttype jedes Ladens, inklusive Namen und Ort des Ladens an.

select au_id, au_lname, au_fname
from authors;

select title
from titles;

select au_id, au_lname, au_fname, city
from authors
where city = 'San Francisco';

select count(*) as num_titles
from titles;

select count(*) as num_authors
from authors;

select title_id, title
from titles
where title like 'S%';

select avg(ltrim(price,'$')) as avg_price
from titles;

select stor_id, stor_name, sales.date, ord_num
from stores natural join sales
where stor_name = 'Bookbeat'

select distinct titles.title
from stores natural join salesdetail natural join titles
where stor_name = 'Bookbeat'

select discounts.discounttype, stores.stor_name, stores.city
from discounts natural join stores;

-- Aufgabe 2
-- 1.  Wieso listet nachfolgender SQL Ausdruck eine leere Tabelle aus?
--     SELECT title, price
--     FROM titles
--     WHERE price >= ALL (SELECT price FROM titles)
-- 2.  Was muss bei obigem Ausdruck geändert werden, damit das teuerste Buch ausgegeben
-- wird?
-- 3.  Geben Sie einen SQL Ausdruck an, der sämtliche Bücher auflistet, die teurer als das
-- billigste Psychologie-Buch sind. Verwenden Sie dabei weder die Funktion MIN() noch die
-- Funktion MAX().
-- 4.  Geben Sie einen SQL Ausdruck an, der sämtliche Autoren auflistet, die in einem Staat
-- wohnen, in dem es keinen der in der pubs2 erfassten Läden gibt.

-- 1. Da es NULL-Werte hat

SELECT title, price FROM titles
WHERE price >= SOME (SELECT price FROM titles WHERE type='psychology');
