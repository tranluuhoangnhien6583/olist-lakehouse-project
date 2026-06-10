

SELECT 
    order_id,
    CAST(payment_sequential AS INTEGER) AS payment_sequential,
    -- Chuẩn hóa tên phương thức thanh toán (chữ thường, xóa khoảng trắng)
    LOWER(TRIM(payment_type)) AS payment_type,
    CAST(payment_installments AS INTEGER) AS payment_installments,
    -- Ép kiểu giá trị đơn hàng sang số thập phân
    CAST(payment_value AS DOUBLE) AS payment_value
FROM "olist_lakehouse"."main"."raw_order_payments"
WHERE order_id IS NOT NULL