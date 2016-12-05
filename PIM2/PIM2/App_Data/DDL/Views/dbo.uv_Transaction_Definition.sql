CREATE VIEW [dbo].[uv_Transaction_Definitions]
AS

SELECT 
TD.[Transaction_Definition_ID]
,TD.[Transaction_Description_ID]
,TS.[Value] AS [Transaction_Description]
,TD.[Transaction_Description_Type_ID]
,TT.[Value] AS [Transaction_Description_Type]
,TD.[Transaction_Category_ID]
,TC.[Value] AS [Transaction_Category]
FROM [dbo].[Transaction_Definition] TD
INNER JOIN [dbo].[Type_Value] TS ON TD.[Transaction_Description_ID] = TS.[Value_ID]
INNER JOIN [dbo].[Type_Value] TT ON TD.[Transaction_Description_Type_ID] = TT.[Value_ID]
INNER JOIN [dbo].[Type_Value] TC ON TD.[Transaction_Category_ID] = TC.[Value_ID]



GO


