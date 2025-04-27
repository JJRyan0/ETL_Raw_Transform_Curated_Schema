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
