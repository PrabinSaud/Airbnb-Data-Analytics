-- ============================================================
-- AIRBNB-001: DATA INSPECTION
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

USE airbnb;


-- Q1. How many total listings are in the dataset?
select
count(*) as Total_Count
from listings;

-- Q2. How many unique listings are in the dataset?
select
count(distinct(id)) as Unique_id
from listings;

-- Q3. How many unique hosts are in the dataset?
select
count(distinct(host_id)) as unique_host
from listings;

-- Q4. What is the minimum and maximum listing price?
select
max(price) as maximum_price,
min(price) as minimum_price
from listings;

-- Q5. What are the different room types available?
select
distinct room_type
from listings;

-- Q6. How many listings are there for each room type?
select
room_type,
count(id) as total_count
from listings
group by room_type;


-- Q7. How many listings are there in each neighbourhood group?
select
neighbourhood_group,
count(id) as total_count
from listings
group by neighbourhood_group;


-- Q8. Which 10 neighbourhoods have the highest number of listings?
select
neighbourhood,
count(id) as total_count 
from listings
group by neighbourhood 
order by total_count desc
limit 10 ;

-- Q9. Are there any duplicate listing IDs?
select
id,
count(id) as duplicate_count
from listings
group by id
having count(id) >1 ;

-- Q10. How many NULL values exist in each of these important columns?
--     id
--     host_id
--     name
--     neighbourhood
--     room_type
--     price
--     minimum_nights
--     availability_365
select
count(case when id is null then 1 end) as null_id,
count(case when host_id is null then 1 end) as null_host_id,
count(case when name is null then 1 end) as null_name,
count(case when neighbourhood is null then 1 end) as null_neighbourhood,
count(case when room_type is null then 1 end) as null_room_type,
count(case when price is null then 1 end) as null_price,
count(case when minimum_nights is null then 1 end) as null_minimum_nights,
count(case when availability_365 is null then 1 end) as null_availability_365
from listings;


-- Q11. What is the average listing price?
select 
round(avg(price)) as average
from listings;

-- Q12. What is the average minimum number of nights?
select 
round(avg(minimum_nights)) as average_minimum_nights
from listings;

-- Q13. What is the average availability over 365 days?
select 
round(avg(availability_365)) as average_minimum_nights
from listings;

-- Q14. Which 10 hosts have the highest number of listings?
select
host_id,
count(id) as total_listings
from listings
group by host_id
order by total_listings desc 
limit 10;

-- Q15. How many listings have never received a review?
select
count(number_of_reviews) as never_reviews_count
from listings 
where number_of_reviews = 0;
