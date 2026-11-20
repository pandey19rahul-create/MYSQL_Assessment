-- Exercise 3
SELECT property_name,price_per_night 
FROM property 
WHERE location LIKE'%Goa%'
AND price_per_night<3000;
