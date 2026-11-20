erDiagram
    %% 1:N Relationships (One to Many)
    CUSTOMER ||--o{ CHECKOUT : "makes (1:N)"
    CUSTOMER ||--o{ CUSTOMER_PHONE : "has (1:N)"
    
    PUBLISHER ||--o{ BOOK : "publishes (1:N)"
    PUBLISHER ||--o{ MEDIA : "publishes (1:N)"
    PUBLISHER ||--o{ PUBLISHER_PHONE : "has (1:N)"
    
    %% Junction/Bridge Tables for M:N Relationships
    CHECKOUT ||--o{ PRODUCT_CHECKOUT : "contains (1:N)"
    BOOK ||--o{ PRODUCT_CHECKOUT : "ordered in (1:N)"
    
    WAREHOUSE ||--o{ WAREHOUSE_PRODUCT : "houses (1:N)"
    BOOK ||--o{ WAREHOUSE_PRODUCT : "stored in (1:N)"
    
    SOURCE ||--o{ SOURCE_PRODUCT : "supplies (1:N)"
    BOOK ||--o{ SOURCE_PRODUCT : "sourced via (1:N)"

    CUSTOMER {
        int id PK
        string c_name
        string c_email
    }
    CUSTOMER_PHONE {
        varchar cust_phone PK
        int c_id FK
    }
    CHECKOUT {
        int id PK
        int c_id FK
        string ch_type
        date ch_date
    }
    BOOK {
        varchar id PK
        int pub_id FK
        string title
        real price
    }
    MEDIA {
        varchar id PK
        int pub_id FK
        string title
        real price
    }
    PUBLISHER {
        int id PK
        string p_name
        string city
        string zip
    }
    PUBLISHER_PHONE {
        varchar pub_phone PK
        int pub_id FK
    }
    PRODUCT_CHECKOUT {
        int id PK
        varchar prod_id FK
        int ch_id FK
    }
    WAREHOUSE {
        int id PK
        string city
        string zip
    }
    WAREHOUSE_PRODUCT {
        int id PK
        int w_id FK
        varchar prod_id FK
    }
    SOURCE {
        int id PK
        string s_name
    }
    SOURCE_PRODUCT {
        int id PK
        int s_id FK
        varchar prod_id FK
    }