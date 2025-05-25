
-- 1. DimProduct
CREATE TABLE DWH.DimProduct (
    ProductKey INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductNumber NVARCHAR(50),
    Color NVARCHAR(30),
    Size NVARCHAR(20),
    StandardCost MONEY,
    ListPrice MONEY,
    SubcategoryName NVARCHAR(100),
    CategoryName NVARCHAR(100)
);

-- 2. DimCustomer
CREATE TABLE DWH.DimCustomer (
    CustomerKey INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmailAddress NVARCHAR(100),
    PhoneNumber NVARCHAR(20),
    AddressLine NVARCHAR(100),
    City NVARCHAR(50),
    StateProvince NVARCHAR(50),
    CountryRegion NVARCHAR(50),
    CustomerType NVARCHAR(20)
);

-- 3. DimStore
CREATE TABLE DWH.DimStore (
    StoreKey INT PRIMARY KEY,
    StoreName NVARCHAR(100),
    AddressLine NVARCHAR(100),
    City NVARCHAR(50),
    StateProvince NVARCHAR(50),
    CountryRegion NVARCHAR(50)
);

-- 4. DimSalesPerson
CREATE TABLE DWH.DimSalesPerson (
    SalesPersonKey INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmailAddress NVARCHAR(100),
    HireDate DATE,
    JobTitle NVARCHAR(50),
    Bonus MONEY,
    CommissionPct DECIMAL(5,2),
    SalesQuota MONEY,
    TerritoryName NVARCHAR(100)
);

-- 5. DimSpecialOffer
CREATE TABLE DWH.DimSpecialOffer (
    SpecialOfferKey INT PRIMARY KEY,
    Description NVARCHAR(200),
    DiscountPct DECIMAL(5,2),
    Type NVARCHAR(50),
    Category NVARCHAR(50),
    StartDate DATE,
    EndDate DATE
);

-- 6. DimSalesTerritory
CREATE TABLE DWH.DimSalesTerritory (
    SalesTerritoryKey INT PRIMARY KEY,
    TerritoryName NVARCHAR(100),
    CountryRegionCode NVARCHAR(10),
    GroupName NVARCHAR(50)
);

-- 7. DimDate
CREATE TABLE DWH.DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    DayNumberOfMonth TINYINT,
    MonthNumber TINYINT,
    MonthName NVARCHAR(20),
    QuarterNumber TINYINT,
    Year INT,
    DayName NVARCHAR(20),
    IsWeekend BIT
);

-- 8. FactSales (without foreign keys)
CREATE TABLE DWH.FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductKey INT,
    CustomerKey INT,
    StoreKey INT,
    SalesPersonKey INT,
    SpecialOfferKey INT,
    TerritoryKey INT,
    OrderDateKey INT,
    OrderQty INT,
    UnitPrice MONEY,
    UnitPriceDiscount MONEY,
    TotalDue MONEY
);
