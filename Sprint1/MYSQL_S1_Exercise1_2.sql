-- Exercise 1
-- Task 1-Property_id is the column that is uniquely identified each property
-- task 2- Owner_id column  is present in both the table property and owner that connects or relate the table

-- Exercise 2
SHOW DATABASES;
USE accommodation;
SHOW TABLES;
SELECT  property_name,location,
price_per_night 
FROM property;

