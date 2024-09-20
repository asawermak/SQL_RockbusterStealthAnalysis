# Summarizing & Cleaning data
## Checking for and cleaning dirty data (Duplicate Data):

## Table Film:
  
SELECT 
  film_id, 
  title, 
  description, 
  release_year, 
  language_id, 
  rental duration, 
  rental rate, 
  length, 
  replacement_cost, 
  rating, 
  Iäst_update, 
  speci al_features, 
  COUNT(*) 
FROM 
  film 
GROUP BY 
  film_fd, 
  title, 
  description, 
  release_year, 
  language_id, 
  rental_duration, 
  rental_rate, 
  length, 
  replacement_cost, 
  rating, 
  last_update, 
  speci al_features 
HAVING 
  COUNT(*) > 1

## Table Customer:
  
SELECT 
  customer_id, 
  store id, 
  first_name last_Name, 
  email address_id, 
  activebool, 
  create_date last_update, 
  active COUNT(*) 
FROM 
  customer 
GROUP BY 
  customer_id, 
  store_id, 
  first_name last_Name, 
  email address_id, 
  activebool, 
  create_date last_update, 
  active 
HAVING 
  COUNT(*) > 1


## Non_uniform:
## Table film:
  
SELECT 
  DISTINCT film_id, 
  title, 
  description, 
  release_year, 
  language_id, 
  rental_duration, 
  rental_rate, 
  length, 
  replacement_cost, 
  rating, 
  last_update, 
  special_features 
FROM 
  film 
ORDER BY 
  film_id;

## Table Customer
SELECT 
  DISTINCT customer_id, 
  store_id, 
  first_name, 
  email, 
  address_id, 
  activebool, 
  create_date, 
  last_update, 
  active 
FROm 
  customer 
ORDER BY 
  customer_id;


## Missing values:
## Table film 

SELECT 
  * 
FROM 
  film 
WHERE 
  (
    film_id, title, description, release_year, 
    language_id, rental_duration, rental_rate, 
    length, replacement_cost, rating, 
    last_update, special_features
  ) Is NULL 
ORDER BY 
  film_id;
  
## Table customer

SELECT 
  * 
FROM 
  customer 
WhERE 
  (
    customer_id, store_id, first_name, 
    last_Name, email, address_id, activebool, 
    create_date, last_update, active
  ) is NULL 
ORDER BY 
  customer_id;


