--Testing data on dvdrental db
/*
SELECT * FROM film;
*/
--Challenge: Send out a promotional email to our existing customers
/*
SElECT first_name, last_name, email 
FROM customer;
*/

--Challenge: How many unique rental rate we have in our film table
/*
SELECT DISTINCT(rental_rate)
FROM film;
*/

--Challenge: We want to know the types of ratings we have in our database
/*
SElECT DISTINCT rating
FROM film;
*/

--Challenge: What is the email for the cusstomer with the name Nancy Thomas?
/*
SELECT email
FROM customer
WHERE first_name='Nancy'
	AND last_name='Thomas';
*/

--Challenge: What the movie "Outlaw Hanky" is about?
/*
SELECT description
FROM film
WHERE title='Outlaw Hanky';
*/

--Challenge: Can you get the phone number for the customer
--           who lives at '259 Ipoh Drive'?
/*
SELECT phone
FROM address
WHERE address = '259 Ipoh Drive';
*/

--Challenge: What are the customer ids of the first 10 customers who created a payment?
/*
SELECT customer_id
FROM payment
ORDER BY payment_date
LIMIT 10;
*/

--Challenge: What are the titles of the 5 shortest (in length of runtime) movies?
/*
SELECT title, length
FROM film
ORDER BY length
LIMIT 5;
*/

--Challenge: If the customer can watch any movie that is 50 minutes or less in run time,
--           how many options does she/he have?
/*
SELECT COUNT(title)
FROM film
WHERE length<=50;
*/

--Challenge: How many customers' name start with J?
/*
SELECT COUNT(*) FROM customer WHERE first_name like 'J%';
SELECT COUNT(*) FROM customer WHERE first_name ilike 'j%'; --case insensitive
*/

--Challenge: How many payment transactions were greater that $5.00?
/*
SELECT COUNT(*)
FROM payment
WHERE amount>5.00;
*/

--Challenge: How may actors have a first name that starts with the letter P?
/*
SELECT COUNT(*)
FROM actor
WHERE first_name ILIKE 'p%' ;
*/

--Challenge: How many unique districts are our customers from
/*
SELECT COUNT(DISTINCT district)
FROM address;
*/

--Challenge: Retrieve the list of names for those distinct districts 
--           from the previous question
/*
SELECT DISTINCT district
FROM address
ORDER BY district;
*/

--Challenge: How many films have a rating of R and a replacement cost
--           between $5 and $15?
/*
SELECT count(title)
FROM film
WHERE rating='R'
	AND replacement_cost BETWEEN 5 AND 15;
*/

--Challenge: How many films have the word Truman somewhere in the title?
/*
SELECT COUNT(title)
FROM film
WHERE title ILIKE '%truman%';
*/

--Challenge: Making group by dates
/*
SELECT DATE(payment_date), COUNT(*), SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY DATE(payment_date)
*/

--Challenge: How many payments did each staff member handle and who gets the bonus?
/*
SELECT staff_id, COUNT(*)
FROM payment
GROUP BY staff_id
ORDER BY COUNT(*) DESC
*/

--Challenge: What is the average replacement cost per MPAA rating
/*
SELECT rating, ROUND(AVG(replacement_cost), 2) as replacement_cost_tot
FROM film
GROUP BY rating
ORDER BY replacement_cost_tot DESC;
*/

--Challenge: What are the customer ids of the top 5 customers by total spend?
/*
SELECT customer_id, SUM(amount) as total_spend
FROM payment
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 5;
*/

--Challenge: Platinum status is given to customers that have had 40 or more transaction
--           payments. What customer ids are eligible for platinum status?
/*
SELECT customer_id, COUNT(*) as q_payments
FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40
ORDER BY q_payments DESC; 
*/

--Challenge: What are the customer ids of customers who have spent more than $100 
--           in payment transactions with our staff_id member 2?
/*
SELECT customer_id, SUM(amount) as total_spent
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount)>100
ORDER BY total_spent DESC;
*/

--Assessment I.1: Return the customer IDs of customers who have spent at least $110
--                with the staff member who has an ID of 2
/*
SELECT customer_id, SUM(amount) as total_spent
FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount)>=110
ORDER BY total_spent DESC;
*/

