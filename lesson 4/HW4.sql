﻿--3. При каких значениях оконные функции Row Number, Rank и Dense Rank вернут одинаковый результат?

If all values ​​are unique and non-NULL + sorted ( for example primary key) 
--------------------------------------------------------------------------------

--4.a)	Изучите данные в таблице Production.UnitMeasure. Проверьте, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’. Сколько всего различных кодов здесь есть? 
		--Вставьте следующий набор данных в таблицу:
		--•	TT1, Test 1, 9 сентября 2020
		--•	TT2, Test 2, getdate()

--4.a)1--
SELECT COUNT (DISTINCT UnitMeasureCode) AS COUNT_T	 --0  UnitMeasureCode, starting ‘Т’
FROM [Production].[UnitMeasure]
WHERE [UnitMeasureCode] LIKE 'T%'
--------------------------------------------------------------------------------
--4.a)2--
INSERT INTO [Production].[UnitMeasure] -- insert new data
Values 	
('TT1', 'Test 1', '2020-09-09 00:00:000'),
('TT2', 'Test 2', getdate())

--------------------------------------------------------------------------------			
--4.a)3--
SELECT [UnitMeasureCode]		--2   UnitMeasureCode, starting ‘Т’
FROM [Production].[UnitMeasure]
WHERE [UnitMeasureCode] LIKE 'T%'

--------------------------------------------------------------------------------
--4.b)	Теперь загрузите вставленный набор в новую, не существующую таблицу Production.UnitMeasureTest. 
		--Догрузите сюда информацию из Production.UnitMeasure по UnitMeasureCode = ‘CAN’.  
		--Посмотрите результат в отсортированном виде по коду. 

--4.b)1
SELECT *
INTO [dbo].[Table1]
FROM [Production].[UnitMeasure]
WHERE [UnitMeasureCode] LIKE 'T%'
--------------------------------------------------------------------------------
--4.b)2    Догрузите сюда информацию из Production.UnitMeasure по UnitMeasureCode = ‘CAN’.
INSERT INTO [dbo].[Table1]
SELECT *
FROM [Production].[UnitMeasure]
WHERE UnitMeasureCode = 'CAN'
--------------------------------------------------------------------------------
--4.b)3     Посмотрите результат в отсортированном виде по коду. 
SELECT *
FROM [dbo].[Table1]
ORDER BY UnitMeasureCode
--------------------------------------------------------------------------------
--4.c)  Измените UnitMeasureCode для всего набора из Production.UnitMeasureTest на ‘TTT’.

UPDATE [dbo].[Table1]
SET UnitMeasureCode='TTT'
--------------------------------------------------------------------------------
--4.d)	Удалите все строки из Production.UnitMeasureTest.

DELETE FROM  [dbo].[Table1]
--------------------------------------------------------------------------------

--4.e)	Найдите информацию из Sales.SalesOrderDetail по заказам 43659,43664. 
       --С помощью оконных функций MAX, MIN, AVG найдем агрегаты по LineTotal для каждого SalesOrderID.

SELECT [SalesOrderID], [LineTotal]
	,MAX ([LineTotal]) OVER (PARTITION BY SalesOrderID) AS MAX_LT
	,MIN ([LineTotal]) OVER (PARTITION BY SalesOrderID) AS MIN_LT
	,AVG ([LineTotal]) OVER (PARTITION BY SalesOrderID) AS AVG_LT
FROM Sales.SalesOrderDetail
WHERE [SalesOrderID] IN ( '43659','43664')
--------------------------------------------------------------------------------

--4.f)	Изучите данные в объекте Sales.vSalesPerson. 
		--Создайте рейтинг cреди продавцов на основе годовых продаж SalesYTD, используя ранжирующую оконную функцию. 
		--Добавьте поле Login, состоящий из 3 первых букв фамилии в верхнем регистре + ‘login’ + TerritoryGroup (Null заменить на пустое значение). 
		--Кто возглавляет рейтинг? А кто возглавлял рейтинг в прошлом году (SalesLastYear). 

SELECT	 CONCAT([LastName],' ',[FirstName],' ',[MiddleName]) AS FIO,[TerritoryGroup], [SalesYTD], [SalesLastYear]
		,CONCAT(UPPER(LEFT ([LastName],3)),' login ',ISNULL([TerritoryGroup],'')) AS LOGIN   --CONCAT ignore NULL -> ISNULL may not be used
		,RANK() OVER (ORDER BY SalesYTD DESC) AS RankYTD		--Mitchell Linda C
		,RANK() OVER (ORDER BY SalesLastYear DESC) AS RankLastYear	--Varkey Chudukatil Ranjit R
FROM Sales.vSalesPerson
--------------------------------------------------------------------------------

--4.g)	Найдите первый будний день месяца (FROM не используем). Нужен стандартный код на все времена.
 --why DATETRUNC doesn't work?

DECLARE @date DATE    --why DATETRUNC doesn't work?
SET @date='2023-10-01'
SELECT @date AS StartDate, 
	DATEADD(month,-1,DATEADD(day, 1,EOMONTH(@date))) AS FDMonth,
	CASE											
	WHEN DATEPART(dw,DATEADD(month,-1,DATEADD(day, 1,EOMONTH(@date))))=7 
		THEN DATEADD(day, 2,DATEADD(month,-1,DATEADD(day, 1,EOMONTH(@date)))) 
	WHEN DATEPART(dw,DATEADD(month,-1,DATEADD(day, 1,EOMONTH(@date))) )=1 
		THEN DATEADD(day, 1,DATEADD(month,-1,DATEADD(day, 1,EOMONTH(@date))) ) 
	ELSE DATEADD(month,-1,DATEADD(day, 1,EOMONTH(@date))) 
	End AS FirstWeekday

 StartDate		FDMonth 		FirstWeekday
2023-10-01	2023-10-01	2023-10-02

--------------------------------------------------------------------------------
--5.	 Давайте еще раз остановимся и отточим понимание функции count. Найдите значения count(1), count(name), count(id), count(*) для следующей таблицы:
		--Id(PK)	Name		DepName
		--1			null		A
		--2			null		null
		--3			A		C
		--4			B		C

--  COUNT(1)=4
--  COUNT(Name)=2
--  COUNT(Id(PK))=4
--  COUNT(*)=4




