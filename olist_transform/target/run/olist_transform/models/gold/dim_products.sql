
  
    
    

    create  table
      "olist_lakehouse"."main"."dim_products__dbt_tmp"
  
    as (
      

SELECT * FROM "olist_lakehouse"."main"."slv_products"
    );
  
  