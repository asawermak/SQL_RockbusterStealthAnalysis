# Common Table Expressions
## Step 1: Find the average amount paid BY the top 5 customers USING CTEs WITH average_amount_cte (customer_id, first_name, last_name, country, city) AS
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
   LIMIT 5)
SELECT AVG(total_amount_paid)
FROM average_amount_cte;

## Step 2: Find out how many of the top 5 customers you identified in step 1 are based within each country. 
WITH top_5_customers_cte AS
  (SELECT D.country,
          COUNT(DISTINCT A.customer_id) AS all_customer_count,
          COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
   FROM customer A
   JOIN address E ON A.address_id = E.address_id
   JOIN city C ON E.city_id = C.city_id
   JOIN country D ON C.country_id = D.country_id
   LEFT JOIN (SELECTA.customer_id,
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
   LIMIT 15)
SELECT all_customer_count,
       top_customer_count
FROM top_5_customers_cte;
