
  
    
    

    create  table
      "olist_lakehouse"."main"."slv_sellers__dbt_tmp"
  
    as (
      

SELECT 
    seller_id,
    seller_zip_code_prefix,
    LOWER(TRIM(seller_city)) AS seller_city,
    UPPER(TRIM(seller_state)) AS seller_state
FROM "olist_lakehouse"."main"."raw_sellers"
WHERE seller_id IS NOT NULL
    );
  
  