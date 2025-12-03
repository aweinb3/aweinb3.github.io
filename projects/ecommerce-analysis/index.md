# E-commerce Sales Analysis and Customer Segmentation

**Tools:** SQL (PostgreSQL), Python (Pandas)
**Dataset Size:** ~2,000 transactions over 24 month period

### Exploartory Analysis

**Customer demographics**
Total dataset
- 155 unique customer_ids
- 1987 unique orders
- Avg profit of $212 per order

**Gender behaviour**
- Females make slightly more orders (51% of tot)
- Males have higher avg profit ($35 higher than females), and 53% of total profit comes from male customers despite fewer total purchases.

**Age Groups**
- Customer age range: 18-64 (teens and 60+ buckets do not have customers in the full range)
- Most unique customers and orders from 40s group, with 22% of total orders.
- Most profitable segment is 50s contributing 22% of total profit, teens avg profit per order was the highest by a wide margin, at $271 per order.
- 60s was the least profitable by order by a lot, at $150 avg. 26% lower than the second lowest group, and 45% lower than the most profitable segment (teens).

**Seasonal trends**
- As expected, December has the highest total profit across both years with 57k, 14% of total profit for the year.
- October had very similar unit sales (290 vs 297), but December was over $20k more profitable.
- Quarterly
    - Q4 sees the highest total profit with 34% of annual profits and 43% of orders. However the lowest avg profit is here, maybe due to black friday/boxing day/holiday sales.
    - Q1 is the quietest with just 15% of orders and 18% of profits.
    - Highest avg profit is Q2 at $279/order. $112 more than Q4 avg orders.
- Time
    - 0 orders occur between midnight and 6am
    - 54% of orders are placed in the evening (5-9pm)
    - Only 23% of orders are placed during the entire workday
    - Despite this, avg profit is much higher earlier in the day. Perhaps people are only making more substantial purchases during the day, and leaving discretionary spending for the evening.
    - Highest avg profit is at 2pm - $338
- Daily
    - As expected weekend sees more orders per day on average, with 13.5% more daily orders coming through on Saturdays and Sundays.
    - Weekdays have the higher average profit by a small margin, earning $13 more than weekend spending.
    - Average of 3 orders per day and $654 in profit
    - 27 days in the dataset have a negative profit
    - Most profitable day recorded was Wednesday November 22, 2023 with $4,629 - 7 times more than average
    - Only 3 of the 15 most profitable days are also in the 15 highest volume days.
    

**Categories**
- asfas

**Customer Segmentation**
We found that customers are pretty evenly split between top and bottom performers. Next step is further segmentation to create targeted campaigns.

Examples:
- **Past big spenders =** high M, low R
    - “We miss you” campaign to bring them back on board. Offer discount code and try to ask why they stopped purchasing.
- **Frequent but small purchasers** = high F, low M
    - How do we make them spend more $$? What products are they frequently purchasing?
- New Customers = high R, low F
    - How do we turn them into loyal customers?
    - Take advantage of the relatively small scale of the store. Can be as simple as a handwritten note thanking them for purchasing and free shipping on their next purchase.
