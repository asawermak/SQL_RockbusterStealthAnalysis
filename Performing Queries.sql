#  Performing Queries
## Step 1: Find the average amount paid BY the top 5 customers.
SELECT AVG (total_amount_paid) AS average
FROM
  (SELECT A.customer_id,
          A.first_name,
          A.last_name,
          D.country,
          C.city,
          SUM(B.amount) AS total_amount_paid
   FROM customer A
   JOIN payment B ON A.customer_id = B.customer_id
   JOIN address E ON A.address_id = E.address_id
   JOIN city C ON E.city_id = C.city_id
   JOIN country D ON C.country_id = D.country_id
   WHERE C.city IN
       (SELECT city
        FROM customer A
        JOIN address E ON A.address_id = E.address_id
        JOIN city C ON E.city_id = C.city_id
        JOIN country D ON C.country_id = D.country_id
        GROUP BY C.city
        ORDER BY COUNT(A.customer_id) DESC
        LIMIT 10)
   GROUP BY A.customer_id,
            A.first_name,
            A.last_name,
            D.country,
            C.city
   ORDER BY total_amount_paid DESC
   LIMIT 5) AS total_amount_paid;

## Step 2: Find OUT how many OF the top 5 customers you IDENTIFIED IN step 1 ARE based within EACH country.
SELECT D.country,
       COUNT(DISTINCT A.customer_id) AS all_customer_count,
       COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
FROM customer A
JOIN address E ON A.address_id = E.address_id
JOIN city C ON E.city_id = C.city_id
JOIN country D ON C.country_id = D.country_id
LEFT JOIN
  (SELECT A.customer_id,
          A.first_name,
          A.last_name,
          D.country,
          C.city,
          SUM(B.amount) AS total_amount_paid
   FROM customer A
   JOIN payment B ON A.customer_id = B.customer_id
   JOIN address E ON A.address_id = E.address_id
   JOIN city C ON E.city_id = C.city_id
   JOIN country D ON C.country_id = D.country_id
   WHERE C.city IN
       (SELECT city
        FROM customer A
        JOIN address E ON A.address_id = E.address_id
        JOIN city C ON E.city_id = C.city_id
        JOIN country D ON C.country_id = D.country_id
        GROUP BY C.city
        ORDER BY COUNT(A.customer_id) DESC
        LIMIT 10)
   GROUP BY A.customer_id,
            A.first_name,
            A.last_name,
            D.country,
            C.city
   ORDER BY total_amount_paid DESC
   LIMIT 5) AS top_5_customers ON A.customer_id = top_5_customers.customer_id
GROUP BY D.country
ORDER BY all_customer_count DESC
LIMIT 15
