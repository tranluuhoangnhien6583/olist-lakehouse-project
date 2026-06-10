{{ config(materialized='table') }}

SELECT 
    customer_id,
    customer_unique_id,
    -- Chuẩn hóa tên thành phố (viết hoa chữ cái đầu hoặc viết thường toàn bộ)
    LOWER(TRIM(customer_city)) AS customer_city,
    -- Chuẩn hóa mã bang thành viết hoa (VD: sp -> SP)
    UPPER(TRIM(customer_state)) AS customer_state
FROM {{ source('olist_src', 'raw_customers') }}
-- Loại bỏ các dòng rác không có mã khách hàng
WHERE customer_id IS NOT NULL