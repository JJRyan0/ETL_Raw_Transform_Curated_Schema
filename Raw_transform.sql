--ETL Project: Clean & Transform E-Commerce Orders

-- Create Raw Schema - Raw Tables and Insert Dirty Data
--This step simulates raw data in your source system.


-- RAW ORDERS TABLE: Contains the initial unclean data
CREATE TABLE raw_orders (
  order_id INT,                    -- Order identifier
  customer_id INT,                 -- Customer identifier
  order_date NVARCHAR(100),        -- Raw order date (in different formats)
  product_ids NVARCHAR(100),       -- Comma-separated list of product IDs
  quantity INT,                    -- Quantity of items ordered
  price NVARCHAR(50),              -- Price as text (with symbols and different formats)
  status NVARCHAR(20)              -- Order status (e.g., 'complete', 'processing')
);

-- Sample data with inconsistent date formats, multi-value product_ids, and price format issues
INSERT INTO raw_orders VALUES
(1, 101, '2023/01/15', '1,2', 2, '$20.00', 'complete'),
(2, 102, '15-01-2023', '3', 1, 'EUR 30.50', 'processing'),
(3, 101, 'Jan 20, 2023', '2,4', 3, 'CAD 15', 'complete');


--The raw_orders table contains messy data like inconsistent date formats ('2023/01/15', '15-01-2023', 'Jan 20, 2023'), multi-value fields for product_ids (e.g., '1,2'), and the price is stored as text (e.g., '$20.00', 'EUR 30.50').

--STEP 1: Create Cleaned Staging Table for Order Lines
--The staging table will store the cleaned, transformed data before it’s used for reporting.


-- Create a staging table to hold cleaned order lines
CREATE TABLE stage_order_lines (
  order_id INT,
  customer_id INT,
  product_id INT,
  order_date DATE,
  quantity INT,
  price DECIMAL(10,2),
  status NVARCHAR(20)
);


--We create a stage_order_lines table, where each row will correspond to a single product ordered (one row per product from the multi-value product_ids field).

--STEP 2: Transform & Insert Clean Data Into Staging
-- In this step, we transform the raw data into a cleaned format. We handle:

--Converting multiple product IDs into separate rows.

-- Normalizing the order_date field into a consistent DATE format.

--Parsing and cleaning the price column to a numeric format.

-- Clean and explode product_ids into individual rows, parse dates and prices
INSERT INTO stage_order_lines
SELECT 
  ro.order_id,
  ro.customer_id,
  TRY_CAST(TRIM(p.value) AS INT) AS product_id,  -- Splitting multi-value product IDs
  COALESCE(
    TRY_CONVERT(DATE, ro.order_date, 111),  -- Trying various date formats
    TRY_CONVERT(DATE, ro.order_date, 103),
    TRY_CONVERT(DATE, ro.order_date, 100),
    TRY_CONVERT(DATE, ro.order_date)  -- Final fallback
  ) AS order_date,
  ro.quantity,
  TRY_CAST(REPLACE(REPLACE(REPLACE(ro.price, '$', ''), 'EUR ', ''), 'CAD ', '') AS DECIMAL(10,2)) AS price,  -- Cleaning the price field
  ro.status
FROM raw_orders ro
CROSS APPLY STRING_SPLIT(ro.product_ids, ',') p;  -- Expanding the product_ids into individual rows


--STRING_SPLIT(ro.product_ids, ','): This splits the product_ids field (e.g., '1,2') into separate rows for each product ID.

--TRY_CONVERT(DATE, ...): We attempt to convert the order_date into a standard DATE format, trying various formats (e.g., 'YYYY/MM/DD', 'DD-MM-YYYY').

--REPLACE(): We clean the price field by removing currency symbols ($, EUR, CAD) and convert the value into a DECIMAL(10,2) format.

--TRY_CAST(): Used for safe conversions that return NULL if the conversion fails, preventing errors from bad data.

--Create Cleaned Customer View
--In this step, we clean up customer data (e.g., removing extra spaces, standardizing email format) and store it in a view.

-- Create a view for cleaned customer data

CREATE VIEW cleaned_customers AS
SELECT 
  customer_id,
  UPPER(LTRIM(RTRIM(customer_name))) AS customer_name,  -- Trim and standardize customer name
  LOWER(LTRIM(RTRIM(email))) AS email,                   -- Trim and standardize email to lowercase
  TRY_CAST(signup_date AS DATE) AS signup_date          -- Clean signup date
FROM raw_customers;


--LTRIM(RTRIM()): Removes leading and trailing spaces from customer_name and email.

--UPPER() and LOWER(): Standardizes the customer name (capitalized) and email (lowercase).

--TRY_CAST(): Converts the signup_date to a DATE format.

-- STEP 4: Final Reporting View — Join Everything
--Now, we join the cleaned stage_order_lines and cleaned_customers data to create a final 
--report that combines order details with customer data.


-- Create a final view that aggregates the data for reporting
CREATE VIEW order_summary AS
SELECT 
  so.order_id,
  c.customer_name,
  c.email,
  so.order_date,
  p.product_name,
  p.category,
  so.quantity,
  so.price,
  (so.quantity * so.price) AS total_amount,  -- Calculate total amount for each order line
  so.status
FROM stage_order_lines so
LEFT JOIN cleaned_customers c ON so.customer_id = c.customer_id  -- Join with cleaned customer data
LEFT JOIN raw_products p ON so.product_id = p.product_id;  -- Join with product details

--This view joins stage_order_lines, cleaned_customers, and raw_products to provide a comprehensive summary of orders, customer details, product info, and calculated totals.

--The total_amount is calculated by multiplying quantity by price.

--STEP 5: Query the Final Output
--Now, you can query the final report to see the transformed and cleaned data.


-- Query the final order summary report
SELECT * FROM order_summary ORDER BY order_date;
Explanation:

--This query pulls data from the order_summary view, which now contains cleaned, transformed order details ready for reporting.

---Build a Star Schema
--For this, we will create a star schema with a fact table for orders and dimension tables 
--for customers and products.
