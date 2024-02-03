--0 --
museum		
----------------------------		
Storage		--хранилища
StorageID		 --ID
StorageName		--Название хранилища
StorageSquare		--площадь хранилища
ArtID		 --хранилище для каких  худ. Форм
		
-----------------------------		
Storage Contents		 --содержимое хранилища
StorageID		 -- ID хранилища
ExID		-- ID экспонатов
SCReceipDate		--дата и время поступления в хранилище
SCDisposalpDate		--дата и время выбытия из хранилища
		
----------------------------		
Exponat		--экспонаты
ExID		
ExName		--название экспоната
ExDateOfCreation		--дата создания
ArtID		--худ форма ИД
AuthorID		--автор ид
ExAssessedValue (cost)		--оценочная стоимость
--------------------------------
Art form		--Художественная форма
ArtID		 --ID
ArtName		 --картины, скульптуры, артефакты и т.д.
-------------------------------		
Author		--авторы
AuthorID		 --ID
AuthorName		 --имя автора
AuPlaceOfBirth		 --место рождения  автора
---------------------------------		
Employee		--Сотрудники
EmployeeID		 --ID
EmployeeName		--Сотрудник
--------------------------------		
Plase		--залы
PlaseID		 --ID
PlaseName		--название зала
---------------------------------		
Exposition -- экспозици		
ExpositionID		 --ID
PlaseID		 --ID зала
ExID		--экспонаты
StartDate		 --дата начала экспозиции
FinishDate		 --дата конца экспозиции
EmployeeID		 --ответственный сотрудник
----------------------------------------------
-- 1 --
--EN What is the most expensive work of the Author (ID=1) at the time of the exhibition (ID=3), which was hidden from the eyes of visitors

--RU Какое самое дорогое произведения Автора (ID=1)  на момент проведения экспозиции (ID=3), были спрятаны от глаз посетителей  

--2--
--EN display for each author a list of his works, location and total insured value of all his works,
--if the insured value of work in the storage facility is equal to the estimated value, and the insurance of work at the exhibition is 20% more than the estimated value)

--RU выведите по каждому автору спиок его произведений, место нахождения и  общую страховую стоимость всех его работ,
--если страховая стоимость работ в хранилище равна оценочной стоимости, а страховка работ на экспозиции  больше оценочной стоимости на 20%)


--2----------------------------------------------------------------------------------------------------------------

SELECT YearO as Year , [January], [February], [December]
FROM  
(
	Select SUM ([OrderQty])		AS [SumOrder]
	,year([DueDate])			AS [YearO]
	,DateName(month,[DueDate])	AS [MonthO]
	from Production.WorkOrder
	Where DateName(month,[DueDate]) in ('January','February','December')
	Group BY year([DueDate]), DateName(month,[DueDate])
)  t  
PIVOT  
(  
 SUM([SumOrder])
 FOR MonthO IN ([January], [February],[December])  
) AS PivotTable;  
