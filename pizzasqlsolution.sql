SELECT * FROM pizza_sales

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_per_Order FROM pizza_sales

-- Daily Trend
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Hourly Trend
SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

SELECT * FROM pizza_sales

-- The percentage of pizza category sales for the whole year
SELECT pizza_category, SUM(total_price) AS Total_Sales, CAST(SUM(total_price) * 100 /(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10, 2)) AS PCT_Total_Sales FROM pizza_sales 
GROUP BY pizza_category

-- Percentage of pizza category sales by month
SELECT pizza_category, SUM(total_price) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales
WHERE MONTH(order_date) = 1) AS DECIMAL(10, 2)) AS PCT_Total_Sales FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- The percentage of pizza size sales for the whole year
SELECT pizza_size, SUM(total_price) AS Total_Sales, CAST(SUM(total_price) * 100 /(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10, 2)) AS PCT_Total_Sales FROM pizza_sales 
GROUP BY pizza_size

-- Percentage of pizza size sales by month
SELECT pizza_size, SUM(total_price) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales
WHERE MONTH(order_date) = 1) AS DECIMAL(10, 2)) AS PCT_Total_Sales FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_Total_Sales

SELECT pizza_category, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_category

-- Top 5 Best sellers by total pizza sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC

-- Bottom 5 worst sellers by total pizza sold
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity_Sold FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC