BEGIN;

CREATE TABLE orders (
 order_id SERIAL PRIMARY KEY,
 customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
 status VARCHAR(20) NOT NULL DEFAULT 'pending',
 total_amount NUMERIC(10, 2) NOT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP,
 deleted_at TIMESTAMP
 );
 
COMMIT;
