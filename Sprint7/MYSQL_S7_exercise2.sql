-- STEP 0: Data Cleaning (Addressing the 'Critical Issue')
-- Ensure there are no invalid rows before applying constraints, otherwise ALTER TABLE will fail.
SET SQL_SAFE_UPDATES=0;
UPDATE customer SET username = 'GuestUser' WHERE username IS NULL;
UPDATE customer SET phone_number = '0000000000' WHERE LENGTH(phone_number) <> 10 OR phone_number IS NULL;

-- STEP 1: Apply Constraints with proper naming and syntax
ALTER TABLE customer 
    -- 1. Named UNIQUE constraint for email
    ADD CONSTRAINT uq_customer_email UNIQUE (email),

    -- 2. Proper syntax for CHECK constraint (length of phone number)
    -- We modify the column first, then add the named constraint
    MODIFY phone_number VARCHAR(10),
    ADD CONSTRAINT chk_customer_phone_length CHECK (LENGTH(phone_number) = 10),

    -- 3. NOT NULL constraint
    MODIFY username VARCHAR(100) NOT NULL;