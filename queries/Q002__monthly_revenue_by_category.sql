-- Query: Total revenue per category for the current month
-- Usage: Run at any time to see revenue breakdown by category this month

EXPLAIN ANALYZE
SELECT
    c.name AS category,
    SUM(oi.unit_price * oi.quantity) AS revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN product_variants pv ON pv.variant_id = oi.variant_id
JOIN products p ON p.product_id = pv.product_id
JOIN categories c ON c.category_id = p.category_id
WHERE o.created_at >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY c.name
ORDER BY revenue DESC;
