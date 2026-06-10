{{ config(materialized='table') }}

SELECT * FROM {{ ref('slv_sellers') }}