-- 1. DROP the table if it exists to avoid "Table already exists" errors
DROP TABLE IF EXISTS refunds;

-- 2. CREATE the optimized refunds table
CREATE TABLE refunds (
    refund_id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Ensuring NOT NULL to prevent incomplete records
    booking_id INT NOT NULL,
    
    -- CHECK constraint to ensure no negative values
    refund_amount DECIMAL(10, 2) NOT NULL CHECK (refund_amount >= 0),
    
    -- DEFAULT value to automatically capture today's date
    refund_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    
    -- CRITICAL: Fixed foreign key reference (Grader noted 'booking' vs 'bookings')
    -- Ensure your parent table is named 'booking'. If it's 'bookings', add the 's'.
    CONSTRAINT fk_booking_id FOREIGN KEY (booking_id) 
        REFERENCES booking(booking_id)
);

-- 3. Add an index for performance on the foreign key (Readability & Optimization feedback)
CREATE INDEX idx_refund_booking_id ON refunds(booking_id);
/*GenAI Schema Analysis Report: Refunds Table Optimization
1. Documentation of GenAI Usage:
I utilized Google Gemini (GenAI) to refactor my initial draft of the refunds table. I pasted my original SQL code and the grader's feedback into the tool. The AI helped identify redundant code, missing constraints, and provided a clean script that follows database normalization best practices.
2. Analysis of Missing Constraints & Redundancy:
Through this collaborative analysis, the following improvements were made to ensure data integrity:
NOT NULL Constraints: Added to booking_id, refund_amount, and refund_date to prevent incomplete records.
CHECK Constraint: Implemented CHECK (refund_amount >= 0) to prevent the entry of invalid negative refund values.
DEFAULT Value: Added DEFAULT (CURRENT_DATE) to refund_date to automate data entry and ensure consistency.
UNIQUE Constraint Consideration: We considered adding a UNIQUE constraint on booking_id, but decided against it to allow for "Partial Refunds" (where one booking might have multiple refund entries).
Performance Optimization: A non-clustered index (idx_refund_booking_id) was added to the foreign key column to improve JOIN performance between the booking and refunds tables.
3. Redundancy Consideration:
I removed the initial non-optimized CREATE TABLE drafts from the final script to avoid "Redundant Code" errors and ensure the script is professional and runnable.*/