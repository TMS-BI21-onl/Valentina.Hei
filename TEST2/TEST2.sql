--Задачи 
--1) Найдите людей и их номера телефонов, код города которых начинается на  4 и заканчивается на 5.
--( таблицы Person.PersonPhone, Person.Person) 

	Select p.[FirstName], p.[LastName], ph.[PhoneNumber]
	From  [Person].[Person]  p
	left Join [Person].[PersonPhone] ph ON p.[BusinessEntityID]=ph.BusinessEntityID
	WHERE LEFT(ph.[PhoneNumber],3) LIKE '4_5'


--2) Отнести каждого человека из [HumanResources].[Employee] в свою возрастную категорию:
--Adolescence: 17-20
--Adults: 21-59
--Elderly: 60-75
--Senile: 76-90

Select e.[BusinessEntityID],
	CASE 
	WHEN ((datediff(y,e.[BirthDate],GETDATE())/365)>= 17 AND (datediff(y,e.[BirthDate],GETDATE())/365)<21) THEN "Adolescence"
	WHEN ((datediff(y,e.[BirthDate],GETDATE())/365)>=21 AND (datediff(y,e.[BirthDate],GETDATE())/365)<60) THEN "Adults"
	WHEN ((datediff(y,e.[BirthDate],GETDATE())/365)>=60 AND (datediff(y,e.[BirthDate],GETDATE())/365)<76) THEN "Elderly"
	WHEN ((datediff(y,e.[BirthDate],GETDATE())/365)>=76 AND (datediff(y,e.[BirthDate],GETDATE())/365)<90) THEN "Senile"
	ELSE "another"
	END AS "Возрастная категория"
FROM [HumanResources].[Employee] e


Select (datediff(y,e.[BirthDate],GETDATE())/365)
FROM [HumanResources].[Employee] e
WHERE (datediff(y,e.[BirthDate],GETDATE())/365)>=65

--3) Вывести самый дорогой продукт для каждого цвета из [Production].[Product] (3 способа)

                                                                               
Select [Name], [Color]
FROM [Production].[Product]
WHERE [StandardCost]=
	(SELECT [Color], MAX([StandardCost])
	FROM [Production].[Product]
	GROUP BY [Color]
	)



Select *
FROM 
	(SELECT [Name], [Color],[StandardCost]
	RANK () OVER (PARTITION BY  [Color] ORDER BY [StandardCost] DESC) AS RANKCOST
	FROM [Production].[Product]
	) t
WHERE t.RANKCOST=1