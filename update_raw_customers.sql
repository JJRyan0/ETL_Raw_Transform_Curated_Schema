--add new column to raw table
ALTER TABLE to add the signup_date;

--update the existing rows with signup date = to created_date
UPDATE raw_customers
SET signup_date = created_date;  -- or use a fixed date like '2023-01-01'


--else try: existing rows with signup date = to created_date
UPDATE raw_customers
SET signup_date = CAST(created_date AS DATE)
WHERE customer_id IN (1, 2);

-- ad a new row as customer_id = 3

INSERT INTO raw_customers (
    customer_id,
    customer_name,
    email,
    date_of_birth,
    address_line1,
    city,
    postal_code,
    country,
    created_date,
    signup_date
) VALUES (
    3,
    'Alice Johnson',
    'alice@example.com',
    '1990-06-15',
    '789 Elm Street',
    'Calgary',
    'T2P 3H7',
    'Canada',
    GETDATE(),         -- created_date
    CAST(GETDATE() AS DATE)  -- sign_up_date (only the date part)
);
