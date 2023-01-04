SELECT * FROM customer
SELECT * FROM purchase



--What does the average customer look like?

---------------DATA CLEANING-----------------

-- Finding outliers

with orderedList AS (
SELECT
	ID,
	Year_Birth,
	ROW_NUMBER() OVER (ORDER BY Year_Birth) AS row_n
FROM customer
),

quartile_breaks AS (
SELECT
	ID,
    Year_Birth,
	(
	SELECT Year_Birth AS quartile_break
	FROM orderedList
	WHERE row_n = FLOOR((SELECT COUNT(*) FROM customer)*0.75)
	) AS q_three_lower,
	(
	SELECT Year_Birth AS quartile_break
	FROM orderedList
	WHERE row_n = FLOOR((SELECT COUNT(*) FROM customer)*0.75) + 1
	) AS q_three_upper,
	(
	SELECT Year_Birth AS quartile_break
	FROM orderedList
	WHERE row_n = FLOOR((SELECT COUNT(*) FROM customer)*0.25)
	) AS q_one_lower,
	(
	SELECT Year_Birth AS quartile_break
	FROM orderedList
	WHERE row_n = FLOOR((SELECT COUNT(*) FROM customer)*0.25) + 1
	) AS q_one_upper
	FROM orderedList
	),

iqr AS (
SELECT
	Year_Birth,
    ID,
	(
	(SELECT MAX(q_three_lower)
    	FROM quartile_breaks) +
	(SELECT MAX(q_three_upper)
    	FROM quartile_breaks)
	)/2 AS q_three,
	(
	(SELECT MAX(q_one_lower)
    	FROM quartile_breaks) +
	(SELECT MAX(q_one_upper)
    	FROM quartile_breaks)
	)/2 AS q_one,
	1.5 * ((
	(SELECT MAX(q_three_lower)
    	FROM quartile_breaks) +
	(SELECT MAX(q_three_upper)
    	FROM quartile_breaks)
	)/2 - (
	(SELECT MAX(q_one_lower)
    	FROM quartile_breaks) +
	(SELECT MAX(q_one_upper)
    	FROM quartile_breaks)
	)/2) AS outlier_range
FROM quartile_breaks
)

SELECT
	ID,
    Year_Birth
FROM iqr
WHERE Year_Birth >=
	((SELECT MAX(q_three)
		FROM iqr) +
	(SELECT MAX(outlier_range)
		FROM iqr))
 OR Year_Birth <=
 	((SELECT MAX(q_one)
		FROM iqr) -
	(SELECT MAX(outlier_range)
		FROM iqr))

-- Deleting the outliers 

DELETE FROM customer
WHERE ID = 1150 
DELETE FROM customer
WHERE ID = 7829 
DELETE FROM customer
WHERE ID = 11004

-- To find null values-- There are 24 null values

SELECT income
FROM customer
WHERE income IS NULL

-- Replace null values with the average income (52247.2513537906)

SELECT AVG(income) FROM customer

update customer set income= 52247.2513537906 where income is null

-- Updating the Marital_Status = 'YOLO' with unknown 

SELECT ID, Marital_Status
FROM customer 
WHERE Marital_Status = 'YOLO'

update customer set Marital_Status= 'unknown' where ID in (492, 11133)

-- Updating Marital_Status= 'Absurd'with 'unknown'
select ID, Marital_Status
FROM customer
WHERE Marital_Status= 'Absurd'

update customer set Marital_Status= 'unknown' where ID in (4369, 7734)
select distinct Marital_Status
FROM customer

-- IDs that were changed to unknown from absurd and YOLO
select ID, Marital_Status
FROM customer
WHERE Marital_Status= 'unknown'

-- Updating Marital_Status= 'Alone' with 'Single' 
SELECT ID, Marital_Status
FROM customer 
WHERE Marital_Status = 'Alone'

update customer set Marital_Status= 'Single' where ID in (92, 433, 7660)

select distinct Marital_Status
FROM customer

------------ END OF DATA CLEANING ------------
--Total number of customers?
SELECT DISTINCT COUNT(ID) AS Total_Customers FROM customer

--What factors are significantly related to the number of web purchases?
SELECT SUM(NumDealsPurchases) AS PurchasedOnDeal, SUM(NumWebPurchases) AS PurchasedOnWeb, SUM(NumCatalogPurchases) AS PurchasedOnCatalog, SUM(NumStorePurchases) AS PurchasedOnStore  
FROM purchase

--Which marketing campaign was the most successful?
SELECT  SUM(AcceptedCmp1) AS Campaign1, SUM(AcceptedCmp2) AS Campaign2, SUM(AcceptedCmp3) AS Campaign3, SUM(AcceptedCmp4) AS Campaign4, SUM(AcceptedCmp5) AS Campaign5
FROM customer


-- Numbers of customers that belong to same year
CREATE VIEW avg_customer AS
SELECT COUNT(ID) AS TotalCust, Year_Birth
FROM customer
GROUP BY Year_Birth

SELECT * FROM avg_customer

--What does the average customer look like?
-- Calculating age of the customer
CREATE VIEW CUST_AGE AS
SELECT ID, (YEAR(CURRENT_TIMESTAMP)  - (Year_Birth)) AS Age
FROM customer

-- Querying the view
SELECT * FROM CUST_AGE

--Finding the average age from the view CUST_AGE
SELECT avg(Age) AS AVG_AGE FROM CUST_AGE

--Which products are performing best?
SELECT SUM(MntWines) AS Wine, SUM(MntFruits) AS Fruits, SUM(MntMeatProducts) AS Meat, SUM(MntFishProducts) AS Fish, SUM(MntSweetProducts) AS Sweet, SUM(MntGoldProds) AS Gold
FROM purchase

--Which channels are underperforming?
SELECT SUM(NumDealsPurchases) AS PurchasedOnDeal, SUM(NumWebPurchases) AS PurchasedOnWeb, SUM(NumCatalogPurchases) AS PurchasedOnCatalog, SUM(NumStorePurchases) AS PurchasedOnStore  
FROM purchase

-- 
SELECT Country, COUNT(ID) AS NumberOfCustomers
FROM customer
GROUP BY Country
ORDER BY COUNT(ID) DESC

--Recency tells about number of days since customer's last purchase
SELECT ID,Recency 
FROM purchase
WHERE Recency BETWEEN 0 and 30
ORDER BY Recency 

--Overall global sales of all products
CREATE VIEW Sales AS
SELECT c.Country, SUM(p.MntWines) AS Wine, SUM(p.MntFruits) AS Fruits, SUM(p.MntMeatProducts) AS Meat, SUM(p.MntFishProducts) AS Fish, SUM(p.MntSweetProducts) AS Sweet, SUM(p.MntGoldProds) AS Gold
FROM purchase p
JOIN customer c
ON c.ID = p.ID
GROUP BY c.Country 

SELECT * FROM Sales

--Total Sales across all Countries
SELECT Country, SUM(Wine + Fruits + Meat + Fish + Sweet + Gold) AS Total_Sales
FROM Sales
GROUP BY Country
ORDER BY Total_Sales DESC

--
SELECT COUNT(p.ID) AS Purchase_Count , year(p.Dt_Customer) AS Years, s.Total_Sales 
FROM purchase p
JOIN Sales s
JOIN customer c
ON c.ID = s.ID

GROUP BY year(Dt_Customer)

SELECT year(p.Dt_Customer) AS Years, SUM(Wine + Fruits + Meat + Fish + Sweet + Gold) AS Total_Sales
FROM Sales s
JOIN purchase p
ON 


---------------THE END-----------------


