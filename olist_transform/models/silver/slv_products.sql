{{ config(materialized='table') }}

SELECT 
    p.product_id,
    -- Dịch tên danh mục sang tiếng Anh để dễ làm báo cáo
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category_name,
    CAST(p.product_weight_g AS DOUBLE) AS product_weight_g
FROM {{ source('olist_src', 'raw_products') }} p
LEFT JOIN {{ source('olist_src', 'raw_category_translation') }} t
    ON p.product_category_name = t.product_category_name
WHERE p.product_id IS NOT NULL