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

[Tableau](https://public.tableau.com/app/profile/divya1779/viz/MavenMarketingAnalysis/MavenMarketing)

![image](https://user-images.githubusercontent.com/54399391/211943988-165eb845-fbb8-48bd-ac31-efde762a8c06.png)

