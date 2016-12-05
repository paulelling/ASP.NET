CREATE PROCEDURE [dbo].[usp_Budget] 
	@sCommand varchar(50) = NULL, 
	@iItemID int = NULL,
	@sBudgetItem varchar(50) = NULL,
	@sPayPeriod varchar(50) = NULL,
	@dAmount decimal(18,2) = NULL
AS
BEGIN
	SET NOCOUNT ON;
			
	DECLARE @sDatabaseObject as varchar(50) = 'dbo.usp_Budget'
	DECLARE @sDatabaseCommand as varchar(50) = [dbo].[uf_Type_DatabaseCommand_Get](@sCommand)
	DECLARE @iErrorNumber as int
	DECLARE @sErrorMessage as nvarchar(4000)
	DECLARE @iErrorSeverity as int
	DECLARE @iErrorState as int
	DECLARE @iErrorLine as int
	DECLARE @sErrorProcedure as nvarchar(200)	
	
	DECLARE @iPayPeriod as int
	
	SELECT @iPayPeriod = [Value_ID]      
	FROM [PIM2].[dbo].[uv_Types]
	WHERE [Type] = 'Budget Pay Period'
	AND [Value] = @sPayPeriod		
	
	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Select'
	BEGIN	
				
		DECLARE @Budget_Items AS TABLE
		(
			Budget_Group_ID int null,
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period_ID int null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int null
		)

		INSERT INTO @Budget_Items
		SELECT 
		it.Type_ID AS 'Budget_Group_ID'
		,it.Type AS 'Budget_Group'
		,bi.[Item_ID] AS 'Budget_Item_ID'
		,it.[Value] AS 'Budget_Item'
		,bi.[Pay_Period] AS 'Pay_Period_ID'
		,pp.Value AS 'Pay_Period'
		,bi.[Amount]
		,it.Order_By
		FROM [Budget_Item] bi
		INNER JOIN [uv_Types] it on bi.[Item_ID] = it.Value_ID
		INNER JOIN [uv_Types] pp on bi.[Pay_Period] = pp.Value_ID


		DECLARE @Budget_Gross_Income AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int null
		)

		INSERT INTO @Budget_Gross_Income
		SELECT 
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Items
		WHERE Budget_Group = 'Budget Gross Income'

		DECLARE @Budget_Pre_Tax AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int null
		)

		INSERT INTO @Budget_Pre_Tax
		SELECT 
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Items
		WHERE Budget_Group = 'Budget Pre-Tax'

		DECLARE @Budget_Tax AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int null
		)

		INSERT INTO @Budget_Tax
		SELECT 
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Items
		WHERE Budget_Group = 'Budget Tax'
		
		DECLARE @Budget_Savings AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int
		)

		INSERT INTO @Budget_Savings
		SELECT 
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Items
		WHERE Budget_Group = 'Budget Savings'		

		DECLARE @Budget_Expense AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int
		)

		INSERT INTO @Budget_Expense
		SELECT 
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Items
		WHERE Budget_Group = 'Budgetary Expense'

		DECLARE @BudgetGroups AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period varchar(50) null,
			Amount decimal(18,2) null,
			Order_By int
		)

		INSERT INTO @BudgetGroups
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By 
		FROM @Budget_Gross_Income

		INSERT INTO @BudgetGroups
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Pre_Tax

		INSERT INTO @BudgetGroups
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Tax
		
		INSERT INTO @BudgetGroups
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Savings		

		INSERT INTO @BudgetGroups
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @Budget_Expense

		DECLARE @Budget AS TABLE
		(
			Budget_Group varchar(50) null,
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period_1 decimal(18,2) null,
			Pay_Period_2 decimal(18,2) null,
			Order_By int
		)

		INSERT INTO @Budget
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			isnull([Period 1],0) AS Period_1,
			isnull([Period 2],0) AS Period_2,
			Order_By
		FROM (
		SELECT
			Budget_Group,
			Budget_Item_ID,
			Budget_Item,
			Pay_Period,
			Amount,
			Order_By
		FROM @BudgetGroups
		) AS BU PIVOT ( Sum(Amount) FOR Pay_Period IN ([Period 1], [Period 2]) ) AS MO


		DECLARE @BudgetDisplay AS TABLE
		(
			Budget_Item_ID int null,
			Budget_Item varchar(50) null,
			Pay_Period_1 decimal(18,2) null,
			Pay_Period_2 decimal(18,2) null
		)

		INSERT INTO @BudgetDisplay
		SELECT
			Budget_Item_ID,
			Budget_Item,
			Pay_Period_1,
			Pay_Period_2
		FROM @Budget
		WHERE Budget_Group = 'Budget Gross Income'
		ORDER BY Order_By

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)

		INSERT INTO @BudgetDisplay
		SELECT
			Budget_Item_ID,
			Budget_Item,
			Pay_Period_1,
			Pay_Period_2
		FROM @Budget
		WHERE Budget_Group = 'Budget Pre-Tax'
		ORDER BY Order_By

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)

		INSERT INTO @BudgetDisplay
		SELECT
			Budget_Item_ID,
			Budget_Item,
			Pay_Period_1,
			Pay_Period_2
		FROM @Budget
		WHERE Budget_Group = 'Budget Tax'
		ORDER BY Order_By

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)

		INSERT INTO @BudgetDisplay
		SELECT
			0,
			'Total Pay Deductions',
			Sum(Pay_Period_1) AS Pay_Period_1,
			Sum(Pay_Period_2) AS Pay_Period_2
		FROM @Budget
		WHERE Budget_Group IN ('Budget Pre-Tax', 'Budget Tax')

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)
		
		INSERT INTO @BudgetDisplay
		SELECT
			Budget_Item_ID,
			Budget_Item,
			Pay_Period_1,
			Pay_Period_2
		FROM @Budget
		WHERE Budget_Group = 'Budget Savings'
		ORDER BY Order_By
		
		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)	
		
		INSERT INTO @BudgetDisplay
		SELECT
			0,
			'Total Savings',
			Sum(Pay_Period_1) AS Pay_Period_1,
			Sum(Pay_Period_2) AS Pay_Period_2
		FROM @Budget
		WHERE Budget_Group IN ('Budget Savings')					

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)		

		INSERT INTO @BudgetDisplay
		SELECT
		0,
		'Operating Income'
		,
		Pay_Period_1
		-
		(
			SELECT
			Pay_Period_1
			FROM @BudgetDisplay
			WHERE Budget_Item = 'Total Pay Deductions'
		)
		-
		(
			SELECT
			Pay_Period_1
			FROM @BudgetDisplay
			WHERE Budget_Item = 'Total Savings'		
		)
		,
		Pay_Period_2
		-
		(
			SELECT
			Pay_Period_2
			FROM @BudgetDisplay
			WHERE Budget_Item = 'Total Pay Deductions'
		)
		-
		(
			SELECT
			Pay_Period_2
			FROM @BudgetDisplay
			WHERE Budget_Item = 'Total Savings'
		)		
		FROM @BudgetDisplay
		WHERE Budget_Item = 'Gross Income' 

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)

		INSERT INTO @BudgetDisplay
		SELECT
			Budget_Item_ID,
			Budget_Item,
			Pay_Period_1,
			Pay_Period_2
		FROM @Budget
		WHERE Budget_Group = 'Budgetary Expense'
		ORDER BY Order_By

		INSERT INTO @BudgetDisplay VALUES (null, null, null, null)

		INSERT INTO @BudgetDisplay
		SELECT
			0,
			'Total Expenses',
			Sum(Pay_Period_1) AS Pay_Period_1,
			Sum(Pay_Period_2) AS Pay_Period_2
		FROM @Budget
		WHERE Budget_Group IN ('Budgetary Expense')

		INSERT INTO @BudgetDisplay
		SELECT
		0,
		'Discretionary Income'
		,
		Pay_Period_1
		-
		(
			SELECT
			Pay_Period_1
			FROM @BudgetDisplay
			WHERE Budget_Item = 'Total Expenses'
		)
		,
		Pay_Period_2
		-
		(
			SELECT
			Pay_Period_2
			FROM @BudgetDisplay
			WHERE Budget_Item = 'Total Expenses'
		)
		FROM @BudgetDisplay
		WHERE Budget_Item = 'Operating Income' 

		SELECT
			Budget_Item_ID AS iItemID,
			Budget_Item AS sBudgetItem,
			Pay_Period_1,
			Pay_Period_2,
			(Pay_Period_1 + Pay_Period_2) AS Monthly_Total
		FROM @BudgetDisplay	
	END

	-------------------------------------------------------------------------------
	IF @sDatabaseCommand = 'Insert'
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION								
				
				INSERT INTO [dbo].[Budget_Item]
				(
				[Item_ID]
				,[Pay_Period]
				,[Amount]
				)
				VALUES
				(
				@iItemID
				,@iPayPeriod
				,@dAmount
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
				
				UPDATE [dbo].[Budget_Item]
				SET [Amount] = @dAmount
				WHERE [Item_ID] = @iItemID
				AND [Pay_Period] = @iPayPeriod					
		
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
			
				SELECT @iItemID = [Value_ID]
				FROM [dbo].[uv_Budget_Items]
				WHERE [Value] = @sBudgetItem
			
				DELETE FROM [dbo].[Budget_Item]
				WHERE [Item_ID] = @iItemID									
	
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


