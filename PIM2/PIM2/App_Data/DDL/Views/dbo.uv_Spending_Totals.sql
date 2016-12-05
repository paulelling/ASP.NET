CREATE VIEW [dbo].[uv_Spending_Totals]
AS

SELECT [Year]
	  ,[Expense]
      ,[January]
      ,[February]
      ,[March]
      ,[April]
      ,[May]
      ,[June]
      ,[July]
      ,[August]
      ,[September]
      ,[October]
      ,[November]
      ,[December]
      ,[Order]
  FROM [PIM2].[dbo].[uv_Spending]
  WHERE [Expense] IN (SELECT [Value]
  FROM [PIM2].[dbo].[uv_Types]
  WHERE [Type] = 'Budgetary Expense')
  UNION ALL
SELECT [Year]
	  ,'Total Expenses'
      ,Sum([January]) AS 'January'
      ,Sum([February]) AS 'February'
      ,Sum([March]) AS 'March'
      ,Sum([April]) AS 'April'
      ,Sum([May]) AS 'May'
      ,Sum([June]) AS 'June'
      ,Sum([July]) AS 'July'
      ,Sum([August]) AS 'August'
      ,Sum([September]) AS 'September'
      ,Sum([October]) AS 'October'
      ,Sum([November]) AS 'November'
      ,Sum([December]) AS 'December'
      ,1999 AS 'Order'
  FROM [PIM2].[dbo].[uv_Spending]
  WHERE [Expense] IN (SELECT [Value]
  FROM [PIM2].[dbo].[uv_Types]
  WHERE [Type] = 'Budgetary Expense')  
  GROUP BY [Year]
UNION ALL
SELECT [Year]
	  ,[Expense]
      ,[January]
      ,[February]
      ,[March]
      ,[April]
      ,[May]
      ,[June]
      ,[July]
      ,[August]
      ,[September]
      ,[October]
      ,[November]
      ,[December]
      ,[Order]
  FROM [PIM2].[dbo].[uv_Spending]
  WHERE [Expense] NOT IN (SELECT [Value]
  FROM [PIM2].[dbo].[uv_Types]
  WHERE [Type] = 'Budgetary Expense')  
  UNION ALL
SELECT [Year]
	  ,'Total Extra Spending'
      ,Sum([January]) AS 'January'
      ,Sum([February]) AS 'February'
      ,Sum([March]) AS 'March'
      ,Sum([April]) AS 'April'
      ,Sum([May]) AS 'May'
      ,Sum([June]) AS 'June'
      ,Sum([July]) AS 'July'
      ,Sum([August]) AS 'August'
      ,Sum([September]) AS 'September'
      ,Sum([October]) AS 'October'
      ,Sum([November]) AS 'November'
      ,Sum([December]) AS 'December'
      ,2999 AS 'Order'
  FROM [PIM2].[dbo].[uv_Spending]
  WHERE [Expense] NOT IN (SELECT [Value]
  FROM [PIM2].[dbo].[uv_Types]
  WHERE [Type] = 'Budgetary Expense')  
  GROUP BY [Year]
  UNION ALL
SELECT [Year]
	  ,'Total Spending'
      ,Sum([January]) AS 'January'
      ,Sum([February]) AS 'February'
      ,Sum([March]) AS 'March'
      ,Sum([April]) AS 'April'
      ,Sum([May]) AS 'May'
      ,Sum([June]) AS 'June'
      ,Sum([July]) AS 'July'
      ,Sum([August]) AS 'August'
      ,Sum([September]) AS 'September'
      ,Sum([October]) AS 'October'
      ,Sum([November]) AS 'November'
      ,Sum([December]) AS 'December'
      ,9999 AS 'Order'
  FROM [PIM2].[dbo].[uv_Spending]
  GROUP BY [Year]







GO


