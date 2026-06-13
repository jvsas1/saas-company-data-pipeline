from pipeline import extract
from pipeline import load

df_list = extract("raw_data/")
load(df_list)