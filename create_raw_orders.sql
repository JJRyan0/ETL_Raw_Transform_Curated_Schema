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
