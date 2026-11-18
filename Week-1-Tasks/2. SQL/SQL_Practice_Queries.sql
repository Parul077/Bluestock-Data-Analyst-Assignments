-- Practice 1: Retrieve all sales records
SELECT * FROM Raw_Sales;

-- Practice 2: Select specific columns
SELECT
    "Order ID",
    "Customer Name",
    "Product",
    "Sales"
FROM Raw_Sales;

-- Practice 3: Retrieve unique product categories
SELECT DISTINCT "Category"
FROM Raw_Sales;

-- Practice 4: Retrieve unique regions
SELECT DISTINCT "Region"
FROM Raw_Sales;

-- Practice 5: Count total records
SELECT COUNT(*) AS Total_Records
FROM Raw_Sales;

-- Practice 6: Find sales from the North region
SELECT *
FROM Raw_Sales
WHERE "Region" = 'North';

-- Practice 7: Find orders with sales greater than 10000
SELECT *
FROM Raw_Sales
WHERE "Sales" > 10000;

-- Practice 8: Find orders with profit greater than 5000
SELECT *
FROM Raw_Sales
WHERE "Profit" > 5000;

-- Practice 9: Find orders from Electronics category
SELECT *
FROM Raw_Sales
WHERE "Category" = 'Electronics';

-- Practice 10: Find orders with quantity greater than 3
SELECT *
FROM Raw_Sales
WHERE "Quantity" > 3;


-- Practice 11: Use multiple conditions
SELECT *
FROM Raw_Sales
WHERE "Region" = 'West'
AND "Sales" > 10000;


-- Practice 12: Use OR condition
SELECT *
FROM Raw_Sales
WHERE "Category" = 'Electronics'
OR "Category" = 'Furniture';


-- Practice 13: Use BETWEEN
SELECT *
FROM Raw_Sales
WHERE "Sales" BETWEEN 10000 AND 50000;


-- Practice 14: Use IN
SELECT *
FROM Raw_Sales
WHERE "Region" IN ('North', 'South');


-- Practice 15: Search customer names using LIKE
SELECT *
FROM Raw_Sales
WHERE "Customer Name" LIKE 'A%';

-- Practice 16: Sort sales from highest to lowest
SELECT *
FROM Raw_Sales
ORDER BY "Sales" DESC;


-- Practice 17: Sort profit from lowest to highest
SELECT *
FROM Raw_Sales
ORDER BY "Profit" ASC;


-- Practice 18: Sort by quantity
SELECT *
FROM Raw_Sales
ORDER BY "Quantity" DESC;


-- Practice 19: Show top 10 highest sales
SELECT *
FROM Raw_Sales
ORDER BY "Sales" DESC
LIMIT 10;


-- Practice 20: Show top 5 profitable orders
SELECT *
FROM Raw_Sales
ORDER BY "Profit" DESC
LIMIT 5;

-- Practice 21: Calculate total revenue
SELECT SUM("Sales") AS Total_Revenue
FROM Raw_Sales;


-- Practice 22: Calculate total profit
SELECT SUM("Profit") AS Total_Profit
FROM Raw_Sales;


-- Practice 23: Calculate average sales
SELECT AVG("Sales") AS Average_Sales
FROM Raw_Sales;


-- Practice 24: Find highest sales value
SELECT MAX("Sales") AS Highest_Sale
FROM Raw_Sales;


-- Practice 25: Find lowest sales value
SELECT MIN("Sales") AS Lowest_Sale
FROM Raw_Sales;


-- Practice 26: Calculate total quantity sold
SELECT SUM("Quantity") AS Total_Quantity_Sold
FROM Raw_Sales;


-- Practice 27: Count unique customers
SELECT COUNT(DISTINCT "Customer ID") AS Total_Customers
FROM Raw_Sales;

-- Practice 28: Revenue by region
SELECT
    "Region",
    SUM("Sales") AS Total_Revenue
FROM Raw_Sales
GROUP BY "Region";


-- Practice 29: Revenue by category
SELECT
    "Category",
    SUM("Sales") AS Total_Revenue
FROM Raw_Sales
GROUP BY "Category";


-- Practice 30: Profit by region
SELECT
    "Region",
    SUM("Profit") AS Total_Profit
FROM Raw_Sales
GROUP BY "Region";


-- Practice 31: Total quantity sold by product
SELECT
    "Product",
    SUM("Quantity") AS Total_Quantity
FROM Raw_Sales
GROUP BY "Product";


-- Practice 32: Number of orders by city
SELECT
    "City",
    COUNT(*) AS Total_Orders
FROM Raw_Sales
GROUP BY "City";


-- Practice 33: Revenue by region and category
SELECT
    "Region",
    "Category",
    SUM("Sales") AS Total_Revenue
FROM Raw_Sales
GROUP BY "Region", "Category";

-- Practice 34: Regions with revenue above 2000000
SELECT
    "Region",
    SUM("Sales") AS Total_Revenue