--Assessment I.2: How many fimls begin with the letter J?
/*
SELECT COUNT(*) FROM film
WHERE title ILIKE 'j%';
*/

--Assessment I.3: What customer has the highest customer ID number whose name starts
--                with an 'E' and has an address ID lower than 500?
/*
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name ILIKE 'e%'
AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;
*/

-- Challenge: Working with Full Outer Join
-- Identify which clients are not associated with payments and wich payments are not 
-- linked to payments
/*
SELECT *
FROM customer AS c
	FULL OUTER JOIN payment AS p ON c.customer_id = p.customer_id
WHERE (c.customer_id IS NULL
	OR p.customer_id IS NULL);
	
-- To validate this
SELECT COUNT(DISTINCT customer_id) FROM customer
SELECT COUNT(DISTINCT customer_id) FROM payment
*/

-- Challenge: What are the emails of the customers who live in California?
/*
SELECT c.first_name, c.last_name, c.email, a.district
FROM customer as c
	INNER JOIN address AS a ON c.address_id = a.address_id
WHERE a.district = 'California'
*/

-- Challenge: Get a list of all the movies "Nick Wahlberg" has been in
/*
SELECT f.title as movie
FROM film AS f
	INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
	INNER JOIN actor AS a on fa.actor_id = a.actor_id
WHERE a.first_name = 'Nick'
	AND a.last_name = 'Wahlberg';
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- Timestamps and extract functions
-- TIME --> only time
-- DATE --> only date
-- TIMESTAMP --> date and time
-- TIMESTAMPTZ --> date, time, and timezone
-------------------------------------------------------------
-------------------------------------------------------------
/*
SHOW ALL;
SHOW TIMEZONE;

SELECT NOW(), TIMEOFDAY(), CURRENT_TIME, CURRENT_DATE;

-- EXTRACT() YEAR, MONTH, DAY, WEEK, QUARTER, AGE(), TO_CHAR()
SELECT EXTRACT(DOW FROM NOW());
SELECT AGE(NOW());
SELECT 
	AGE(payment_date) AS age_column, 
	EXTRACT(WEEK FROM payment_date) AS extract_column, 
	TO_CHAR(payment_date, 'Dy Mon dd, yyyy HH:MI:SS a.m.') AS format_column,
	payment_date AS date_column
FROM payment;
*/

-- Challenge: During which months did payments occur?
/*
SELECT DISTINCT(TO_CHAR(payment_date, 'Month')) AS pay_month
FROM payment;
*/

-- Challenge: How many payments occurred on a Monday?
/*
SELECT TO_CHAR(payment_date, 'Dy') AS pay_week_day, COUNT(*) AS Total_payments
FROM payment
GROUP BY pay_week_day;

SELECT COUNT(*)
FROM payment
WHERE EXTRACT(DOW from payment_date)=1;
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- Mathematical functions
-- |/ square root
-- ||/ cube root
-- @ absolute value
-------------------------------------------------------------
-------------------------------------------------------------
/*
SELECT 
	|/4 AS square_v, 
	||/8 AS cube_v, 
	@ -42.1 AS absolute_v,
	--5 ! AS factorial_v,
	7 % 2 AS residual_v,
	1 & 2 AS bitwise_and,
	1 | 2 AS bitwise_or,
	1 # 2 AS bitwise_xor,
	~ 1 AS bitwise_not,
	1 << 4 AS bitwise_shift_left,
	8 >> 2 AS bitwise_shift_right
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- Strings functions and operations
-- || concatenate
-- bit_length -- bits
-- char_length
-- octet_length --> bytes
-- overlay
-- position
-- substring
-------------------------------------------------------------
-------------------------------------------------------------
/*
SELECT 
	'Post' || 'greSQL',
	'Value: ' || 42,
	BIT_LENGTH('Jose'),
	CHAR_LENGTH('Jose'),
	OCTET_LENGTH('Jose'),
	LENGTH('Jose'),
	LOWER('Tom'),
	UPPER('Tom'),
	OVERLAY('Txxxxas' PLACING 'hom' FROM 2 FOR 4),
	POSITION('om' in 'Thomas'),
	SUBSTRING('Thomas' from 3 for 2),
	SUBSTRING('Thomas' from '...$'),
	SUBSTRING('Thomas' from '%#"o_a#"_' for '#'),
	TRIM(both 'xyzXYZ' from 'yxTomXX'),
	ASCII('x'),
	CHR(120),
	BTRIM('xyxtrimyyx', 'xyz'),
	CONCAT('Post','greSQL ',2.0),
	CONCAT_WS(',','abc',2,NULL,'End',TRUE, FALSE),
	INITCAP('jose'),
	LEFT('jose',2),
	RIGHT('jose',2)
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- Subqueries
-------------------------------------------------------------
-------------------------------------------------------------

-- Challenge: find films with an rental rate above the average
/*
SELECT title
FROM film
WHERE rental_rate > (
	SELECT AVG(rental_rate)
	FROM film
);
*/

