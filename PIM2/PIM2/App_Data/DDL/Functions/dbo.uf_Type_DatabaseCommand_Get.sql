CREATE FUNCTION [dbo].[uf_Type_DatabaseCommand_Get]
(
	@sCommand varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @sDatabaseCommand as varchar(50)
	
	SELECT @sDatabaseCommand = [Value]
	FROM [dbo].[uv_Types]
	WHERE [Type] = 'Database Command'
	AND [Value] = @sCommand

	RETURN @sDatabaseCommand

END


GO


