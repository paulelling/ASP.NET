CREATE VIEW [dbo].[uv_Account_Security]
AS

SELECT 
AC.[Account_ID]
,AC.[Vendor_ID]
,VE.[Name] AS [Vendor]
,AC.[Account_Type_ID]
,TV.[Value] AS [Account_Type]
,AC.[Order_By]
,AT.[Account_Security_ID]
,ATA.[Attribute_ID]
,ATA.[Name] AS [Attribute]
,ATA.[Data_Type_ID]
,DT.[Value] AS [Data_Type]
,ATV.[Value_Integer]
,ATV.[Value_Varchar_50]
,ATV.[Value_Datetime]
,ATV.[Value_Decimal]
,ATV.[Value_Boolean]
,ATV.[Value_Nvarchar_255]
FROM [dbo].[Account] AC
INNER JOIN [dbo].[Vendor] VE ON AC.[Vendor_ID] = VE.[Vendor_ID]
INNER JOIN [dbo].[Type_Value] TV ON AC.[Account_Type_ID] = TV.Value_ID
INNER JOIN [dbo].[Account_Security] AT ON AC.[Account_ID] = AT.[Account_ID]
INNER JOIN [dbo].[Account_Security_Value] ATV ON AT.[Account_Security_ID] = ATV.[Account_Security_ID]
INNER JOIN [dbo].[Account_Security_Attribute] ATA ON ATV.[Attribute_ID] = ATA.[Attribute_ID]
INNER JOIN [dbo].[Type_Value] DT ON ATA.[Data_Type_ID] = DT.[Value_ID]





GO


