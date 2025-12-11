# ECOMMERCE CASE STUDY
  
## 1. Project Overview
This project analyzes two years of e-commerce transactions to understand customer behaviour, profitability drivers, and opportunities to grow lifetime value. Using PostgreSQL for all exploratory analysis and Python for RFM segmentation, I evaluated customer demographics, time-based purchasing patterns, category performance, and customer-level engagement.
  
The dataset contains **1,987 orders** (after removing NULLs), **155 customer IDs**, and three product categories (Clothing, Electronics, Beauty). I built a PostgreSQL database for structured querying, performed cohort and profitability analysis in SQL, and exported customer-level metrics for RFM scoring in Python. The final output combines quantitative insight with practical, business-focused recomendations. 
  
**Assumptions**
- Customer IDs are likely tied to orders from a specific address or area. Each contains multiple ages, genders, etc.
- COGS not specified as per unit or per order, assumed per unit as margins are unreasonably high if not.
- 0 orders between midnight and 6am across the entire dataset, likely a capture error.
  
## 2. Executive Insights  
- **Profitability is broad-based across categories.** Clothing, electronics, and beauty each generate ~$137-143k in profit despite differing sales volumes, indicating a balanced assortment and no over-reliance on a single category.
- **High order volume does not guarantee value.** Only 3 of the top 15 days by profit overlap with the top 15 days by volume. Value is driven by mix and margin, not transaction count.
- **Q4 drives revenue but compressess margins.** It accounts for 43% of orders but delivers the lowest average profit per order, reflecting heavy promotional activity in the market over holiday seasons.
- **Customer profitability is highly uneven.** Teens and customers in their 50s deliver highest average profit per order, while customers in their 60s significantly underperform.
  
## 3. Exploratory Analysis
  
### 3.1 Customer Insights  
**Age Groups**
- All customers are between the ages of 18 and 64
- Most orders come from individuals in their 40s, making up 22% of total.
- Customers in their 50s contribute the most to profit, making up 22% of total profit.
- 60s were the least profitable by far, only contributing $150 per order.
-   This is 26% lower than the second least profitable segment (40s, avg of $203 per order)
-   45% less than the most profitable segment (teens, avg of $271 per order)

**Gender Split**
- Females make slightly more orders (51% of tot)
- However men are $35 more profitable per order ($195 vs $230), and thus contribute 53% of profit, despite making 49% of purchases.
  
### 3.2 Temporal Patterns   
**Seasonal**
- As expected, accross both years Q4 makes up 34% of annual profits and 43% of sales, likely due to increased holiday spending on electronics, beauty, and clothing categories.
  - However the lowest avg profit is also Q4, likely due to end of year sales (boxing day, black friday) lowering margins.
  - The month of December had the most unit sales, and alone contributed 14% of total profit.
  - October had very similar unit sales (290 vs 297), but December was 20k more profitable. Could be worth looking into transaction data to see why the difference is so significant.
- Q1 is the quietest month with just 15% of oreders and 18% of profits.
- Q2 has the highest avg profit at $279 per order, 67% higher than Q4.
|Quarter|% of Orders|% of Profit|Avg Profit|
|---|---|---|---|
|Q1|15%|18%|$253|
|Q2|16%|21%|$279|
|Q3|26%|27%|$222|
|Q4|43%|34%|$167|
  
**Daily**
- Weekend sees more orders per day on average, with 13.5% more orders placed on Saturdays and Sundays.
- Weekdays have slightly higher profits by a small margin, earning $13 more than weekend spending.
- Overall daily average of 3 orders per day, and $654 in profit.
- Most profitable day was November 22, 2023 with $4,629 - 7x more than the avg day.
- Only 3 of the 15 most profitable days are also in the 15 highest volume days.
  
**Hourly**
- Over half of all orders are placed between 5-9pm
- Only 23% are placed during the workday (9a-5p)
- Despite this, average profit is much higher earlier in the day.
- Highest average profit is at 2pm ($338)
  
### 3.3 Category Performance  
**Categories**
|Category|Orders|Revenue|Profit|Avg Margin|
|---|---|---|---|---|
|Clothing|698|$310.0k|$143.2k|46.2%|
|Electronics|678|$311.4k|$140.7k|45.2%|
|Beauty|611|$286.8k|$137.4k|47.9%|
  
