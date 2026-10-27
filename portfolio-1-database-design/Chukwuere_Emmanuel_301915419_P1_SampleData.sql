-- Fictional sample records for Emmanuel-Devo Store — E-commerce Order and Inventory Management.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customers" ("customer_id", "full_name", "email", "registered_at") VALUES (201, 'Avery Morgan', 'avery.morgan@example.test', '2026-01-15T10:30:00Z');
INSERT INTO portfolio."categories" ("category_id", "name", "description") VALUES (101, 'Accessories', 'Everyday accessories');
INSERT INTO portfolio."categories" ("category_id", "name", "description") VALUES (102, 'Home Goods', NULL);
INSERT INTO portfolio."products" ("product_id", "category_id", "sku", "name", "unit_price", "stock_on_hand") VALUES (301, 101, 'SKU-A-301', 'Canvas Tote', 18.5, 24);
INSERT INTO portfolio."products" ("product_id", "category_id", "sku", "name", "unit_price", "stock_on_hand") VALUES (302, 102, 'SKU-B-302', 'Ceramic Mug', 12, 40);
INSERT INTO portfolio."orders" ("order_id", "customer_id", "ordered_at", "status", "total_amount") VALUES (401, 201, '2026-02-01T14:00:00Z', 'completed', 37);
INSERT INTO portfolio."orders" ("order_id", "customer_id", "ordered_at", "status", "total_amount") VALUES (402, 201, '2026-02-03T09:15:00Z', 'processing', 24);
INSERT INTO portfolio."order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price") VALUES (501, 401, 301, 2, 18.5);
INSERT INTO portfolio."payments" ("payment_id", "order_id", "amount", "paid_at", "status", "payment_reference") VALUES (601, 401, 37, '2026-02-01T14:05:00Z', 'paid', 'PAY-2026-001');
COMMIT;
