-- SQL Task – Customer Orders, Revenue & Product Performance

-- SECTION 1: OVERALL SALES ANALYSIS

-- 1. Total Number of Orders

SELECT
    COUNT(DISTINCT "Order ID") AS Total_Orders
FROM Raw_Sales;


-- 2. Total Revenue

SELECT
    ROUND(SUM("Sales"), 2) AS Total_Revenue
FROM Raw_Sales;


-- 3. Total Profit

SELECT
    ROUND(SUM("Profit"), 2) AS Total_Profit
FROM Raw_Sales;


-- 4. Overall Business Performance

SELECT
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    COUNT(DISTINCT "Customer ID") AS Total_Customers,
    ROUND(SUM("Sales"), 2) AS Total_Revenue,
    ROUND(SUM("Profit"), 2) AS Total_Profit,
    ROUND(AVG("Sales"), 2) AS Average_Order_Value
FROM Raw_Sales;


-- SECTION 2: CUSTOMER ORDER ANALYSIS

-- 5. Customer-wise Order Analysis

SELECT
    "Customer ID",
    "Customer Name",
    COUNT(DISTINCT "Order ID") AS Total_Orders
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY Total_Orders DESC;


-- 6. Customer-wise Revenue

SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM("Sales"), 2) AS Total_Revenue
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY Total_Revenue DESC;


-- 7. Top 5 Customers by Revenue

SELECT
    "Customer Name",
    ROUND(SUM("Sales"), 2) AS Total_Revenue
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY Total_Revenue DESC
LIMIT 5;


-- 8. Regional Sales Analysis
SELECT
    Region,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Raw_Sales
GROUP BY Region
ORDER BY Total_Revenue DESC;


-- 9. Product-wise Sales Performance
SELECT
    TRIM(Product) AS Product,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Raw_Sales
GROUP BY TRIM(Product)
ORDER BY Total_Revenue DESC;


-- 10. Top 5 Products by Revenue
SELECT
    TRIM(Product) AS Product,
    ROUND(SUM(Sales), 2) AS Total_Revenue
FROM Raw_Sales
GROUP BY TRIM(Product)
ORDER BY Total_Revenue DESC
LIMIT 5;


-- 11. Category-wise Sales Analysis
SELECT
    Category,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Raw_Sales
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- 12. Monthly Revenue Analysis
SELECT
    STRFTIME('%Y-%m', "Order Date") AS Sales_Month,
    ROUND(SUM(Sales), 2) AS Monthly_Revenue,
    ROUND(SUM(Profit), 2) AS Monthly_Profit
FROM Raw_Sales
GROUP BY STRFTIME('%Y-%m', "Order Date")
ORDER BY Sales_Month;

-- validation queries
-- 13. Check Total Records
SELECT
    COUNT(*) AS Total_Records
FROM Raw_Sales;


-- 14. Check Duplicate Orders
SELECT
    "Order ID",
    COUNT(*) AS Duplicate_Count
FROM Raw_Sales
GROUP BY "Order ID"
HAVING COUNT(*) > 1;


-- 15. Check Missing Values
SELECT
    SUM(CASE WHEN TRIM(COALESCE("Order ID", '')) = '' THEN 1 ELSE 0 END) AS Missing_Order_ID,
    SUM(CASE WHEN TRIM(COALESCE("Customer ID", '')) = '' THEN 1 ELSE 0 END) AS Missing_Customer_ID,
    SUM(CASE WHEN TRIM(COALESCE(Product, '')) = '' THEN 1 ELSE 0 END) AS Missing_Product,
    SUM(CASE WHEN "Sales" IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
    SUM(CASE WHEN "Profit" IS NULL THEN 1 ELSE 0 END) AS Missing_Profit
FROM Raw_Sales;


-- 16. Check Product Catalog
SELECT *
FROM Product_Catalog;


-- 17. Identify Products Missing from Catalog
SELECT DISTINCT
    TRIM(r.Product) AS Product_Not_In_Catalog
FROM Raw_Sales r
LEFT JOIN Product_Catalog p
    ON TRIM(r.Product) = TRIM(p.Product)
WHERE TRIM(COALESCE(r.Product, '')) <> ''
  AND p.Product IS NULL;


-- 18. Final Sales Summary
SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    COUNT(DISTINCT "Customer ID") AS Total_Customers,
    COUNT(DISTINCT TRIM(Product)) AS Total_Products,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Average_Sales_Per_Record
FROM Raw_Sales;