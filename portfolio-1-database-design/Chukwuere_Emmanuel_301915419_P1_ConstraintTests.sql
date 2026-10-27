-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. customers pk. Expected: pk_customers, SQLSTATE 23505.
INSERT INTO portfolio."customers" ("customer_id", "full_name", "email", "registered_at")
VALUES (201, 'Jordan Lee', 'jordan.lee@example.test', '2026-03-01T08:00:00Z');

-- 2. customers unique. Expected: uq_customers_0, SQLSTATE 23505.
INSERT INTO portfolio."customers" ("customer_id", "full_name", "email", "registered_at")
VALUES (1001, 'Jordan Lee', 'avery.morgan@example.test', '2026-03-01T08:00:00Z');

-- 3. customers not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."customers" ("customer_id", "full_name", "email", "registered_at")
VALUES (1002, NULL, 'casey.park@example.test', '2026-03-01T08:00:00Z');

-- 4. categories pk. Expected: pk_categories, SQLSTATE 23505.
INSERT INTO portfolio."categories" ("category_id", "name", "description")
VALUES (101, 'Office Supplies', 'Synthetic test category');

-- 5. categories unique. Expected: uq_categories_0, SQLSTATE 23505.
INSERT INTO portfolio."categories" ("category_id", "name", "description")
VALUES (1003, 'Accessories', 'Synthetic test category');

-- 6. products pk. Expected: pk_products, SQLSTATE 23505.
INSERT INTO portfolio."products" ("product_id", "category_id", "sku", "name", "unit_price", "stock_on_hand")
VALUES (301, 102, 'SKU-PK-1004', 'Test Product', 9.5, 5);

-- 7. products unique. Expected: uq_products_0, SQLSTATE 23505.
INSERT INTO portfolio."products" ("product_id", "category_id", "sku", "name", "unit_price", "stock_on_hand")
VALUES (1005, 101, 'SKU-A-301', 'Test Product', 9.5, 5);

-- 8. products fk. Expected: fk_products_0, SQLSTATE 23503.
INSERT INTO portfolio."products" ("product_id", "category_id", "sku", "name", "unit_price", "stock_on_hand")
VALUES (1006, 9999, 'SKU-FK-1006', 'Test Product', 9.5, 5);

-- 9. products check. Expected: product_stock_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."products" ("product_id", "category_id", "sku", "name", "unit_price", "stock_on_hand")
VALUES (1007, 101, 'SKU-CHECK-1007', 'Test Product', 9.5, -1);

-- 10. orders pk. Expected: pk_orders, SQLSTATE 23505.
INSERT INTO portfolio."orders" ("order_id", "customer_id", "ordered_at", "status", "total_amount")
VALUES (401, 201, '2026-03-02T10:00:00Z', 'processing', 10);

-- 11. orders fk. Expected: fk_orders_0, SQLSTATE 23503.
INSERT INTO portfolio."orders" ("order_id", "customer_id", "ordered_at", "status", "total_amount")
VALUES (1008, 9998, '2026-03-02T10:00:00Z', 'processing', 10);

-- 12. order items pk. Expected: pk_order_items, SQLSTATE 23505.
INSERT INTO portfolio."order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (501, 402, 302, 1, 12);

-- 13. order items unique. Expected: uq_order_items_0, SQLSTATE 23505.
INSERT INTO portfolio."order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (1009, 401, 301, 1, 18.5);

-- 14. order items order fk. Expected: fk_order_items_0, SQLSTATE 23503.
INSERT INTO portfolio."order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (1010, 9997, 302, 1, 12);

-- 15. order items product fk. Expected: fk_order_items_1, SQLSTATE 23503.
INSERT INTO portfolio."order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (1011, 402, 9996, 1, 12);

-- 16. order items check. Expected: order_item_quantity_positive, SQLSTATE 23514.
INSERT INTO portfolio."order_items" ("item_id", "order_id", "product_id", "quantity", "unit_price")
VALUES (1012, 402, 302, 0, 12);

-- 17. payments pk. Expected: pk_payments, SQLSTATE 23505.
INSERT INTO portfolio."payments" ("payment_id", "order_id", "amount", "paid_at", "status", "payment_reference")
VALUES (601, 402, 24, '2026-03-02T10:05:00Z', 'paid', 'PAY-TEST-1013');

-- 18. payments unique. Expected: uq_payments_0, SQLSTATE 23505.
INSERT INTO portfolio."payments" ("payment_id", "order_id", "amount", "paid_at", "status", "payment_reference")
VALUES (1014, 402, 24, '2026-03-02T10:05:00Z', 'paid', 'PAY-2026-001');

-- 19. payments fk. Expected: fk_payments_0, SQLSTATE 23503.
INSERT INTO portfolio."payments" ("payment_id", "order_id", "amount", "paid_at", "status", "payment_reference")
VALUES (1015, 9995, 24, '2026-03-02T10:05:00Z', 'paid', 'PAY-FK-1015');
