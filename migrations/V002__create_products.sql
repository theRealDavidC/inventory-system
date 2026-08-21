BEGIN;

CREATE TABLE products (
 product_id SERIAL PRIMARY KEY,
 category_id INTEGER NOT NULL REFERENCES categories(category_id),
 name VARCHAR(120) NOT NULL,
 description TEXT,
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 deleted_at TIMESTAMP
 );
 
 COMMIT;
