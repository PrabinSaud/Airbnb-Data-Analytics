-- ============================================================
-- AIRBNB-004: BUSINESS ANALYSIS
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

use airbnb;


-- q1. how many unique hosts are in the dataset?

select
    count(distinct host_id) as unique_host_count
from listings;


-- q2. which 10 hosts have the most listings?

select
    host_id,
    count(*) as total_listings
from listings
group by host_id
order by total_listings desc
limit 10;


-- q3. which 10 hosts have the highest total number of reviews?

select
    host_id,
    sum(number_of_reviews) as total_reviews
from listings
group by host_id
order by total_reviews desc
limit 10;


-- q4. which 10 hosts have the highest average reviews per listing?

select
    host_id,
    round(avg(number_of_reviews), 2) as average_reviews
from listings
group by host_id
order by average_reviews desc
limit 10;


-- q5. which hosts manage listings in multiple neighbourhoods?

select
    host_id,
    count(distinct neighbourhood) as neighbourhood_count
from listings
group by host_id
having count(distinct neighbourhood) > 1
order by neighbourhood_count desc;


-- q6. which 10 hosts have the highest average listing price?

select
    host_id,
    round(avg(price), 2) as average_price
from listings
group by host_id
order by average_price desc
limit 10;


-- q7. which hosts have more than 10 listings and an average price
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


-- q8. which hosts have many listings but relatively low review activity?

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


-- q9. which hosts have fewer listings but relatively high review activity?

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


-- q10. what percentage of all listings are controlled by the
--      top 10 hosts?

select
    round(
        100.0 * sum(total_listings) /
        (select count(*) from listings),
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


-- q11. what percentage of all listings are controlled by hosts
--      with more than 10 listings?

select
    round(
        100.0 * sum(total_listings) /
        (select count(*) from listings),
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


-- q12. compare hosts with 1 listing against hosts with multiple
--      listings. compare their average price.

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


-- q13. compare hosts with 1 listing against hosts with multiple
--      listings. compare their average reviews.

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


-- q14. which neighbourhoods have high average prices but
--      relatively low competition?

select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as average_price
from listings
group by neighbourhood
having count(*) < (
    select avg(total_listings)
    from (
        select
            neighbourhood,
            count(*) as total_listings
        from listings
        group by neighbourhood
    ) as neighbourhood_counts
)
and avg(price) > (
    select avg(average_price)
    from (
        select
            neighbourhood,
            avg(price) as average_price
        from listings
        group by neighbourhood
    ) as neighbourhood_prices
)
order by average_price desc;


-- q15. which neighbourhoods have high listing volume but
--      relatively low average prices?

select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as average_price
from listings
group by neighbourhood
having count(*) > (
    select avg(total_listings)
    from (
        select
            neighbourhood,
            count(*) as total_listings
        from listings
        group by neighbourhood
    ) as neighbourhood_counts
)
and avg(price) < (
    select avg(average_price)
    from (
        select
            neighbourhood,
            avg(price) as average_price
        from listings
        group by neighbourhood
    ) as neighbourhood_prices
)
order by total_listings desc;


-- q16. which room types appear to have the strongest market presence?

select
    room_type,
    count(*) as total_listings,
    round(
        100.0 * count(*) / (select count(*) from listings),
        2
    ) as listing_percentage
from listings
group by room_type
order by total_listings desc;


-- q17. which neighbourhood and room-type combinations have
--      the highest average price?

select
    neighbourhood,
    room_type,
    count(*) as total_listings,
    round(avg(price), 2) as average_price
from listings
group by neighbourhood, room_type
having count(*) >= 10
order by average_price desc
limit 10;


-- q18. which neighbourhoods have high supply but low review activity?

select
    neighbourhood,
    count(*) as total_listings,
    round(avg(number_of_reviews), 2) as average_reviews
from listings
group by neighbourhood
having count(*) > (
    select avg(total_listings)
    from (
        select
            neighbourhood,
            count(*) as total_listings
        from listings
        group by neighbourhood
    ) as neighbourhood_counts
)
and avg(number_of_reviews) < (
    select avg(average_reviews)
    from (
        select
            neighbourhood,
            avg(number_of_reviews) as average_reviews
        from listings
        group by neighbourhood
    ) as neighbourhood_reviews
)
order by total_listings desc;


-- q19. which neighbourhoods have low supply but high average prices?

select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as average_price
from listings
group by neighbourhood
having count(*) < (
    select avg(total_listings)
    from (
        select
            neighbourhood,
            count(*) as total_listings
        from listings
        group by neighbourhood
    ) as neighbourhood_counts
)
and avg(price) > (
    select avg(average_price)
    from (
        select
            neighbourhood,
            avg(price) as average_price
        from listings
        group by neighbourhood
    ) as neighbourhood_prices
)
order by average_price desc;


-- q20. which listings have high reviews, high availability,
--      and relatively low prices?

select
    id,
    name,
    neighbourhood,
    room_type,
    price,
    number_of_reviews,
    availability_365
from listings
where number_of_reviews > (
    select avg(number_of_reviews)
    from listings
)
and availability_365 > (
    select avg(availability_365)
    from listings
)
and price < (
    select avg(price)
    from listings
)
order by number_of_reviews desc
limit 20;


-- q21. which neighbourhoods appear attractive for a new host
--      based on listing volume, average price, and review activity?

select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as average_price,
    round(avg(number_of_reviews), 2) as average_reviews
from listings
group by neighbourhood
having count(*) >= 100
order by average_price desc, average_reviews desc;