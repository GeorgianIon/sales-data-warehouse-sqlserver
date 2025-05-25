
-- 1. Total sales per product category
SELECT  
    p.CategoryName, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.CategoryName
ORDER BY TotalSales DESC;

-- 2. Sales per calendar year
SELECT  
    d.Year, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimDate d ON f.OrderDateKey = d.DateKey
GROUP BY d.Year
ORDER BY d.Year;

-- 3. Total sales by city (individual customers)
SELECT  
    c.City, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.City
ORDER BY TotalSales DESC;

-- 4. Sales per sales territory
SELECT  
    t.TerritoryName,
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimSalesTerritory t ON f.TerritoryKey = t.SalesTerritoryKey
GROUP BY t.TerritoryName
ORDER BY TotalSales DESC;

-- 5. Top salespeople by commission
SELECT  
    s.FirstName + ' ' + s.LastName AS SalesPerson,
    SUM(f.TotalDue) AS TotalSales, 
    s.CommissionPct
FROM DWH.FactSales f
JOIN DWH.DimSalesPerson s ON f.SalesPersonKey = s.SalesPersonKey
GROUP BY s.FirstName, s.LastName, s.CommissionPct
ORDER BY TotalSales DESC;

-- 6. Total sales by year and category (CUBE)
SELECT  
    ISNULL(CONVERT(VARCHAR, d.Year), 'Total Year') AS Year, 
    ISNULL(p.CategoryName, 'Total Categories') AS Category, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimDate d ON f.OrderDateKey = d.DateKey
JOIN DWH.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY CUBE(d.Year, p.CategoryName);

-- 7. Sales per month and year (ROLLUP)
SELECT  
    ISNULL(CONVERT(VARCHAR, d.Year), 'Total Year') AS Year, 
    ISNULL(CONVERT(VARCHAR, d.Month), 'Total Month') AS Month, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimDate d ON f.OrderDateKey = d.DateKey
GROUP BY ROLLUP(d.Year, d.Month);

-- 8. Sales by product category and store (CUBE)
SELECT  
    ISNULL(s.StoreName, 'Total Stores') AS Store, 
    ISNULL(p.CategoryName, 'Total Categories') AS Category, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimStore s ON f.StoreKey = s.StoreKey
JOIN DWH.DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY CUBE(s.StoreName, p.CategoryName);

-- 9. Slice: Sales for year 2013 only
SELECT  
    p.CategoryName, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimProduct p ON f.ProductKey = p.ProductKey
JOIN DWH.DimDate d ON f.OrderDateKey = d.DateKey
WHERE d.Year = 2013
GROUP BY p.CategoryName;

-- 10. Total sales by salesperson and year (ROLLUP)
SELECT  
    ISNULL(s.FirstName + ' ' + s.LastName, 'Total Salespeople') AS Salesperson,
    ISNULL(CONVERT(VARCHAR, d.Year), 'Total Years') AS Year, 
    SUM(f.TotalDue) AS TotalSales
FROM DWH.FactSales f
JOIN DWH.DimSalesPerson s ON f.SalesPersonKey = s.SalesPersonKey
JOIN DWH.DimDate d ON f.OrderDateKey = d.DateKey
GROUP BY ROLLUP(s.FirstName, s.LastName, d.Year);
