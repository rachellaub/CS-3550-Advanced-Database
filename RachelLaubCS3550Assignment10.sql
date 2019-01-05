
/*How many products have a 10 % discount*/

SELECT COUNT(sso.DiscountPct) AS Discount_Amount
FROM Production.Product pp INNER JOIN Sales.SpecialOfferProduct ssop
ON ssop.ProductID = pp.ProductID
INNER JOIN Sales.SalesOrderDetail ssod
ON ssod.SpecialOfferID = ssop.SpecialOfferID
AND ssod.ProductID = ssop.ProductID
INNER JOIN Sales.SpecialOffer sso
ON sso.SpecialOfferID = ssop.SpecialOfferID
WHERE sso.DiscountPct = .1

/*How many documents has each employee written?*/

SELECT  pers.FirstName, pers.LastName, COUNT(pd.Document) AS Num_Documents
FROM Production.Product pp INNER JOIN Production.ProductDocument ppd
ON pp.ProductID = ppd.ProductID
INNER JOIN Production.Document pd
ON pd.DocumentNode = ppd.DocumentNode, 
HumanResources.Employee hre INNER JOIN Person.Person pers
ON hre.BusinessEntityID = pers.BusinessEntityID
WHERE pers.PersonType = 'EM'
GROUP BY pers.FirstName, pers.LastName
