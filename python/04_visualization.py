import pandas as pd
import matplotlib.pyplot as plt


# load cleaned dataset
df = pd.read_csv("data/processed/listings_cleaned.csv")


# ============================================================
# CREATE OUTPUT FOLDER
# ============================================================

import os

os.makedirs("outputs/figures", exist_ok=True)


# ============================================================
# 1. LISTINGS BY ROOM TYPE
# ============================================================

room_counts = (
    df["room_type"]
    .value_counts()
)

plt.figure(figsize=(8, 5))

room_counts.plot(
    kind="bar"
)

plt.title("Airbnb Listings by Room Type")
plt.xlabel("Room Type")
plt.ylabel("Number of Listings")
plt.xticks(rotation=0)
plt.tight_layout()

plt.savefig(
    "outputs/figures/listings_by_room_type.png"
)

plt.show()


# ============================================================
# 2. AVERAGE PRICE BY ROOM TYPE
# ============================================================

average_price = (
    df.groupby("room_type")["price"]
    .mean()
    .sort_values(ascending=False)
)

plt.figure(figsize=(8, 5))

average_price.plot(
    kind="bar"
)

plt.title("Average Price by Room Type")
plt.xlabel("Room Type")
plt.ylabel("Average Price")
plt.xticks(rotation=0)
plt.tight_layout()

plt.savefig(
    "outputs/figures/average_price_by_room_type.png"
)

plt.show()


# ============================================================
# 3. TOP 10 NEIGHBOURHOODS BY LISTING COUNT
# ============================================================

top_neighbourhoods = (
    df["neighbourhood"]
    .value_counts()
    .head(10)
    .sort_values()
)

plt.figure(figsize=(9, 6))

top_neighbourhoods.plot(
    kind="barh"
)

plt.title("Top 10 Neighbourhoods by Listing Count")
plt.xlabel("Number of Listings")
plt.ylabel("Neighbourhood")
plt.tight_layout()

plt.savefig(
    "outputs/figures/top_10_neighbourhoods.png"
)

plt.show()


# ============================================================
# 4. PRICE DISTRIBUTION
# ============================================================

plt.figure(figsize=(9, 5))

plt.hist(
    df["price"],
    bins=50
)

plt.title("Airbnb Listing Price Distribution")
plt.xlabel("Price")
plt.ylabel("Number of Listings")
plt.xlim(0, 1000)
plt.tight_layout()

plt.savefig(
    "outputs/figures/price_distribution.png"
)

plt.show()


# ============================================================
# 5. AVAILABILITY BY ROOM TYPE
# ============================================================

availability = (
    df.groupby("room_type")["availability_365"]
    .mean()
    .sort_values(ascending=False)
)

plt.figure(figsize=(8, 5))

availability.plot(
    kind="bar"
)

plt.title("Average Availability by Room Type")
plt.xlabel("Room Type")
plt.ylabel("Average Available Days")
plt.xticks(rotation=0)
plt.tight_layout()

plt.savefig(
    "outputs/figures/availability_by_room_type.png"
)

plt.show()


# ============================================================
# 6. PRICE VS REVIEWS
# ============================================================

plt.figure(figsize=(9, 6))

plt.scatter(
    df["price"],
    df["number_of_reviews"],
    alpha=0.3
)

plt.title("Price vs Number of Reviews")
plt.xlabel("Price")
plt.ylabel("Number of Reviews")
plt.xlim(0, 1000)
plt.tight_layout()

plt.savefig(
    "outputs/figures/price_vs_reviews.png"
)

plt.show()


print("All visualizations created successfully.")