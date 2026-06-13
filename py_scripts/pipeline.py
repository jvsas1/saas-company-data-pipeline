from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()


def extract(raw_data_path):
    df_list={}
    raw_data_file=Path(raw_data_path)
    if raw_data_file.exists():
        print("Checking raw_data directory...")
        if any(raw_data_file.iterdir()): 
            for file in raw_data_file.iterdir():
                df_list[file.stem]=pd.read_csv(file)                        
        else:
            print("Directory has no files")
    else:
        print("Directory not available")
    return df_list

def load(df_list):

    DATABASE = os.getenv("DATABASE")
    PASSWORD = os.getenv("PASSWORD")
    engine=create_engine(f"postgresql+psycopg2://postgres:{PASSWORD}@localhost:5432/{DATABASE}")
    try:
        with engine.connect() as connection:
            print("Engine created and connected successfully!")
            for csv in df_list:
                df_list[csv].to_sql(name=csv,con=engine,if_exists='replace',index=False)
            print("Databases created")
    except Exception as e:
        print(f"Engine creation or connection failed: {e}")






