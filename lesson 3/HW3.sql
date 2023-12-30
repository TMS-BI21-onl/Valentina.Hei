
--2.a) 

SELECT distinct [StandardCost],
	CASE 
		WHEN (StandardCost=0 OR StandardCost IS NULL) THEN 'Not for sale'
		WHEN (StandardCost>0 AND StandardCost<100) THEN '<$100'
		WHEN (StandardCost>=100 AND StandardCost<500) THEN '<$500'
		ELSE '>= $500'
	 END PriceRange
FROM [Production].[Product]

-----------------------------------------------------------------
--2.b) 
	SELECT ppv.[ProductID] --34 lines
	,ppv.[BusinessEntityID]
	,pv.[Name] AS VendorName
	--,ppv.StandardPrice
FROM  [Purchasing].[ProductVendor] ppv
JOIN  [Purchasing].[Vendor]  pv ON ppv.[BusinessEntityID]=pv.[BusinessEntityID] -- JOIN  becouse StandardPrice and  VendorName in the filter NOT NULL 
	WHERE  StandardPrice>10 
	AND (pv.[Name] like '%X%' OR pv.[Name] like 'N%')



--------------------------------------------------------------------
--2.c) 

SELECT pv.[Name]
FROM  [Purchasing].[Vendor]  pv
LEFT JOIN [Purchasing].[ProductVendor] ppv ON ppv.[BusinessEntityID]=pv.[BusinessEntityID]
WHERE ppv.[ProductID] is NULL


----------------------------------------------------------------------
--3.a) 
SELECT pp.[Name]
	, pp.[StandardCost]
FROM [Production].[Product] PP
Left JOIN [Production].[ProductModel] pm ON pp.ProductModelID=pm.ProductModelID
WHERE pm.Name LIKE 'LL%'


-----------------------------------------------------------------------
--3.b.1) 
SELECT  DISTINCT   pv.Name AS Vendor   -- It is wrong to combine different entities into one list
		, s.Name AS Store
FROM [Purchasing].[Vendor] pv
FULL JOIN [Sales].[Store] s ON s.BusinessEntityID=pv.BusinessEntityID
ORDER BY 2,1

--3.b.2)
SELECT DISTINCT t.Name
FROM (
	SELECT Name
	FROM [Purchasing].[Vendor]
	UNION ALL
	SELECT  Name
	FROM [Sales].[Store]
	) t
ORDER BY t.Name

-----------------------------------------------------------------------
--3.c) 

SELECT pp.Name AS ProductSO
FROM (
	SELECT ProductID, COUNT(SpecialOfferID) AS CountSpecialOffer
	FROM [Sales].[SpecialOfferProduct]
	WHERE SpecialOfferID>1    --SpecialOfferID = 1 is No Discount
	Group BY ProductID
	) t
JOIN [Production].[Product] pp ON pp.ProductID=t.ProductID
WHERE CountSpecialOffer>1
