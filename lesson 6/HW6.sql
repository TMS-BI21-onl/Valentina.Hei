CREATE TABLE dbo.CangeNatIDNumber
	( BusinessEntityID  INT NOT NULL  
	, NationalIDNumber NVARCHAR(15) NOT NULL
	);

INSERT INTO dbo.CangeNatIDNumber ( BusinessEntityID, NationalIDNumber) 
VALUES 
	(15, '879341111')


UPDATE [HumanResources].[Employee]	
SET NationalIDNumber = 
	(select c.NationalIDNumber 
	From [HumanResources].[Employee] e
	JOIN dbo.CangeNatIDNumber c ON c.BusinessEntityID=e.BusinessEntityID)
Where BusinessEntityID=15

select * 
From [HumanResources].[Employee]
