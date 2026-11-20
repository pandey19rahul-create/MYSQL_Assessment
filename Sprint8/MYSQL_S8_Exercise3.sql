-- Task 1: Create a temporary table to store property-wise booking summary
-- This table exists only for the duration of your current session.
CREATE TEMPORARY TABLE property_booking_summary AS
SELECT 
    property_id, 
    COUNT(booking_id) AS total_bookings, 
    SUM(total_amount) AS total_revenue
FROM booking
GROUP BY property_id;

-- Task 2: Use a view to display total bookings and revenue for each property
-- A view is a virtual table that updates automatically when data changes.
CREATE OR REPLACE VIEW property_performance_view AS
SELECT 
    p.property_id, 
    p.property_name, 
    COUNT(b.booking_id) AS total_bookings, 
    SUM(b.total_amount) AS total_revenue
FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.property_name;

-- Task 3: Query the view to generate a report
-- This pulls the final report for management.
SELECT * FROM property_performance_view;