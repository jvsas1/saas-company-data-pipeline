from pipeline import extract
from pipeline import load_local
from pipeline import load_gbq

df_list = extract("raw_data/")
load_local(df_list)
load_gbq(df_list)
