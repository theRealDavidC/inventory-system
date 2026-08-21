BEGIN;

CREATE TABLE product_variants (
    variant_id  SERIAL PRIMARY KEY,
    product_id  INTEGER NOT NULL REFERENCES products(product_id),
    size        VARCHAR(20),
    color       VARCHAR(100),
    sku         VARCHAR(100) NOT NULL UNIQUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at  TIMESTAMP
);

COMMIT;
