-- Exercise 5
SELECT property_name, created_at 
FROM property 
WHERE DATE(created_at)=CURDATE();
