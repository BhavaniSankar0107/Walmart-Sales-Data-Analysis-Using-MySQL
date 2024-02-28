# Walmart-Sales-Data-Analysis-Using-MySQL

## Overview
  This project aims to explore the Walmart Sales data to understand the top-performing branches and products, sales trends of different products, and customer behavior. The goal is to gain insights into the factors affecting sales at various branches and to identify strategies for optimizing sales performance. The dataset used in this analysis was obtained from the Kaggle Walmart Sales Forecasting Competition.

## Purposes Of The Project
The main objectives of this project are: 
1. To analyze sales data to identify top-performing branches and products. 
2. To understand sales trends and patterns for different product lines. 
3. To explore customer behavior and segment customers based on their purchasing patterns. 
4. To derive actionable insights for improving sales strategies and optimizing business performance. 

## Dataset

The dataset was obtained from the Kaggle. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(10)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                     | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(12, 4) |
| date                    | The date on which the purchase was made | DATETIME       |
| time                    | The time at which the purchase was made | TIME           |
| payment_method          | The total amount paid                   | VARCHAR(15)    |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(12, 4) |
| rating                  | Rating                                  | FLOAT(2, 1)    |


## Approach Used
Data Wrangling: The dataset is inspected for missing or null values, and necessary data cleaning steps are performed.

Feature Engineering: Additional columns such as time of day, day name, and month name are created from existing columns to facilitate deeper analysis.

Exploratory Data Analysis (EDA): Various analyses are conducted to answer specific questions and gain insights into sales trends, customer behavior, and product performance.

## Calculations used
1. Cost Of Goods Sold (COGS): Unit Price * Quantity 
2. VAT: 5% of COGS 
3. Total Revenue: VAT + COGS 
4. Gross Income: Total Revenue - COGS 
5. Gross Margin Percentage: Gross Income / Total Revenue 

## Questions
### Generic:
1. How many unique branches are there in the dataset? [Easy] 
2. What is the total number of transactions recorded in the dataset? [Easy] 
3. What is the average gross margin percentage across all transactions? [Medium] 
4. What is the trend of total revenue over time, and can you identify any significant anomalies or patterns? [Hard]

### Product:
1. What is the average quantity sold per product line? [Medium]  
2. Which payment method generates the highest average gross income per transaction? [Medium] 
3. How does the total revenue vary across different branches? [Medium] 
4. Identify the top 5 product lines that contribute the most to total revenue and their respective contribution percentages. [Medium] 
5. Which branch sold more products than average product sold? [Medium] 
6. What is the most common product line by gender? [Medium] 
7. What is the average rating of each product line? [Medium] 

### Sales:
1. What is the average revenue per transaction for each product line? [Medium] 
2. How does the total revenue differ between weekdays and weekends? [Hard] 
3. What is the average number of products sold per transaction per branch? [Medium] 
4. Which customer type pays the most in VAT? [Medium] 

### Customer:
1. What is the distribution of customer types across different cities? [Medium] 
2. Which gender tends to purchase higher-priced products on average? [Medium] 
3. How does the average rating vary between different customer types? [Medium] 
4. Identify the product lines with the highest total revenue, considering the number of orders and average transaction value for each product line [Medium] 

### Branch Based Questions:
1. Which branch has the highest average quantity sold per transaction? [Medium] 
2. How does the average gross income per transaction vary between different branches? [Medium] 
3. Is there a relationship between branch location and average transaction value? [Medium] 

### Product Type Based Questions:
1. What is the average VAT percentage for each product line? [Medium] 
2. How does the average rating of each product line compare across different branches? [Medium] 
3. Is there a relationship between product line popularity and the time of day? [Medium] 

### Customer Based Questions:
1. What is the average spend per transaction for each customer type? [Medium] 
2. How does the average rating given by customers vary between different genders? [Medium] 
3. Are there any seasonal trends in customer purchasing behavior? [Medium] 
4. How does the average rating given by customers vary between weekdays and weekends? [Hard] 

### Other Questions:
1. Is there a correlation between the time of day and the average rating given by customers? [Hard] 
2. What is the correlation between product line popularity and average unit price? [Hard] 
3. How does the seasonality of sales impact total revenue? [Hard] 

## Conclusion
This analysis provides valuable insights into Walmart sales data, helping to understand sales trends, customer preferences, and branch performance. By identifying key factors influencing sales and customer behavior, Walmart can make informed decisions to improve sales strategies and optimize business performance.
