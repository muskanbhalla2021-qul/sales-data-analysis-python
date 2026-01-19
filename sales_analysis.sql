-- Total and average bill amount by day
SELECT 
  day,
  COUNT(*) AS total_orders,
  SUM(total_bill) AS total_sales,
  AVG(total_bill) AS avg_bill
FROM sales
GROUP BY day;

-- Compare sales between Lunch and Dinner
SELECT 
  time,
  COUNT(*) AS total_orders,
  SUM(total_bill) AS total_sales,
  AVG(total_bill) AS avg_bill
FROM sales
GROUP BY time;

-- Calculate tip percentage per transaction
SELECT
  total_bill,
  tip,
  ROUND((tip / total_bill) * 100, 2) AS tip_percent
FROM sales;

-- Average tip percentage by day using CTE
WITH tip_analysis AS (
  SELECT
    day,
    (tip / total_bill) * 100 AS tip_percent
  FROM sales
)
SELECT
  day,
  ROUND(AVG(tip_percent), 2) AS avg_tip_percent
FROM tip_analysis
GROUP BY day;

-- Rank days by total sales
SELECT
  day,
  SUM(total_bill) AS total_sales,
  RANK() OVER (ORDER BY SUM(total_bill) DESC) AS sales_rank
FROM sales
GROUP BY day;

-- Identify high-value orders
SELECT *
FROM sales
WHERE total_bill > (
  SELECT AVG(total_bill)
  FROM sales
);
