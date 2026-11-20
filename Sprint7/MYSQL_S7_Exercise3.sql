-- 1. CLEANUP (The order matters!)
-- First, drop the user if they exist
DROP USER IF EXISTS 'analyst_user'@'%';

-- Second, drop the role if it exists
DROP ROLE IF EXISTS 'data_analyst';


-- 2. CREATE ROLE & GRANT PERMISSIONS
CREATE ROLE 'data_analyst';
GRANT SELECT ON *.* TO 'data_analyst';


-- 3. CREATE USER (Consistent naming with @'%')
CREATE USER 'analyst_user'@'%' IDENTIFIED BY 'your_password_here';


-- 4. ASSIGN ROLE (Using consistent host)
GRANT 'data_analyst' TO 'analyst_user'@'%';
SET DEFAULT ROLE 'data_analyst' TO 'analyst_user'@'%';


-- 5. REVOKE PERMISSIONS
-- Replacing *.* with your specific schema name (like movieonrent.*) is best practice
REVOKE DELETE ON *.* FROM 'analyst_user'@'%';