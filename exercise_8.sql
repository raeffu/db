-- Aufgabe 1
-- Geben Sie SQL Anfragen für die publications-Datenbank an (Schema auf Übungsblatt 6). Testen Sie alle Abfragen mit SQLite.
-- 1. Bestimmen Sie alle Bücher, die den gleichen Typ besitzen wie das Buch 'Net Etiquette'.
-- 2. Bestimmen Sie für jeden Laden den Gesamtpreis der verkauften Bücher jedes Autors
-- (ohne Discounts), absteigend sortiert.
-- 3. Bestimmen Sie alle Autoren, die weniger 'psychology' Bücher herausgegeben haben als
-- 'Livia Karsen'.
-- 4. Geben Sie für jedes Buch seinen Titel, Preis, Anzahl bisher verkaufter Exemplare sowie die
-- effektiv geschuldeten Tantiemen an. (Die pro Buch geschuldete Tantieme in Prozent des
-- Verkaufspreises ist in der Spalte royalty in Abhängigkeit der Verkaufszahlen angegeben.)
-- 5. Geben Sie die Städte an, in denen es sowohl Autoren wie auch Verleger gibt.
-- 6. Testen Sie, ob die Werte des Attributs total_sales korrekt sind, indem Sie alle Buchtitel mit
-- falschen Werte zusammen mit den Werten ausgeben.
-- 7. Geben Sie die Läden an, die schon Bücher aller Typen verkauft haben.

select title
from titles
where type = (select type from titles where title = 'Net Etiquette');

select au_id, stor_id, sum(qty*price) as summe
from titles natural join salesdetail natural join titleauthor
group by stor_id, au_id
order by stor_id, summe desc;

select au_lname, au_fname
from authors
where au_id not in(
	select au_id
	from titleauthor natural join titles natural join authors
	where type = 'psychology  '
	group by au_id
	having count(*) >= (
		select count(*)
		from authors natural join titleauthor natural join titles
		where type = 'psychology  '  and au_lname = 'Karsen'
	)
)
order by au_lname, au_fname;

select title, price, total_sales, price*total_sales*(royalty*0.01)
from titles natural join roysched
where total_sales between lorange and hirange;

select distinct authors.city
from authors, publishers
where authors.city = publishers.city;

select city from authors
intersect
select city from publishers;

select title, total_sales, sum(qty) as correct_sales
from titles natural join salesdetail
group by title, total_sales
having total_sales <> correct_sales;

select stor_name from stores
EXCEPT select stor_name from
(
  select stor_name, type from titles, stores
  where type<>'UNDECIDED'
  EXCEPT
  select type, stor_name from titles natural join salesdetail natural join stores
  where type<>'UNDECIDED'
) as notsold;