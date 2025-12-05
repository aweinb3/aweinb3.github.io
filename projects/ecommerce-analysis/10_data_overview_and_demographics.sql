-- ===================================================================
-- DATA OVERVIEW & CUSTOMER DEMOGRAPHICS
-- Objective: Understand dataset size, ranges, and customer profile
-- ===================================================================

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