FROM Raw_Sales
GROUP BY "Region"
HAVING SUM("Sales") > 2000000;


-- Practice 35: Categories with profit above 100000
SELECT
    "Category",
    SUM("Profit") AS Total_Profit
FROM Raw_Sales
GROUP BY "Category"
HAVING SUM("Profit") > 100000;


-- Practice 36: Customers with more than 5 orders
SELECT
    "Customer ID",
    "Customer Name",
    COUNT(*) AS Total_Orders
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name"
HAVING COUNT(*) > 5;


-- Practice 37: Products with average sales above 10000
SELECT
    "Product",
    AVG("Sales") AS Average_Sales
FROM Raw_Sales
GROUP BY "Product"
HAVING AVG("Sales") > 10000;


-- JOINs – Combine multiple tables

PRAGMA table_info(Product_Catalog);

-- Practice 38: INNER JOIN
SELECT
    r."Order ID",
    r."Product",
    r."Sales",
    p.*
FROM Raw_Sales r
INNER JOIN Product_Catalog p
    ON r."Product" = p."Product";

-- Practice 39: LEFT JOIN
SELECT
    r."Order ID",
    r."Product",
    r."Sales",
    p.*
FROM Raw_Sales r
LEFT JOIN Product_Catalog p
    ON r."Product" = p."Product";

-- Practice 40: Find products without a catalog match
SELECT
    r."Product",
    COUNT(*) AS Total_Orders
FROM Raw_Sales r
LEFT JOIN Product_Catalog p
    ON r."Product" = p."Product"
WHERE p."Product" IS NULL
GROUP BY r."Product";

-- Verifying missing product
SELECT
    "Order ID",
    "Product",
    "Category",
    "Sales"
FROM Raw_Sales
WHERE "Product" = 'Laptop'
   OR "Product" IS NULL;

SELECT *
FROM Product_Catalog;

SELECT DISTINCT
    '[' || "Product" || ']' AS Product_Name,
    LENGTH("Product") AS Name_Length
FROM Raw_Sales
WHERE "Product" LIKE '%Laptop%';

SELECT
    r."Order ID",
    '[' || r."Product" || ']' AS Sales_Product,
    '[' || p."Product" || ']' AS Catalog_Product
FROM Raw_Sales r
LEFT JOIN Product_Catalog p
    ON TRIM(r."Product") = TRIM(p."Product")
WHERE TRIM(r."Product") = 'Laptop';

SELECT
    "Order ID",
    "Customer Name",
    "Product",
    "Sales"
FROM Raw_Sales
WHERE "Product" IS NULL
   OR TRIM("Product") = '';

SELECT
    r."Product",
    COUNT(*) AS Total_Orders
FROM Raw_Sales r
LEFT JOIN Product_Catalog p
    ON TRIM(r."Product") = TRIM(p."Product")
WHERE p."Product" IS NULL
GROUP BY r."Product";

SELECT
    "Order ID",
    "Customer Name",
    "Product",
    "Sales"
FROM Raw_Sales
WHERE "Product" IS NULL
   OR TRIM("Product") = '';

SELECT
    "Order ID",
    '[' || "Product" || ']' AS Product_Value,
    LENGTH("Product") AS Product_Length,
    HEX("Product") AS Product_Hex
FROM Raw_Sales
WHERE "Product" IS NOT NULL
  AND TRIM("Product") = '';

SELECT
    COUNT(*) AS Total_Empty_Rows
FROM Raw_Sales
WHERE
    TRIM(COALESCE("Order ID", '')) = ''
    AND TRIM(COALESCE("Order Date", '')) = ''
    AND TRIM(COALESCE("Customer ID", '')) = ''
    AND TRIM(COALESCE("Customer Name", '')) = ''
    AND TRIM(COALESCE("Product", '')) = ''
    AND TRIM(COALESCE("Category", '')) = ''
    AND TRIM(COALESCE("Region", '')) = '';

SELECT
    COUNT(*) AS Total_Rows,
    COUNT("Product") AS Non_Null_Products,
    SUM(CASE
        WHEN TRIM(COALESCE("Product", '')) = ''
        THEN 1 ELSE 0
    END) AS Empty_Products
FROM Raw_Sales;

SELECT
    COUNT(*) AS Total_Records,

    SUM(CASE
        WHEN TRIM(COALESCE("Order ID", '')) = ''
        THEN 1 ELSE 0
    END) AS Missing_Order_ID,

    SUM(CASE
        WHEN TRIM(COALESCE("Order Date", '')) = ''
        THEN 1 ELSE 0
    END) AS Missing_Order_Date,

    SUM(CASE
        WHEN TRIM(COALESCE("Customer Name", '')) = ''
        THEN 1 ELSE 0
    END) AS Missing_Customer_Name,

    SUM(CASE
        WHEN TRIM(COALESCE("Product", '')) = ''
        THEN 1 ELSE 0
    END) AS Missing_Product,

    SUM(CASE
        WHEN TRIM(COALESCE("Sales", '')) = ''
        THEN 1 ELSE 0
    END) AS Missing_Sales

