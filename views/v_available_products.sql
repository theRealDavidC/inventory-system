CREATE VIEW v_available_products AS
SELECT
    p.product_id,
    p.name        AS product_name,
    pv.sku,
    pv.size,
    pv.color,
    i.quantity    AS stock_available
FROM products p
JOIN product_variants pv ON pv.product_id = p.product_id
JOIN inventory i ON i.variant_id = pv.variant_id
WHERE p.deleted_at IS NULL
AND pv.deleted_at IS NULL
AND i.quantity > 0;
