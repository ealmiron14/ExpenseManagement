USE [DBBudget_2]
GO

DECLARE @RC int
DECLARE @p_description varchar(50)
DECLARE @p_amount decimal(18,2)
DECLARE @p_effective_date datetime
DECLARE @p_null_date datetime
DECLARE @p_update_date datetime

SET @p_description = 'Asignacion Mari'
SET @p_amount = 120000
SET @p_effective_date = GETDATE() 
SET @p_null_date = NULL 
SET @p_update_date = GETDATE()

EXECUTE @RC = [dbo].[insert_constant_value_data] 
   @p_description
  ,@p_amount
  ,@p_effective_date
  ,@p_null_date
  ,@p_update_date

SET @p_description = 'Asignacion Gasto Ordinario'
SET @p_amount = 0
SET @p_effective_date = GETDATE() 
SET @p_null_date = NULL 
SET @p_update_date = GETDATE()

EXECUTE @RC = [dbo].[insert_constant_value_data] 
   @p_description
  ,@p_amount
  ,@p_effective_date
  ,@p_null_date
  ,@p_update_date
GO


