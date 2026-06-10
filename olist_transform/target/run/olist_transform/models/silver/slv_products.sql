
  
    
    

    create  table
      "olist_lakehouse"."main"."slv_products__dbt_tmp"
  
    as (
      

SELECT 
    p.product_id,
    -- Dịch tên danh mục sang tiếng Anh để dễ làm báo cáo
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category_name,
    CAST(p.product_weight_g AS DOUBLE) AS product_weight_g
FROM "olist_lakehouse"."main"."raw_products" p
LEFT JOIN "olist_lakehouse"."main"."raw_category_translation" t
    ON p.product_category_name = t.product_category_name
WHERE p.product_id IS NOT NULL
    );
  
  