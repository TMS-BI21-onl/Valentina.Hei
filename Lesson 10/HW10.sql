--0 --
museum		
----------------------------		
Storage		--���������
StorageID		 --ID
StorageName		--�������� ���������
StorageSquare		--������� ���������
ArtID		 --��������� ��� �����  ���. ����
		
-----------------------------		
Storage Contents		 --���������� ���������
StorageID		 -- ID ���������
ExID		-- ID ����������
SCReceipDate		--���� � ����� ����������� � ���������
SCDisposalpDate		--���� � ����� ������� �� ���������
		
----------------------------		
Exponat		--���������
ExID		
ExName		--�������� ���������
ExDateOfCreation		--���� ��������
ArtID		--��� ����� ��
AuthorID		--����� ��
ExAssessedValue (cost)		--��������� ���������
--------------------------------
Art form		--�������������� �����
ArtID		 --ID
ArtName		 --�������, ����������, ��������� � �.�.
-------------------------------		
Author		--������
AuthorID		 --ID
AuthorName		 --��� ������
AuPlaceOfBirth		 --����� ��������  ������
---------------------------------		
Employee		--����������
EmployeeID		 --ID
EmployeeName		--���������
--------------------------------		
Plase		--����
PlaseID		 --ID
PlaseName		--�������� ����
---------------------------------		
Exposition -- ���������		
ExpositionID		 --ID
PlaseID		 --ID ����
ExID		--���������
StartDate		 --���� ������ ����������
FinishDate		 --���� ����� ����������
EmployeeID		 --������������� ���������
----------------------------------------------
-- 1 --
--EN What is the most expensive work of the Author (ID=1) at the time of the exhibition (ID=3), which was hidden from the eyes of visitors

--RU ����� ����� ������� ������������ ������ (ID=1)  �� ������ ���������� ���������� (ID=3), ���� �������� �� ���� �����������  

--2--
--EN display for each author a list of his works, location and total insured value of all his works,
--if the insured value of work in the storage facility is equal to the estimated value, and the insurance of work at the exhibition is 20% more than the estimated value)

--RU �������� �� ������� ������ ����� ��� ������������, ����� ���������� �  ����� ��������� ��������� ���� ��� �����,
--���� ��������� ��������� ����� � ��������� ����� ��������� ���������, � ��������� ����� �� ����������  ������ ��������� ��������� �� 20%)


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
