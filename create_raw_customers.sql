-- Create Raw Schema - Raw Tables and Insert Dirty Data
--This step simulates raw data in your source system.

CREATE TABLE raw_customers (
    customer_id INT,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    date_of_birth DATE,
    address_line1 VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    created_date DATETIME
);

--Sample Data Insert:

INSERT INTO raw_customers (customer_id, customer_name, email, date_of_birth, address_line1, city, postal_code, country, created_date)
VALUES 
(1, 'John Doe', 'john@example.com', '1985-06-10', '123 Main St', 'Seattle', '98101', 'USA', GETDATE()),
(2, 'Jane Smith', 'jane@example.com', '1990-02-15', '456 Maple Ave', 'Toronto', 'M5H 2N2', 'Canada', GETDATE());
