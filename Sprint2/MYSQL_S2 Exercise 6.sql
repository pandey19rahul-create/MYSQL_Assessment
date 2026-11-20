-- Exercise 6
-- Using Left outer join
SELECT 
  a.amenity_name, 
  p.property_name
FROM amenity  a
LEFT OUTER JOIN  property_amenity ap ON a.amenity_id=ap.amenity_id
LEFT OUTER JOIN  property AS p ON  ap.property_id=p.property_id;