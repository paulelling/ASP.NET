CREATE PROCEDURE [dbo].[usp_Type_Value] 
	@sCommand varchar(50) = NULL, 
	@iValueID int = NULL,
	@sValue varchar(50) = NULL,
	@iTypeID int = NULL,
	@iOrderBy int = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @sDatabaseObject as varchar(50) = 'dbo.usp_Type_Value'
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
		[Value_ID]
		,[Value]
		,[Type_ID]
		,[Order_By]
		FROM [dbo].[Type_Value]	
		WHERE [Type_ID] = @iTypeID
		ORDER BY [Order_By]
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Insert'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION	

				DECLARE @iNextOrderBy as int
				
				SELECT 
				@iNextOrderBy = MAX([Order_By]) + 1
				FROM [Type_Value] 	
				WHERE [Type_ID] = @iTypeID
							
				INSERT INTO [dbo].[Type_Value]
				(
				[Value]
				,[Type_ID]
				,[Order_By]
				)
				VALUES
				(
				@sValue
				,@iTypeID
				,@iNextOrderBy
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
				
				UPDATE [dbo].[Type_Value]
				SET [Value] = @sValue
				,[Order_By] = @iOrderBy
				WHERE [Value_ID] = @iValueID
		
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
			
				DELETE FROM [dbo].[Type_Value]
				WHERE [Value_ID] = @iValueID
	
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


