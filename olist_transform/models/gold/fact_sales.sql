{{ config(materialized='table') }}

WITH order_items AS (
    SELECT * FROM {{ ref('slv_order_items') }}
),
orders AS (
    SELECT * FROM {{ ref('slv_orders') }}
),
payments AS (
    -- Gom tổng tiền thanh toán theo từng đơn hàng
    SELECT 
        order_id,
        SUM(payment_value) as total_payment_value,
        STRING_AGG(DISTINCT payment_type, ', ') as payment_types
    FROM {{ ref('slv_order_payments') }}
    GROUP BY 1
),
reviews AS (
    -- Lấy điểm đánh giá trung bình của đơn hàng
    SELECT 
        order_id,
        AVG(review_score) as avg_review_score
    FROM {{ ref('slv_order_reviews') }}
    GROUP BY 1
)

SELECT 
    -- 1. Khóa liên kết (Foreign Keys)
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,
    
    -- 2. Chiều Thời gian (Time Dimensions)
    o.purchase_timestamp,
    o.delivered_timestamp,
    
    -- 3. Thông tin trạng thái
    o.order_status,
    COALESCE(p.payment_types, 'unknown') AS payment_types,
    
    -- 4. Các chỉ số đo lường (Measures/Facts)
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS total_item_value,
    p.total_payment_value,
    r.avg_review_score

FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN payments p ON o.order_id = p.order_id
LEFT JOIN reviews r ON o.order_id = r.order_id
-- Chỉ đưa vào Fact những đơn hàng hợp lệ (đã giao hoặc đã xuất hóa đơn)
WHERE o.order_status NOT IN ('canceled', 'unavailable')