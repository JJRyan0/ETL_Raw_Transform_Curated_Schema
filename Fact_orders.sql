-- Fact table for orders report
CREATE TABLE fact_orders AS 
SELECT 
  so.order_id,
  so.customer_id,
  so.product_id,
  so.order_date,
  so.quantity,
  so.price,
  (so.quantity * so.price) AS total_amount
FROM stage_order_lines so;

--dim_customers and dim_products store unique customer and product data, respectively.

--fact_orders stores the actual transactional data, where each row represents an order 
--line with references to the dimension tables (using customer_id and product_id).
