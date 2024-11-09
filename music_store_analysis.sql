USE musicstore
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


SELECT * FROM GENRE 
WHERE name LIKE 'Rock'



