

SELECT 
    geolocation_zip_code_prefix AS zip_code_prefix,
    LOWER(TRIM(MAX(geolocation_city))) AS city,
    UPPER(TRIM(MAX(geolocation_state))) AS state,
    -- Tính trung bình tọa độ của các điểm bị trùng
    AVG(CAST(geolocation_lat AS DOUBLE)) AS latitude,
    AVG(CAST(geolocation_lng AS DOUBLE)) AS longitude
FROM "olist_lakehouse"."main"."raw_geolocation"
GROUP BY 1