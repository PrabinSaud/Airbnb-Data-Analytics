Airbnb Data Analytics — New York City

A practical data analytics project using Airbnb New York City listing data. The project focuses on SQL-based data exploration, data quality validation, business analysis, and eventually visualization.

Project Overview

This project simulates the work of a Junior Data Analyst working with Airbnb listing data.

The goal is to transform raw Airbnb listing data into useful business insights such as:

- Listing distribution across NYC neighbourhoods
- Room-type availability
- Host activity
- Pricing patterns
- Minimum-stay requirements
- Listing availability
- Review activity
- Data quality issues

The project is being developed using a real Airbnb dataset rather than a theoretical or manually created dataset.

Business Objective

The main objective is to answer questions such as:

«Where are Airbnb listings concentrated in New York City, what types of accommodation are available, how active are hosts, and what data-quality issues should be considered before using the dataset for business decisions?»

The analysis will progress from basic data validation to deeper business analysis.

Dataset

Source: Inside Airbnb

Location: New York City, USA

Dataset: Airbnb Listings

The raw dataset contains approximately:

- 30,555 listings
- 19 columns

Main Fields

Column| Description
"id"| Unique Airbnb listing ID
"name"| Listing name
"host_id"| Unique host ID
"host_profile_id"| Host profile identifier
"host_name"| Host name
"neighbourhood_group"| NYC borough
"neighbourhood"| NYC neighbourhood
"latitude"| Listing latitude
"longitude"| Listing longitude
"room_type"| Type of accommodation
"price"| Listing price
"minimum_nights"| Minimum nights required
"number_of_reviews"| Total reviews
"last_review"| Date of most recent review
"reviews_per_month"| Average monthly reviews
"calculated_host_listings_count"| Number of listings associated with host
"availability_365"| Available days during a 365-day period
"number_of_reviews_ltm"| Reviews received in the last 12 months
"license"| Listing license information

Tech Stack

- MySQL — SQL analysis and data exploration
- Python — Data cleaning and further analysis
- Pandas — Data manipulation
- Power BI — Data visualization and dashboard development
- Git & GitHub — Version control and project documentation
- CSV — Raw dataset format

Project Workflow

Raw Airbnb Dataset
        ↓
Data Import
        ↓
Data Validation
        ↓
Data Quality Checks
        ↓
SQL Exploration
        ↓
Business Analysis
        ↓
Python Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights

Repository Structure

Airbnb-Data-Analytics/
│
├── data/
│   └── raw/
│       ├── listings.csv
│       └── README.md
│
├── sql/
│   └── 01_data_inspection.sql
│
├── documentation/
│
├── .gitignore
└── README.md

SQL Analysis

AIRBNB-001 — Data Inspection

The first analysis stage focuses on validating and understanding the dataset.

Questions covered:

1. Total number of listings
2. Unique number of listings
3. Unique number of hosts
4. Minimum and maximum listing price
5. Available room types
6. Listings by room type
7. Listings by NYC borough
8. Top 10 neighbourhoods by listing count
9. Duplicate listing IDs
10. NULL-value checks
11. Average listing price
12. Average minimum nights
13. Average availability
14. Hosts with the highest number of listings
15. Listings with zero reviews

SQL file:

sql/01_data_inspection.sql

Data Quality Checks

Data validation is performed before business analysis.

Current checks include:

- Record count validation
- Unique listing validation
- Duplicate listing ID detection
- NULL-value analysis
- Price validation
- Review-count validation
- Availability validation
- Host-level validation

This prevents incorrect conclusions caused by poor-quality or incomplete data.

Analysis Roadmap

The project will be developed through multiple analytical stages.

Phase 1 — Data Inspection

- Understand dataset structure
- Validate records
- Identify NULLs
- Detect duplicates
- Understand categorical fields

Status: Completed

Phase 2 — Data Quality Analysis

Planned analysis:

- Invalid prices
- Extreme minimum-night values
- Availability anomalies
- Review inconsistencies
- Missing information
- Potential outliers

Phase 3 — Business Analysis

Planned questions:

- Which NYC borough has the most listings?
- Which neighbourhoods have the highest listing density?
- Which room types dominate the market?
- Where are the highest-priced listings?
- Which hosts operate the largest number of listings?
- How does availability differ by room type?
- Which neighbourhoods have high listing volume but low review activity?

Phase 4 — Python Analysis

Python and Pandas will be used for:

- Data cleaning
- Exploratory Data Analysis
- Statistical analysis
- Outlier detection
- Additional transformations

Phase 5 — Power BI Dashboard

The final dashboard will provide interactive views of:

- Total listings
- Average price
- Room-type distribution
- Borough distribution
- Neighbourhood analysis
- Host activity
- Availability
- Review activity

Git Workflow

The project uses Git for version control.

Example workflow:

git status

git add .

git commit -m "Add Airbnb data inspection queries"

git push

Major analytical stages will be committed separately so the development history remains clear.

Data Privacy

The raw dataset is kept locally and excluded from Git tracking where appropriate.

The ".gitignore" file is used to prevent large raw data files from being unnecessarily committed to the repository.

Project Status

Component| Status
Repository setup| ✅ Completed
Local project structure| ✅ Completed
Dataset collection| ✅ Completed
MySQL database setup| ✅ Completed
CSV import| ✅ Completed
Data inspection| ✅ Completed
Data quality analysis| 🔄 In progress
Business analysis| ⏳ Planned
Python analysis| ⏳ Planned
Power BI dashboard| ⏳ Planned
Final insights| ⏳ Planned

Author

Prabin Saud

BCA Student | Aspiring Data Analyst

GitHub: "PrabinSaud" (https://github.com/PrabinSaud)
