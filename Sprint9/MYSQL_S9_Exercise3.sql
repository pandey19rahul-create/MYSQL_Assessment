-- Exercise 3
-- Task 1
CREATE TABLE daily_booking_summary (
    summary_id INT AUTO_INCREMENT PRIMARY KEY,
    report_date DATE,
    total_bookings INT,
    total_revenue DECIMAL(15,2),
    unique_properties_booked INT
);


SET GLOBAL event_scheduler = ON; 
drop event if exists Test_dailyReport;
DELIMITER //

CREATE EVENT Test_DailyReport
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    INSERT INTO daily_booking_summary (report_date, total_bookings, total_revenue, unique_properties_booked)
    SELECT 
        CURDATE(), 
        COUNT(booking_id), 
        COALESCE(SUM(total_amount), 0), 
        COUNT(DISTINCT property_id)
    FROM Booking
    WHERE DATE(check_in_date) = CURDATE();
END //

DELIMITER ;
SELECT * FROM daily_booking_summary ORDER BY report_date DESC ;
SELECT property_id, availability_status FROM property WHERE availability_status = 'inactive';-- to guide verification after the events run.

drop event if exists CleanupInactiveProperties;
    -- Task2 
    
    CREATE EVENT CleanupInactiveProperties
ON SCHEDULE EVERY 1 minute
DO
    UPDATE property
    SET availability_status = 'inactive'
    WHERE property_id NOT IN (
        SELECT DISTINCT property_id 
        FROM Booking 
        WHERE check_in_date >= CURDATE() - INTERVAL 6 MONTH
    );
    