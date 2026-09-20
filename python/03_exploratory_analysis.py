import pandas as pd


# load cleaned dataset
df = pd.read_csv("data/processed/listings_cleaned.csv")


# ============================================================
# BASIC ANALYSIS
# ============================================================

print("Total listings:", len(df))

print(
    "Unique hosts:",
    df["host_id"].nunique()
)


# ============================================================
# PRICE ANALYSIS
# ============================================================

print("\nAverage listing price:")

print(
    round(df["price"].mean(), 2)
)


print("\nAverage price by room type:")

room_price = (
    df.groupby("room_type")["price"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print(room_price)


print("\nAverage price by neighbourhood:")

neighbourhood_price = (
    df.groupby("neighbourhood")["price"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print(neighbourhood_price.head(10))


# ============================================================
# LISTING ANALYSIS
# ============================================================

print("\nListings by room type:")

room_counts = (
    df["room_type"]
    .value_counts()
)

print(room_counts)


print("\nListings by neighbourhood group:")

group_counts = (
    df["neighbourhood_group"]
    .value_counts()
)

print(group_counts)


# ============================================================
# REVIEW ANALYSIS
# ============================================================

print("\nAverage reviews by room type:")

reviews_by_room = (
    df.groupby("room_type")["number_of_reviews"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print(reviews_by_room)


print("\nTop 10 neighbourhoods by total reviews:")

top_review_neighbourhoods = (
    df.groupby("neighbourhood")["number_of_reviews"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

print(top_review_neighbourhoods)


# ============================================================
# AVAILABILITY ANALYSIS
# ============================================================

print("\nAverage availability by room type:")

availability_by_room = (
    df.groupby("room_type")["availability_365"]
    .mean()
    .round(2)
    .sort_values(ascending=False)
)

print(availability_by_room)


# ============================================================
# PRICE SEGMENTATION
# ============================================================

df["price_segment"] = pd.cut(
    df["price"],
    bins=[0, 100, 300, float("inf")],
    labels=["Budget", "Mid-range", "Premium"]
)


print("\nListings by price segment:")

print(
    df["price_segment"]
    .value_counts()
)


# ============================================================
# HIGH-VALUE LISTINGS
# ============================================================

print("\nTop 10 listings by number of reviews:")

top_reviewed = (
    df[
        [
            "id",
            "name",
            "neighbourhood",
            "room_type",
            "price",
            "number_of_reviews"
        ]
    ]
    .sort_values(
        "number_of_reviews",
        ascending=False
    )
    .head(10)
)

print(top_reviewed)


# ============================================================
# HOST ANALYSIS
# ============================================================

print("\nTop 10 hosts by number of listings:")

top_hosts = (
    df.groupby("host_id")
    .size()
    .sort_values(ascending=False)
    .head(10)
)

print(top_hosts)


# ============================================================
# BUSINESS COMPARISON
# ============================================================

print("\nAverage price: listings with reviews vs no reviews:")

df["review_status"] = df["number_of_reviews"].apply(
    lambda x: "Has Reviews"
    if x > 0
    else "No Reviews"
)

review_price = (
    df.groupby("review_status")["price"]
    .mean()
    .round(2)
)

print(review_price)


print("\nAverage availability: listings with reviews vs no reviews:")

review_availability = (
    df.groupby("review_status")["availability_365"]
    .mean()
    .round(2)
)

print(review_availability)