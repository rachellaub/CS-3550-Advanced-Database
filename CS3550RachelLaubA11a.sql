---Rachel Laub
---CS3550
---Assignment 11a

/*1. List the first name, last name, gender, age (in years), and job title of the oldest (by number of days) employee.*/
SELECT pp.FirstName, pp.LastName, hre.Gender, hre.JobTitle, DATEPART(yyyy, GETDATE())-DATEPART(yyyy, hre.BirthDate)
FROM HumanResources.Employee hre INNER JOIN Person.Person pp
ON pp.BusinessEntityID = hre.BusinessEntityID
WHERE DATEDIFF(day, hre.BirthDate, GETDATE()) =
(SELECT MAX(DATEDIFF(day, hre.BirthDate, GETDATE())) FROM HumanResources.Employee hre)

/*2. Display the employee male to female ratio. (Note that ratio is male/female). Show the single value up to two digits after the decimal (i.e. 5.43)*/

SELECT (ROUND(CAST(MGender AS DECIMAL(6,2))/FGender, 2)) AS GenderRatio
FROM (SELECT COUNT(Gender) AS FGender
FROM HumanResources.Employee
WHERE Gender = 'F') AS FemaleGender,
(SELECT COUNT(Gender) AS MGender
FROM HumanResources.Employee
WHERE Gender = 'M') AS MaleGender

/*3. Show the name, quantity and product ID of the highest total quantity ordered item sold to customers?*/ 
SELECT pp.Name, pp.ProductID, ppi.Quantity, pod.OrderQty
FROM Production.Product pp INNER JOIN Production.ProductInventory ppi
ON pp.ProductID = ppi.ProductID
INNER JOIN Purchasing.PurchaseOrderDetail pod
ON pp.ProductID = pod.ProductID
WHERE pod.OrderQty = (SELECT MAX(pod.OrderQty) FROM Purchasing.PurchaseOrderDetail pod)
ORDER BY pod.OrderQty

/*4. Show the state(s) with the most online orders.*/ 

SELECT sp.Name, COUNT(*) AS Num_Order_Per_State
FROM Sales.SalesOrderHeader soh INNER JOIN Person.Address pa
ON soh.ShipToAddressID = pa.AddressID
INNER JOIN Person.StateProvince sp
ON pa.StateProvinceID = sp.StateProvinceID
WHERE OnlineOrderFlag = 1
GROUP BY sp.Name
HAVING COUNT (*) =
(SELECT MAX(orders)
FROM (
SELECT sp.Name, COUNT(*) AS orders
FROM Sales.SalesOrderHeader soh INNER JOIN Person.Address pa
ON soh.ShipToAddressID = pa.AddressID
INNER JOIN Person.StateProvince sp
ON pa.StateProvinceID = sp.StateProvinceID
WHERE OnlineOrderFlag = 1
GROUP BY sp.Name) mycount)

/*5. Display the vendor name, credit rating and address (street address, city, state) for vendors that have a credit rating higher than 3. Sort the list be Vendor Name.*/
SELECT pv.Name, pa.AddressLine1 AS Address, pa.City, psp.Name AS State, pv.CreditRating
FROM Purchasing.Vendor pv INNER JOIN Person.BusinessEntityAddress bea
ON pv.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address pa
ON bea.AddressID = pa.AddressID
INNER JOIN Person.StateProvince psp
ON pa.StateProvinceID = psp.StateProvinceID
WHERE pv.CreditRating > 3
ORDER BY pv.Name