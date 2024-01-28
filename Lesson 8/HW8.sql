--1.1--------------------------------------
CREATE DATABASE Online_Shop
-----------------------------------------
CREATE TABLE Product
(
	ProductID			INT PRIMARY KEY IDENTITY,
	Name				NVARCHAR(30) NOT NULL,
	[Group]				NVARCHAR(30) NOT NULL,
	Brand				NVARCHAR(30) NOT NULL,
	Model				NVARCHAR(30) NOT NULL,
	Color				NVARCHAR(30),
	Price				FLOAT NOT NULL,
	VendorPrice			FLOAT NOT NULL
)
--1.2------------------------------------------
CREATE TABLE Vendor
(
	VendorID			INT PRIMARY KEY IDENTITY,
	Vendor				NVARCHAR(30) NOT NULL,
	Name				NVARCHAR(30) NOT NULL,
	ActiveFlag			BIT NOT NULL,
	WebURL				NVARCHAR(150) UNIQUE,
	ModifiedeDate		DATE NOT NULL
)

--1.3-----------------------------------------------

CREATE TABLE Client
(
	ClientID			INT PRIMARY KEY IDENTITY,
	FirstName			NVARCHAR(30) NOT NULL,
	LastName			NVARCHAR(30) NOT NULL,
	Gender				CHAR(1) NOT NULL,
	Birthday			DATE NOT NULL,
	PassportID			NVARCHAR(14) UNIQUE NOT NULL,
	TelNumber			NVARCHAR(13),
	Mail				AS CONCAT(UPPER(LEFT(FirstName,3)), LOWER(LEFT(LastName,3)), '@mail.com') PERSISTED 
)

--1.4-------------------------------------------------
CREATE TABLE Delivery
(
	DeliveryID			INT PRIMARY KEY IDENTITY,
	DeliveryType		NVARCHAR(30) NOT NULL
)
--1.5-----------------------------------------------
CREATE TABLE Status
(
	StatusID			INT PRIMARY KEY IDENTITY,
	Status				NVARCHAR(30) NOT NULL
)
--1.6---------------------------------------------------
CREATE TABLE Pay
(
	PayTypeID			INT PRIMARY KEY IDENTITY,
	PayType				NVARCHAR(30) NOT NULL
)
--1.7-----------------------------------------------------
CREATE TABLE Orders
(	
	OrderID				INT PRIMARY KEY IDENTITY,
	ClientID			INT, 
	ProductID			INT,		
	DeliveryID			INT,
	VendorID			INT,
	StatusID			INT,
	PayTypeID			INT,
	Quantity			INT,
	Orderdate			DATETIME,
	TotalPrice			FLOAT,
	StatusChange		DATE,
	FOREIGN KEY (ClientID)  REFERENCES Client (ClientID),
	FOREIGN KEY (ProductID)  REFERENCES Product (ProductID),
	FOREIGN KEY (DeliveryID)  REFERENCES Delivery (DeliveryID),
	FOREIGN KEY (VendorID)  REFERENCES Vendor (VendorID),
	FOREIGN KEY (StatusID)  REFERENCES Status (StatusID),
	FOREIGN KEY (PayTypeID)  REFERENCES Pay (PayTypeID),
)


-- 2 ------------------------------------
WITH CTE_l AS
	(
	SELECT  [last_name]   --[first_name]
	FROM [dbo].[MOCK_DATA (14)]
	),
	CTE_f AS
	(
	SELECT  [first_name]
	FROM [dbo].[MOCK_DATA (14)]
	)
SELECT [first_name], [last_name]
FROM CTE_l CROSS JOIN CTE_f

--3-------------------------------------------

	--CTE temporary,
	--CTEs are created when they will be used
	--Typically used to simplify complex join queries and subqueries
	--One CTE can be accessed multiple times

