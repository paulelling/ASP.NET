CREATE VIEW [dbo].[uv_Transactions]
AS

SELECT 
TR.[Transaction_ID]
,TR.[Account_ID]
,AC.[Vendor_ID]
,VE.[Name] AS 'Vendor'
,VE.[Vendor_Type_ID]
,VT.[Value] AS 'Vendor_Type'
,AC.[Account_Type_ID]
,AC.[Order_By] AS 'Account_Order_By'
,AT.[Value] AS 'Account_Type'
,TR.[Transaction_Date]
,TR.[Transaction_Definition_ID]
,TD.[Transaction_Description_ID]
,TS.[Value] AS 'Transaction_Description'
,TS.[Order_By] AS 'Transaction_Description_Order_By'
,TD.[Transaction_Description_Type_ID]
,TT.[Value] AS 'Transaction_Description_Type'
,TT.[Order_By] AS 'Transaction_Description_Type_Order_By'
,TD.[Transaction_Category_ID]
,TC.[Value] AS 'Transaction_Category'
,TC.[Order_By] AS 'Transaction_Category_Order_By'
,TR.[Transaction_Amount]
,TR.[Transaction_Type_ID]
,TY.[Value] AS 'Transaction_Type'
FROM [dbo].[Transaction] TR
LEFT OUTER JOIN [dbo].[Account] AC ON TR.[Account_ID] = AC.[Account_ID]
LEFT OUTER JOIN [dbo].[Vendor] VE ON AC.[Vendor_ID] = VE.[Vendor_ID]
LEFT OUTER JOIN [dbo].[Type_Value] VT ON VE.[Vendor_Type_ID] = VT.[Value_ID]
LEFT OUTER JOIN [dbo].[Type_Value] AT ON AC.[Account_Type_ID] = AT.[Value_ID]
LEFT OUTER JOIN [dbo].[Transaction_Definition] TD ON TR.[Transaction_Definition_ID] = TD.[Transaction_Definition_ID]
LEFT OUTER JOIN [dbo].[Type_Value] TS ON TD.[Transaction_Description_ID] = TS.[Value_ID] AND TS.[Type_ID] = (SELECT [Type_ID] FROM [dbo].[Type] WHERE [Type] = 'Transaction Description')
LEFT OUTER JOIN [dbo].[Type_Value] TT ON TD.[Transaction_Description_Type_ID] = TT.[Value_ID] AND TT.[Type_ID] = (SELECT [Type_ID] FROM [dbo].[Type] WHERE [Type] = 'Transaction Description Type')
LEFT OUTER JOIN [dbo].[Type_Value] TC ON TD.[Transaction_Category_ID] = TC.[Value_ID]
LEFT OUTER JOIN [dbo].[Type_Value] TY ON TR.[Transaction_Type_ID] = TY.[Value_ID]

  






GO


