Airbnb Data Analytics — New York City

A real-world data analytics project using Airbnb New York City listing data to understand pricing, hosts, neighbourhoods, room types, availability, reviews, and listing performance.

The project follows a practical Junior Data Analyst workflow:

Raw Data
   ↓
Data Validation
   ↓
MySQL Data Preparation
   ↓
Exploratory Data Analysis
   ↓
Business Analysis
   ↓
Python Analysis
   ↓
Power BI Dashboard
   ↓
Business Insights
   ↓
Final Report

---

1. Project Overview

Airbnb operates a large marketplace where hosts list properties and guests search for short-term accommodation.

This project analyzes Airbnb listing data from New York City to answer practical business questions such as:

- Which neighbourhoods have the most Airbnb listings?
- Which room types are most common?
- How does pricing vary across neighbourhoods?
- Which hosts manage the largest number of listings?
- Which areas have high availability?
- How many listings have never received reviews?
- Are there unusual or potentially problematic prices?
- Which neighbourhoods appear attractive from a host/business perspective?
- What factors are associated with listing performance?

The goal is not simply to create SQL queries.

The goal is to simulate the work performed by a junior data analyst working with a real business dataset.

---

2. Project Objectives

The project will focus on five major objectives.

Objective 1 — Understand the Dataset

Inspect the structure, size, columns, data types, missing values, duplicates, and unusual values.

Objective 2 — Analyze Airbnb Listings

Analyze:

- Listing distribution
- Room types
- Prices
- Minimum nights
- Availability
- Reviews
- Hosts
- Neighbourhoods

Objective 3 — Find Business Patterns

Identify patterns such as:

- High-demand areas
- High-price areas
- Highly concentrated hosts
- Room-type differences
- Availability patterns
- Review activity

Objective 4 — Build an Analytical Dashboard

Create an interactive Power BI dashboard that allows users to explore Airbnb NYC data.

Objective 5 — Produce Business Recommendations

Convert the analysis into clear findings that could help:

- Hosts
- Property managers
- Airbnb marketplace teams
- Investors
- Analysts

---

3. Dataset

Source:

Inside Airbnb

Dataset:

New York City Airbnb Listings

The project currently uses the detailed listings dataset.

Main table:

listings

Current dataset size:

30,555 listings
19 columns

---

4. Dataset Columns

The current dataset contains:

Column| Description
"id"| Unique Airbnb listing ID
"name"| Listing name
"host_id"| Host identifier
"host_profile_id"| Host profile identifier
"host_name"| Host name
"neighbourhood_group"| NYC borough
"neighbourhood"| Specific neighbourhood
"latitude"| Listing latitude
"longitude"| Listing longitude
"room_type"| Type of accommodation
"price"| Listing price
"minimum_nights"| Minimum nights required
"number_of_reviews"| Total reviews
"last_review"| Date of most recent review
"reviews_per_month"| Average monthly reviews
"calculated_host_listings_count"| Number of listings controlled by host
"availability_365"| Available days during the year
"number_of_reviews_ltm"| Reviews received in the last 12 months
"license"| Listing license information

---

5. Technology Stack

Database

MySQL

Used for:

- Data storage
- SQL querying
- Data validation
- Aggregation
- Data quality analysis
- Business analysis

Python

Used for:

- Data exploration
- Statistical analysis
- Data cleaning
- Visualization
- Advanced analysis

Main libraries:

Pandas
NumPy
Matplotlib
Seaborn

Power BI

Used for:

- Interactive dashboards
- KPI cards
- Geographic analysis
- Price analysis
- Neighbourhood analysis
- Host analysis
- Business reporting

Git & GitHub

Used for:

- Version control
- Project documentation
- SQL versioning
- Python code versioning
- Dashboard documentation
- Portfolio presentation

---

6. Project Workflow

Phase 1 — Project Setup

Status: Completed

Tasks:

- Create project repository
- Create local project structure
- Configure Git
- Connect local repository to GitHub
- Create ".gitignore"
- Create project README
- Create raw-data directory

---

Phase 2 — Data Acquisition

Status: Completed

Tasks:

- Download Airbnb NYC dataset
- Store the raw CSV locally
- Verify the dataset source
- Verify the geographic coverage
- Verify row count
- Verify column structure

Raw data location:

data/raw/listings.csv

The raw CSV is excluded from Git using ".gitignore".

---

7. Phase 3 — MySQL Data Import

Status: Completed

The Airbnb CSV was imported into MySQL.

Database:

airbnb

Table:

listings

The final import was validated using:

SELECT COUNT(*)
FROM listings;

Expected dataset size:

30,555 listings

---

8. Phase 4 — Data Inspection

Status: Completed

SQL file:

sql/01_data_inspection.sql

The first analysis ticket is:

