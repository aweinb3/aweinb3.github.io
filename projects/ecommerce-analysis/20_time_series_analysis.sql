-- ===================================================================
-- TIME SERIES ANALYSIS
-- Objective: Understand temporal patterns in orders and profit.
-- ===================================================================

-- YoY changes
SELECT
    to_char(sale_date, 'YYYY') as year,
    count (order_id) as orders,
    sum(profit) as tot_profit,
    round(avg(profit), 2) as avg_profit
from sales
group by year;
    -- 5.7% growth in orders
    -- 5.1% growth in total profit
    -- 0.5% decline in avg profit

-- quarterly patterns
SELECT
    to_char (sale_date, 'Q') as quarter,
    count(order_id) as tot_orders,
    sum(profit) as tot_profit,
    round(avg(profit),2) as avg_profit,
    round(count(order_id) *1.0 / sum(count(order_id)) over(), 2) as pct_of_orders,
    round(sum(profit) *1.0 / sum(sum(profit)) over(), 2) as pct_of_profit
from sales
group by quarter
order by quarter;

-- monthly trends
SELECT
    to_char (sale_date, 'MM') as month,
    count(order_id) as tot_orders,
    sum(profit) as tot_profit,
    round(avg(profit),2) as avg_profit,
    round(count(order_id) *1.0 / sum(count(order_id)) over(), 2) as pct_of_orders,
    round(sum(profit) *1.0 / sum(sum(profit)) over(), 2) as pct_of_profit
from sales
group by month
order by month;

-- patterns by DOW
select
    to_char (sale_date, 'dy') as day,
    count(order_id) as tot_orders,
    sum(profit) as tot_profit,
    round(count(order_id) * 1.0 / sum(count(order_id)) over(),2) as pct_of_orders,
    round(sum(profit) * 1.0 / sum(sum(profit)) over(), 2) as pct_of_profit,
    round(avg(profit),2) as avg_profit
from sales
group by day, extract (DOW from sale_date)
order by extract (DOW from sale_date);

-- weekday vs weekend (per-day averages)
SELECT
    day_type,
    tot_orders,
    CASE
        when day_type = 'weekday' then tot_orders / 5
        else tot_orders / 2
    end as avg_daily_orders,
    avg_profit
FROM(
    SELECT
        CASE
            when extract (DOW from sale_date) between 1 and 5 then 'weekday'
            else 'weekend'
        end as day_type,
        count(order_id) as tot_orders,
        round(avg(profit),2) as avg_profit
    from sales
    group by day_type
) subquery;

-- avg profit and orders per day
select 
    round(sum(profit) / count(distinct sale_date),2) as daily_profit,
    round(count(order_id) / count(distinct sale_date),2) as daily_orders
from sales;

-- comparing highest volume dates vs most profitable dates
with top_volume as(
    select to_char(sale_date, 'dy') as dow, sale_date, count(order_id) as tot_orders
    from sales
    group by sale_date
    order by tot_orders DESC
    limit 15
),
top_profit as (
    SELECT to_char(sale_date, 'dy') as dow, sale_date, sum(profit) as tot_profit
    from sales
    group by sale_date
    order by tot_profit DESC
    limit 15
)
select
    p.dow,
    p.sale_date,
    p.tot_orders,
    case when p.sale_date in (select sale_date from top_profit)
        then TRUE
        else FALSE
    end as in_top_profit
from top_volume p
order by p.tot_orders desc;

-- pulling orders from most profitable date
select * from sales
where sale_date = (
    select sale_date from sales
    group by sale_date
    order by sum(profit) DESC
    limit 1);

-- hourly behaviour
SELECT
    extract (hour from sale_time) as time,
    count(order_id) as tot_orders,
    sum(profit) as tot_profit,
    round(count(order_id) * 1.0 / sum(count(order_id)) over(),2) as pct_of_orders,
    round(sum(profit) * 1.0 / sum(sum(profit)) over(), 2) as pct_of_profit,
    round(avg(profit),2) as avg_profit
from sales
group by time
order by time;
    -- no orders between 00:00 and 6:00