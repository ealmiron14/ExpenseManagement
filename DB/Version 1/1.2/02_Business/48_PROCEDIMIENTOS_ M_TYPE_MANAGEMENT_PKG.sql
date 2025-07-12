--NOTA DE DEBUG: 12-JUL-25 PROCEDIMIENTOS DE M_TYPE_MANAGEMENT_PKG(ORACLE)
-- ====================================================================
-- Procedimiento Almacenado: insert_movement_type_data
-- Descripción: Inserta una nueva entrada de tipo de movimiento en la tabla 'MovementType'.
-- ====================================================================
CREATE OR ALTER PROCEDURE insert_movement_type_data
    @p_id                 INT,
    @p_description        VARCHAR(50)
AS
BEGIN
    -- Inicia una transacción para asegurar la atomicidad de la operación.
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        BEGIN TRANSACTION; -- Inicia la transacción

        -- NOTA DE DEBUG: TODO, VALIDACIONES
        -- Aquí se pueden añadir validaciones adicionales si son necesarias.

        INSERT INTO MovementType ( -- Cambiado de movement_type
            Id,
            Description
        ) VALUES (
            @p_id,
            @p_description
        );

        COMMIT TRANSACTION; -- Confirma la transacción si todo es exitoso.
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revierte la transacción.
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO

-- ====================================================================
-- Función Escalar: get_movement_type_count
-- Descripción: Retorna el número de tipos de movimiento que coinciden con una descripción específica.
-- ====================================================================
CREATE OR ALTER FUNCTION get_movement_type_count
(
    @p_description VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @v_count INT;

    SELECT @v_count = COUNT(*)
    FROM MovementType -- Cambiado de movement_type
    WHERE Description = @p_description; -- Búsqueda exacta por descripción

    RETURN @v_count;
END;
GO

-- ====================================================================
-- Procedimiento Almacenado: delete_movement_type
-- Descripción: Elimina tipos de movimiento que coinciden con una descripción específica,
--              y retorna el número de filas eliminadas.
-- ====================================================================
CREATE OR ALTER PROCEDURE delete_movement_type
    @p_description        VARCHAR(50),
    @p_rows_deleted       INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM MovementType -- Cambiado de movement_type
        WHERE Description = @p_description; -- Búsqueda exacta por descripción

        SET @p_rows_deleted = @@ROWCOUNT;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO
