# Maven Marketing Analysis Dataset
This Dataset has been taken from the Maven Analytics website. It has marketing campaign data of 2240 customers of Maven Marketing,  including customer profiles, product preferences, campaign successes/failures, and channel performance. 

# Features 
* Field - Description
* ID - Customer's unique identifier
* Year_Birth - Customer's birth year
* Education - Customer's education level
* Marital_Status - Customer's marital status
* Income - Customer's yearly household income
* Kidhome	- Number of children in customer's household
* Teenhome - Number of teenagers in customer's household
* Dt_Customer - Date of customer's enrollment with the company
* Recency - Number of days since customer's last purchase
* MntWines - Amount spent on wine in the last 2 years
* MntFruits -	Amount spent on fruits in the last 2 years
* MntMeatProducts - Amount spent on meat in the last 2 years
* MntFishProducts	- Amount spent on fish in the last 2 years
* MntSweetProducts - Amount spent on sweets in the last 2 years
* MntGoldProds - Amount spent on gold in the last 2 years
* NumDealsPurchases -	Number of purchases made with a discount
* NumWebPurchases - Number of purchases made through the company's web site
* NumCatalogPurchases - Number of purchases made using a catalogue
* NumStorePurchases -	Number of purchases made directly in stores
* NumWebVisitsMonth -	Number of visits to company's web site in the last month
* AcceptedCmp3 - 1 if customer accepted the offer in the 3rd campaign, 0 otherwise
* AcceptedCmp4 - 1 if customer accepted the offer in the 4th campaign, 0 otherwise
* AcceptedCmp5 - 1 if customer accepted the offer in the 5th campaign, 0 otherwise
* AcceptedCmp1 - 1 if customer accepted the offer in the 1st campaign, 0 otherwise
* AcceptedCmp2 - 1 if customer accepted the offer in the 2nd campaign, 0 otherwise
* Response - 1 if customer accepted the offer in the last campaign, 0 otherwise
* Complain - 1 if customer complained in the last 2 years, 0 otherwise
* Country - Customer's location

# Tools used 
SSMS, SQL 
# SQL skills
DDL, DML, DQL for database creation, data insertion, querying, aggregation functions, joins, grouping, sorting, data cleaning and transformation.

# Data Cleaning
There are some data quality issues that are identified in the dataset like missing data, Outliers, inconsistent data and duplicate data.
* Null values: There are 24 null values in the income column of the customer table which were replaced with the average value based on income.
* Outliers: The Year_Birth column has 3 outliers which were deleted as having outliers can mess up the analysis by bringing the averages up or down and in general distorting the statistics.
* Inconsisteny: Marital status column has some inconsistent data like absurd, alone and YOLO. Absurd and YOLO values were changed to unknown and alone was changed to single.
* Data cleaning was performed using simple to complex SQL queries.

# Analysis
I have analyzed the dataset with SSMS(SQL Server Management Studio). The dataset was divided into 2 tables: customer and purchase. The below questions were answered through SQL analysis.

1. Are there any null values or outliers? How will you handle them?
* There were 24 null values in the income column, which were replaced with average values based on the education column. Additionally, 3 outliers were removed to ensure consistency in the data analysis.
2. What factors are significantly related to the number of web purchases?
* Web purchases were more prevalent compared to deal and catalog purchases.
3. Which marketing campaign was the most successful?
* Campaign 4 emerged as the most successful marketing campaign.
4. What does the average customer look like?
* The average customer has an age of approximately 54.
5. Which products are performing best?
* Wine has yielded the highest profits of $680,816, making it the best performing product.
6. Which channels are underperforming?
* Deal purchases showed lower performance compared to other channels.

# Recommendations
* **Web Purchases**: Since web purchases are more prevalent than deal and catalog purchases, it would be wise to focus marketing efforts on improving the online shopping experience, optimizing website functionality, and investing in digital marketing strategies to drive further growth in web purchases.

* **Marketing Campaigns**: Given that Campaign 4 was the most successful, it would be advisable to analyze the factors that contributed to its effectiveness. Identify the specific elements that made Campaign 4 successful and consider incorporating similar strategies, messaging, or channels into future marketing campaigns to maximize their impact.

* **Customer Profile**: Understanding that the average customer has an age of around 54, it would be beneficial to tailor marketing messages, product offerings, and customer experiences to cater to this demographic. Consider conducting further market research to gain insights into the preferences, needs, and behaviors of customers within this age group.

* **Product Performance**: As wine has shown the highest profits, it would be worthwhile to allocate additional resources and marketing efforts towards promoting and expanding the wine product line. Consider exploring partnerships with wineries, enhancing wine-related content, and implementing targeted marketing campaigns to further capitalize on its success.

* **Underperforming Channels**: Given that deal purchases demonstrated lower performance, it may be worthwhile to evaluate the effectiveness of the deal channel. Consider analyzing the reasons behind its underperformance, such as pricing strategies, product selection, or customer targeting, and explore potential improvements or alternative marketing channels that align better with the target audience's preferences and behaviors.
