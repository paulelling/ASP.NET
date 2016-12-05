CREATE PROCEDURE [dbo].[usp_Account_Security_Value] 
	@sCommand varchar(50) = NULL, 
	@iValueID int = NULL,
	@iValueInteger int = NULL,
	@sValueVarchar varchar(50) = NULL,
	@dtValueDatetime datetime = NULL,
	@dValueDecimal decimal(18,2) = NULL,
	@bValueBoolean bit = NULL,
	@nvValueNVarchar nvarchar(255) = NULL,
	@iAccountSecurityID int = NULL,
	@iAttributeID int = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @sDatabaseObject as varchar(50) = 'dbo.usp_Account_Security_Value'
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
	    ,[Value_Integer]
	    ,[Value_Varchar_50]
	    ,[Value_Datetime]
	    ,[Value_Decimal]
	    ,[Value_Boolean]
	    ,[Value_Nvarchar_255]
	    ,[Account_Security_ID]
	    ,[Attribute_ID]
		FROM [dbo].[Account_Security_Value]		
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Insert'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION	
				
				INSERT INTO [dbo].[Account_Security_Value]
			    ([Value_Integer]
			    ,[Value_Varchar_50]
			    ,[Value_Datetime]
			    ,[Value_Decimal]
			    ,[Value_Boolean]
			    ,[Value_Nvarchar_255]
			    ,[Account_Security_ID]
			    ,[Attribute_ID])
				VALUES
				(
				@iValueInteger
			    ,@sValueVarchar
			    ,@dtValueDatetime
			    ,@dValueDecimal
			    ,@bValueBoolean
			    ,@nvValueNVarchar
			    ,@iAccountSecurityID
			    ,@iAttributeID
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
				
				UPDATE [dbo].[Account_Security_Value]
				SET [Value_Integer] = @iValueInteger
				,[Value_Varchar_50] = @sValueVarchar
				,[Value_Datetime] = @dtValueDatetime
				,[Value_Decimal] = @dValueDecimal
				,[Value_Boolean] = @bValueBoolean
				,[Value_Nvarchar_255] = @nvValueNVarchar
				,[Account_Security_ID] = @iAccountSecurityID
				,[Attribute_ID] = @iAttributeID
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
			
				DELETE FROM [dbo].[Account_Security_Value]
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


