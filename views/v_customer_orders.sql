CREATE VIEW v_customer_orders AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.status,
    o.total_amount,
    o.created_at
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.deleted_at IS NULL;