- Store profits and sales are well ditributed across categories.
- Margins pretty similar, but beauty products come slightly higher.
- Electronics have highest revenue (total and by unit), but high ticket items don't translate to highest margins.
- Pricing structure is identical across categories
  - All three categories share the same price points: $25, $30, $50, $300, $500
  - Implies profit differences must come from variations in COGS, purchase patterns, and promotions vs exclusively price of itmes.
  
**Costs**
- There were 27 days (3.7% of total) with a net negative profit.
- This is something to review more heavily, and a big operational signal.
  - Days cluster in October and November, likely tying to seasonal promoations, perhaps selling a significant amount of cost leaders to get people onto the website.
  - Margins also compress significantly during this time period.
    
## 4. RFM Segmentation
**Scoring Method**
- Each customer was asigned a score from 1-5 for each of *Recency (R)*, *Frequency (F)*, and *Monetary (M)*.
  - Recency (40%): Days since last purchase.
  - Frquency (30%): Number of purchases in the last 90 days.
  - Monetary (30%): Total spend in last 90 days.
- Weighted scores slightly emphasize recent purchases, signifying a lack of recent activities is the strongest sign of customer dropoff.
- Customers with 0 purchases in last 90 days were dropped from this part of the analysis.
  
**Segmentation Results**
Based on weighted RFM scores:
|Segment|Count|Description|
|---|---|---|
|Best|27|Highly engaged and high spending customers|
|Good|34|Good customers with strong behviour in at least two categories|
|Okay|46|Moderate/inconsistent customers|
|At risk|27|Low in at least two categories but still active in last 90 days. Highest churn risk.|
  
**Customer Personas**
- **High M, Low R:** Past big spenders, previously high-value but recently disengaged.
- **High F, Low M:** Frequent but low spending, loyal but low value transactions.
- **High R, Low F:** New or infrequent, recently acquired, not yet loyal.
  
## 5. Recomendations  
**Customer Marketing**
  - Re-engage past big spenders with personalized "we miss you" and retention incentives.
  - Upsell frequent but low spending customers with product recomendations and bundle offers.
  - Nurture new or infrequent buyers with perks to minimize friction (free-shipping/returns) and incentives for repeat purchases.
- ***Prioritize higher margin categories** (Beauty)**:**  in full-price placements, recomendation algorithms, and targetted marketing.
- **Explore demographic targetting:** certain demographics are far more profitable (teens & 50s), either target them more heavily or find out how to increase margins with other groups.
- **Monitor category-specific margin dynamics:** Electronics drive revenue but not profit, warrents a review of COGS, pricing strategy, or promotional depth.
  
## 6. File References 
- [Original Data Source](https://github.com/najirh/Retail-Sales-Analysis-SQL-Project--P1/blob/main/SQL%20-%20Retail%20Sales%20Analysis_utf%20.csv)
- [Database Setup](https://github.com/aweinb3/aweinb3.github.io/blob/main/projects/ecommerce-analysis/00_creating_db.sql)
- [Overview & Demographics](https://github.com/aweinb3/aweinb3.github.io/blob/main/projects/ecommerce-analysis/10_data_overview_and_demographics.sql)
- [Temporal Analysis](https://github.com/aweinb3/aweinb3.github.io/blob/main/projects/ecommerce-analysis/20_time_series_analysis.sql)
- [Cost & Category Trends](https://github.com/aweinb3/aweinb3.github.io/blob/main/projects/ecommerce-analysis/30_costs_and_category_trends.sql)
- [RFM Analysis](https://github.com/aweinb3/aweinb3.github.io/blob/main/projects/ecommerce-analysis/50_RFM.ipynb)
- [Data Exports](https://github.com/aweinb3/aweinb3.github.io/blob/main/projects/ecommerce-analysis/40_exports_for_rfm_and_charts.sql)
  
## 7. Next Steps
- **Explore customer_ids:** Dive deeper into each cutomer_id to find highest spenders and most valuable households.
- **Expand segmentation with clustering:** Once more customer data is collected, use K-Means/Hierarchical clustering models to validate RFM groups and discover hidden personas.
- **Create a dashboard** To track order mix, daily profit volatility, and weekly cost, order, and revenue averages.
