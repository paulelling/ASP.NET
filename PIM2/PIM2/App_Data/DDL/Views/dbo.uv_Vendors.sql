CREATE VIEW [dbo].[uv_Vendors]
AS

SELECT 
VE.[Vendor_ID]
,VE.[Name]
,VE.[Vendor_Type_ID]
,TV.[Value] AS [Vendor_Type]
FROM [dbo].[Vendor] VE
INNER JOIN [dbo].[Type_Value] TV ON VE.Vendor_Type_ID = TV.[Value_ID]
  



GO


