-- Show related customers, orders, order_items, products records (up to 20).
SELECT t0."customer_id" AS "customers_customer_id",
       t0."full_name" AS "customers_full_name",
       t1."order_id" AS "orders_order_id",
       t1."ordered_at" AS "orders_ordered_at",
       t2."item_id" AS "order_items_item_id",
       t2."quantity" AS "order_items_quantity",
       t3."product_id" AS "products_product_id",
       t3."sku" AS "products_sku"
FROM portfolio."customers" t0
JOIN portfolio."orders" t1 ON t1."customer_id" = t0."customer_id"
JOIN portfolio."order_items" t2 ON t2."order_id" = t1."order_id"
JOIN portfolio."products" t3 ON t2."product_id" = t3."product_id"
ORDER BY t0."customer_id", t1."order_id", t2."item_id", t3."product_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."customer_id" AS "customers_customer_id",
       t0."full_name" AS "customers_full_name",
       t1."order_id" AS "orders_order_id",
       t1."ordered_at" AS "orders_ordered_at",
       t2."item_id" AS "order_items_item_id",
       t2."quantity" AS "order_items_quantity",
       t3."product_id" AS "products_product_id",
       t3."sku" AS "products_sku"
FROM portfolio."customers" t0
JOIN portfolio."orders" t1 ON t1."customer_id" = t0."customer_id"
JOIN portfolio."order_items" t2 ON t2."order_id" = t1."order_id"
JOIN portfolio."products" t3 ON t2."product_id" = t3."product_id"
ORDER BY t0."customer_id", t1."order_id", t2."item_id", t3."product_id"
LIMIT 20;

-- Find categories records where name matches "Accessories" (up to 20).
SELECT * FROM portfolio."categories"
WHERE "name" IS NOT DISTINCT FROM 'Accessories'
ORDER BY "category_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."categories"
WHERE "name" IS NOT DISTINCT FROM 'Accessories'
ORDER BY "category_id"
LIMIT 20;

-- Count orders records for each customer_id (up to 20 groups).
SELECT "customer_id", count(*) AS record_count
FROM portfolio."orders"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "customer_id", count(*) AS record_count
FROM portfolio."orders"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;

-- Find customers records where full_name matches "Avery Morgan" (up to 20).
SELECT * FROM portfolio."customers"
WHERE "full_name" IS NOT DISTINCT FROM 'Avery Morgan'
ORDER BY "customer_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."customers"
WHERE "full_name" IS NOT DISTINCT FROM 'Avery Morgan'
ORDER BY "customer_id"
LIMIT 20;
