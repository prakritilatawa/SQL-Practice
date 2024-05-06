-- View the execution plan for a query
-- SQL Server uses a toolbar button to display query plans
-- PostgreSQL uses the EXPLAIN command to show plans

-- Rename company column in SQL Server to match changes made to PostgreSQL database
EXEC sp_rename 'sales.customers.company', 'company_name', 'COLUMN';


-- EXPLAIN (ANALYZE)  -- PostgreSQL only. Omit for SQL Server
SELECT 
    orders.customer_id,
    customers.company_name,
    COUNT(orders.order_id) AS number_of_orders,
    SUM(order_lines.quantity * products.price) AS customer_total_spend
FROM sales.order_lines
    JOIN inventory.products ON order_lines.sku = products.sku
    JOIN sales.orders ON order_lines.order_id = orders.order_id
    JOIN sales.customers ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id, customers.company_name;