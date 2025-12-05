-- ===================================================================
-- COST AND CATEGORY TRENDS
-- Objective: Compare profitability acrsoo categories and
--            indentify days with negative profit.
-- ===================================================================

-- categories overview
select 
    category, 
    count(category) as tot_orders,
    sum(revenue) as tot_revenue,
    sum(cogs) as tot_cogs, 
    sum(profit) as tot_profit,
    round(sum(profit)/sum(revenue)*100,1) as avg_margin
from sales
group by category
order by tot_profit desc;

-- pricing bands by category
select distinct category, price_per_unit 
from sales
order by category, price_per_unit;

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