AIRBNB-001
Data Inspection

Questions covered:

1. Total number of listings
2. Unique listings
3. Unique hosts
4. Minimum and maximum price
5. Available room types
6. Listings by room type
7. Listings by neighbourhood group
8. Top 10 neighbourhoods by listing count
9. Duplicate listing IDs
10. NULL-value analysis
11. Average listing price
12. Average minimum nights
13. Average availability
14. Top hosts by listing count
15. Listings with zero reviews

This phase establishes whether the dataset is suitable for deeper analysis.

---

9. Phase 5 — Data Quality Investigation

Status: Upcoming

The next stage will investigate whether the data contains values that could distort business analysis.

Areas of investigation:

Missing Data

Check:

NULL values
Missing reviews
Missing prices
Missing neighbourhoods
Missing host information

Duplicate Data

Check:

Duplicate listing IDs
Duplicate host records
Potential duplicate listings

Invalid Values

Investigate:

Price <= 0
Minimum nights <= 0
Availability outside 0–365
Invalid coordinates
Unexpected room types

Outliers

Investigate unusually high:

Price
Minimum nights
Availability
Review counts
Host listing counts

The objective is to distinguish real extreme values from data-quality problems.

---

10. Phase 6 — Exploratory Data Analysis

Status: Upcoming

We will investigate the dataset from a business perspective.

Listing Distribution

Questions:

- Which borough has the most listings?
- Which neighbourhood has the most listings?
- How concentrated are listings geographically?

Room Type

Questions:

- Which room type is most common?
- How does price differ by room type?
- Which room type has the highest availability?

Pricing

Questions:

- What is the average price?
- What is the median price?
- Which neighbourhoods are most expensive?
- Which room types are most expensive?
- How strongly does price vary across NYC?

Host Analysis

Questions:

- Which hosts have the most listings?
- What percentage of listings are controlled by major hosts?
- Are professional hosts concentrated in specific areas?

Reviews

Questions:

- Which listings receive the most reviews?
- Which neighbourhoods have the highest review activity?
- How many listings have zero reviews?
- Does review activity differ by room type?

Availability

Questions:

- Which neighbourhoods have the highest availability?
- Are highly available listings cheaper or more expensive?
- Are entire homes more or less available than private rooms?

---

11. Phase 7 — Advanced SQL Analysis

Status: Upcoming

After basic analysis, we will use more advanced SQL.

Topics include:

GROUP BY
HAVING
CASE
Subqueries
CTEs
Window Functions
RANK()
DENSE_RANK()
ROW_NUMBER()
LAG()
LEAD()
Aggregations
Conditional Aggregation
Date Functions

Example business questions:

- Rank neighbourhoods by average price.
- Find the top 3 hosts in every borough.
- Compare each neighbourhood's price with the borough average.
- Find listings with unusually high prices.
- Calculate price rankings by room type.
- Compare recent review activity with historical reviews.
- Identify hosts with a high concentration of listings.

---

12. Phase 8 — Python Analysis

Status: Upcoming

After SQL analysis, the dataset will be analyzed using Python.

Main workflow:

MySQL
  ↓
SQL extraction
  ↓
Pandas
  ↓
Data cleaning
  ↓
Exploratory analysis
  ↓
Visualization

Python will be used for analysis that is easier to perform programmatically.

Planned analysis:

- Distribution analysis
- Correlation analysis
- Outlier detection
- Price distributions
- Neighbourhood comparisons
- Review patterns
- Availability patterns
- Host concentration
- Statistical summaries

Example:

import pandas as pd

df = pd.read_csv("listings.csv")

df.info()
df.describe()
df.isnull().sum()

---

13. Phase 9 — Power BI Dashboard

Status: Upcoming

The cleaned analytical dataset will be used to create an interactive Power BI dashboard.

Dashboard Page 1 — Executive Overview

KPIs:

Total Listings
Total Hosts
Average Price
Median Price
Average Reviews
Average Availability

Visuals:

- Listings by borough
- Listings by room type
- Price distribution
- Top neighbourhoods

---

Dashboard Page 2 — Pricing Analysis

Visuals:

- Average price by neighbourhood
- Average price by room type
- Price distribution
- Borough price comparison
- Top expensive neighbourhoods

Filters:

Borough
Neighbourhood
Room Type
Price Range

---

Dashboard Page 3 — Host Analysis

Visuals:

- Top hosts
- Listings per host
- Host concentration
- Listings by borough
- Professional vs smaller hosts

---

Dashboard Page 4 — Reviews & Availability

Visuals:

- Review distribution
- Listings with zero reviews
- Reviews per month
- Availability by room type
- Availability by neighbourhood

---

14. Phase 10 — Business Insights

Status: Upcoming

