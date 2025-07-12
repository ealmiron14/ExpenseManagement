USE [DBBudget_2]
GO

DECLARE @RC int
DECLARE @p_id int
DECLARE @p_description varchar(50)

SET @p_id = 1;
SET @p_description = 'Gasto'

EXECUTE @RC = [dbo].[insert_movement_type_data] 
   @p_id
  ,@p_description
GO

SET @p_id = 2;
SET @p_description = 'Ingreso'

EXECUTE @RC = [dbo].[insert_movement_type_data] 
   @p_id
  ,@p_description
GO

