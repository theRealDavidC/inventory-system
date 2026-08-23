-- Query: Top 20 best selling products in the last 30 days
-- Usage: Run weekly to identify best performing products

EXPLAIN ANALYZE
SELECT
    p.name AS product_name,
    SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN product_variants pv ON pv.variant_id = oi.variant_id
JOIN products p ON p.product_id = pv.product_id
WHERE o.created_at >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 20;
