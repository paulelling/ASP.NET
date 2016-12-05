CREATE VIEW [dbo].[uv_Spending]
AS

SELECT 
MO.Year
,MO.Transaction_Category AS Expense
, Sum(IsNull(January, 0)) AS January
, Sum(IsNull(February, 0)) AS February
, Sum(IsNull(March, 0)) AS March
, Sum(IsNull(April, 0)) AS April
, Sum(IsNull(May, 0)) AS May
, Sum(IsNull(June, 0)) AS June
, Sum(IsNull(July, 0)) AS July
, Sum(IsNull(August, 0)) AS August
, Sum(IsNull(September, 0)) AS September
, Sum(IsNull(October, 0)) AS October
, Sum(IsNull(November, 0)) AS November
, Sum(IsNull(December, 0)) AS December
, [Transaction_Category_Order_By] AS 'Order'
FROM
(SELECT 
Year([Transaction_Date]) AS 'Year'
,[Transaction_Category]
,Month([Transaction_Date]) AS 'Month'
,Datename(month, [Transaction_Date]) AS 'Month_Name'
,[Transaction_Amount]
,[Transaction_Category_Order_By]
  FROM [PIM2].[dbo].[uv_Transactions]
  WHERE [Transaction_Description_Type] = 'Expense'
) AS EX PIVOT ( Sum(Transaction_Amount) FOR Month_Name IN (January, February, March, April, May, June, July, August, September, October, November, December) ) AS MO
GROUP BY MO.Year, MO.Transaction_Category, MO.[Transaction_Category_Order_By]






GO


