-- Emmanuel-Devo Store — E-commerce Order and Inventory Management: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."customers" (
  "customer_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "registered_at" timestamptz NOT NULL,
  CONSTRAINT "pk_customers" PRIMARY KEY ("customer_id"),
  CONSTRAINT "uq_customers_0" UNIQUE ("email")
);
CREATE TABLE portfolio."categories" (
  "category_id" bigint NOT NULL,
  "name" text NOT NULL,
  "description" text,
  CONSTRAINT "pk_categories" PRIMARY KEY ("category_id"),
  CONSTRAINT "uq_categories_0" UNIQUE ("name")
);
CREATE TABLE portfolio."products" (
  "product_id" bigint NOT NULL,
  "category_id" bigint NOT NULL,
  "sku" text NOT NULL,
  "name" text NOT NULL,
  "unit_price" numeric(18,2) NOT NULL,
  "stock_on_hand" bigint NOT NULL,
  CONSTRAINT "pk_products" PRIMARY KEY ("product_id"),
  CONSTRAINT "uq_products_0" UNIQUE ("sku")
);
CREATE TABLE portfolio."orders" (
  "order_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  "ordered_at" timestamptz NOT NULL,
  "status" text NOT NULL,
  "total_amount" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_orders" PRIMARY KEY ("order_id")
);
CREATE TABLE portfolio."order_items" (
  "item_id" bigint NOT NULL,
  "order_id" bigint NOT NULL,
  "product_id" bigint NOT NULL,
  "quantity" bigint NOT NULL,
  "unit_price" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_order_items" PRIMARY KEY ("item_id"),
  CONSTRAINT "uq_order_items_0" UNIQUE ("order_id", "product_id")
);
CREATE TABLE portfolio."payments" (
  "payment_id" bigint NOT NULL,
  "order_id" bigint NOT NULL,
  "amount" numeric(18,2) NOT NULL,
  "paid_at" timestamptz,
  "status" text NOT NULL,
  "payment_reference" text,
  CONSTRAINT "pk_payments" PRIMARY KEY ("payment_id"),
  CONSTRAINT "uq_payments_0" UNIQUE ("payment_reference")
);
ALTER TABLE portfolio."products" ADD CONSTRAINT "fk_products_0" FOREIGN KEY ("category_id") REFERENCES portfolio."categories" ("category_id");
ALTER TABLE portfolio."orders" ADD CONSTRAINT "fk_orders_0" FOREIGN KEY ("customer_id") REFERENCES portfolio."customers" ("customer_id");
ALTER TABLE portfolio."order_items" ADD CONSTRAINT "fk_order_items_0" FOREIGN KEY ("order_id") REFERENCES portfolio."orders" ("order_id");
ALTER TABLE portfolio."order_items" ADD CONSTRAINT "fk_order_items_1" FOREIGN KEY ("product_id") REFERENCES portfolio."products" ("product_id");
ALTER TABLE portfolio."payments" ADD CONSTRAINT "fk_payments_0" FOREIGN KEY ("order_id") REFERENCES portfolio."orders" ("order_id");
ALTER TABLE portfolio."products" ADD CONSTRAINT "product_stock_nonnegative" CHECK ("stock_on_hand" >= 0);
ALTER TABLE portfolio."order_items" ADD CONSTRAINT "order_item_quantity_positive" CHECK ("quantity" > 0);
COMMIT;
