from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv
from google.oauth2 import service_account
import pandas_gbq

load_dotenv()


def extract(raw_data_path: str) -> dict :
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

def load_local(df_list:dict) -> None:

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


def load_gbq(df_list:dict) -> None:
    # Load credentials from your service account JSON file
    key=os.getenv("gbq_key")
    credentials = service_account.Credentials.from_service_account_file(key)

    # Set your Google Cloud project ID
    project_id=os.getenv("project_id") 

    try:
        for csv in df_list:
            pandas_gbq.to_gbq(
                df_list[csv], 
                destination_table=f"raw_data.{csv}",
                project_id=project_id,
                credentials=credentials,
                if_exists="replace"
            )
    except Exception as e:
        print(f"Error: {e}")







