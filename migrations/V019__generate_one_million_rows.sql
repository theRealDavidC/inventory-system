BEGIN;

-- Insert 1000 additional customers
INSERT INTO customers (first_name, last_name, email, phone_number, address)
SELECT
    'Customer_' || i,
    'Lastname_' || i,
    'customer_' || i || '@email.com',
    '07' || LPAD(i::TEXT, 8, '0'),
    'Street ' || i || ', Mbeya'
FROM generate_series(1, 1000) AS i;

-- Insert 1 million orders spread over 3 years
INSERT INTO orders (customer_id, status, total_amount, created_at)
SELECT
    (random() * 999 + 1)::INTEGER,
    (ARRAY['pending','confirmed','shipped','delivered','cancelled'])[floor(random() * 5 + 1)],
    (random() * 500 + 10)::NUMERIC(10,2),
    ('2024-01-01'::DATE + (random() * 900)::INTEGER * INTERVAL '1 day')
FROM generate_series(1, 1000000) AS i;

COMMIT;
