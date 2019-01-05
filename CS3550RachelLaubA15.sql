--1
SELECT sp.TerritoryID, sp.StateProvinceID, st.Name AS TerritoryName, COUNT(*) AS ProvinceNameCount
FROM Person.StateProvince sp
INNER JOIN Sales.SalesTerritory st
ON sp.TerritoryID = st.TerritoryID
GROUP BY sp.TerritoryID, st.Name, sp.StateProvinceID

--2
SELECT 'db.Territory.save({' 
+ '"territoryID":' + CONVERT(varchar(MAX),sp.TerritoryID), 
+ ', "territoryName":"' + CONVERT(varchar(MAX),st.Name), 
+ '", "provinceName":"' + CONVERT(varchar(MAX),sp.Name),
+ '", "stateProvinceID":"' + CONVERT(varchar(MAX),sp.StateProvinceID) +'"});'
FROM Person.StateProvince sp
INNER JOIN Sales.SalesTerritory st
ON sp.TerritoryID = st.TerritoryID
