# Maven-Marketing-Analysis

# Dataset
**Maven Analytics: marketing Campaign Results Dataset**

**About the Dataset**

This Dataset has been taken from the Maven Analytics website. It has marketing campaign data of 2240 customers of Maven Marketing,  including customer profiles, product preferences, campaign successes/failures, and channel performance. 

**Features** 

Field - Description

ID - Customer's unique identifier

Year_Birth - Customer's birth year

Education - Customer's education level

Marital_Status - Customer's marital status

Income - Customer's yearly household income

Kidhome	- Number of children in customer's household

Teenhome - Number of teenagers in customer's household

Dt_Customer - Date of customer's enrollment with the company

Recency - Number of days since customer's last purchase

MntWines - Amount spent on wine in the last 2 years

MntFruits -	Amount spent on fruits in the last 2 years

MntMeatProducts - Amount spent on meat in the last 2 years

MntFishProducts	- Amount spent on fish in the last 2 years

MntSweetProducts - Amount spent on sweets in the last 2 years

MntGoldProds - Amount spent on gold in the last 2 years

NumDealsPurchases -	Number of purchases made with a discount

NumWebPurchases - Number of purchases made through the company's web site

NumCatalogPurchases - Number of purchases made using a catalogue

NumStorePurchases -	Number of purchases made directly in stores

NumWebVisitsMonth -	Number of visits to company's web site in the last month

AcceptedCmp3 - 1 if customer accepted the offer in the 3rd campaign, 0 otherwise

AcceptedCmp4 - 1 if customer accepted the offer in the 4th campaign, 0 otherwise

AcceptedCmp5 - 1 if customer accepted the offer in the 5th campaign, 0 otherwise

AcceptedCmp1 - 1 if customer accepted the offer in the 1st campaign, 0 otherwise

AcceptedCmp2 - 1 if customer accepted the offer in the 2nd campaign, 0 otherwise

Response - 1 if customer accepted the offer in the last campaign, 0 otherwise

Complain - 1 if customer complained in the last 2 years, 0 otherwise

Country - Customer's location

# Data Cleaning

There are some data quality issues that are identified in the dataset like missing data, Outliers, inconsistent data and duplicate data.

Null values: There are 24 null values in the income column of the customer table which were replaced with the average value based on income.

Outliers: The Year_Birth column has 3 outliers which were deleted as having outliers can mess up the analysis by bringing the averages up or down and in general distorting the statistics.

Inconsisteny: Marital status column has some inconsistent data like absurd, alone and YOLO. Absurd and YOLO values were changed to unknown and alone was changed to single.

Data cleaning was performed using simple to complex SQL queries.

# SQL code explanation:

-- Finding outliers (using CTE)

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

Explanation of the above code:

This SQL code uses the quartile method to identify potential outliers in the Year_Birth column of the customer table. 

1. The first CTE, orderedList, assigns a row number to each row in the customer table, ordered by the Year_Birthcolumn.

2. The second CTE, quartile_breaks, uses the row numbers from orderedList to calculate the values of the first and third quartiles of the Year_Birth column. It does this by selecting the Year_Birth value for the row that corresponds to the 25th and 75th percentiles of the data, respectively. It then assigns these values to q_one_lower, q_one_upper, q_three_lower, and q_three_upper.

3. The third CTE, iqr, uses the quartile values from quartile_breaks to calculate the interquartile range (IQR) of the Year_Birth column. It does this by multiplying the difference between the first and third quartiles by 1.5. It also calculates the median value of the data, which is used to calculate the upper and lower bounds of the range of non-outlier data points.

4. The final SELECT statement filters the customer table to only include rows where the Year_Birth value is outside of the range of non-outlier values calculated in iqr. Specifically, it selects all rows where the Year_Birth value is greater than the upper bound (calculated as the third quartile plus 1.5 times the IQR) or less than the lower bound (calculated as the first quartile minus 1.5 times the IQR).

