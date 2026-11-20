-- Step 1: Start the transaction and insert Ramesh's booking
START TRANSACTION;

INSERT INTO booking (property_id, customer_id, check_in_date, check_out_date, total_amount, status) 
VALUES (1, 1, '2026-05-01', '2026-05-10', 5000.00, 'PENDING');

-- Step 2: Create a SAVEPOINT right after the insertion
SAVEPOINT after_booking_insert;

-- Step 3: Update the dates (Ramesh realizes he chose the wrong dates)
UPDATE booking 
SET check_in_date = '2026-05-15', check_out_date = '2026-05-20' 
WHERE customer_id = 1 AND status = 'PENDING';

-- Step 4: Implement the condition (Choose ONE based on the situation)

/* SITUATION A: If Ramesh confirms the new dates, use:
   COMMIT; 
*/

/* SITUATION B: If Ramesh cancels the date change but wants to keep the booking:
   ROLLBACK TO SAVEPOINT after_booking_insert;
   COMMIT; -- To save the original insertion
*/

/* SITUATION C: If Ramesh cancels everything:
   ROLLBACK; 
*/