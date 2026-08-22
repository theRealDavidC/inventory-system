BEGIN;

CREATE OR REPLACE FUNCTION audit_customer_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO customers_audit (customer_id, first_name, last_name, email, phone_number, address, operation)
        VALUES (NEW.customer_id, NEW.first_name, NEW.last_name, NEW.email, NEW.phone_number, NEW.address, 'INSERT');

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO customers_audit (customer_id, first_name, last_name, email, phone_number, address, operation)
        VALUES (OLD.customer_id, OLD.first_name, OLD.last_name, OLD.email, OLD.phone_number, OLD.address, 'UPDATE');

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO customers_audit (customer_id, first_name, last_name, email, phone_number, address, operation)
        VALUES (OLD.customer_id, OLD.first_name, OLD.last_name, OLD.email, OLD.phone_number, OLD.address, 'DELETE');

    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_customers_audit
AFTER INSERT OR UPDATE OR DELETE ON customers
FOR EACH ROW
EXECUTE FUNCTION audit_customer_changes();

COMMIT;
