--1 ---

INSERT INTO 
manufacturer (id, name , countru_id)
VALUES  (5,'HP',4)



--2---
UPDATE User  SET age= age
	   Where  name-"Андрей"


--3-- --3/1
SELECT Top 1 with ties Name, price
From product
order by  price

--3/2
SELECT Name, price
FROM product
WHERE	price=(	SELECT max(price) FROM product )

--3/3
SELECT *
FROM (
	SELECT name, price 
	RUNK()  over (ORDER BY price DESC) AS rn
	FROM product 
	) t
Where rn=1

--3/4
SELECT *
FROM (
	SELECT name, price 
	MAX(cost)  over () AS mc
	FROM product 
	) m
Where price=mc


--4-- 
SELECT u.name, u.age, p.phone
FROM user u
Join phone p ON p.user_id=u.id
WHERE   (p.name LIKE '+3%4' ) or  (   u.age>35)

--5-- 
SELECT TOP 5 with ties *
FROM (
	u.Name, 
	COUNT(o.id) over (partition BY o.user_id ) AS Box  
	FROM order o
	JOIN uther u ON u.id=o.user_id
	JOIN product p ON p.id=o.prodyct_id 
	ORDER BY Box DESC
	) t


SELECT TOP 5 with ties *
FROM (
	SELECT u.Name,COUNT(o.id) AS Box
	FROM order o
	JOIN uther u ON u.id=o.user_id
	JOIN product p ON p.id=o.prodyct_id 
	GROUP BY o.user_id
	ORDER BY Box  DESC
	) t
