{{ config(materialized='table') }}

SELECT 
    -- Đặc trưng Giao dịch (Transaction Features)
    f.order_id,
    f.total_item_value,
    f.freight_value,
    f.total_payment_value,
    f.avg_review_score,
    f.order_status,
    
    -- Đặc trưng Khách hàng (Customer Features)
    c.customer_city,
    c.customer_state,
    
    -- Đặc trưng Sản phẩm (Product Features)
    p.category_name,
    p.product_weight_g,
    
    -- Đặc trưng Thời gian (Time Features - Trích xuất để AI dễ học dự báo nhu cầu)
    EXTRACT(MONTH FROM f.purchase_timestamp) AS purchase_month,
    EXTRACT(DOW FROM f.purchase_timestamp) AS purchase_day_of_week
    
FROM {{ ref('fact_sales') }} f
LEFT JOIN {{ ref('dim_customers') }} c ON f.customer_id = c.customer_id
LEFT JOIN {{ ref('dim_products') }} p ON f.product_id = p.product_id