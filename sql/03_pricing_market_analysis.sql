-- ============================================================
-- AIRBNB-003: PRICING & MARKET ANALYSIS
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

use airbnb;


-- q1. what is the average listing price?
select
avg(price)
from listings;

-- q2. what is the minimum and maximum listing price?
select
min(price) as min_price,
max(price) as max_price
from listings;

-- q3. what is the average price for each room type?
select
room_type,
avg(price) as avg_room_type_price
from listings
group by room_type;

-- q4. how many listings are available for each room type?
select
room_type,
count(*) as room_type_count
from listings
group by room_type;

-- q5. which room type has the highest average price?
select
room_type,
avg(price) as avg_room_type_price
from listings
group by room_type
order by avg_room_type_price desc
limit 1;

-- q6. what is the average price for each neighbourhood group?
select
neighbourhood_group,
avg(price) as avg_neighbourhood_group_price
from listings
group by neighbourhood_group;


-- q7. which neighbourhood group has the highest average listing price?
select
neighbourhood_group,
avg(price) as avg_neighbourhood_group_price
from listings
group by neighbourhood_group
order by avg_neighbourhood_group_price desc
limit 1;

-- q8. which 10 neighbourhoods have the highest average listing price?
select
neighbourhood,
avg(price) as avg_neighbourhood_price
from listings
group by neighbourhood
order by avg_neighbourhood_price desc
limit 10;

-- q9. which 10 neighbourhoods have the lowest average listing price?
--     only include neighbourhoods with at least 10 listings.
select
neighbourhood,
count(*) as total_listings,
avg(price) as avg_neighbourhood_price
from listings
group by neighbourhood
having total_listings >=10
order by avg_neighbourhood_price asc
limit 10;

-- q10. how many listings are priced below $100?
select
count(*) as total_listings_below100
from listings
where price < 100;

-- q11. how many listings are priced between $100 and $200?
select
count(*) as total_listings_between_100and200
from listings
where price between 100 and 200;

-- q12. how many listings are priced between $200 and $500?
select
count(*) as total_listings_between_200and500
from listings
where price between 200 and 500;

-- q13. how many listings are priced above $500?
select
count(*) as total_listings_above_500
from listings
where price > 500;

-- q14. what percentage of listings are priced below $100?
select
concat(round(count(*)/
	(select count(*) from listings)*100,2),'%') as total_listings_percentage_below100
from listings
where price < 100;

-- q15. what is the average price by room type and neighbourhood group?
select
room_type,
neighbourhood_group,
round(avg(price),2) as avg_price
from listings
group by room_type,neighbourhood_group;

-- q16. which neighbourhood group has the largest difference
--     between private room and entire home/apartment prices?
select
    neighbourhood_group,
avg(case when room_type = 'Private room' then price end) as private_room_avg,
avg(case when room_type = 'Entire home/apt' then price end)as entire_home_avg,
(avg(case when room_type = 'Private room' then price end) 
	- avg(case when room_type = 'Entire home/apt' then price end)) as price_difference
from listings
group by neighbourhood_group
order by price_difference desc
limit 1;

-- q17. what are the 10 most expensive listings?
select
*,
price
from listings
order by price desc
limit 10;

-- q18. what are the 10 least expensive listings?
select
*,
price
from listings
order by price asc
limit 10;

-- q19. which neighbourhood has the largest number of listings
--     with a price above $500?
select
neighbourhood,
price
from listings
where price > 500
order by price desc;


-- q20. compare the average price of listings with reviews
--     against listings with no reviews.
select
avg(case when number_of_reviews >=1 then price end) as average_reviews_price ,
avg(case when number_of_reviews = 0  then price end) as average_no_reviews_price
from listings;


-- q21. does availability_365 differ between room types?
select
room_type,
round(avg(availability_365), 2) as average_availability
from listings
group by room_type
order by average_availability desc;

-- q22. does minimum_nights differ between room types?
select
room_type,
round(avg(minimum_nights), 2) as average_minimum_nights
from listings
group by room_type
order by average_minimum_nights desc;

-- q23. identify neighbourhoods that have a high number of listings and a high average price.
select
neighbourhood,
count(*) as highest_total_listings
from listings 
group by neighbourhood
order by highest_total_listings  desc
limit 1;

select
neighbourhood,
avg(price) as highest_avg_price
from listings 
group by neighbourhood
order by highest_avg_price  desc
limit 1;

-- q24. identify neighbourhoods that have both:
--     a high number of listings and a high average price.

select
neighbourhood,
count(*) as total_listings,
round(avg(price), 2) as avg_price
from listings
group by neighbourhood
having count(*) >= 100
order by avg_price desc;


-- q25. based on the analysis above, what pricing insights could
--     be useful for an Airbnb business?


-- 1. neighbourhoods have significant differences in average listing
--    prices, showing that location is an important pricing factor.

-- 2. tribeca has a very high average listing price compared with most
--    other neighbourhoods, although it has a smaller number of listings.

-- 3. midtown combines high listing volume with a high average price,
--    making it an important market for both supply and pricing analysis.

-- 4. upper east side and financial district also show relatively high
--    average prices with substantial listing volumes.

-- 5. neighbourhoods such as bedford-stuyvesant, harlem, and williamsburg
--    have large numbers of listings but lower average prices, suggesting
--    stronger competition among listings.

-- 6. pricing should not be evaluated using listing volume alone.
--    both market size and average price should be considered when
--    evaluating neighbourhood opportunities.

-- 7. the business could use these pricing differences to compare
--    neighbourhoods, identify premium markets, and evaluate pricing
--    strategies.