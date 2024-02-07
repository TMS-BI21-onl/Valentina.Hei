
--2.1---------------------------------------------------------
Select *
FROM 
	(SELECT c.��� , COUNT (p.penalty_id) AS Count_Penalties
	FROM  Penalties p
	JOIN VIN  v ON v.vin_id=p.vin_id
	JOIN Car_owner  c ON c.car_id =v.car_id 
	WHERE DATEPART( year,p.���� ���������)='2022'
	GROUP BY c.��� ) t
WHERE t.Count_Penalties >5

--2.2--------------------------------------------------------------
SELECT Stazh as ([���1], [���2],[���3],...[���N])
	(SELECT	, COUNT(p.penalty_id   AS [Count_Penalties]
			, k.Stazh			AS [Stazh]
			, p.���				AS [���]	
	FROM Penalties p
	JOIN VIN v ON v.vin_id=p.vin_id
	JOIN	(SELECT	i.owner_id			 -- We calculate the length of service for each driver 
			,datediff(year,c.���� ������ ����, GETDATE()) AS Stazh
			FROM licenses i ) k  ON k.owner_id=v.owner_id 
	GROUP BY  k.Stazh ,p.���
	) s
PIVOT
(
SUM([Count_Penalties])
FOR ��� IN ([���1], [���2],[���3],...[���N])
) AS PivotTable; 

--3----------------------------------------------------------------
Create table dbo.HW11 (Function_name nvarchar(50) ,Function_count INT)


 MERGE dbo.HW11 AS T
 USING 
	(SELECT Alex AS Function_name , count(Alex) AS Function_count
	FROM [dbo].[data_for_merge] 
	WHERE Alex IS NOT NULL GROUP BY Alex ) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_name+T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
  GO
 MERGE dbo.HW11 AS T
 USING 
	(SELECT Carlos AS Function_name , count(Carlos) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Carlos IS NOT NULL GROUP BY Carlos ) AS S
  ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
 GO
 MERGE dbo.HW11 AS T
 USING 
	(SELECT Charles AS Function_name , count(Charles) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Charles IS NOT NULL GROUP BY Charles ) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
 GO
 MERGE dbo.HW11 AS T
 USING 
	(SELECT Daniel AS Function_name , count(Daniel) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Daniel IS NOT NULL GROUP BY Daniel ) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
 GO
 MERGE dbo.HW11 AS T
 USING 
	(SELECT Esteban AS Function_name , count(Esteban) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Esteban IS NOT NULL GROUP BY Esteban) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
 GO
 MERGE dbo.HW11 AS T
 USING 
	(SELECT Fred AS Function_name , count(Fred) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Fred IS NOT NULL GROUP BY Fred) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
GO
MERGE dbo.HW11 AS T
USING 
	(SELECT George AS Function_name , count(George) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE George IS NOT NULL GROUP BY George) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
GO
MERGE dbo.HW11 AS T
USING 
	(SELECT Lando AS Function_name , count(Lando) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Lando IS NOT NULL GROUP BY Lando) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
GO
MERGE dbo.HW11 AS T
	USING (SELECT Lewis AS Function_name , count(Lewis) AS Function_count
	FROM [dbo].[data_for_merge]
	WHERE Lewis IS NOT NULL GROUP BY Lewis) AS S
 ON  S.Function_name=T.Function_name
 WHEN MATCHED  THEN UPDATE SET T.Function_count=S.Function_count + T.Function_count 
 WHEN NOT MATCHED THEN INSERT VALUES (S.Function_name, S.Function_count)
 ;
Select *From dbo.HW11

