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
-   However the lowest avg profit is also Q4, likely due to end of year sales (boxing day, black friday) lowering margins.
-   The month of December had the most unit sales, and alone contributed 14% of total profit.
-   October had very similar unit sales (290 vs 297), but December was 20k more profitable. Could be worth looking into transaction data to see why the difference is so significant.
- Q1 is the quietest month with just 15% of oreders and 18% of profits.
- Q2 has the highest avg profit at $279 per order, 67% higher than Q4.

| | Q1 | Q2 | Q3 | Q4 |
|---|---|---|---|---|
|pct_orders |15%|16%|26%|43%|
|pct_profit |18%|21%|27%|34%|
|avg_profit |$253|$279|$222|$167|


**Daily**
- Weekend sees more orders per day on average, with 13.5% more orders placed on Saturdays and Sundays.
- Weekdays have slightly higher profits by a small margin, earning $13 more than weekend spending.
- Overall daily average of 3 orders per day, and $654 in profit.
- Most profitable day was November 22, 2023 with $4,629 - 7x more than the avg day.
- Only 3 of the 15 most profitable days are also in the 15 highest volume days.
  
**Hourly**
- 
- 

### 5.3 Category Performance  
profit & Margin by category, negative-profit days  

## 6. RFM Segmentation  
scoring method, segment results, customer personas  

## 7. Recomendations  

## 8. SQL & Notebook References  

## 9. Next Steps