The final analysis will convert SQL, Python, and Power BI results into business findings.

Example format:

Finding
    ↓
Evidence
    ↓
Business meaning
    ↓
Recommendation

For example:

Finding:
A small group of hosts controls a large share of listings.

Evidence:
Host-level listing concentration analysis.

Business meaning:
The marketplace may have a significant professional-host segment.

Recommendation:
Analyze professional-host behaviour separately from individual hosts.

The final recommendations will be based on the actual dataset rather than assumptions.

---

15. Phase 11 — Final Data Analyst Report

Status: Upcoming

The final report will contain:

Executive Summary

Key business findings.

Data Overview

Dataset size, scope, and columns.

Data Quality

Missing values, duplicates, outliers, and validation results.

Market Analysis

Neighbourhoods, prices, room types, and availability.

Host Analysis

Host concentration and listing distribution.

Review Analysis

Review activity and listing engagement.

Dashboard

Power BI dashboard screenshots and explanations.

Recommendations

Actionable findings supported by data.

---

16. GitHub Project Structure

The final repository is planned to follow this structure:

Airbnb-Data-Analytics/
│
├── data/
│   ├── raw/
│   │   ├── listings.csv
│   │   └── README.md
│   │
│   └── processed/
│
├── sql/
│   ├── 01_data_inspection.sql
│   ├── 02_data_quality.sql
│   ├── 03_exploratory_analysis.sql
│   ├── 04_business_analysis.sql
│   └── 05_advanced_analysis.sql
│
├── python/
│   ├── 01_data_loading.py
│   ├── 02_data_cleaning.py
│   ├── 03_exploratory_analysis.py
│   └── 04_visualization.py
│
├── powerbi/
│   ├── Airbnb_NYC_Dashboard.pbix
│   └── README.md
│
├── documentation/
│   ├── data_dictionary.md
│   ├── data_quality_report.md
│   ├── business_questions.md
│   └── final_report.md
│
├── outputs/
│   ├── figures/
│   └── reports/
│
├── .gitignore
└── README.md

The repository will grow phase by phase. We do not need to create every file now.

---

17. Git Commit Strategy

Each meaningful stage will be committed separately.

Examples:

git add sql/01_data_inspection.sql
git commit -m "Add Airbnb data inspection queries"
git push

Future commits may look like:

Add Airbnb data quality analysis
Add exploratory pricing analysis
Add host analysis queries
Add advanced SQL analysis
Add Python data cleaning
Add Python exploratory analysis
Add Power BI dashboard
Add final business insights
Update project documentation

This creates a clear development history.

---

18. Business Questions

The project will eventually answer questions across several areas.

Marketplace

- Where are Airbnb listings concentrated?
- Which areas have the highest supply?

Pricing

- Which areas are most expensive?
- Which room types command higher prices?
- How widely do prices vary?

Hosts

- Which hosts control the most listings?
- How concentrated is Airbnb supply among large hosts?

Customer Engagement

- Which listings receive the most reviews?
- Which areas have strong review activity?
- How many listings have no reviews?

Availability

- Which listings are available most of the year?
- Does availability vary by room type?
- Does availability vary by neighbourhood?

Data Quality

- Are there duplicate listings?
- Which fields contain missing values?
- Are there suspicious prices or minimum-night requirements?

---

19. Project Learning Goals

This project is designed to develop practical skills in:

SQL
MySQL
Data Cleaning
Data Quality
Exploratory Data Analysis
Python
Pandas
Data Visualization
Power BI
Business Analysis
Git
GitHub
Documentation

More importantly, the project follows a realistic analyst workflow:

Business Question
       ↓
Data
       ↓
Validation
       ↓
SQL Analysis
       ↓
Python Analysis
       ↓
Visualization
       ↓
Insight
       ↓
Recommendation

---

20. Current Project Status

Phase| Status
Project Setup| ✅ Completed
GitHub Setup| ✅ Completed
Dataset Acquisition| ✅ Completed
MySQL Import| ✅ Completed
Data Inspection| ✅ Completed
Data Quality Investigation| 🔄 Next
Exploratory Analysis| ⏳ Planned
Advanced SQL| ⏳ Planned
Python Analysis| ⏳ Planned
Power BI Dashboard| ⏳ Planned
Business Insights| ⏳ Planned
Final Report| ⏳ Planned

---

21. Project Principle

This project is built as a real analyst workflow, not as a collection of disconnected SQL queries.

Every analysis should answer:

What is the business question?
        ↓
What data do we need?
        ↓
How do we validate it?
        ↓
What analysis should we perform?
        ↓
What does the result tell us?
        ↓
What business action could follow?

The final objective is to demonstrate the complete process of taking raw Airbnb marketplace data and turning it into validated analysis, dashboards, and business insights.
