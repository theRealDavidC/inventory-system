-- Query: All products with stock below 10 units
-- Usage: Run every morning to identify products that need restocking

EXPLAIN ANALYZE
SELECT
    p.name AS product_name,
    pv.sku,
    i.quantity
FROM inventory i
JOIN product_variants pv ON pv.variant_id = i.variant_id
JOIN products p ON p.product_id = pv.product_id
WHERE i.quantity < 10
ORDER BY i.quantity ASC;
