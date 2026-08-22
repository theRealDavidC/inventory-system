BEGIN;

CREATE INDEX index_order ON orders(customer_id, created_at DESC);
CREATE INDEX index_order_created_at ON orders(created_at);
CREATE INDEX index_inventory_quantity ON inventory(quantity);
CREATE INDEX index_order_items_id ON order_items(order_id);
CREATE INDEX index_order_items_variant_id ON order_items(variant_id);

COMMIT;
