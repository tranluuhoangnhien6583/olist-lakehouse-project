import os
import duckdb
import pandas as pd

def main():
    md_token = os.environ.get("MOTHERDUCK_TOKEN", "").strip()
    if not md_token:
        raise ValueError("Không tìm thấy MOTHERDUCK_TOKEN!")

    print("Đang kết nối tới MotherDuck...")
    con = duckdb.connect(f'md:olist_lakehouse?motherduck_token={md_token}')

    base_url = "https://huggingface.co/datasets/aviahYadler/Olist_Ecommerce_Dataset/resolve/main/"
    tables = {
        "raw_orders": "olist_orders_dataset.csv",
        "raw_order_items": "olist_order_items_dataset.csv",
        "raw_order_reviews": "olist_order_reviews_dataset.csv",
        "raw_customers": "olist_customers_dataset.csv",
        "raw_order_payments": "olist_order_payments_dataset.csv",
        "raw_geolocation": "olist_geolocation_dataset.csv",
        "raw_products": "olist_products_dataset.csv",
        "raw_sellers": "olist_sellers_dataset.csv",
        "raw_category_translation": "product_category_name_translation.csv"
    }

    for table_name, file_name in tables.items():
        print(f"Đang tải dữ liệu bảng: {table_name} ({file_name})...")
        file_url = base_url + file_name
 
        df = pd.read_csv(file_url)
        print(f"-> Tải thành công {len(df)} dòng. Đang lưu vào Lakehouse...")
        
        con.execute(f"CREATE OR REPLACE TABLE {table_name} AS SELECT * FROM df")

    print("Hoàn tất nạp toàn bộ 9 bảng dữ liệu Olist!")
    con.close()

if __name__ == "__main__":
    main()
