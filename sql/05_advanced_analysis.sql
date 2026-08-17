-- ============================================================
-- AIRBNB-005: ADVANCED ANALYSIS
-- Dataset: Airbnb NYC Listings
-- Database: airbnb
-- Table: listings
-- ============================================================

use airbnb;


-- q1. rank neighbourhoods by average listing price.

with neighbourhood_prices as (
    select
        neighbourhood,
        round(avg(price), 2) as average_price
    from listings
    group by neighbourhood
)
select
    neighbourhood,
    average_price,
    rank() over (order by average_price desc) as price_rank
from neighbourhood_prices
order by price_rank;


-- q2. rank neighbourhoods by total number of listings.

with neighbourhood_listings as (
    select
        neighbourhood,
        count(*) as total_listings
    from listings
    group by neighbourhood
)
select
    neighbourhood,
    total_listings,
    rank() over (order by total_listings desc) as listing_rank
from neighbourhood_listings
order by listing_rank;


-- q3. rank room types by average price within each
--     neighbourhood group.

with room_prices as (
    select
        neighbourhood_group,
        room_type,
        round(avg(price), 2) as average_price
    from listings
    group by neighbourhood_group, room_type
)
select
    neighbourhood_group,
    room_type,
    average_price,
    rank() over (
        partition by neighbourhood_group
        order by average_price desc
    ) as price_rank
from room_prices
order by neighbourhood_group, price_rank;


-- q4. identify the most expensive room type in each
--     neighbourhood group.

with room_prices as (
    select
        neighbourhood_group,
        room_type,
        round(avg(price), 2) as average_price
    from listings
    group by neighbourhood_group, room_type
),
ranked_rooms as (
    select
        neighbourhood_group,
        room_type,
        average_price,
        row_number() over (
            partition by neighbourhood_group
            order by average_price desc
        ) as ranking
    from room_prices
)
select
    neighbourhood_group,
    room_type,
    average_price
from ranked_rooms
where ranking = 1;


-- q5. identify the most common room type in each
--     neighbourhood group.

with room_counts as (
    select
        neighbourhood_group,
        room_type,
        count(*) as total_listings
    from listings
    group by neighbourhood_group, room_type
),
ranked_rooms as (
    select
        neighbourhood_group,
        room_type,
        total_listings,
        row_number() over (
            partition by neighbourhood_group
            order by total_listings desc
        ) as ranking
    from room_counts
)
select
    neighbourhood_group,
    room_type,
    total_listings
from ranked_rooms
where ranking = 1;


-- q6. calculate each neighbourhood's percentage share
--     of total listings.

with neighbourhood_listings as (
    select
        neighbourhood,
        count(*) as total_listings
    from listings
    group by neighbourhood
)
select
    neighbourhood,
    total_listings,
    round(
        100.0 * total_listings /
        sum(total_listings) over (),
        2
    ) as listing_share_percentage
from neighbourhood_listings
order by listing_share_percentage desc;


-- q7. calculate the cumulative percentage of listings
--     by neighbourhood.

with neighbourhood_listings as (
    select
        neighbourhood,
        count(*) as total_listings
    from listings
    group by neighbourhood
),
listing_share as (
    select
        neighbourhood,
        total_listings,
        100.0 * total_listings /
        sum(total_listings) over () as listing_percentage
    from neighbourhood_listings
)
select
    neighbourhood,
    total_listings,
    round(listing_percentage, 2) as listing_percentage,
    round(
        sum(listing_percentage) over (
            order by total_listings desc
        ),
        2
    ) as cumulative_percentage
from listing_share
order by total_listings desc;


-- q8. rank hosts based on their total number of listings.

with host_listings as (
    select
        host_id,
        count(*) as total_listings
    from listings
    group by host_id
)
select
    host_id,
    total_listings,
    dense_rank() over (
        order by total_listings desc
    ) as host_rank
from host_listings
order by host_rank;


-- q9. calculate each host's percentage share of total listings.

with host_listings as (
    select
        host_id,
        count(*) as total_listings
    from listings
    group by host_id
)
select
    host_id,
    total_listings,
    round(
        100.0 * total_listings /
        sum(total_listings) over (),
        2
    ) as listing_share_percentage
from host_listings
order by listing_share_percentage desc;


-- q10. identify the top 10% of hosts based on listing count.

with host_listings as (
    select
        host_id,
        count(*) as total_listings
    from listings
    group by host_id
),
ranked_hosts as (
    select
        host_id,
        total_listings,
        ntile(10) over (
            order by total_listings desc
        ) as host_decile
    from host_listings
)
select
    host_id,
    total_listings,
    host_decile
from ranked_hosts
where host_decile = 1
order by total_listings desc;


-- q11. classify listings into budget, mid-range, and premium
--      price segments.

select
    id,
    name,
    neighbourhood,
    room_type,
    price,
    case
        when price < 100 then 'budget'
        when price <= 300 then 'mid_range'
        else 'premium'
    end as price_segment