FROM Raw_Sales;


SELECT
    "Order ID",
    "Order Date",
    "Customer ID",
    "Customer Name",
    "Product",
    "Sales"
FROM Raw_Sales
WHERE
    TRIM(COALESCE("Order ID", '')) = ''
    OR TRIM(COALESCE("Order Date", '')) = ''
    OR TRIM(COALESCE("Customer Name", '')) = ''
    OR TRIM(COALESCE("Product", '')) = ''
    OR TRIM(COALESCE("Sales", '')) = '';


DELETE FROM Raw_Sales
WHERE
    TRIM(COALESCE("Order ID", '')) = ''
    AND TRIM(COALESCE("Order Date", '')) = ''
    AND TRIM(COALESCE("Customer ID", '')) = ''
    AND TRIM(COALESCE("Customer Name", '')) = ''
    AND TRIM(COALESCE("Product", '')) = ''
    AND TRIM(COALESCE("Category", '')) = ''
    AND TRIM(COALESCE("Region", '')) = '';

SELECT COUNT(*) AS Total_Records
FROM Raw_Sales;


-- Finding customers who placed more than 3 orders
SELECT
    "Customer ID",
    "Customer Name",
    COUNT(DISTINCT "Order ID") AS Total_Orders
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name"
HAVING COUNT(DISTINCT "Order ID") > 3
ORDER BY Total_Orders DESC;

-- Finding regions with revenue greater than ₹10 lakh
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Revenue
FROM Raw_Sales
GROUP BY Region
HAVING SUM(Sales) > 1000000
ORDER BY Total_Revenue DESC;

-- Find products with total quantity sold greater than 20
SELECT
    TRIM(Product) AS Product,
    SUM(Quantity) AS Total_Quantity
FROM Raw_Sales
GROUP BY TRIM(Product)
HAVING SUM(Quantity) > 20;

-- Subqueries

-- Find customers whose revenue is above average customer revenue

SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM(Sales), 2) AS Customer_Revenue
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name"
HAVING SUM(Sales) > (
    SELECT AVG(Customer_Revenue)
    FROM (
        SELECT SUM(Sales) AS Customer_Revenue
        FROM Raw_Sales
        GROUP BY "Customer ID"
    )
)
ORDER BY Customer_Revenue DESC;


-- Find products whose revenue is above average product revenue

SELECT
    TRIM(Product) AS Product,
    ROUND(SUM(Sales), 2) AS Product_Revenue
FROM Raw_Sales
GROUP BY TRIM(Product)
HAVING SUM(Sales) > (
    SELECT AVG(Product_Revenue)
    FROM (
        SELECT SUM(Sales) AS Product_Revenue
        FROM Raw_Sales
        GROUP BY TRIM(Product)
    )
);


-- Find the highest-value order

SELECT
    "Order ID",
    ROUND(SUM(Sales), 2) AS Order_Value
FROM Raw_Sales
GROUP BY "Order ID"
HAVING SUM(Sales) = (
    SELECT MAX(Order_Value)
    FROM (
        SELECT SUM(Sales) AS Order_Value
        FROM Raw_Sales
        GROUP BY "Order ID"
    )
);


-- Window Functions

-- Rank customers by revenue

SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Revenue_Rank
FROM Raw_Sales
GROUP BY "Customer ID", "Customer Name";


-- Rank products within each category

SELECT *
FROM (
    SELECT
        Category,
        TRIM(Product) AS Product,
        ROUND(SUM(Sales), 2) AS Total_Revenue,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Product_Rank
    FROM Raw_Sales
    GROUP BY Category, TRIM(Product)
)
ORDER BY Category, Product_Rank;


-- Calculate running monthly revenue

SELECT
    Sales_Month,
    Monthly_Revenue,
    ROUND(
        SUM(Monthly_Revenue) OVER (
            ORDER BY Sales_Month
        ), 2
    ) AS Running_Revenue
FROM (
    SELECT
        STRFTIME('%Y-%m', "Order Date") AS Sales_Month,
        SUM(Sales) AS Monthly_Revenue
    FROM Raw_Sales
    GROUP BY STRFTIME('%Y-%m', "Order Date")
)
ORDER BY Sales_Month;


-- Compare each month's revenue with the previous month

SELECT
    Sales_Month,
    Monthly_Revenue,
    LAG(Monthly_Revenue) OVER (
        ORDER BY Sales_Month
    ) AS Previous_Month_Revenue
FROM (
    SELECT
        STRFTIME('%Y-%m', "Order Date") AS Sales_Month,
        ROUND(SUM(Sales), 2) AS Monthly_Revenue
    FROM Raw_Sales
    GROUP BY STRFTIME('%Y-%m', "Order Date")
)
ORDER BY Sales_Month;