-- EXERCISE 3
-- Task 1
SELECT property_name,JSON_EXTRACT(property_details,'$."Room Types"')  Room_types 
FROM property;
-- Task 2
SELECT property_name,JSON_EXTRACT(property_details,'$."Year Built"') Year_Built
FROM property
 WHERE JSON_CONTAINS_PATH(property_details,'one','$."Year Built"') ; 

-- Task 3
SELECT property_name,JSON_EXTRACT(property_details,'$."Room Types"') as Room_Types
FROM property
WHERE 
JSON_CONTAINS(JSON_EXTRACT(property_details,'$."Room Types"'),'"Deluxe"');

-- Task 4

SELECT  property_name ,JSON_EXTRACT(property_details,'$."Year Built"') 
FROM 
property 
WHERE CAST(JSON_UNQUOTE(JSON_EXTRACT(property_details,'$."Year Built"')) AS UNSIGNED )>2020; 
  
  
-- TASK 5

SELECT property_name,property_details
FROM property
WHERE NOT
JSON_CONTAINS_PATH(property_details,'one','$."Year Built"');
