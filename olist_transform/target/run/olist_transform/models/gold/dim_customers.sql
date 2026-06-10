
  
    
    

    create  table
      "olist_lakehouse"."main"."dim_customers__dbt_tmp"
  
    as (
      

SELECT * FROM "olist_lakehouse"."main"."slv_customers"
    );
  
  