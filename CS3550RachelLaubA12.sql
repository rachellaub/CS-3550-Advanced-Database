--1. Display the name of the day, the average online order sales subtotal and average in-store order sales subtotal for each day of the week (Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday). You should have days of the week as headers across the top and Online vs In store down the side

--Static
SELECT OrderedType, [Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday]
FROM
(SELECT CASE WHEN soh.OnlineOrderFlag = 0 THEN 'In-Store Order'
			 ELSE 'Online Order' END AS OrderedType, DATENAME(dw,soh.OrderDate) AS OrderDay, soh.TotalDue
FROM Sales.SalesOrderHeader soh) dataTable
PIVOT
(AVG(TotalDue)
FOR OrderDay IN ([Sunday], [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday]) )AS PivotTable
ORDER BY OrderedType
--Dynamic

DECLARE @Columns as VARCHAR(MAX)
SELECT @Columns = 
COALESCE(@Columns + ', ','') + QUOTENAME(OrderDate)
FROM
(SELECT DISTINCT OrderDate
FROM Sales.SalesOrderHeader) AS P
ORDER BY P.OrderDate

DECLARE @SQL as VARCHAR(MAX)
SET @SQL = 'SELECT OrderedType, ' + @Columns + N'
FROM(
SELECT soh.OnlineOrderFlag AS OrderedType, DATENAME(dw,soh.OrderDate) AS OrderDay, soh.TotalDue
FROM Sales.SalesOrderHeader soh) dataTable
PIVOT
(AVG(TotalDue)
FOR OrderDay IN (' + @Columns + ') )AS PivotTable
ORDER BY OrderedType'

--2. List each product category and the number of units sold by month.You should have names of the months as headers across the top and product categories down the side

--Static
SELECT CategoryName, [January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December]
FROM
(SELECT pc.Name AS CategoryName, sod.OrderQTY, DATENAME(mm,soh.OrderDate) AS OrderMonth
FROM Production.ProductCategory pc INNER JOIN Production.ProductSubcategory sc
ON pc.ProductCategoryID = sc.ProductCategoryID
INNER JOIN Production.Product pr
ON sc.ProductSubcategoryID = pr.ProductSubcategoryID
INNER JOIN Sales.SpecialOfferProduct sop
ON pr.ProductID = sop.ProductID
INNER JOIN Sales.SalesOrderDetail sod
ON sop.SpecialOfferID = sod.SpecialOfferID
AND sop.ProductID = sod.ProductID
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID = soh.SalesORderID) dataTable
PIVOT
(SUM(OrderQTY)
FOR OrderMonth IN ([January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
) AS PivotTable
ORDER BY CategoryName
--Dynamic

DECLARE @Columns as VARCHAR(MAX)
SELECT @Columns = 
COALESCE(@Columns + ', ','') + QUOTENAME(OrderDate)
FROM
(SELECT DISTINCT OrderDate
FROM Sales.SalesOrderHeader) AS P
ORDER BY P.OrderDate

DECLARE @SQL as VARCHAR(MAX)
SET @SQL = 'SELECT CategoryName, ' + @Columns + '
FROM(
SELECT pc.Name AS CategoryName, sod.OrderQTY, DATENAME(mm,soh.OrderDate) AS OrderMonth
FROM Production.ProductCategory pc INNER JOIN Production.ProductSubcategory sc
ON pc.ProductCategoryID = sc.ProductCategoryID
INNER JOIN Production.Product pr
ON sc.ProductSubcategoryID = pr.ProductSubcategoryID
INNER JOIN Sales.SpecialOfferProduct sop
ON pr.ProductID = sop.ProductID
INNER JOIN Sales.SalesOrderDetail sod
ON sop.SpecialOfferID = sod.SpecialOfferID
AND sop.ProductID = sod.ProductID
INNER JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID = soh.SalesORderID
) AS PivotData
PIVOT
(SUM(OrderQTY)
FOR OrderMonth IN (' + @Columns + ')
) AS PivotResult
ORDER BY CategoryName'
