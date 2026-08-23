# Performance Report

## Overview
This report documents query performance before and after indexes were added
to my inventory system database containing one million orders.

## Baseline Query Times (before indexes)
| Query | Execution Time | Scan Type |
|-------|---------------|-----------|
| Customer orders | 123ms | Seq Scan |
| Monthly revenue | N/A | Seq Scan |
| Low stock | N/A | Seq Scan |
| Best sellers | N/A | Seq Scan |

## Post Optimization Query Times (done after indexes)
| Query | Execution Time | Scan Type |
|-------|---------------|-----------|
| Customer orders | 9.6ms | Bitmap Index Scan |
| Monthly revenue | 0.677ms | Index Scan |
| Low stock | 0.430ms | Bitmap Index Scan |
| Best sellers | 0.370ms | Index Scan |

## Indexes Created
| Index Name | Table | Columns | Query It Serves |
|------------|-------|---------|-----------------|
| idx_orders_customer_date | orders | customer_id, created_at DESC | Customer orders |
| idx_orders_created_at | orders | created_at | Monthly revenue, Best sellers |
| index_inventory_quantity | inventory | quantity | Low stock |
| index_order_items_id | order_items | order_id | All order joins |
| index_order_items_variant_id | order_items | variant_id | Variant lookups |

## Oversold Product Solution
Overselling is prevented through pessimistic locking in the purchase procedure.
When a customer tries to purchase the inventory row for that variant is locked
immediately using SELECT ... FOR UPDATE. No other transaction can read or modify
that row until the purchase completes or rolls back. This gives us guarantee that two
customers cannot buy the last item at the same time.

## What I Learned so far by doing this:
- EXPLAIN ANALYZE shows exactly how PostgreSQL executes a query
- Seq Scan reads every row in the table regardless of filters
- Index Scan jumps directly to matching rows using the index
- The customer orders query went from 123ms to 9.6ms after indexing — 13x faster
- Partitioning splits a large table into smaller physical pieces by date range
- PostgreSQL automatically prunes partitions that cannot contain matching rows
- unit_price on order_items is a frozen snapshot so price changes never affect
  historical orders
- Pessimistic locking with FOR UPDATE prevents race conditions and overselling
