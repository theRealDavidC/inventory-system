BEGIN;

CREATE OR REPLACE PROCEDURE purchase_product(
    p_customer_id INTEGER,
    p_variant_id  INTEGER,
    p_quantity    INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock    INTEGER;
    v_price    NUMERIC(10,2);
    v_order_id INTEGER;
BEGIN

    -- Step 1: Lock inventory row to prevent overselling
    SELECT quantity INTO v_stock
    FROM inventory
    WHERE variant_id = p_variant_id
    FOR UPDATE;

    -- Step 2: Check sufficient stock
    IF v_stock < p_quantity THEN
        RAISE EXCEPTION 'Insufficient stock. Available: %, Requested: %', v_stock, p_quantity;
    END IF;

    -- Step 3: Get current price
    SELECT price INTO v_price
    FROM price_history
    WHERE variant_id = p_variant_id
    AND effective_to IS NULL
    LIMIT 1;

    -- Step 4: Create order and capture order_id
    INSERT INTO orders (customer_id, status, total_amount)
    VALUES (p_customer_id, 'confirmed', v_price * p_quantity)
    RETURNING order_id INTO v_order_id;

    -- Step 5: Create order item with frozen price
    INSERT INTO order_items (order_id, variant_id, quantity, unit_price)
    VALUES (v_order_id, p_variant_id, p_quantity, v_price);

    -- Step 6: Decrement inventory
    UPDATE inventory
    SET quantity = quantity - p_quantity,
        last_updated = CURRENT_TIMESTAMP
    WHERE variant_id = p_variant_id;

END;
$$;

COMMIT;
