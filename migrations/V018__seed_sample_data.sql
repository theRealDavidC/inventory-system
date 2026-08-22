BEGIN;

-- Categories
INSERT INTO categories (name, description) VALUES
('Soap', 'Bar soaps and washing products'),
('Cooking Oil', 'Edible cooking oils'),
('Beverages', 'Drinks and juices');

-- Products
INSERT INTO products (category_id, name, description) VALUES
(1, 'Azam Soap', 'Popular bar soap sold in wholesale'),
(2, 'Azam Cooking Oil', 'Refined cooking oil'),
(3, 'Azam Juice', 'Fruit juice in various flavors');

-- Product Variants
INSERT INTO product_variants (product_id, size, color, sku) VALUES
(1, 'Large', 'White', 'SOAP-AZM-LRG-WHT'),
(2, '5L',    'Clear', 'OIL-AZM-5L-CLR'),
(3, '500ml', 'Orange', 'JUC-AZM-500-ORG');

-- Inventory
INSERT INTO inventory (variant_id, quantity) VALUES
(1, 500),
(2, 300),
(3, 1000);

-- Price History
INSERT INTO price_history (variant_id, price, effective_from) VALUES
(1, 2500.00, '2024-01-01'),
(2, 12000.00, '2024-01-01'),
(3, 1500.00, '2024-01-01');

-- Customers
INSERT INTO customers (first_name, last_name, email, phone_number, address) VALUES
('Juma', 'Mkwawa', 'juma.mkwawa@email.com', '0712345678', 'Mbeya Road, Mbeya'),
('Fatuma', 'Salim', 'fatuma.salim@email.com', '0723456789', 'Kariakoo Street, Dar es Salaam'),
('David', 'Mwangi', 'david.mwangi@email.com', '0734567890', 'Arusha Town, Arusha');

COMMIT;
