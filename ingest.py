import os
import duckdb
import pandas as pd
from datasets import load_dataset

def main():
    md_token = os.environ.get("MOTHERDUCK_TOKEN", "").strip()
    hf_token = os.environ.get("HF_TOKEN", "").strip()

    if not md_token:
        raise ValueError("Không tìm thấy MOTHERDUCK_TOKEN!")

    print("Đang kết nối tới MotherDuck...")
    con = duckdb.connect(f'md:olist_lakehouse?motherduck_token={md_token}')

    print("Đang tải dữ liệu Olist E-Commerce từ Hugging Face...")
    dataset = load_dataset("aviahYadler/Olist_Ecommerce_Dataset", split="train", token=hf_token)
    
    df = dataset.to_pandas()
    print(f"Tải thành công {len(df)} dòng dữ liệu.")

    # Nạp dữ liệu vào MotherDuck (Tầng Bronze)
    print("Đang nạp dữ liệu thô vào bảng olist_raw...")
    con.execute("CREATE OR REPLACE TABLE olist_raw AS SELECT * FROM df")

    print("Hoàn tất nạp dữ liệu!")
    con.close()

if __name__ == "__main__":
    main()
