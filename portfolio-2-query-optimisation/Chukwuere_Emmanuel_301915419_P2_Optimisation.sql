-- A separate performance table using the case's order_items.order_id type.
-- Only this field and a lab row ID are copied. Business constraints stay in Portfolio 1.
-- Generated values are for measuring a selective lookup, not complete case records.
CREATE SCHEMA query_lab;
CREATE TABLE query_lab."order_items" AS
SELECT "order_id", 0::bigint AS "lab_row_id" FROM portfolio."order_items" WITH NO DATA;
INSERT INTO query_lab."order_items" ("order_id", "lab_row_id")
SELECT (g % 1000)::bigint, g FROM generate_series(1, 25000) AS g;
ANALYZE query_lab."order_items";

-- Before: warm the lookup, then measure it three times.
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";

CREATE INDEX p2_filter_idx ON query_lab."order_items" USING btree ("order_id");

-- After: run the same lookup and repeat the measurements.
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
EXPLAIN (ANALYZE, BUFFERS)
SELECT "lab_row_id", "order_id"
FROM query_lab."order_items"
WHERE "order_id" = (42 % 1000)::bigint
ORDER BY "lab_row_id";
