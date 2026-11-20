USE Accommodation;
-- Exercise 1
ALTER TABLE  property 
ADD COLUMN property_details JSON;
DESC property;
SELECT * FROM property;