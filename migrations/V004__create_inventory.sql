BEGIN;

CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    variant_id   INTEGER NOT NULL REFERENCES product_variants(variant_id),
    quantity     INTEGER NOT NULL,
    last_updated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMIT;
