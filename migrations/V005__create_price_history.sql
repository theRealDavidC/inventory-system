BEGIN;

CREATE TABLE price_history (
    price_id       SERIAL PRIMARY KEY,
    variant_id     INTEGER NOT NULL REFERENCES product_variants(variant_id),
    price          NUMERIC(10,2) NOT NULL,
    effective_from TIMESTAMP NOT NULL,
    effective_to   TIMESTAMP
);

COMMIT;
