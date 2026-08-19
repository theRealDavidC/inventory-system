Problem statement: 
What problem exists?
Whosale businesses are operating at large, fast-moving environment. Where hundreds of transaction is happening daily across multiple products variants, prices and customers. Despite of having such a massive scale, most whosalers still manage their entire operation manually recording orders, tracking stock levels and calculating revenue using pen and paper in exercise book.

The current approach isn't a good solution because Excercise books fill up, get lost or becomes impossible to search something fast. Stocks levels are unkown until a shelf is physically checked. Prices change there is no a reliable record of what a customer was charged last month. Incase of any argument about an order, there is no any audit trail. When product is low no body knows until the products are completely empty.

The result is slow service, overselling, pricing errors and decision made on guesswork rather than data.

With our system we replace exercise books completely. Our system tracks every product variant, every stock movement, every price change, and every order in a structured PostgreSQL database. The system prevents overselling through inventory locking, preserves pricing history so every order records exactly what was charged at the time of sale and gives the owner visibility into stock level, revenue by category and best selling products none of which are possible with pen and paper.

Every table on our inventory database:
1. categories:stores the broad groupings that products belong to. For example, Soap, Cooking Oil, Beverages. Every product must belong to a category so the business can report revenue and stock by product type.
2. products: stores the core product itself, the name and description, linked to a category. For example, Azam Soap is a product. It does not track stock or price directly because those belong to its variants.
3. product_variants: stores a specific combination of size and color for a product, each with its own unique SKU, stock level, and price. For example, Azam soap exists as Small/White and Large/White-two separate variants because they have different sizes, different prices, and are tracked separately in stock.
4. inventory: stores the current stock level for each variant. Every time a purchase is made the quantity goes down. Every time stock is restocked the quantity goes up. The system prevents the quantity from ever going below zero.
5. price_history: stores every price a variant has ever been sold at, and when each price was active. When a price changes, the old record is closed with an effective_to date and a new record is opened. This means the business always has a full record of pricing over time.
6. customers: stores the shops and buyers who purchase from the wholesaler. Every order must belong to a customer so the business knows who bought what and when.
7. orders: stores the purchase event itself. One order belongs to one customer and records the status of that purchase whether it is pending, confirmed, shipped, delivered, or cancelled.
8. order_items: stores the individual product lines inside an order. One order can contain many items. For example, one order might contain 32 bars of soap and 10 bottles of cooking oil that is two rows in order_items, each recording the variant, quantity, and the frozen unit price at the exact moment of purchase so future price changes never alter historical records.
9. settings: stores system-wide configuration values as key-value pairs. For example, a maintenance mode flag or a daily fine rate. This allows the system administrator to change how the system behaves without touching the code.
 
