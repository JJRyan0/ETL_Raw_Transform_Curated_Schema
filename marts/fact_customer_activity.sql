--This new fact table will focus on customer activity — tracking the number of orders placed by a customer over time, 
-- their average spending, and other engagement metrics.
CREATE TABLE fact_customer_activity AS
SELECT 
  so.customer_id,
  CONVERT(DATE, so.order_date) AS activity_date,
  COUNT(DISTINCT so.order_id) AS total_orders,
  SUM(so.quantity) AS total_items,
  SUM(so.quantity * so.price) AS total_spent,
  AVG(so.price) AS avg_item_price
FROM stage_order_lines so
GROUP BY so.customer_id, CONVERT(DATE, so.order_date);
