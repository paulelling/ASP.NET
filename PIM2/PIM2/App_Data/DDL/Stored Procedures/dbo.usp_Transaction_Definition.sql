CREATE PROCEDURE [dbo].[usp_Transaction_Definition] 
	@sCommand varchar(50) = NULL, 
	@iTransactionDefinitionID int = NULL,
	@iTransactionDescriptionID int = NULL,
	@iTransactionDescriptionTypeID int = NULL,
	@iTransactionCategoryID int = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @sDatabaseObject as varchar(50) = 'dbo.usp_Transaction_Definition'
	DECLARE @sDatabaseCommand as varchar(50) = [dbo].[uf_Type_DatabaseCommand_Get](@sCommand)
	DECLARE @iErrorNumber as int
	DECLARE @sErrorMessage as nvarchar(4000)
	DECLARE @iErrorSeverity as int
	DECLARE @iErrorState as int
	DECLARE @iErrorLine as int
	DECLARE @sErrorProcedure as nvarchar(200)	
	
	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Select'
	BEGIN
		SELECT 
		[Transaction_Definition_ID]
		,[Transaction_Description_ID]
		,[Transaction_Description_Type_ID]
		,[Transaction_Category_ID]
		FROM [dbo].[Transaction_Definition]		
		ORDER BY [Transaction_Description_ID] ASC, [Transaction_Description_Type_ID] ASC, [Transaction_Category_ID] ASC
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Insert'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION	
			
				INSERT INTO [dbo].[Transaction_Definition]
				(
				[Transaction_Description_ID]
				,[Transaction_Description_Type_ID]
				,[Transaction_Category_ID]
				)
				VALUES
				(
				@iTransactionDescriptionID
				,@iTransactionDescriptionTypeID
				,@iTransactionCategoryID
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
				
				UPDATE [dbo].[Transaction_Definition]
				SET [Transaction_Description_ID] = @iTransactionDescriptionID
				,[Transaction_Description_Type_ID] = @iTransactionDescriptionTypeID
				,[Transaction_Category_ID] = @iTransactionCategoryID
				WHERE [Transaction_Definition_ID] = @iTransactionDefinitionID								
		
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
			
				DELETE FROM [dbo].[Transaction_Definition]
				WHERE [Transaction_Definition_ID] = @iTransactionDefinitionID			
	
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


