---1
---What employees that have a pay rate over 50? Include their name, the rate and the department they are in.
SELECT pp.FirstName, pp.LastName, eph.Rate, dep.Name
FROM Person.Person pp INNER JOIN HumanResources.Employee hre
ON pp.BusinessEntityID = hre.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory eph
ON eph.BusinessEntityID = hre.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
ON edh.BusinessEntityID = eph.BusinessEntityID
INNER JOIN HumanResources.Department dep
ON dep.DepartmentID = edh.DepartmentID
WHERE eph.Rate > 50
ORDER BY dep.DepartmentID

---2
--- What products are at the location 'Tool Crib' with a quantity of 500 or more? Include the subcategory name.
SELECT pp.ProductNumber, ppi.Quantity, psc.Name
FROM Production.Product pp INNER JOIN Production.ProductInventory ppi
ON pp.ProductID = ppi.ProductID
INNER JOIN Production.Location pl
ON pl.LocationID = ppi.LocationID
INNER JOIN Production.ProductSubcategory psc
ON psc.ProductSubcategoryID = pp.ProductID
WHERE ppi.Quantity > 500
AND pl.Name = 'Tool Crib'

---3
--- List each persons first name, last name, phone number, email address and credit card number.
SELECT pp.FirstName, pp.LastName, ph.PhoneNumber, ea.EmailAddress, cred.CardNumber
FROM Person.Person pp INNER JOIN Person.PersonPhone ph
ON pp.BusinessEntityID = ph.BusinessEntityID
INNER JOIN Person.EmailAddress ea
ON ea.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Sales.PersonCreditCard pcc
ON pcc.BusinessEntityID = pp.BusinessEntityID
INNER JOIN Sales.CreditCard cred
ON cred.CreditCardID = pcc.CreditCardID

---4
--- Which products have more than 10 items? Include the standard cost. 
SELECT ppc.Name, ppch.StandardCost, COUNT(*) AS Num_Products
FROM Production.Product pp INNER JOIN Production.ProductSubcategory pps
ON pps.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN production.ProductCategory ppc
ON ppc.ProductCategoryID = pps.ProductCategoryID
INNER JOIN Production.ProductCostHistory ppch
ON ppch.ProductID = pp.ProductID
GROUP BY ppc.Name, ppch.StandardCost
HAVING COUNT(*) > 10
ORDER BY ppc.Name;

---5
---Which products have a discount value of 30% and above? Include the unit price. 
SELECT pp.Name AS "Name", ssod.UnitPrice, sso.DiscountPct
FROM Production.Product pp INNER JOIN Sales.SpecialOfferProduct ssop
ON ssop.ProductID = pp.ProductID
INNER JOIN Sales.SalesOrderDetail ssod
ON ssod.SpecialOfferID = ssop.SpecialOfferID
AND ssod.ProductID = ssop.ProductID
INNER JOIN Sales.SpecialOffer sso
ON sso.SpecialOfferID = ssop.SpecialOfferID
WHERE sso.DiscountPct>0.30
ORDER BY sso.DiscountPct DESC
