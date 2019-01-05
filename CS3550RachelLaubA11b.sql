---Rachel Laub
---CS3550
---Assignment 11b

/*1. Display the territory (ID, Name, CountryRegionCode, Group and Number of Customers) of the territory that has the most customers. */
SELECT sst.TerritoryID, sst.Name, sst.CountryRegionCode, sst.[group], COUNT(*) AS Num_Per_Territory
FROM Sales.SalesTerritory sst INNER JOIN Person.StateProvince psp
ON sst.TerritoryID = psp.TerritoryID
INNER JOIN Person.Address pa
ON psp.StateProvinceID = pa.StateProvinceID
INNER JOIN Person.BusinessEntityAddress pbea
ON pa.AddressID = pbea.AddressID
INNER JOIN Person.BusinessEntity pbe
ON pbea.BusinessEntityID = pbe.BusinessEntityID
INNER JOIN Person.Person pp
ON pbe.BusinessEntityID = pp.BusinessEntityID
WHERE pp.PersonType = 'IN'
GROUP BY sst.TerritoryID, sst.Name, sst.CountryRegionCode, sst.[group]
HAVING COUNT(*) =
(SELECT MAX(numterr)
FROM
	(SELECT sst.TerritoryID, sst.Name, sst.CountryRegionCode, sst.[group], COUNT(*) AS numterr
	FROM Sales.SalesTerritory sst INNER JOIN Person.StateProvince psp
	ON sst.TerritoryID = psp.TerritoryID
	INNER JOIN Person.Address pa
	ON psp.StateProvinceID = pa.StateProvinceID
	INNER JOIN Person.BusinessEntityAddress pbea
	ON pa.AddressID = pbea.AddressID
	INNER JOIN Person.BusinessEntity pbe
	ON pbea.BusinessEntityID = pbe.BusinessEntityID
	INNER JOIN Person.Person pp
	ON pbe.BusinessEntityID = pp.BusinessEntityID
	WHERE pp.PersonType = 'IN'
	GROUP BY sst.TerritoryID, sst.Name, sst.CountryRegionCode, sst.[group]) numberterr)
/*2. List the first employee (still with the company) hired in each department, in alphabetical order by department. The employee must still be in the department.*/
SELECT pp.FirstName, pp.LastName, hre.HireDate, hrd.Name AS Department
FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
INNER JOIN Person.Person pp
ON hre.BusinessEntityID = pp.BusinessEntityID
WHERE 
(hrd.Name = 'Production'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Production' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Finance'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Finance' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Document Control'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Document Control' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Engineering'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Engineering' AND hredp.EndDate IS NULL))
OR
( hrd.Name = 'Executive'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Executive' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Facilities and Maintenance'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Facilities and Maintenance' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Human Resources'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Human Resources' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Information Services'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Information Services' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Marketing'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Marketing' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Production Control'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Production Control' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Purchasing'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Purchasing' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Quality Assurance'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Quality Assurance' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Research and Development'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Research and Development' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Sales'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Sales' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Shipping and Receiving'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Shipping and Receiving' AND hredp.EndDate IS NULL))
OR
(hrd.Name = 'Tool Design'
AND
hre.HireDate = (SELECT MIN(HireDate) FROM HumanResources.Employee hre INNER JOIN HumanResources.EmployeeDepartmentHistory hredp
ON hre.BusinessEntityID = hredp.BusinessEntityID
INNER JOIN HumanResources.Department hrd
ON hredp.DepartmentID = hrd.DepartmentID
WHERE hrd.Name = 'Tool Design' AND hredp.EndDate IS NULL))
ORDER BY hrd.Name

/*3. List the first and last name and current pay rate of employees who have above average YTD sales. Sort by last name then first name*/
SELECT pp.FirstName, pp.LastName, hreph.Rate
FROM HumanResources.Employee hre INNER JOIN Person.Person pp
ON pp.BusinessEntityID = hre.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory hreph 
ON hreph.BusinessEntityID = hre.BusinessEntityID
INNER JOIN Sales.SalesPerson psp
ON psp.BusinessEntityID = hre.BusinessEntityID
WHERE psp.SalesYTD >(SELECT AVG(SalesYTD) FROM Sales.SalesPerson)
AND hreph.RateChangeDate = (SELECT MAX(RateChangeDate) FROM HumanResources.EmployeePayHistory
				WHERE BusinessEntityID = hre.BusinessEntityID)



/*4. Identify the currency of the foreign country with the highest total number of orders.*/
SELECT sc.Name, COUNT (*) AS Num_Currency
FROM Sales.SalesOrderHeader ssoh INNER JOIN Sales.CurrencyRate scr
ON ssoh.CurrencyRateID = scr.CurrencyRateID
INNER JOIN Sales.Currency sc
ON scr.ToCurrencyCode = sc.CurrencyCode
GROUP BY sc.Name
HAVING COUNT(*) =
	(SELECT MAX(currency_name)
	FROM 
	(SELECT sc.Name, COUNT (*) AS currency_name
FROM Sales.SalesOrderHeader ssoh INNER JOIN Sales.CurrencyRate scr
ON ssoh.CurrencyRateID = scr.CurrencyRateID
INNER JOIN Sales.Currency sc
ON scr.ToCurrencyCode = sc.CurrencyCode
GROUP BY sc.Name) curr)

/*5. Display the average amount of markup (unit price - standard cost) on bikes sold during June of 2008.*/
--SELECT 'Unable to complete Query <5>';




