CREATE PROCEDURE [dbo].[usp_Failed_Database_Transaction] 
	@sDatabaseObject varchar(50),
	@sDatabaseCommand varchar(50),
	@iErrorNumber int = NULL,
	@sErrorMessage nvarchar(4000) = NULL,
	@iErrorSeverity int = NULL,
	@iErrorState int = NULL,
	@iErrorLine int = NULL,
	@sErrorProcedure nvarchar(200) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO [dbo].[Failed_Database_Transaction]
	(
	[Database_Object]
	,[Transaction_Date]
	,[Database_Command]
	,[Error_Number]
	,[Error_Message]
	,[Error_Severity]
	,[Error_State]
	,[Error_Line]
	,[Error_Procedure]
	)
	VALUES
	(
	@sDatabaseObject
	,GETDATE()
	,@sDatabaseCommand
	,@iErrorNumber
	,@sErrorMessage
	,@iErrorSeverity
	,@iErrorState
	,@iErrorLine
	,@sErrorProcedure
	)
END



GO


