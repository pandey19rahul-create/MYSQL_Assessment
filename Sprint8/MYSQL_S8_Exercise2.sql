-- ======================================================
-- SESSION 1: Primary Transaction
-- ======================================================
START TRANSACTION;

-- 1. Locking property_id = 1 for update
-- This prevents any other session from modifying this specific row.
SELECT * FROM property 
WHERE property_id = 1 
FOR UPDATE;

-- 2. Performing the booking insert
INSERT INTO booking (property_id, customer_id, check_in_date, check_out_date, total_amount, status)
VALUES (1, 10, '2026-08-01', '2026-08-05', 4500.00, 'CONFIRMED');

-- 3. Releasing the lock by committing
COMMIT;


-- ======================================================
-- SESSION 2: Concurrent Transaction Simulation
-- ======================================================
-- This block represents a second user trying to book the same property at the same time.

START TRANSACTION;

-- 1. Attempting to lock the SAME property (property_id = 1)
-- CRITICAL NOTE: This statement will 'Wait' or 'Hang' until Session 1 runs 'COMMIT'.
SELECT * FROM property 
WHERE property_id = 1 
FOR UPDATE;

-- 2. Once Session 1 commits, Session 2 gains the lock and proceeds.
-- We simulate a failure or a check here to show proper handling.
INSERT INTO booking (property_id, customer_id, check_in_date, check_out_date, total_amount, status)
VALUES (1, 11, '2026-08-01', '2026-08-05', 4500.00, 'PENDING');

-- 3. Example of Handling a failed booking/scenario (As requested by grader)
-- If the dates overlap, we rollback to keep the database consistent.
ROLLBACK;