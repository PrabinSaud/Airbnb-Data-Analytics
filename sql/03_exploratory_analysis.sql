-- ============================================================
-- AIRBNB-003: EXPLORATORY ANALYSIS
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

use airbnb;


-- q1. what is the average listing price?
select
    round(avg(price), 2) as average_price
from listings;


-- q2. what is the minimum and maximum listing price?
select
    min(price) as min_price,
    max(price) as max_price
from listings;


-- q3. what is the average price for each room type?
select
    room_type,
    round(avg(price), 2) as avg_room_type_price
from listings
group by room_type
order by avg_room_type_price desc;


-- q4. how many listings are available for each room type?
select
    room_type,
    count(*) as total_listings
from listings
group by room_type
order by total_listings desc;


-- q5. what is the average price for each neighbourhood group?
select
    neighbourhood_group,
    round(avg(price), 2) as avg_neighbourhood_group_price
from listings
group by neighbourhood_group
order by avg_neighbourhood_group_price desc;


-- q6. which 10 neighbourhoods have the highest average listing price?
--     only include neighbourhoods with at least 10 listings.
select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as avg_neighbourhood_price
from listings
group by neighbourhood
having count(*) >= 10
order by avg_neighbourhood_price desc
limit 10;


-- q7. which 10 neighbourhoods have the lowest average listing price?
--     only include neighbourhoods with at least 10 listings.
select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as avg_neighbourhood_price
from listings
group by neighbourhood
having count(*) >= 10
order by avg_neighbourhood_price asc
limit 10;


-- q8. how many listings are priced below $100?
select
    count(*) as total_listings_below_100
from listings
where price < 100;


-- q9. how many listings are priced between $100 and $200?
select
    count(*) as total_listings_100_200
from listings
where price between 100 and 200;


-- q10. how many listings are priced between $200 and $500?
select
    count(*) as total_listings_200_500
from listings
where price between 200 and 500;


-- q11. how many listings are priced above $500?
select
    count(*) as total_listings_above_500
from listings
where price > 500;


-- q12. what percentage of listings are priced below $100?
select
    round(
        count(*) / (select count(*) from listings) * 100,
        2
    ) as percentage_below_100
from listings
where price < 100;


-- q13. what is the average price by room type and neighbourhood group?
select
    neighbourhood_group,
    room_type,
    round(avg(price), 2) as avg_price
from listings
group by neighbourhood_group, room_type
order by neighbourhood_group, avg_price desc;


-- q14. which neighbourhood group has the largest difference
--      between private room and entire home/apartment prices?
select
    neighbourhood_group,
    round(avg(case
        when room_type = 'Private room' then price
    end), 2) as private_room_avg,
    round(avg(case
        when room_type = 'Entire home/apt' then price
    end), 2) as entire_home_avg,
    round(
        avg(case
            when room_type = 'Entire home/apt' then price
        end)
        -
        avg(case
            when room_type = 'Private room' then price
        end),
        2
    ) as price_difference
from listings
group by neighbourhood_group
order by price_difference desc
limit 1;


-- q15. what are the 10 most expensive listings?
select
    id,
    name,
    host_id,
    neighbourhood,
    room_type,
    price
from listings
order by price desc
limit 10;


-- q16. what are the 10 least expensive listings?
select
    id,
    name,
    host_id,
    neighbourhood,
    room_type,
    price
from listings
order by price asc
limit 10;


-- q17. which neighbourhood has the largest number of listings
--      with a price above $500?
select
    neighbourhood,
    count(*) as expensive_listings
from listings
where price > 500
group by neighbourhood
order by expensive_listings desc
limit 1;


-- q18. compare the average price of listings with reviews
--      against listings with no reviews.
select
    round(avg(case
        when number_of_reviews > 0 then price
    end), 2) as average_reviewed_price,
    round(avg(case
        when number_of_reviews = 0 then price
    end), 2) as average_no_review_price
from listings;


-- q19. does availability_365 differ between room types?
select
    room_type,
    round(avg(availability_365), 2) as average_availability
from listings
group by room_type
order by average_availability desc;


-- q20. does minimum_nights differ between room types?
select
    room_type,
    round(avg(minimum_nights), 2) as average_minimum_nights
from listings
group by room_type
order by average_minimum_nights desc;


-- q21. identify neighbourhoods that have both:
--      a high number of listings and a high average price.
select
    neighbourhood,
    count(*) as total_listings,
    round(avg(price), 2) as avg_price
from listings
group by neighbourhood
having count(*) >= 100
order by avg_price desc;


-- q22. what percentage of listings belong to each room type?
select
    room_type,
    round(
        count(*) / sum(count(*)) over () * 100,
        2
    ) as percentage_of_listings
from listings
group by room_type;


-- q23. what percentage of listings belong to each neighbourhood group?
select
    neighbourhood_group,
    round(
        count(*) / sum(count(*)) over () * 100,
        2
    ) as percentage_of_listings
from listings
group by neighbourhood_group;


-- q24. what is the average price by neighbourhood and room type?
select
    neighbourhood,
    room_type,
    count(*) as total_listings,
    round(avg(price), 2) as average_price
from listings
group by neighbourhood, room_type
order by average_price desc;


-- q25. which room type is most common in each neighbourhood group?
select
    neighbourhood_group,
    room_type,
    total_listings
from (
    select
        neighbourhood_group,
        room_type,
        count(*) as total_listings,
        row_number() over (
            partition by neighbourhood_group
            order by count(*) desc
        ) as ranking
    from listings
    group by neighbourhood_group, room_type
) as ranked_room_types
where ranking = 1;