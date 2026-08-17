import pandas as pd
import os


# load raw dataset
df = pd.read_csv("data/raw/listings.csv")


# make a copy before cleaning
cleaned_df = df.copy()


# ------------------------------------------------------------
# 1. inspect data-quality issues
# ------------------------------------------------------------

print("\nRows affected by cleaning rules:")

print(
    "Duplicate IDs:",
    df["id"].duplicated().sum()
)

print(
    "Missing prices:",
    df["price"].isna().sum()
)

print(
    "Invalid or missing prices:",
    (df["price"].fillna(0) <= 0).sum()
)

print(
    "Missing host IDs:",
    df["host_id"].isna().sum()
)

print(
    "Invalid minimum nights:",
    (df["minimum_nights"] <= 0).sum()
)

print(
    "Invalid availability:",
    (~df["availability_365"].between(0, 365)).sum()
)

print(
    "Negative reviews:",
    (df["number_of_reviews"] < 0).sum()
)


# ------------------------------------------------------------
# 2. convert numeric columns to numeric data types
# ------------------------------------------------------------

numeric_columns = [
    "id",
    "host_id",
    "price",
    "minimum_nights",
    "number_of_reviews",
    "reviews_per_month",
    "calculated_host_listings_count",
    "availability_365"
]

for column in numeric_columns:
    cleaned_df[column] = pd.to_numeric(
        cleaned_df[column],
        errors="coerce"
    )


# ------------------------------------------------------------
# 3. remove duplicate listing IDs
# ------------------------------------------------------------

cleaned_df = cleaned_df.drop_duplicates(
    subset="id"
)


# ------------------------------------------------------------
# 4. remove listings without a valid price
# ------------------------------------------------------------

cleaned_df = cleaned_df.dropna(
    subset=["price"]
)

cleaned_df = cleaned_df[
    cleaned_df["price"] > 0
]


# ------------------------------------------------------------
# 5. remove invalid minimum-night values
# ------------------------------------------------------------

cleaned_df = cleaned_df[
    cleaned_df["minimum_nights"] > 0
]


# ------------------------------------------------------------
# 6. keep availability within valid range
# ------------------------------------------------------------

cleaned_df = cleaned_df[
    cleaned_df["availability_365"].between(0, 365)
]


# ------------------------------------------------------------
# 7. remove negative review counts
# ------------------------------------------------------------

cleaned_df = cleaned_df[
    cleaned_df["number_of_reviews"] >= 0
]


# ------------------------------------------------------------
# 8. fill review-related missing values
# ------------------------------------------------------------

cleaned_df["number_of_reviews"] = (
    cleaned_df["number_of_reviews"].fillna(0)
)

cleaned_df["reviews_per_month"] = (
    cleaned_df["reviews_per_month"].fillna(0)
)


# ------------------------------------------------------------
# 9. convert last_review to date
# ------------------------------------------------------------

cleaned_df["last_review"] = pd.to_datetime(
    cleaned_df["last_review"],
    errors="coerce"
)


# ------------------------------------------------------------
# 10. reset index
# ------------------------------------------------------------

cleaned_df = cleaned_df.reset_index(
    drop=True
)


# ------------------------------------------------------------
# 11. display cleaning results
# ------------------------------------------------------------

print("\nCleaning results:")

print(
    "Original rows:",
    len(df)
)

print(
    "Cleaned rows:",
    len(cleaned_df)
)

print(
    "Rows removed:",
    len(df) - len(cleaned_df)
)


print("\nMissing values after cleaning:")

print(
    cleaned_df.isnull().sum()
)


print("\nCleaned dataset:")

print(
    cleaned_df.head()
)


# ------------------------------------------------------------
# 12. create processed directory
# ------------------------------------------------------------

os.makedirs(
    "data/processed",
    exist_ok=True
)


# ------------------------------------------------------------
# 13. save processed dataset
# ------------------------------------------------------------

cleaned_df.to_csv(
    "data/processed/listings_cleaned.csv",
    index=False
)

print(
    "\nCleaned dataset saved successfully."
)