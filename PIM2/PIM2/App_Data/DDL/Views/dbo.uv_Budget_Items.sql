CREATE VIEW [dbo].[uv_Budget_Items]
AS

SELECT DISTINCT
[Value_ID]
,[Value]
FROM [dbo].[uv_Types]
where Type in ('Budget Gross Income', 'Budget Pre-Tax', 'Budget Tax', 'Budget Savings', 'Budgetary Expense')







GO


