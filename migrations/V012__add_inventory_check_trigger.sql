BEGIN;

CREATE OR REPLACE FUNCTION check_inventory_quantity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.quantity < 0 THEN
        RAISE EXCEPTION 'Inventory quantity cannot be negative. Current value attempted: %', NEW.quantity;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_positive_inventory
BEFORE UPDATE ON inventory
FOR EACH ROW
EXECUTE FUNCTION check_inventory_quantity();

COMMIT;