-- Challenge: first query generate duplicates.
/*
SELECT f.title 
FROM rental AS r
INNER JOIN inventory AS i ON r.inventory_id=i.inventory_id 
INNER JOIN film AS f ON i.film_id=f.film_id
WHERE r.return_date BETWEEN '2005-05-29' AND '2005-05-30';
ORDER BY f.title;

SELECT title
FROM film
WHERE film_id in (
	SELECT i.film_id
	FROM rental AS r
	INNER JOIN inventory AS i ON r.inventory_id=i.inventory_id 
	WHERE r.return_date BETWEEN '2005-05-29' AND '2005-05-30'
)
ORDER BY title;
*/

-- Challenge: find customers with at least one payment greater than $11
/*
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE EXISTS(
	SELECT * 
	FROM payment as p
	WHERE p.customer_id=c.customer_id
	AND p.amount>11
);

-- opposite
SELECT c.first_name, c.last_name
FROM customer AS c
WHERE NOT EXISTS(
	SELECT * 
	FROM payment as p
	WHERE p.customer_id=c.customer_id
	AND p.amount>11
);
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- Self Join
-------------------------------------------------------------
-------------------------------------------------------------

-- Challenge: find all the pairs of films that have the same length
/*
SELECT f1.title, f2.title, f1.length
FROM film as f1
	INNER JOIN film as f2 
		ON f1.length=f2.length 
		AND f1.film_id!=f2.film_id
ORDER BY f1.length DESC
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- CASE
-------------------------------------------------------------
-------------------------------------------------------------
/*
select 
	customer_id,
	case
		when customer_id<=100 then 'Premium'
		when customer_id between 101 and 200 then 'Plus'
		else 'Normal'
	end as category,
	case customer_id 
		when 2 then 'Winner'
		when 5 then 'Second place'
		else 'Normal'
	end as raffle_result
from customer;

select 
	sum(
		case rental_rate
			when 0.99 then 1
			else 0
		end
	) as bargains,
	sum(
		case rental_rate
			when 2.99 then 1
			else 0
		end
	) as regulars,
	sum(
		case rental_rate
			when 4.99 then 1
			else 0
		end
	) as premium
from film;

select 
	sum(case rating when 'R' then 1 else 0 end) as r,
	sum(case rating when 'PG' then 1 else 0 end) as pg,
	sum(case rating when 'PG-13' then 1 else 0 end) as pg13
from film
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- COALESCE --> return the first not null value from the provided list
-------------------------------------------------------------
-------------------------------------------------------------
/*
select coalesce(1, 2), coalesce(null, 2, 3)
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- CAST 
-------------------------------------------------------------
-------------------------------------------------------------
/*
select cast('5' as integer), '5'::integer;

select length(inventory_id::varchar),
	char_length(inventory_id::varchar)
from rental;
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- NULLIF --> return null if the 2 arguments are equal, otherwise return the 1st arg.
-------------------------------------------------------------
-------------------------------------------------------------
/*
select nullif(10,10), nullif(10,12)
*/

-------------------------------------------------------------
-------------------------------------------------------------
-- VIEWS
-------------------------------------------------------------
-------------------------------------------------------------
/*
create or replace view view_customer_info as
select first_name, last_name, address, district
from customer
	inner join address on customer.address_id=address.address_id;

alter view view_customer_info rename to view_customer;

select * from view_customer;

drop view if exists view_customer;
*/
