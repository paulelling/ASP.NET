CREATE PROCEDURE [dbo].[usp_Status] 
	@iYear as int
AS
BEGIN
	SET NOCOUNT ON;
			
	DECLARE @Status as TABLE
	(
		Vendor varchar(50) null,
		Account_Type varchar(50) null,
		Month int null,
		Month_Name varchar(50) null,
		Debits decimal(18,2) null,
		Credits decimal(18,2) null,
		Surplus_Deficit decimal(18,2) null,
		Order_By int null
	)

	INSERT INTO @Status
	SELECT [Vendor]
		  ,[Account_Type]
		  ,0 AS 'Month'
		  ,'Beginning Balance' AS 'Month_Name'
		  ,0 AS 'Debits'
		  ,[Transaction_Amount] AS 'Credits'
		  ,[Transaction_Amount] AS 'Surplus_Deficit'      
		  ,[Account_Order_By]
	  FROM [PIM2].[dbo].[uv_Transactions]
	  WHERE [Account_Type] NOT IN ('Retirement', 'Investment', 'Gold', 'Silver')	  
	  AND [Transaction_Description_Type] = 'Beginning Balance'
	  AND Year([Transaction_Date]) = @iYear
	UNION ALL  
	SELECT [Vendor]
		  ,[Account_Type]
		  ,MONTH([Transaction_Date]) AS 'Month'
		  ,Datename(month, [Transaction_Date]) AS 'Month_Name'      
		  ,Sum(CASE WHEN [Transaction_Type] = 'Debit' THEN [Transaction_Amount] ELSE 0 END) AS 'Debits'
		  ,Sum(CASE WHEN [Transaction_Type] = 'Credit' THEN [Transaction_Amount] ELSE 0 END) AS 'Credits'
		  ,(Sum(CASE WHEN [Transaction_Type] = 'Credit' THEN [Transaction_Amount] ELSE 0 END) - Sum(CASE WHEN [Transaction_Type] = 'Debit' THEN [Transaction_Amount] ELSE 0 END)) AS 'Surplus_Deficit'      
		  ,[Account_Order_By]
	  FROM [PIM2].[dbo].[uv_Transactions]
	  WHERE [Account_Type] NOT IN ('Retirement', 'Investment', 'Gold', 'Silver')
		AND [Transaction_Description_Type] <> 'Beginning Balance'
		AND Year([Transaction_Date]) = @iYear
	  GROUP BY [Vendor], [Account_Type], MONTH([Transaction_Date]) , Datename(month, [Transaction_Date]), [Account_Order_By]
	  order by [Vendor], [Account_Type], [Month]

	INSERT INTO @Status
	SELECT [Vendor]
		  ,[Account_Type]
		  ,0 AS 'Month'
		  ,'Beginning Balance' AS 'Month_Name'
		  ,0 AS 'Debits'
		  ,[Transaction_Amount] AS 'Credits'
		  ,[Transaction_Amount] AS 'Surplus_Deficit'      
		  ,[Account_Order_By]
	  FROM [PIM2].[dbo].[uv_Transactions]
	  WHERE [Account_Type] IN ('Retirement', 'Investment', 'Gold', 'Silver')
	  AND [Transaction_Description_Type] = 'Beginning Balance'
	  AND Year([Transaction_Date]) = @iYear
	UNION ALL  
	SELECT [Vendor]
		  ,[Account_Type]
		  ,MONTH([Transaction_Date]) AS 'Month'
		  ,Datename(month, [Transaction_Date]) AS 'Month_Name'      
		  ,Sum(CASE WHEN [Transaction_Type] = 'Debit' THEN [Transaction_Amount] ELSE 0 END) AS 'Debits'
		  ,Sum(CASE WHEN [Transaction_Type] = 'Credit' THEN [Transaction_Amount] ELSE 0 END) AS 'Credits'
		  ,(Sum(CASE WHEN [Transaction_Type] = 'Credit' THEN [Transaction_Amount] ELSE 0 END) - Sum(CASE WHEN [Transaction_Type] = 'Debit' THEN [Transaction_Amount] ELSE 0 END)) AS 'Surplus_Deficit'      
		  ,[Account_Order_By]
	  FROM [PIM2].[dbo].[uv_Transactions]
	  WHERE [Account_Type] IN ('Retirement', 'Investment', 'Gold', 'Silver')
	  AND [Transaction_Description_Type] = 'Balance'
	  AND Year([Transaction_Date]) = @iYear
	  GROUP BY [Vendor], [Account_Type], MONTH([Transaction_Date]) , Datename(month, [Transaction_Date]), [Account_Order_By]
	  order by [Vendor], [Account_Type], [Month]
	  
	  
		UPDATE @Status
		SET Credits = 0,
		Surplus_Deficit = 0
		WHERE [Vendor] = 'HSBC Bank USA' 
		AND [Account_Type] = 'Savings'
		AND [Month] BETWEEN 1 AND 3
	  

