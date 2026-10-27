# Emmanuel-Devo Store — E-commerce Order and Inventory Management — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| order_id | order_items records (list) |
| --- | --- |
| 401 | [501] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| order_items.item_id | order_items.order_id | order_items.product_id | orders.order_id | orders.customer_id | orders.status | customers.customer_id | customers.full_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 501 | 401 | 301 | 401 | 201 | completed | 201 | Avery Morgan |

Key: item_id.

## 2NF: depend on the whole key

order_items: order_id is a proper part of candidate key (order_id, product_id), and determines orders details. order_items: product_id is a proper part of candidate key (order_id, product_id), and determines products details.

## orders_example

| orders.order_id | orders.customer_id | orders.status | customers.customer_id | customers.full_name |
| --- | --- | --- | --- | --- |
| 401 | 201 | completed | 201 | Avery Morgan |

## order_items_example

| order_items.item_id | order_items.order_id | order_items.product_id |
| --- | --- | --- |
| 501 | 401 | 301 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customers

| customer_id | full_name | email | registered_at |
| --- | --- | --- | --- |
| 201 | Avery Morgan | avery.morgan@example.test | 2026-01-15T10:30:00+00:00 |

## categories

| category_id | name | description |
| --- | --- | --- |
| 101 | Accessories | Everyday accessories |
| 102 | Home Goods | NULL |

## products

| product_id | category_id | sku | name | unit_price | stock_on_hand |
| --- | --- | --- | --- | --- | --- |
| 301 | 101 | SKU-A-301 | Canvas Tote | 18.5 | 24 |
| 302 | 102 | SKU-B-302 | Ceramic Mug | 12 | 40 |

## orders

| order_id | customer_id | ordered_at | status | total_amount |
| --- | --- | --- | --- | --- |
| 401 | 201 | 2026-02-01T14:00:00+00:00 | completed | 37 |
| 402 | 201 | 2026-02-03T09:15:00+00:00 | processing | 24 |

## order_items

| item_id | order_id | product_id | quantity | unit_price |
| --- | --- | --- | --- | --- |
| 501 | 401 | 301 | 2 | 18.5 |

## payments

| payment_id | order_id | amount | paid_at | status | payment_reference |
| --- | --- | --- | --- | --- | --- |
| 601 | 401 | 37 | 2026-02-01T14:05:00+00:00 | paid | PAY-2026-001 |

## Dependencies

- customers: (customer_id) → full_name, email, registered_at
- categories: (category_id) → name, description
- products: (product_id) → category_id, sku, name, unit_price, stock_on_hand
- orders: (order_id) → customer_id, ordered_at, status, total_amount
- order_items: (item_id) → order_id, product_id, quantity, unit_price
- payments: (payment_id) → order_id, amount, paid_at, status, payment_reference

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
