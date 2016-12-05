CREATE VIEW [dbo].[uv_Types]
AS

SELECT 
TY.[Type_ID]
,TY.[Type]
,TV.[Value_ID]
,TV.[Value]
,TV.[Order_By]
FROM [dbo].[Type] TY
INNER JOIN [dbo].[Type_Value] TV ON TY.Type_ID = TV.Type_ID
  
  
  

GO


