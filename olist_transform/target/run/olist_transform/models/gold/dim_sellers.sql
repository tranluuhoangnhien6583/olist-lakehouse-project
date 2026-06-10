
  
    
    

    create  table
      "olist_lakehouse"."main"."dim_sellers__dbt_tmp"
  
    as (
      

SELECT * FROM "olist_lakehouse"."main"."slv_sellers"
    );
  
  