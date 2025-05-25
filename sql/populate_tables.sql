
-- ================================
-- Populate DimProduct
-- ================================
INSERT INTO DWH.DimProduct (
    ProductKey,
    ProductName,
    ProductNumber,
    Color,
    Size,
    StandardCost,
    ListPrice,
    SubcategoryName,
    CategoryName
)
SELECT
    p.ProductID,
    p.Name,
    p.ProductNumber,
    p.Color,
    p.Size,
    p.StandardCost,
    p.ListPrice,
    ps.Name AS SubcategoryName,
    pc.Name AS CategoryName
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID;

-- ================================
-- Populate DimCustomer
-- ================================
INSERT INTO DWH.DimCustomer (
    CustomerKey,
    FirstName,
    LastName,
    EmailAddress,
    PhoneNumber,
    AddressLine,
    City,
    StateProvince,
    CountryRegion,
    CustomerType
)
SELECT
    c.CustomerID,
    p.FirstName,
    p.LastName,
    ea.EmailAddress,
    ph.PhoneNumber,
    a.AddressLine1,
    a.City,
    sp.Name AS StateProvince,
    cr.Name AS CountryRegion,
    'Individual' AS CustomerType
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID
LEFT JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
LEFT JOIN Person.Address a ON bea.AddressID = a.AddressID
LEFT JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
LEFT JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
WHERE c.StoreID IS NULL;

-- ================================
-- Populate DimSalesPerson
-- ================================
INSERT INTO DWH.DimSalesPerson (
    SalesPersonKey,
    FirstName,
    LastName,
    EmailAddress,
    HireDate,
    JobTitle,
    Bonus,
    CommissionPct,
    SalesQuota,
    TerritoryName
)
SELECT
    sp.BusinessEntityID,
    p.FirstName,
    p.LastName,
    ea.EmailAddress,
    e.HireDate,
    e.JobTitle,
    sp.Bonus,
    sp.CommissionPct,
    sp.SalesQuota,
    st.Name AS TerritoryName
FROM Sales.SalesPerson sp
JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
LEFT JOIN Person.EmailAddress ea ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Sales.SalesTerritory st ON sp.TerritoryID = st.TerritoryID;

-- ================================
-- Populate DimSpecialOffer
-- ================================
INSERT INTO DWH.DimSpecialOffer (
    SpecialOfferKey,
    Description,
    DiscountPct,
    Type,
    Category,
    StartDate,
    EndDate
)
SELECT
    SpecialOfferID,
    Description,
    DiscountPct,
    Type,
    Category,
    StartDate,
    EndDate
FROM Sales.SpecialOffer;

-- ================================
-- Populate DimSalesTerritory
-- ================================
INSERT INTO DWH.DimSalesTerritory (
    SalesTerritoryKey,
    TerritoryName,
    CountryRegionCode,
    GroupName
)
SELECT
    TerritoryID,
    Name,
    CountryRegionCode,
    [Group]
FROM Sales.SalesTerritory;

-- ================================
-- Populate DimStore
-- ================================
INSERT INTO DWH.DimStore (
    StoreKey,
    StoreName,
    AddressLine,
    City,
    StateProvince,
    CountryRegion
)
SELECT
    s.BusinessEntityID,
    s.Name,
    a.AddressLine1,
    a.City,
    sp.Name AS StateProvince,
    cr.Name AS CountryRegion
FROM Sales.Store s
JOIN Person.BusinessEntityAddress bea ON s.BusinessEntityID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode;

-- ================================
-- Populate DimDate
-- ================================
DECLARE @Date DATE = '2003-01-01';
WHILE @Date <= '2016-12-31'
BEGIN
    INSERT INTO DWH.DimDate (
        DateKey,
        FullDate,
        DayNumberOfMonth,
        MonthNumber,
        MonthName,
        QuarterNumber,
        Year,
        DayName,
        IsWeekend
    )
    VALUES (
        CONVERT(INT, FORMAT(@Date, 'yyyyMMdd')),
        @Date,
        DAY(@Date),
        MONTH(@Date),
        DATENAME(MONTH, @Date),
        DATEPART(QUARTER, @Date),
        YEAR(@Date),
        DATENAME(WEEKDAY, @Date),
        CASE WHEN DATEPART(WEEKDAY, @Date) IN (1, 7) THEN 1 ELSE 0 END
    );
    SET @Date = DATEADD(DAY, 1, @Date);
END;

-- ================================
-- Populate FactSales
-- ================================
INSERT INTO DWH.FactSales (
    ProductKey,
    CustomerKey,
    StoreKey,
    SalesPersonKey,
    SpecialOfferKey,
    TerritoryKey,
    OrderDateKey,
    OrderQty,
    UnitPrice,
    UnitPriceDiscount,
    TotalDue
)
SELECT
    sod.ProductID,
    soh.CustomerID,
    c.StoreID,
    soh.SalesPersonID,
    sod.SpecialOfferID,
    soh.TerritoryID,
    CONVERT(INT, FORMAT(soh.OrderDate, 'yyyyMMdd')),
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID;
