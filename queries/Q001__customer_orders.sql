-- Query: All orders for a specific customer sorted by date
-- Usage: Replace 5 with the actual customer_id

EXPLAIN ANALYZE
SELECT * FROM orders
WHERE customer_id = 5
ORDER BY created_at DESC;
