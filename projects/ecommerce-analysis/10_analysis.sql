
-- ===================
-- === DATA RANGES ===
-- ===================

-- finding total customer ids and orders
select 
    count(distinct customer_id) as unique_users, 
    count(distinct order_id) as unique_orders, 
    round(avg(profit), 2) as avg_profit 
from sales;

-- customer age range
select min(age), max(age) from sales;

-- date range
select min(sale_date), max(sale_date) from sales;

-- =============================
-- === CUSTOMER DEMOGRAPHICS ===
-- =============================

-- comparing by gender
select gender, 
    count(order_id) as tot_orders, 
    sum(profit) as tot_profit, 
    round(avg(profit),2) as avg_profit,
    round(count(order_id) *1.0 / sum(count(order_id)) over (),2) as pct_orders,
    round(sum(profit) * 1.0 / sum(sum(profit)) over (),2) as pct_profit
from sales
group by gender;


-- finding data by age group
select 
    CASE
        when age between 0 and 19 then '0-19'
        when age between 20 and 29 then '20s'
        when age between 30 and 39 then '30s'
        when age between 40 and 49 then '40s'
        when age between 50 and 59 then '50s'
        when age between 60 and 69 then '60s'
    end as age_group,
    count(distinct customer_id) as customers, 
    count(order_id) as tot_orders, 
    sum(profit) as tot_profit, 
    round(avg(profit), 2) as avg_profit,
    round(count(order_id) * 1.0 / sum(count(order_id)) over (),2) as pct_orders,
    round(sum(profit) * 1.0 / sum(sum(profit)) over(),2) as pct_profit
from sales
group by age_group;


-- ===================
-- === TIME TRENDS ===
-- ===================

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


-- Quarterly patterns (aggregated by quarter)
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


-- Monthly trends (aggregated by month)
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


-- Hourly behaviour
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

-- weekday vs weekend
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

-- avg profit per day
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
    limit 15),

top_profit as (
    SELECT to_char(sale_date, 'dy') as dow, sale_date, sum(profit) as tot_profit
    from sales
    group by sale_date
    order by tot_profit DESC
    limit 15)

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

-- on how many days did we lose money?
select count(sale_date) from(
    select sale_date, sum(profit) from sales
    group by sale_date
    having sum(profit) < 0) as subquery;

-- info on days we lost money
select 
    sale_date, 
    sum(profit) as net_loss, 
    count(order_id) as orders 
from sales
group by sale_date
having sum(profit) < 0
order by sum(profit);

-- daily totals (make histograms)
select 
    to_char(sale_date, 'dy') as DOW, 
    sale_date, 
    sum(profit), 
    count(order_id) from sales
group by sale_date
order by sale_date;

-- avg profit per day
select round(sum(profit) / count(distinct sale_date),2) 
from sales;

-- weekend vs weekday behaviour
SELECT
    CASE
        when extract (DOW from sale_date) between 1 and 5 then 'weekday'
        else 'weekend'
    end as day_type,
    count(order_id) as tot_orders,
    sum(profit) as tot_profit,
    round(count(order_id) * 1.0 / sum(count(order_id)) over(),2) as pct_of_orders,
    round(sum(profit) * 1.0 / sum(sum(profit)) over(), 2) as pct_of_profit,
    round(avg(profit),2) as avg_profit
from sales
group by day_type;

-- ===============================
-- === COSTS & CATEGORY TRENDS ===
-- ===============================

-- categories overview
select 
    category, 
    count(category) as orders,
    sum(revenue) as revenue,
    sum(cogs) as cost, 
    sum(profit) as profit,
    round(sum(profit)/sum(revenue)*100,1) as margin_pct
from sales
group by category;

-- cost bands
select distinct category, price_per_unit 
from sales
order by category, price_per_unit;