-- ============================================================
-- AIRBNB-004: HOST & LISTING PERFORMANCE ANALYSIS
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

use airbnb;


-- q1. how many unique hosts are in the dataset?
select
count(distinct host_id) as unique_host_count
from listings;

-- q2. how many listings does each host have?
select
host_id,
host_name,
count(*) as each_host_count
from listings
group by host_id,host_name;

-- q3. which 10 hosts have the most listings?
select
host_id,
count(*) as total_listings
from listings
group by host_id
order by total_listings desc
limit 10 ;


-- q4. which 10 hosts have the highest total number of reviews?
select
host_id,
count(number_of_reviews) as total_reviews
from listings
group by host_id
order by total_reviews desc
limit 10 ;


-- q5. which 10 hosts have the highest average number of reviews
--     per listing?
select
host_id,
avg(number_of_reviews) as total_avg_reviews
from listings
group by host_id
order by total_avg_reviews desc
limit 10 ;

-- q6. which 10 hosts have the highest average rating proxy based
--     on reviews_per_month?
select
host_id,
avg(reviews_per_month) as total_avg_reviews_month
from listings
group by host_id
order by total_avg_reviews desc
limit 10 ;

-- q7. how many listings does each host have by room type?
select
host_id,
room_type,
count(*) as total_listings
from listings
group by host_id, room_type;

-- q8. which hosts manage listings in multiple neighbourhoods?
select
host_id,
count(distinct neighbourhood) as neighbourhood_count
from listings
group by host_id
having count(distinct neighbourhood) > 1;

-- q9. which 10 hosts operate in the most neighbourhoods?
select
host_id,
count(distinct neighbourhood) as neighbourhood_count
from listings
group by host_id
having count(distinct neighbourhood) > 1
order by neighbourhood_count desc
limit 10;

-- q10. which 10 hosts have the highest average listing price?
select
host_id,
avg(price) as highest_average_price
from listings
group by host_id
order by highest_average_price desc
limit 10;

-- q11. which hosts have more than 10 listings and an average price
--     above the overall average listing price?
select
host_id,
count(*) as total_listings,
round(avg(price), 2) as average_price
from listings
group by host_id
having count(*) > 10
and avg(price) > (
	select avg(price)
	from listings
	)
order by average_price desc;

-- q12. how many listings does each host have that have never
--     received a review?
select
host_id,
sum(case when number_of_reviews = 0 then 1 else 0 end) as listings_without_reviews
from listings
group by host_id
having listings_without_reviews > 0;

-- q14. which 10 hosts have the highest average availability_365?
select
host_id,
avg(availability_365) as avg_availability_365
from listings
group by host_id
order by avg_availability_365 desc
limit 10 ;

-- q15. which 10 hosts have the lowest average availability_365?
select
host_id,
avg(availability_365) as avg_availability_365
from listings
group by host_id
order by avg_availability_365 asc
limit 10 ;


-- q16. compare hosts with 1 listing against hosts with multiple
--     listings. compare their average price.

select
    case
        when host_listing_count = 1 then 'single_listing'
        else 'multiple_listings'
    end as host_type,
    round(avg(avg_price), 2) as average_price
from (
    select
        host_id,
        count(*) as host_listing_count,
        avg(price) as avg_price
    from listings
    group by host_id
) as host_summary
group by host_type;


-- q17. compare hosts with 1 listing against hosts with multiple
--     listings. compare their average reviews.
select
    case
        when host_listing_count = 1 then 'single_listing'
        else 'multiple_listings'
    end as host_type,
    round(avg(avg_reviews), 2) as average_reviews
from (
    select
        host_id,
        count(*) as host_listing_count,
        avg(number_of_reviews) as avg_reviews
    from listings
    group by host_id
) as host_summary
group by host_type;

-- q18. which hosts have listings across multiple room types?
select
host_id,
count(distinct room_type) as unique_room_count
from listings 
group by host_id
having count(distinct room_type) >1;


-- q19. which 10 hosts have the highest combined number of reviews
--     and listings?
select
host_id,
count(*) as total_listings,
sum(number_of_reviews) as total_reviews
from listings
group by host_id
order by total_reviews desc ,total_listings desc
limit 10;

-- q20. identify hosts that have many listings but relatively
--     low review activity.
select
    host_id,
    count(*) as total_listings,
    sum(number_of_reviews) as total_reviews,
    round(avg(number_of_reviews), 2) as average_reviews
from listings
group by host_id
having count(*) >= 10
   and avg(number_of_reviews) < 10
order by total_listings desc;

-- q21. identify hosts that have fewer listings but relatively
--     high review activity.
select
    host_id,
    count(*) as total_listings,
    sum(number_of_reviews) as total_reviews,
    round(avg(number_of_reviews), 2) as average_reviews
from listings
group by host_id
having count(*) <= 3
   and avg(number_of_reviews) > 100
order by average_reviews desc;

-- q22. what percentage of all listings are controlled by the
--     top 10 hosts?
select
    round(
        100.0 * sum(total_listings) / (select count(*) from listings),
        2
    ) as top_10_host_listing_percentage
from (
    select
        host_id,
        count(*) as total_listings
    from listings
    group by host_id
    order by total_listings desc
    limit 10
) as top_hosts;

-- q23. what percentage of all listings are controlled by hosts
--     with more than 10 listings?
select
    round(
        100.0 * sum(total_listings) / (select count(*) from listings),
        2
    ) as percentage_of_listings
from (
    select
        host_id,
        count(*) as total_listings
    from listings
    group by host_id
    having count(*) > 10
) as multi_listing_hosts;

-- q24. based on the analysis above, what insights can Airbnb
--     management learn about host behaviour and listing performance?


-- q24. based on the analysis above, what insights can airbnb
--     management learn about host behaviour and listing performance?

-- 1. a small number of hosts may control a significant share of
--    the total listings, indicating that the market includes both
--    individual hosts and professional or multi-listing hosts.

-- 2. hosts with multiple listings can have different pricing
--    behaviour compared with hosts managing only one listing.

-- 3. hosts operating multiple listings across different
--    neighbourhoods may have a broader market presence.

-- 4. hosts with many listings but low review activity may require
--    further investigation into listing performance and guest engagement.

-- 5. hosts with fewer listings but high review activity may have
--    strong guest engagement despite having a smaller portfolio.

-- 6. comparing listing count, price, reviews, and availability
--    helps identify different host strategies.

-- 7. high listing volume does not necessarily mean high performance.
--    review activity and availability should also be considered.

-- 8. Airbnb management can use these metrics to identify high-volume
--    hosts, understand host behaviour, and identify potential
--    opportunities to improve listing performance.