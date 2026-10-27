# Emmanuel-Devo Store — E-commerce Order and Inventory Management — database design

My case study records customers, categories, products, orders, order_items, payments.

## Users

- Customers
- Store administrators
- Inventory staff
- Order-processing staff

## Main operations

- Register customers
- Maintain product categories and catalogue items
- Monitor and update stock
- Place orders and record order items
- Record payments
- Track order and delivery events
- Report sales

## Entities

| Entity | Information stored |
| --- | --- |
| customers | Customer registration and contact details for store orders. |
| categories | Named product categories used to organize the catalogue. |
| products | Catalogue products, each linked to a category and carrying a nonnegative stock quantity. |
| orders | Customer order header with placement time, status, and recorded total. |
| order_items | Normalized order-line records. Each row represents one product on one order, with quantity and purchase-time unit price; order and product details remain in their parent entities. |
| payments | Payment records associated with customer orders. |

## customers

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| registered_at | TIMESTAMPTZ |  | Yes |
- Unique key: (email).

## categories

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| category_id | BIGINT | PK | Yes |
| name | TEXT | Unique | Yes |
| description | TEXT |  | No |
- Unique key: (name).

## products

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| product_id | BIGINT | PK | Yes |
| category_id | BIGINT | FK | Yes |
| sku | TEXT | Unique | Yes |
| name | TEXT |  | Yes |
| unit_price | NUMERIC(18,2) |  | Yes |
| stock_on_hand | INTEGER |  | Yes |
- category_id → categories.category_id
- Unique key: (sku).

## orders

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| order_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| ordered_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
| total_amount | NUMERIC(18,2) |  | Yes |
- customer_id → customers.customer_id

## order_items

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| item_id | BIGINT | PK | Yes |
| order_id | BIGINT | FK | Yes |
| product_id | BIGINT | FK | Yes |
| quantity | INTEGER |  | Yes |
| unit_price | NUMERIC(18,2) |  | Yes |
- order_id → orders.order_id
- product_id → products.product_id
- Unique key: (order_id, product_id).

## payments

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| payment_id | BIGINT | PK | Yes |
| order_id | BIGINT | FK | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| paid_at | TIMESTAMPTZ |  | No |
| status | TEXT |  | Yes |
| payment_reference | TEXT | Unique | No |
- order_id → orders.order_id
- Unique key: (payment_reference).

## Relationships and business rules

- Each registered customer email identifies at most one customer.
- Each product category has a distinct name.
- Every product references an existing category.
- A product's stock_on_hand must never be below zero.
- Every order references an existing customer.
- Every order item references an existing order.
- Every order item references an existing product.
- Each order item quantity must be greater than zero.
- A product may appear at most once in an order; additional units are represented by quantity on that line.
- Every payment record references an existing order.

## Assumptions

- All records and test data are synthetic; no student names or IDs are included.
- Each product belongs to one category and has one stock_on_hand value.
- An order belongs to one customer; its order items store the unit-price snapshot used for that purchase.
- An order may have multiple payment records; payment_reference is unique when supplied.
- The compact relational model records payments but represents delivery tracking as MongoDB events rather than adding a relational delivery table.
- Prices and payment amounts use one assumed currency, and no currency conversion is in scope.
- MongoDB documents are a proposed complementary model, not a replacement for PostgreSQL transactional order and inventory data.

