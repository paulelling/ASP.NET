CREATE VIEW [dbo].[uv_Accounts]
AS

SELECT 
AC.[Account_ID]
,AC.[Vendor_ID]
,VE.[Name] AS [Vendor]
,AC.[Account_Type_ID]
,TV.[Value] AS [Account_Type]
,AC.[Order_By]
FROM [dbo].[Account] AC
INNER JOIN [dbo].[Vendor] VE ON AC.[Vendor_ID] = VE.[Vendor_ID]
INNER JOIN [dbo].[Type_Value] TV ON AC.[Account_Type_ID] = TV.Value_ID
  



GO