This SQL code uses quartile calculations to identify potential outliers. I calculated the IQR and then identified any data points that fall outside of the range of non-outlier values.

********************************************************************************************************************************************
-- Delete the outliers 
DELETE FROM customer
WHERE ID = 1150 
DELETE FROM customer
WHERE ID = 7829 
DELETE FROM customer
WHERE ID = 11004

This SQL code deletes specific rows from the customer table based on their ID values. It removes the rows with ID values of 1150, 7829, and 11004.

*******************************************************************************************************************************************************
-- To find null values-- 
SELECT income
FROM customer
WHERE income IS NULL

o/p: There are 24 null values

-- Replace null values with the average income 
SELECT AVG(income) FROM customer

-- o/p: (52247.2513537906)

update customer set income= 52247.2513537906 where income is null

The first statement uses the SELECT command to extract data from the income column of the customer table where the value is null. It uses the WHERE clause and the IS NULL condition to filter out any non-null values from the incomecolumn. The output of this statement will be a list of all the rows where the income value is null.

The second statement calculates the average value of the income column using the AVG() function. This statement will output a single value, which is the average income of all the customers in the customer table. 

The second statement is being used to replace the null values in the income column with the average income value calculated in this statement.
**********************************************************************************************************************************
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

-- Update Marital_Status= 'Alone' with 'Single' 
SELECT ID, Marital_Status
FROM customer 
WHERE Marital_Status = 'Alone'

update customer set Marital_Status= 'Single' where ID in (92, 433, 7660)

select distinct Marital_Status
FROM customer

The SQL code is written to update the Marital_Status column in the customer table:

1. The first section of code selects the ID and Marital_Status columns for any rows in which the Marital_Status value is 'YOLO'.

2. The second section of code updates the Marital_Status column for the rows with an ID of 492 and 11133 to 'unknown'.

3. The third section of code selects the ID and Marital_Status columns for any rows in which the Marital_Status value is 'Absurd'.

4. The fourth section of code updates the Marital_Status column for the rows with an ID of 4369 and 7734 to 'unknown'.

5. The fifth section of code selects the distinct values in the Marital_Status column of the customer table, which will include 'unknown' after the previous updates.

6. The sixth section of code selects the ID and Marital_Status columns for any rows in which the Marital_Status value is 'Alone'.

7. The seventh section of code updates the Marital_Status column for the rows with an ID of 92, 433, and 7660 to 'Single'.

This SQL code updates the Marital_Status column in the customer table by replacing certain non-standard or inconsistent values with more standardized values that will likely be more useful for analysis or reporting purposes. 






# Analysis

I have analyzed the dataset with SSMS(SQL Server Management Studio) and also performed visualization with [Tableau](https://public.tableau.com/app/profile/divya1779/viz/MavenMarketingAnalysis/MavenMarketing).The dataset was divided into 2 tables: customer and purchase. The below questions were answered through SQL analysis.

1. Are there any null values or outliers? How will you handle them?

   There are 24 null values in the income column of the customer table which were replaced with the average values based on education column. There were also 3 outliers which were removed as it will cause inconsistency in the data analysis.

2. What factors are significantly related to the number of web purchases?

   More purchases were made through web when compared to deal purchases and catalog purchases.

3. Which marketing campaign was the most successful?

   Campaign 4 was the most successful one.

4. What does the average customer look like?

   This question can be answered by finding the  average age of the customer 54.09, that is 54. 

5. Which products are performing best?

   Wine has yeilded more profits $680816. So, it can be said as best performing product.

6. Which channels are underperforming?

   Porducts that were purchased on deal performed low.

# Tableau Dashboard

View here [Tableau](https://public.tableau.com/app/profile/divya1779/viz/MavenMarketingAnalysis/MavenMarketing)

![image](https://user-images.githubusercontent.com/54399391/211943988-165eb845-fbb8-48bd-ac31-efde762a8c06.png)



