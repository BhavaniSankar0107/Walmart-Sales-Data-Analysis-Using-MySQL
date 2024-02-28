-- Creating database
CREATE DATABASE IF NOT EXISTS WalmartSalesData; 

-- Using the created database
USE WalmartSalesData;

-- Creating Table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(10) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    vat FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9) NOT NULL,
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1) NOT NULL
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------FEATURE ENGINEERING------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- We are going to alter table in this section by adding new columns. Make sure that safe mode is turned off to make changes
-- For turning off safe mode for update
-- Edit > Preferences > SQL Edito > scroll down and toggle safe mode
-- Reconnect to MySQL: Query > Reconnect to server

-- Feature 1: time of the day
SELECT 
	time,
	CASE 
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
        WHEN time BETWEEN '12:00:01' AND '16:00:00' THEN 'AFTERNOON'
        ELSE 'EVENING'
	END AS time_of_day 
FROM sales;

-- Adding the new column to the table
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- Updating the data to newly added column
UPDATE sales
SET time_of_day=(
	CASE 
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
        WHEN time BETWEEN '12:00:01' AND '16:00:00' THEN 'AFTERNOON'
        ELSE 'EVENING'
	END
);

-- Feature 2: day name
SELECT
	date,
    DAYNAME(date)
FROM sales;

-- Adding the new column to the table
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

-- Updating the data to newly added column
UPDATE sales
SET day_name = DAYNAME(date);

-- Feature 3: month name
SELECT
	date,
    MONTHNAME(date)
FROM sales;

-- Adding the new column to the table
ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);

-- Updating the data to newly added column
UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------GENERIC----------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- How many unique branches are there in the dataset? 
SELECT DISTINCT branch 
FROM sales; 

SELECT COUNT(DISTINCT branch) AS num_branches 
FROM sales;

-- What is the total number of transactions recorded in the dataset? 
SELECT COUNT(invoice_id) AS total_number_of_transactions 
FROM sales;

-- What is the average gross margin percentage across all transactions?
SELECT AVG(gross_margin_pct) AS average_gross_margin_percentage 
FROM sales;

-- What is the trend of total revenue over time, and can you identify any significant anomalies or patterns?
SELECT DATE(date) AS transaction_date, SUM(total) AS total_revenue
FROM sales
GROUP BY transaction_date
ORDER BY transaction_date;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------PRODUCT----------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the average quantity sold per product line?
SELECT product_line, AVG(quantity) AS average_quantity_sold 
FROM sales 
GROUP BY product_line;

-- Which payment method generates the highest average gross income per transaction? 
SELECT payment_method, AVG(gross_income) AS average_gross_income_per_transaction 
FROM sales 
GROUP BY payment_method 
ORDER BY average_gross_income_per_transaction DESC 
LIMIT 1;

-- How does the total revenue vary across different branches?
SELECT branch,SUM(total) AS total_revenue
FROM sales
GROUP BY branch
ORDER BY total_revenue DESC;

-- Identify the top 5 product lines that contribute the most to total revenue and their respective contribution percentages.
SELECT product_line, SUM(total) AS total_revenue, (SUM(total) / (SELECT SUM(total) FROM sales)) * 100 AS contribution_percentage
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 5;

-- Which branch sold more products than average product sold?
SELECT branch, SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT gender, product_line, COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating), 2) as avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------SALES-----------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the average revenue per transaction for each product line?
SELECT product_line, AVG(total) AS average_revenue_per_transaction 
FROM sales 
GROUP BY product_line;

-- How does the total revenue differ between weekdays and weekends?
SELECT 
    SUM(CASE WHEN DAYOFWEEK(date) BETWEEN 2 AND 6 THEN total ELSE 0 END) AS weekdays_total_revenue,
    SUM(CASE WHEN DAYOFWEEK(date) IN (1, 7) THEN total ELSE 0 END) AS weekends_total_revenue
FROM sales;

-- What is the average number of products sold per transaction per branch?
SELECT branch, AVG(quantity) AS avg_number_of_products_sold
FROM sales
GROUP BY branch;

-- Which customer type pays the most in VAT?
SELECT customer_type, AVG(vat) AS avg_tax
FROM sales
GROUP BY customer_type
ORDER BY avg_tax DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------CUSTOMER---------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
	
-- What is the distribution of customer types across different cities?
SELECT city, COUNT(customer_type='Normal') AS normal_customers, COUNT(customer_type='Member') AS member_customers
FROM sales
GROUP BY city;

-- Which gender tends to purchase higher-priced products on average?
SELECT gender,AVG(unit_price) AS average_unit_price
FROM sales
GROUP BY gender
ORDER BY average_unit_price DESC
LIMIT 1;

-- How does the average rating vary between different customer types? 
SELECT customer_type,AVG(rating) AS average_rating
FROM sales
GROUP BY customer_type;

-- Identify the product lines with the highest total revenue, considering the number of orders and average transaction value for each product line.
SELECT product_line, SUM(total) AS total_revenue, COUNT(total) AS number_of_orders, AVG(total) AS average_transaction_value
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------- BRANCH BASED QUESTIONS  --------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Which branch has the highest average quantity sold per transaction?
SELECT branch,AVG(quantity) AS average_quantity_sold
FROM sales
GROUP BY branch
ORDER BY average_quantity_sold DESC;

-- How does the average gross income per transaction vary between different branches? 
SELECT branch, AVG(gross_income) AS average_gross_income
FROM sales
GROUP BY branch
ORDER BY average_gross_income DESC;

-- Is there a relationship between branch location and average transaction value?
SELECT branch, AVG(total) AS average_transaction_value
FROM sales
GROUP BY branch
ORDER BY average_transaction_value DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------PRODUCT LINE BASED QUESTIONS-------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the average VAT percentage for each product line?
SELECT product_line, AVG(vat/total * 100) AS average_VAT_percentage
FROM sales
GROUP BY product_line;

-- How does the average rating of each product line compare across different branches? 
SELECT branch, product_line, AVG(rating) AS average_rating
FROM sales
GROUP BY branch,product_line;

-- Is there a relationship between product line popularity and the time of day? 
SELECT product_line, time_of_day, COUNT(*) AS popularity
FROM sales
GROUP BY product_line,time_of_day;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------CUSTOMER BASED QUESTIONS---------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What is the average spend per transaction for each customer type? 
SELECT customer_type, AVG(total) AS average_spend_per_transaction
FROM sales
GROUP BY customer_type;

-- How does the average rating given by customers vary between different genders?
SELECT gender, AVG(rating) AS average_rating
FROM sales
GROUP BY gender; 

-- Are there any seasonal trends in customer purchasing behavior?
SELECT month_name, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- How does the average rating given by customers vary between weekdays and weekends? 
SELECT 
    AVG(CASE WHEN DAYOFWEEK(date) BETWEEN 2 AND 6 THEN rating ELSE 0 END) AS weekdays_avg_rating,
    AVG(CASE WHEN DAYOFWEEK(date) IN (1, 7) THEN rating ELSE 0 END) AS weekends_avg_rating
FROM sales;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------OTHER QUESTIONS--------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Is there a correlation between the time of day and the average rating given by customers? 
SELECT time_of_day, AVG(rating) AS average_rating
FROM sales
GROUP BY time_of_day
ORDER BY average_rating DESC;

-- What is the correlation between product line popularity and average unit price?
SELECT product_line, AVG(unit_price) AS average_unit_price, COUNT(*) AS popularity
FROM sales
GROUP BY product_line;

-- How does the seasonality of sales impact total revenue?
SELECT month_name, SUM(total) AS total_revenue
FROM sales
GROUP BY month_name;