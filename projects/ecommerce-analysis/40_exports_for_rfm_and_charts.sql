-- -------------------------------------------------------------------
-- EXPORT FOR RFM ANALYSIS
    -- For each customer_id find: 
    -- Recency: most recent purchase
    -- Frequency: number of purchases in last 90 days
    -- Monetary: revenue in last 90 days
-- -------------------------------------------------------------------

SELECT
    customer_id,
    max(sale_date) as most_recent_purchase,
    count(case when sale_date >= '2023-09-01' then customer_id end) as orders,
    sum(case when sale_date >= '2023-09-01' then revenue end) as revenue
from sales
group by customer_id;


-- -------------------------------------------------------------------
-- CHART DATA EXPORTS
    -- histogram for order_count
    -- stacked line chart with monthly revenue vs profit
-- -------------------------------------------------------------------

select 
    sale_date as sale_date, 
    sum(profit) as profit,
    sum(revenue) as revenue,
    count(order_id) as orders
from sales
group by sale_date
order by sale_date;