from listings;


-- q12. count listings in each price segment.

with price_segments as (
    select
        case
            when price < 100 then 'budget'
            when price <= 300 then 'mid_range'
            else 'premium'
        end as price_segment
    from listings
)
select
    price_segment,
    count(*) as total_listings
from price_segments
group by price_segment
order by total_listings desc;


-- q13. calculate the percentage of listings in each
--      price segment.

with price_segments as (
    select
        case
            when price < 100 then 'budget'
            when price <= 300 then 'mid_range'
            else 'premium'
        end as price_segment
    from listings
)
select
    price_segment,
    count(*) as total_listings,
    round(
        100.0 * count(*) /
        (select count(*) from listings),
        2
    ) as listing_percentage
from price_segments
group by price_segment
order by listing_percentage desc;


-- q14. find listings whose price is above their
--      neighbourhood's average price.

with neighbourhood_prices as (
    select
        neighbourhood,
        avg(price) as average_price
    from listings
    group by neighbourhood
)
select
    l.id,
    l.name,
    l.neighbourhood,
    l.price,
    round(np.average_price, 2) as neighbourhood_average_price,
    round(l.price - np.average_price, 2) as price_difference
from listings l
join neighbourhood_prices np
    on l.neighbourhood = np.neighbourhood
where l.price > np.average_price
order by price_difference desc;


-- q15. find listings whose price is below their
--      neighbourhood's average price.

with neighbourhood_prices as (
    select
        neighbourhood,
        avg(price) as average_price
    from listings
    group by neighbourhood
)
select
    l.id,
    l.name,
    l.neighbourhood,
    l.price,
    round(np.average_price, 2) as neighbourhood_average_price,
    round(np.average_price - l.price, 2) as price_difference
from listings l
join neighbourhood_prices np
    on l.neighbourhood = np.neighbourhood
where l.price < np.average_price
order by price_difference desc;


-- q16. rank listings within each neighbourhood by
--      number of reviews.

select
    id,
    name,
    neighbourhood,
    number_of_reviews,
    rank() over (
        partition by neighbourhood
        order by number_of_reviews desc
    ) as review_rank
from listings
order by neighbourhood, review_rank;


-- q17. identify the top 3 most-reviewed listings
--      in each neighbourhood.

with ranked_listings as (
    select
        id,
        name,
        neighbourhood,
        number_of_reviews,
        row_number() over (
            partition by neighbourhood
            order by number_of_reviews desc
        ) as ranking
    from listings
)
select
    id,
    name,
    neighbourhood,
    number_of_reviews,
    ranking
from ranked_listings
where ranking <= 3
order by neighbourhood, ranking;


-- q18. compare each neighbourhood's average price
--      with the overall average price.

with neighbourhood_prices as (
    select
        neighbourhood,
        avg(price) as average_price
    from listings
    group by neighbourhood
)
select
    neighbourhood,
    round(average_price, 2) as average_price,
    round(
        (select avg(price) from listings),
        2
    ) as overall_average_price,
    round(
        average_price - (select avg(price) from listings),
        2
    ) as difference_from_overall
from neighbourhood_prices
order by difference_from_overall desc;


-- q19. identify hosts whose listing count is above
--      the average host listing count.

with host_listings as (
    select
        host_id,
        count(*) as total_listings
    from listings
    group by host_id
)
select
    host_id,
    total_listings
from host_listings
where total_listings > (
    select avg(total_listings)
    from host_listings
)
order by total_listings desc;


-- q20. identify neighbourhoods with both high listing
--      share and above-average price.

with neighbourhood_summary as (
    select
        neighbourhood,
        count(*) as total_listings,
        avg(price) as average_price
    from listings
    group by neighbourhood
),
benchmarks as (
    select
        avg(total_listings) as average_listings,
        avg(average_price) as average_price
    from neighbourhood_summary
)
select
    ns.neighbourhood,
    ns.total_listings,
    round(ns.average_price, 2) as average_price
from neighbourhood_summary ns
cross join benchmarks b
where ns.total_listings > b.average_listings
  and ns.average_price > b.average_price
order by ns.average_price desc;


-- q21. rank neighbourhoods by a combined score based on
--      listing volume and average price.

with neighbourhood_summary as (
    select
        neighbourhood,
        count(*) as total_listings,
        avg(price) as average_price
    from listings
    group by neighbourhood
),
scored_neighbourhoods as (
    select
        neighbourhood,
        total_listings,
        average_price,
        percent_rank() over (
            order by total_listings
        ) as listing_score,
        percent_rank() over (
            order by average_price
        ) as price_score
    from neighbourhood_summary
)
select
    neighbourhood,
    total_listings,
    round(average_price, 2) as average_price,
    round(
        (listing_score + price_score) / 2 * 100,
        2
    ) as combined_score
from scored_neighbourhoods
order by combined_score desc;