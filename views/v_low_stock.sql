CREATE VIEW v_low_stock AS
SELECT
    p.name    AS product_name,
    pv.sku,
    i.quantity
FROM products p
JOIN product_variants pv ON pv.product_id = p.product_id
JOIN inventory i ON i.variant_id = pv.variant_id
WHERE i.quantity < 10
ORDER BY i.quantity ASC;
