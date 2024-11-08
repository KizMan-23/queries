--- MUSIC STORE  ANALYSIS --- 
--- PROVIDE QUERIES FOR FOLLOWING QUESTIONS---

'Q1 - WHO IS THE SENIOR MOST EMPLOYEE BASED ON JOB TITLE'
SELECT last_name, first_name, title, levels FROM employee
ORDER BY levels DESC
LIMIT 1;


'Q2 -- WHICH COUNTRY HAVE THE MOST INVOICES?'

SELECT billing_country, COUNT(1) as Invoice_Count
FROM invoice
GROUP BY billing_country
ORDER BY Invoice_Count DESC


'Q3 -- WHAT ARE THE TOP 3 VALUES OF TOTAL INVOICE'
SELECT billing_country, total
FROM invoice
ORDER BY total DESC
LIMIT 3

'Q4 -- WHICH CITY HAS BEST CUSTOMERS?..-- 1 CITY WITH THE HIGHEST SUM OF INVOICE TOTALS'
'RETURN BOTH THE CITY NAME AND SUM OF ALL INVOICE TOTAL'

select cu.city, cu.country, sum(iv.total) as total_invoice from customer cu
join invoice iv on iv.customer_id = cu.customer_id
group by cu.city, cu.country
order by total_invoice desc
limit 3

select billing_city, billing_country, sum(total) as total_invoice
from invoice
group by billing_city, billing_country
order by total_invoice desc
limit 3


'Q5 -- WHO IS THE BEST CUSTOMER? - THE CUSTOMER THAT SPENT THE MOST MONEY'

select cu.customer_id, cu.first_name, cu.last_name, iv.billing_country, sum(iv.total) customer_total from customer cu
join invoice iv on iv.customer_id = cu.customer_id
group by cu.customer_id, cu.first_name, cu.last_name, iv.billing_country
order by customer_total desc
limit 3

--INTERMEDIATE --

'Q6 -- RETURN THE EMAIL, FIRST NAME, LAST NAME & GENRE OF ALL ROCK MUSIC LISTENERS'
'THE LIST SHOULD BE APHABETICALLY ORDERED BY EMAIL'
SELECT name, count(1) FROM GENRE
group by name

SELECT DISTINCT cu.first_name, cu.last_name, cu.email, gen.name from customer cu
JOIN invoice iv ON iv.customer_id = cu.customer_id
JOIN invoice_line il ON il.invoice_id = iv.invoice_id
JOIN track tr ON tr.track_id = il.track_id
JOIN genre gen ON gen.genre_id = tr.genre_id
WHERE gen.name = 'Rock'
ORDER BY cu.email

'Q7 -- RETURN 10 ARTISTS WHO HAVE WRITTEN THE MOST ROCK MUSIC IN OUR DATABASE--'

SELECT art.artist_id, art.name, gen.name as Genre, count(art.artist_id)  as num_release 
FROM artist art
JOIN album al ON al.artist_id = art.artist_id
JOIN track tr ON tr.album_id = al.album_id
JOIN genre gen ON tr.genre_id = gen.genre_id
WHERE gen.name = 'Rock'
GROUP BY art.artist_id, art.name, gen.name
ORDER BY num_release desc
LIMIT 10


'Q8 RETURN ALL THE TRACK THAT HAVE A SONG LENGTH LONGER THAN THE AVERAGE SONG LENGTH'
'RETURN THE NAME AND MILLISEONDS FOR EACH TRACK. ORDER BY THE SONG LENGTH WITH THE LONGEST SONGS LISTED FIRST'

SELECT name, milliseconds 
FROM track
WHERE milliseconds > (
	select avg(milliseconds) from track
    )
ORDER BY milliseconds desc


-- ADVANCED --

'Q9 -- FIND HOW MUCH AMOUNT SPENT BY EACH CUSTOMER ON ARTISTS? 
-- WRTIE A QUERY TO RETURN CUSTOMER NAME, ARTIST NAME AND TOTAL SPENT'

WITH top_spenders as (
		SELECT iv.customer_id, CONCAT(cu.first_name, ' ', cu.last_name) as full_name,
		tr.track_id, SUM(iv.total) as Amt_Spent 
		FROM track tr
		Join invoice_line il on il.track_id = tr.track_id
		JOIN invoice iv ON iv.invoice_id = il.invoice_id
		JOIN customer cu ON cu.customer_id = iv.customer_id
		GROUP BY iv.customer_id, tr.track_id, cu.first_name, cu.last_name
		ORDER BY Amt_Spent desc
        LIMIT 5
)
        
SELECT ts.customer_id, ts.full_name, art.name, tr.track_id, ts.Amt_Spent
FROM artist art
JOIN album al ON al.artist_id = art.artist_id
JOIN track tr ON tr.album_id  = al.album_id
JOIN top_spenders ts ON ts.track_id = tr.track_id 
GROUP BY 1, 2, 3, 4
ORDER BY 5 desc


WITH best_selling_artist AS (
	SELECT ar.artist_id as Artist_id, ar.name as Artist_name,
    SUM(il.unit_price * il.quantity) as total_sales
    FROM invoice_line il
    JOIN track tr on tr.track_id = il.track_id
    JOIN album al on al.album_id = tr.album_id
    JOIN artist ar on ar.artist_id = al.artist_id
    GROUP BY 1
    ORDER BY 3 DESC
    LIMIT 1
    )

SELECT c.customer_id, c.first_name, c.last_name, bsa.Artist_name,
SUM(il.unit_price * il.quantity) as Amount_Spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album al ON al.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.Artist_id = al.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC 



'Q10 -- THE MOST POPULAR GENRE FOR EACH COUNTRY. THE MOST POPULAR GENRE IS THE GENRE WITH HIGHEST AMOUNT OF PURCHASE
FOR COUNTRIES WHERE MAX NUMBER OF PURCHASES IS SHARED. ALL GENRE IS RETURNED'


'Q11 -- DETERMINE THE CUSTOMER THAT HAS SPENT THE MOST ON MONEY FOR EACH COUNTRY- TOP SPENDER FOR EACH COUNTRY'
'FOR COUNTRIES WHERE THE TOP AMOUNT IS SHARED, PROVIDE ALL CUSTOMERS WHO SPENT THE AMOUNT
