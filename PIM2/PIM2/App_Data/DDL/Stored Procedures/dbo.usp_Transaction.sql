CREATE PROCEDURE [dbo].[usp_Transaction] 
	@sCommand varchar(50) = NULL, 
	@iTransactionID int = NULL,
	@iAccountID int = NULL,
	@dtTransactionDate datetime = NULL,
	@iTransactionDefinitionID int = NULL,
	@dTransactionAmount decimal(18,2) = NULL,
	@sTransactionType varchar(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @sDatabaseObject as varchar(50) = 'dbo.usp_Transaction'
	DECLARE @sDatabaseCommand as varchar(50) = [dbo].[uf_Type_DatabaseCommand_Get](@sCommand)
	DECLARE @iErrorNumber as int
	DECLARE @sErrorMessage as nvarchar(4000)
	DECLARE @iErrorSeverity as int
	DECLARE @iErrorState as int
	DECLARE @iErrorLine as int
	DECLARE @sErrorProcedure as nvarchar(200)	
	
	DECLARE @iTransactionTypeID as int
	
	SELECT
	@iTransactionTypeID = [Value_ID]
	FROM [uv_Types]
	WHERE [Type] = 'Transaction Type'
	AND [Value] = @sTransactionType			
	
	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Select'
	BEGIN
		SELECT 
		[Transaction_ID]
		,[Account_ID]
		,[Transaction_Date]
		,[Transaction_Definition_ID]
		,[Transaction_Amount]
		,[Transaction_Type_ID]
		FROM [dbo].[Transaction]	
		ORDER BY [Transaction_Date]	ASC, [Account_ID] ASC
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Insert'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION		
				
				INSERT INTO [dbo].[Transaction]
				(
				[Account_ID]
				,[Transaction_Date]
				,[Transaction_Definition_ID]
				,[Transaction_Amount]
				,[Transaction_Type_ID])
				VALUES
				(
				@iAccountID
				,@dtTransactionDate
				,@iTransactionDefinitionID
				,@dTransactionAmount
				,@iTransactionTypeID
				)						
				
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH		
			SET @iErrorNumber = ERROR_NUMBER()
			SET @sErrorMessage = ERROR_MESSAGE()
			SET @iErrorSeverity = ERROR_SEVERITY()
			SET @iErrorState = ERROR_STATE()
			SET @iErrorLine = ERROR_LINE()
			SET @sErrorProcedure = ERROR_PROCEDURE()
		
			IF @@TRANCOUNT > 0
				BEGIN				
					ROLLBACK TRANSACTION
				END	
				
			EXECUTE [dbo].[usp_Failed_Database_Transaction] 
			  @sDatabaseObject
			  ,@sDatabaseCommand
			  ,@iErrorNumber
			  ,@sErrorMessage
			  ,@iErrorSeverity
			  ,@iErrorState
			  ,@iErrorLine
			  ,@sErrorProcedure
		END CATCH
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Update'	
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION	
				
				UPDATE [dbo].[Transaction]
				SET [Account_ID] = @iAccountID
				,[Transaction_Date] = @dtTransactionDate
				,[Transaction_Definition_ID] = @iTransactionDefinitionID
				,[Transaction_Amount] = @dTransactionAmount
				,[Transaction_Type_ID] = @iTransactionTypeID
				WHERE [Transaction_ID] = @iTransactionID
		
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH		
			SET @iErrorNumber = ERROR_NUMBER()
			SET @sErrorMessage = ERROR_MESSAGE()
			SET @iErrorSeverity = ERROR_SEVERITY()
			SET @iErrorState = ERROR_STATE()
			SET @iErrorLine = ERROR_LINE()
			SET @sErrorProcedure = ERROR_PROCEDURE()
		
			IF @@TRANCOUNT > 0
				BEGIN				
					ROLLBACK TRANSACTION
				END	
				
			EXECUTE [dbo].[usp_Failed_Database_Transaction] 
			  @sDatabaseObject
			  ,@sDatabaseCommand
			  ,@iErrorNumber
			  ,@sErrorMessage
			  ,@iErrorSeverity
			  ,@iErrorState
			  ,@iErrorLine
			  ,@sErrorProcedure
		END CATCH
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Delete'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION	
			
				DELETE FROM [dbo].[Transaction]
				WHERE [Transaction_ID] = @iTransactionID
	
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH		
			SET @iErrorNumber = ERROR_NUMBER()
			SET @sErrorMessage = ERROR_MESSAGE()
			SET @iErrorSeverity = ERROR_SEVERITY()
			SET @iErrorState = ERROR_STATE()
			SET @iErrorLine = ERROR_LINE()
			SET @sErrorProcedure = ERROR_PROCEDURE()
		
			IF @@TRANCOUNT > 0
				BEGIN				
					ROLLBACK TRANSACTION
				END	
				
			EXECUTE [dbo].[usp_Failed_Database_Transaction] 
			  @sDatabaseObject
			  ,@sDatabaseCommand
			  ,@iErrorNumber
			  ,@sErrorMessage
			  ,@iErrorSeverity
			  ,@iErrorState
			  ,@iErrorLine
			  ,@sErrorProcedure
		END CATCH	
	END
	
END












GO


