BEGIN;

CREATE TABLE customers_audit (
    audit_id     SERIAL PRIMARY KEY,
    customer_id  INTEGER NOT NULL,
    first_name   VARCHAR(100),
    last_name    VARCHAR(100),
    email        VARCHAR(150),
    phone_number VARCHAR(20),
    address      VARCHAR(100),
    changed_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    operation    VARCHAR(10) NOT NULL
);

COMMIT;