DECLARE @StatusTotals AS TABLE
(
	Vendor varchar(50) null,
	Account_Type varchar(50) null,
	Beginning_Balance decimal(18,2) null,
	January decimal(18,2) null,
	February decimal(18,2) null,
	March decimal(18,2) null,
	April decimal(18,2) null,
	May decimal(18,2) null,
	June decimal(18,2) null,
	July decimal(18,2) null,
	August decimal(18,2) null,
	September decimal(18,2) null,
	October decimal(18,2) null,
	November decimal(18,2) null,
	December decimal(18,2) null,
	Order_By int null
)	  

	INSERT INTO @StatusTotals
	SELECT 
	Vendor,
	Account_Type,
	Isnull([Beginning Balance],0) AS 'Beginning_Balance', 
	Isnull(January,0) AS 'January', 
	Isnull(February,0) AS 'February', 
	Isnull(March,0) AS 'March', 
	Isnull(April,0) AS 'April', 
	Isnull(May,0) AS 'May', 
	Isnull(June,0) AS 'June', 
	Isnull(July,0) AS 'July', 
	Isnull(August,0) AS 'August', 
	Isnull(September,0) AS 'September', 
	Isnull(October,0) AS 'October', 
	Isnull(November,0) AS 'November', 
	Isnull(December,0) AS 'December'
	,Order_By
	FROM
		(
		SELECT 
		st.Vendor,
		st.Account_Type,
		st.Month_Name,
		st.Surplus_Deficit +
		Isnull((
			SELECT 
			Sum(Surplus_Deficit) 
			FROM @Status
			WHERE Vendor = st.Vendor
			AND Account_Type = st.Account_Type
			AND Month < st.Month
		), 0) AS 'Balance',
		st.Order_By
		FROM @Status st
		WHERE st.Account_Type NOT IN ('Retirement', 'Investment', 'Gold', 'Silver')
		) AS MS PIVOT (Sum(Balance) FOR Month_Name IN ([Beginning Balance], January, February, March, April, May, June, July, August, September, October, November, December)) AS MO
	UNION ALL
	SELECT 
	Vendor,
	Account_Type,
	Isnull([Beginning Balance],0) AS 'Beginning_Balance', 
	Isnull(January,0) AS 'January', 
	Isnull(February,0) AS 'February', 
	Isnull(March,0) AS 'March', 
	Isnull(April,0) AS 'April', 
	Isnull(May,0) AS 'May', 
	Isnull(June,0) AS 'June', 
	Isnull(July,0) AS 'July', 
	Isnull(August,0) AS 'August', 
	Isnull(September,0) AS 'September', 
	Isnull(October,0) AS 'October', 
	Isnull(November,0) AS 'November', 
	Isnull(December,0) AS 'December'
	,Order_By
	FROM
		(
		SELECT 
		st.Vendor,
		st.Account_Type,
		st.Month_Name,
		st.Credits AS 'Balance',
		st.Order_By
		FROM @Status st
		WHERE st.Account_Type IN ('Retirement', 'Investment', 'Gold', 'Silver')
		) AS MS PIVOT (Sum(Balance) FOR Month_Name IN ([Beginning Balance], January, February, March, April, May, June, July, August, September, October, November, December)) AS MO


	INSERT INTO @StatusTotals
	SELECT
	'All Vendors' AS Vendor,
	'Assests' AS Account_Type,
	Sum(Beginning_Balance) AS Beginning_Balance,
	Sum(January) AS January,
	Sum(February) AS February,
	Sum(March) AS March,
	Sum(April) AS April,
	Sum(May) AS May,
	Sum(June) AS June,
	Sum(July) AS July,
	Sum(August) AS August,
	Sum(September) AS September,
	Sum(October) AS October,
	Sum(November) AS November,
	Sum(December) AS December,
	1999 AS Order_By
	FROM @StatusTotals
	WHERE Account_Type <> 'Credit'	
	
	INSERT INTO @StatusTotals
	SELECT
	'All Vendors' AS Vendor,
	'Liabilities' AS Account_Type,
	Sum(Beginning_Balance) AS Beginning_Balance,
	Sum(January) AS January,
	Sum(February) AS February,
	Sum(March) AS March,
	Sum(April) AS April,
	Sum(May) AS May,
	Sum(June) AS June,
	Sum(July) AS July,
	Sum(August) AS August,
	Sum(September) AS September,
	Sum(October) AS October,
	Sum(November) AS November,
	Sum(December) AS December,
	2999 AS Order_By
	FROM @StatusTotals
	WHERE Account_Type = 'Credit'		
	
	INSERT INTO @StatusTotals
	SELECT
	'All Accounts' AS Vendor,
	'Status' AS Account_Type,
	Sum(Beginning_Balance) AS Beginning_Balance,
	Sum(January) AS January,
	Sum(February) AS February,
	Sum(March) AS March,
	Sum(April) AS April,
	Sum(May) AS May,
	Sum(June) AS June,
	Sum(July) AS July,
	Sum(August) AS August,
	Sum(September) AS September,
	Sum(October) AS October,
	Sum(November) AS November,
	Sum(December) AS December,
	9999 AS Order_By
	FROM @StatusTotals
	WHERE Vendor = 'All Vendors'			
	
	
	SELECT
	Vendor,
	Account_Type,
	Beginning_Balance,
	January,
	February,
	March,
	April,
	May,
	June,
	July,
	August,
	September,
	October,
	November,
	December,
	Order_By
	FROM @StatusTotals
	ORDER BY Order_By  




	
	
END
















GO


