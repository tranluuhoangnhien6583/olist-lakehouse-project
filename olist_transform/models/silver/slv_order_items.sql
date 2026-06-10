{{ config(materialized='table') }}

SELECT 
    order_id,
    order_item_id,
    product_id,
    seller_id,
    -- Ép kiểu giá tiền từ văn bản sang số thập phân
    CAST(price AS DOUBLE) AS price,
    CAST(freight_value AS DOUBLE) AS freight_value
FROM {{ source('olist_src', 'raw_order_items') }}
WHERE order_id IS NOT NULL