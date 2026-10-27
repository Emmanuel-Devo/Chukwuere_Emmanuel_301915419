# Emmanuel-Devo Store — E-commerce Order and Inventory Management — ER diagram

```mermaid
erDiagram
    direction LR
    customers {
        bigint customer_id PK
        text full_name
        text email UK
        timestamptz registered_at
    }
    categories {
        bigint category_id PK
        text name UK
        text description "Optional"
    }
    products {
        bigint product_id PK
        bigint category_id FK
        text sku UK
        text name
        numeric unit_price
        integer stock_on_hand
    }
    orders {
        bigint order_id PK
        bigint customer_id FK
        timestamptz ordered_at
        text status
        numeric total_amount
    }
    order_items {
        bigint item_id PK
        bigint order_id FK
        bigint product_id FK
        integer quantity
        numeric unit_price
    }
    payments {
        bigint payment_id PK
        bigint order_id FK
        numeric amount
        timestamptz paid_at "Optional"
        text status
        text payment_reference UK "Optional"
    }
    categories ||--o{ products : "category_id"
    customers ||--o{ orders : "customer_id"
    orders ||--o{ order_items : "order_id"
    products ||--o{ order_items : "product_id"
    orders ||--o{ payments : "order_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Chukwuere_Emmanuel_301915419_ERDiagram.png)
