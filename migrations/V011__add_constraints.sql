BEGIN;

ALTER TABLE inventory
ADD CONSTRAINT chk_inventory_quantity CHECK (quantity >= 0);

ALTER TABLE order_items
ADD CONSTRAINT chk_order_items_unit_price CHECK (unit_price > 0);

ALTER TABLE order_items
ADD CONSTRAINT chk_order_items_quantity CHECK (quantity > 0);

ALTER TABLE orders
ADD CONSTRAINT chk_orders_status CHECK (status IN ('pending', 'confirmed', 'shipped', 'delivered', 'cancelled'));

ALTER TABLE price_history
ADD CONSTRAINT chk_price_history_effective_to CHECK (effective_to IS NULL OR effective_to > effective_from);

COMMIT;
