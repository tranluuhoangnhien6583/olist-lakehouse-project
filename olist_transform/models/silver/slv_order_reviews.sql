{{ config(materialized='table') }}

SELECT 
    review_id,
    order_id,
    -- Ép kiểu điểm số về dạng số nguyên (Integer)
    CAST(review_score AS INTEGER) AS review_score,
    -- Dọn dẹp khoảng trắng ở tiêu đề và nội dung
    TRIM(review_comment_title) AS review_title,
    TRIM(review_comment_message) AS review_message,
    -- Chuẩn hóa thời gian
    CAST(review_creation_date AS TIMESTAMP) AS review_creation_date,
    CAST(review_answer_timestamp AS TIMESTAMP) AS review_answer_timestamp
FROM {{ source('olist_src', 'raw_order_reviews') }}
WHERE review_id IS NOT NULL 
  AND order_id IS NOT NULL