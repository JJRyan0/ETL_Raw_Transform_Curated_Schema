-- create table
CREATE TABLE raw_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    brand VARCHAR(100),
    created_date DATETIME
);

-- insert sample raw data
INSERT INTO raw_products (product_id, product_name, category, brand, created_date)
VALUES 
(101, 'Wireless Mouse', 'Electronics', 'Logitech', '2024-03-01'),
(102, 'Noise Cancelling Headphones', 'Electronics', 'Sony', '2024-03-02'),
(103, 'Espresso Machine', 'Home Appliances', 'Breville', '2024-03-03'),
(104, 'Running Shoes', 'Sportswear', 'Nike', '2024-03-04'),
(105, 'Smart Watch', 'Wearables', 'Apple', '2024-03-05');
