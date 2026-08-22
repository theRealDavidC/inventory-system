BEGIN;

CREATE OR REPLACE FUNCTION prevent_order_items_modification()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'Order items cannot be modified or deleted. They are permanent transaction records.';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_order_items_immutable
BEFORE UPDATE OR DELETE ON order_items
FOR EACH ROW
EXECUTE FUNCTION prevent_order_items_modification();

COMMIT;
