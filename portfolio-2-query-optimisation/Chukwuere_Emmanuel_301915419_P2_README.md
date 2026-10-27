# Emmanuel-Devo Store — E-commerce Order and Inventory Management — SQL queries

## 1. Show related customers, orders, order_items, products records (up to 20).

```sql
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
```

| customers_customer_id | customers_full_name | orders_order_id | orders_ordered_at | order_items_item_id | order_items_quantity | products_product_id | products_sku |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 201 | Avery Morgan | 401 | 2026-02-01T14:00:00+00:00 | 501 | 2 | 301 | SKU-A-301 |

## 2. Find categories records where name matches "Accessories" (up to 20).

```sql
SELECT * FROM portfolio."categories"
WHERE "name" IS NOT DISTINCT FROM 'Accessories'
ORDER BY "category_id"
LIMIT 20;
```

| category_id | name | description |
| --- | --- | --- |
| 101 | Accessories | Everyday accessories |

## 3. Count orders records for each customer_id (up to 20 groups).

```sql
SELECT "customer_id", count(*) AS record_count
FROM portfolio."orders"
GROUP BY "customer_id"
ORDER BY record_count DESC, "customer_id" NULLS LAST
LIMIT 20;
```

| customer_id | record_count |
| --- | --- |
| 201 | 2 |

## 4. Find customers records where full_name matches "Avery Morgan" (up to 20).

```sql
SELECT * FROM portfolio."customers"
WHERE "full_name" IS NOT DISTINCT FROM 'Avery Morgan'
ORDER BY "customer_id"
LIMIT 20;
```

| customer_id | full_name | email | registered_at |
| --- | --- | --- | --- |
| 201 | Avery Morgan | avery.morgan@example.test | 2026-01-15T10:30:00+00:00 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.204 | 2.859, 1.204, 1.159 | Sort → Seq Scan | 139 |
| After index | 0.229 | 0.209, 0.235, 0.229 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 30 |

The median execution time changed from 1.204 ms to 0.229 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.873..2.819 rows=25 loops=1)
  Seq Scan on order_items (actual time=0.02..1.826 rows=25 loops=1)
Planning Time: 0.531 ms
Execution Time: 2.859 ms
```

### Before index, run 2

```text
Sort (actual time=1.164..1.172 rows=25 loops=1)
  Seq Scan on order_items (actual time=0.015..1.128 rows=25 loops=1)
Planning Time: 0.332 ms
Execution Time: 1.204 ms
```

### Before index, run 3

```text
Sort (actual time=1.124..1.13 rows=25 loops=1)
  Seq Scan on order_items (actual time=0.015..1.089 rows=25 loops=1)
Planning Time: 0.345 ms
Execution Time: 1.159 ms
```

### After index, run 1

```text
Sort (actual time=0.15..0.156 rows=25 loops=1)
  Bitmap Heap Scan on order_items (actual time=0.031..0.112 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.012 rows=25 loops=1)
Planning Time: 0.53 ms
Execution Time: 0.209 ms
```

### After index, run 2

```text
Sort (actual time=0.18..0.186 rows=25 loops=1)
  Bitmap Heap Scan on order_items (actual time=0.033..0.112 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=25 loops=1)
Planning Time: 0.504 ms
Execution Time: 0.235 ms
```

### After index, run 3

```text
Sort (actual time=0.17..0.176 rows=25 loops=1)
  Bitmap Heap Scan on order_items (actual time=0.031..0.134 rows=25 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.013 rows=25 loops=1)
Planning Time: 0.495 ms
Execution Time: 0.229 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Chukwuere_Emmanuel_301915419_P2_Queries.sql, then Chukwuere_Emmanuel_301915419_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Chukwuere_Emmanuel_301915419_P2_QueryResults.png) · [Index comparison](screenshots/Chukwuere_Emmanuel_301915419_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

