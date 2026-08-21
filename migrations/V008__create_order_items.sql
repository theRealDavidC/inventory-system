BEGIN;

CREATE TABLE order_items (
 order_item_id SERIAL PRIMARY KEY,
 order_id INTEGER NOT NULL REFERENCES orders(order_id),
 variant_id INTEGER NOT NULL REFERENCES product_variants(variant_id),
 quantity INTEGER NOT NULL,
 unit_price NUMERIC(10, 2) NOT NULL,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
 );
 
COMMIT;
