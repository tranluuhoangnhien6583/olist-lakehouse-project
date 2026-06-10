

SELECT 
    order_id,
    customer_id,
    LOWER(TRIM(order_status)) AS order_status,
    -- Ép kiểu chuỗi văn bản thành kiểu Thời gian (Timestamp) thực thụ
    CAST(order_purchase_timestamp AS TIMESTAMP) AS purchase_timestamp,
    CAST(order_delivered_customer_date AS TIMESTAMP) AS delivered_timestamp
FROM "olist_lakehouse"."main"."raw_orders"
WHERE order_id IS NOT NULL