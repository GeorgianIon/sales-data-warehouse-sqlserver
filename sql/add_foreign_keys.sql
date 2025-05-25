
-- Add foreign keys for FactSales table

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_Product
FOREIGN KEY (ProductKey) REFERENCES DWH.DimProduct(ProductKey);

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_Customer
FOREIGN KEY (CustomerKey) REFERENCES DWH.DimCustomer(CustomerKey);

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_Store
FOREIGN KEY (StoreKey) REFERENCES DWH.DimStore(StoreKey);

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_SalesPerson
FOREIGN KEY (SalesPersonKey) REFERENCES DWH.DimSalesPerson(SalesPersonKey);

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_SpecialOffer
FOREIGN KEY (SpecialOfferKey) REFERENCES DWH.DimSpecialOffer(SpecialOfferKey);

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_Territory
FOREIGN KEY (TerritoryKey) REFERENCES DWH.DimSalesTerritory(SalesTerritoryKey);

ALTER TABLE DWH.FactSales
ADD CONSTRAINT FK_FactSales_OrderDate
FOREIGN KEY (OrderDateKey) REFERENCES DWH.DimDate(DateKey);
