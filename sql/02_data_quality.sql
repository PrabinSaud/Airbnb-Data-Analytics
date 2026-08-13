-- ============================================================
-- AIRBNB-002: DATA QUALITY INVESTIGATION
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

USE airbnb;


-- Q1. How many listings have a price of 0 or less?
select 
count(price) as price_count_less_0
from listings
where price <= 0;

-- Q2. What are the minimum, maximum, and average listing prices?
select
min(price) as min_price,
max(price) as max_price,
avg(price) as average_price
from listings;

-- Q3. How many listings have unusually high prices?
--     First investigate the price distribution before deciding
--     what should be considered unusually high.
select
id,
price
from listings 
where price is not null
order by price desc
limit 10;

select
count(price) as high_price_count
from listings 
where price > 9000;

-- Q4. What are the minimum, maximum, and average minimum-night
--     requirements?
select
min(minimum_nights) as min_minimum_nights,
max(minimum_nights) as max_minimum_nights,
avg(minimum_nights) as average_minimum_nights
from listings;

-- Q5. How many listings have minimum_nights less than or equal to 0?
select 
count(minimum_nights) as minimum_nights_count_less_0
from listings
where minimum_nights <= 0;

-- Q6. How many listings have an unusually high minimum_nights value?
--     First investigate the distribution before deciding
--     what should be considered unusually high.
select
minimum_nights,
count(*)
from listings 
where minimum_nights is not null
group by minimum_nights
order by minimum_nights desc
limit 10;

select
count(minimum_nights) as highest_minimum_nights_count
from listings
where minimum_nights >= 365; 

-- Q7. What are the minimum, maximum, and average availability_365?
select
min(availability_365) as min_availability_365,
max(availability_365) as max_availability_365,
avg(availability_365) as average_availability_365
from listings;

-- Q8. Are there any listings with availability_365 below 0
--     or above 365?
select 
count(availability_365) as availability_365_count_less_0
from listings
where availability_365 <= 0
or availability_365 >=365;

-- Q9. What are the minimum, maximum, and average number_of_reviews?
select
min(number_of_reviews) as min_number_of_reviews,
max(number_of_reviews) as max_number_of_reviews,
avg(number_of_reviews) as average_number_of_reviews
from listings;

-- Q10. Are there any listings with a negative number_of_reviews?
select 
count(number_of_reviews) as negative_number_of_reviews_count
from listings
where number_of_reviews < 0;

-- Q11. What are the minimum, maximum, and average reviews_per_month?
select
min(reviews_per_month) as min_reviews_per_month,
max(reviews_per_month) as max_reviews_per_month,
avg(reviews_per_month) as average_reviews_per_month
from listings;

-- Q12. How many NULL values exist in reviews_per_month?
select 
count(reviews_per_month) as null_number_of_reviews_count
from listings
where reviews_per_month is null;

-- Q13. Are there any listings with a negative reviews_per_month value?
select 
count(reviews_per_month) as negative_number_of_reviews_count
from listings
where reviews_per_month < 0;


-- Q14. What are the minimum and maximum latitude and longitude values?
select
min(latitude) as min_latitude,
max(latitude) as max_latitude,
min(longitude) as min_longitude,
max(longitude) as max_longitude
from listings;

-- Q15. How many listings have NULL latitude or longitude values?
select 
count(reviews_per_month) as null_latitude_or_longitude_count
from listings
where latitude is null
or longitude is null;


-- Q16. Are there any listings with suspicious geographic coordinates?
select
id,
latitude,
longitude
from listings
where latitude not between 40.4 and 41.0
or longitude not between -74.3 and -73.6;

select
count(*) as suspicious_coordinate_count
from listings
where latitude not between 40.4 and 41.0
or longitude not between -74.3 and -73.6;


-- Q17. What are the different room_type values and how many listings
--     belong to each room type?
select
room_type,
count(*) as total_count
from listings
group by room_type;

-- Q18. Are there any listings where room_type is NULL or empty?
select
count(*) as null_empty_count
from listings
where room_type is null
or room_type = '';

-- Q19. How many unique neighbourhood_group values are there?
select
neighbourhood_group,
count(*) as total_count
from listings
group by neighbourhood_group;

-- Q20. How many unique neighbourhood values are there?
select
neighbourhood,
count(*) as total_count
from listings
group by neighbourhood;

-- Q21. Are there any listings where neighbourhood_group or
--     neighbourhood is NULL or empty?
select
count(*) as null_count
from listings
where neighbourhood_group is null or neighbourhood_group = ''
or neighbourhood is null or neighbourhood = '';

-- Q22. Does the same host_id have multiple different host_name values?
select
host_id,
count(distinct(host_name)) as unique_host_names
from listings
group by host_id
having unique_host_names > 1;

-- Q23. Are there any duplicate listing IDs?
select
count(distinct(id)) as unique_id
from listings
group by id
having unique_id > 1;

-- Q24. For duplicate listing IDs, do any records have conflicting
--     host_id, room_type, neighbourhood, or price values?
-- q24. do duplicate listing ids have conflicting values?

select
id,
count(distinct host_id) as unique_hosts,
count(distinct room_type) as unique_room_types,
count(distinct neighbourhood) as unique_neighbourhoods,
count(distinct price) as unique_prices
from listings
group by id
having count(id) > 1
and (
count(distinct host_id) > 1
or count(distinct room_type) > 1
or count(distinct neighbourhood) > 1
or count(distinct price) > 1
);

-- Q25. Based on the checks above, identify the data-quality issues
--     that could affect future Airbnb business analysis.


-- finding 1:
-- price values should be checked for zero, negative, and unusually
-- high values before using price for business analysis.
--
-- finding 2:
-- minimum_nights should be checked for invalid or unusually high
-- values because extreme values can affect average stay analysis.
--
-- finding 3:
-- availability_365 should only contain values between 0 and 365.
-- values outside this range would indicate invalid data.
--
-- finding 4:
-- number_of_reviews should not contain negative values.
-- listings with zero reviews are valid and represent listings
-- that have never received a review.
--
-- finding 5:
-- reviews_per_month can contain null values because some listings
-- may not have review activity. this should not automatically be
-- treated as an error.
--
-- finding 6:
-- latitude and longitude should be checked for null or suspicious
-- values because incorrect coordinates can affect location analysis.
--
-- finding 7:
-- multiple host_name values for the same host_id may indicate
-- inconsistent host information and should be investigated.
--
-- finding 8:
-- duplicate listing ids should be investigated because they can
-- cause double counting in listing, pricing, and host analysis.
--
-- finding 9:
-- duplicate listing ids with conflicting host_id, room_type,
-- neighbourhood, or price values require further investigation
-- before using the data for business reporting.
--
-- business impact:
-- these data-quality issues can affect pricing analysis, host
-- performance analysis, neighbourhood analysis, listing counts,
-- and other business metrics if they are not identified before
-- analysis.
