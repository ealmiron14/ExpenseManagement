--NOTA DE DEBUG: 12-JUL-25 PROCEDIMIENTOS DE MOVEMENT_MANAGEMENT_PKG(ORACLE)
-- ====================================================================
-- Procedimiento Almacenado: insert_movement_data
-- Descripción: Inserta una nueva entrada de movimiento en la tabla 'Movement'.
-- ====================================================================
CREATE OR ALTER PROCEDURE insert_movement_data
    @p_description        VARCHAR(50),
    @p_amount             DECIMAL(18, 2),
    @p_movement_sub_type_id INT,
    @p_completion_date    DATETIME,
    @p_effective_date     DATETIME,
    @p_update_date        DATETIME
AS
BEGIN
    -- Inicia una transacción para asegurar la atomicidad de la operación.
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        BEGIN TRANSACTION; -- Inicia la transacción

        -- NOTA DE DEBUG: TODO, VALIDACIONES
        -- Aquí se pueden añadir validaciones adicionales si son necesarias.

        INSERT INTO Movement ( -- Cambiado de movement
            Description,
            Amount,
            MovementSubTypeId,
            CompletionDate,
            EffectiveDate,
            UpdateDate
        ) VALUES (
            @p_description,
            @p_amount,
            @p_movement_sub_type_id,
            @p_completion_date,
            @p_effective_date,
            @p_update_date
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
-- Función Escalar: get_movement_count
-- Descripción: Retorna el número de movimientos que coinciden con una descripción,
--              mes y año específicos.
-- ====================================================================
CREATE OR ALTER FUNCTION get_movement_count
(
    @p_description VARCHAR(50),
    @p_month       INT,
    @p_year        INT
)
RETURNS INT
AS
BEGIN
    DECLARE @v_count INT;

    SELECT @v_count = COUNT(*)
    FROM Movement -- Cambiado de movement
    WHERE Description = @p_description -- Búsqueda exacta por descripción
      AND MONTH(EffectiveDate) = @p_month
      AND YEAR(EffectiveDate) = @p_year;

    RETURN @v_count;
END;
GO

-- ====================================================================
-- Procedimiento Almacenado: delete_movement
-- Descripción: Elimina movimientos que coinciden con una descripción,
--              mes y año específicos, y retorna el número de filas eliminadas.
-- ====================================================================
CREATE OR ALTER PROCEDURE delete_movement
    @p_description        VARCHAR(50),
    @p_month              INT,
    @p_year               INT,
    @p_rows_deleted       INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        DELETE FROM Movement -- Cambiado de movement
        WHERE Description = @p_description -- Búsqueda exacta por descripción
          AND MONTH(EffectiveDate) = @p_month
          AND YEAR(EffectiveDate) = @p_year;

        SET @p_rows_deleted = @@ROWCOUNT;

    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO
