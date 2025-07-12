-- Declaración de variables para los parámetros del procedimiento
DECLARE @p_id INT;
DECLARE @p_description VARCHAR(50);
DECLARE @p_movement_type_id INT;

-- Primera inserción: 'Gasto Extraordinario'
SET @p_id = 10;
SET @p_description = 'Gasto Extraordinario';
SET @p_movement_type_id = 1;
EXEC insert_movement_sub_type_data @p_id, @p_description, @p_movement_type_id;

-- Segunda inserción: 'Mensualidad Mari'
SET @p_id = 11;
SET @p_description = 'Mensualidad Mari';
SET @p_movement_type_id = 1;
EXEC insert_movement_sub_type_data @p_id, @p_description, @p_movement_type_id;

-- Tercera inserción: 'Gasto Ordinario'
SET @p_id = 12;
SET @p_description = 'Gasto Ordinario';
SET @p_movement_type_id = 1;
EXEC insert_movement_sub_type_data @p_id, @p_description, @p_movement_type_id;

-- Cuarta inserción: 'Ingreso'
SET @p_id = 20;
SET @p_description = 'Ingreso';
SET @p_movement_type_id = 2;
EXEC insert_movement_sub_type_data @p_id, @p_description, @p_movement_type_id;
