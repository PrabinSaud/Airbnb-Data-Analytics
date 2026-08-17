# ============================================================
# AIRBNB-001: DATA LOADING
# Dataset: Airbnb NYC Listings
# ============================================================

import pandas as pd

# load dataset
df = pd.read_csv("data/raw/listings.csv")


# display first 5 rows
print(df.head())


# display number of rows and columns
print("Dataset shape:", df.shape)


# display column names
print("\nColumns:")
print(df.columns.tolist())


# display data types
print("\nData types:")
print(df.dtypes)


# display basic dataset information
print("\nDataset information:")
df.info()