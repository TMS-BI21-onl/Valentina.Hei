-- 1. ����� ProductSubcategoryID �� Production.Product, ��� ��� ��� ������ ProductSubcategoryID ������ 150. 

--1 
Select DISTINCT ProductSubcategoryID
FROM (
	SELECT [ProductSubcategoryID], Weight, 
		MIN(Weight) over (PARTITION BY [ProductSubcategoryID] ) AS MinW
	FROM [Production].[Product]
	) x
Where MinW > 150



--2. ����� ����� ������� ������� (���� StandardCost) �� Production.Product. (4 �������)
--1
Select TOP 1 WITH TIES [Name], [StandardCost]
FROM  [Production].[Product]
ORDER BY [StandardCost] DESC
--2
Select  [Name], [StandardCost]
FROM  [Production].[Product]
WHERE  [StandardCost]= ( SELECT MAX([StandardCost])  FROM [Production].[Product] ) 
--3
SELECT * 
FROM ( SELECT [Name], [StandardCost],
		RANK() OVER (ORDER BY [StandardCost] DESC) AS rnc
		FROM  [Production].[Product]
		) t
WHERE  rnc=1
--4
SELECT *
FROM  (SELECT [Name], [StandardCost],
		MAX ( [StandardCost])  OVER () AS maxC
		FROM  [Production].[Product]
		) t 
WHERE [StandardCost]=maxC


-- 3. ����� ��������, ������� �� ��������� ��� �� ��������� �� ������ ������ (����� GROUP2)
SELECT c.FirstName, c.LastName
FROM Client c 
LEFT JOIN (
	SELECT ClientID
	FROM Orders
	WHERE OrderDate >= DATEADD (year , -1, OrderDate)
	) t ON  t.ClientID=c. ClientID
WHERE t.ClientID IS NULL


-- 4. ����� ��� ������� ���������� ���-�� ������� �� ��������� 5 ���.  (����� GROUP2)

Select v.Vendor, cnt
FROM Vendor v
LEFT JOIN (Select VendorID, COUNT(OrderID) AS cnt
			FROM Orders o
			WHERE  OrderDate >= DATEADD (year , -5, OrderDate)
			GROUP BY VendorID
			)x ON x.VendorID=v.VendorID


5. 
Users (
    id bigint NOT NULL,
    email varchar(255) NOT NULL
);

Notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    category varchar(100),
    is_read boolean DEFAULT false
);

����� ������ ��������� ��� ������������ alex@gmail.com, � ������� ����� 50 ������������� �����������

--5 

SELECT *
FROM ( SELEC n.category, n.user_id, COUNT(n.is_read) AS cnt, u.email
	 FROM Notifications n
	 JOIN Users u ON u.id=n.user_id
	 WHERE is_read = FALSE  AND  u.email='alex@gmail.com'
	 GROUP BY category, user_id, u.email
	 ) t
WHERE cnt>50 
