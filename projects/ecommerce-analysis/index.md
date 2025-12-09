# ECOMMERCE CASE STUDY  

## 1. Project Overview  

## 2. Methodology
- PG Admin & PostgreSQL for database creation and hosting
- PostgreSQL for exploratory analysis
- Pandas for RFM analysis
- Matplotlib for charts
  
**Assumptions**
- Customer IDs are likely tied to orders from a specific address or area. Each contains multiple ages, genders, etc.
- COGS not specified as per unit or per order, assumed per unit as margins are unreasonably high if not.
- 0 orders between midnight and 6am across the entire dataset, likely a capture error.

## 3. Dataset Snapshot  
- 1,987 unique orders
- Date range: Jan 1 2022 to Dec 31 2023
- 155 unique customer IDs
- Customer age range: 18-64
- 3 product categories; Clothing, Electronics, Beauty
- Avg profit per order: $212

## 4. Executive Insights  

## 5. Exploratory Analysis

### 5.1 Customer Insights  
**Age Groups**
- Most orders come from individuals in their 40s, making up 22% of total.
- Customers in their 50s contribute the most to profit, making up 22% of total profit.
- 60s were the least profitable by far, only contributing $150 per order.
-   This is 26% lower than the second least profitable segment (40s, avg of $203 per order)
-   45% less than the most profitable segment (teens, avg of $271 per order)

**Gender Split**
- Females make slightly more orders (51% of tot)
- However men are $35 more profitable per order ($195 vs $230), and thus contribute 53% of profit, despite making 49% of purchases.
  
  
### 5.2 Temporal Patterns   
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
  
### 5.3 Category Performance  
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
  
## 6. RFM Segmentation  
scoring method, segment results, customer personas  

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
- Past big spenders (High M, Low R)
  - Previously high-value but recently disengaged
  - **Action:** "We miss you" retention campaigns, personalized outreach
- Frequent but low spending (High F, Low M)
  - Loyal but low value transactions
  - **Action:** Work on upselling, product recomendation, bundle offers
- New or infrequent (High R, Low F)
  - Recently acquired, not yet loyal
  - **Action:** Welcome journeys, low friction offers (free shipping/returns)




## 7. Recomendations  

## 8. SQL & Notebook References  

## 9. Next Steps

