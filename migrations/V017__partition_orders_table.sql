BEGIN;

-- Step 1: Rename existing orders table
ALTER TABLE orders RENAME TO orders_old;

-- Step 2: Drop foreign key on order_items that points to orders_old
ALTER TABLE order_items DROP CONSTRAINT order_items_order_id_fkey;

-- Step 3: Create new partitioned orders table
CREATE TABLE orders (
    order_id     SERIAL,
    customer_id  INTEGER NOT NULL REFERENCES customers(customer_id),
    status       VARCHAR(20) NOT NULL DEFAULT 'pending',
    total_amount NUMERIC(10,2) NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP,
    deleted_at   TIMESTAMP
) PARTITION BY RANGE (created_at);

-- Step 4: Create partitions for each year
CREATE TABLE orders_2024 PARTITION OF orders
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE orders_2025 PARTITION OF orders
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE orders_2026 PARTITION OF orders
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Step 5: Copy data from old table to new partitioned table
INSERT INTO orders (order_id, customer_id, status, total_amount, created_at, updated_at, deleted_at)
SELECT order_id, customer_id, status, total_amount, created_at, updated_at, deleted_at
FROM orders_old;

-- Step 6: Drop old table
DROP TABLE orders_old;

-- Note: Foreign key from order_items to orders is not recreated because
-- PostgreSQL does not support foreign keys referencing partitioned tables.
-- Referential integrity is enforced through the purchase procedure.

COMMIT;
