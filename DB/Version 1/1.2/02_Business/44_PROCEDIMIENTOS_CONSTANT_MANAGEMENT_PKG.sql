--NOTA DE DEBUG: 12-JUL-25 PROCEDIMIENTOS DE CONSTANT_MANAGEMENT_PKG(ORACLE)
-- ====================================================================
-- Procedimiento Almacenado: insert_constant_value_data
-- Descripción: Inserta una nueva entrada de valor constante en la tabla 'ConstantValue'.
-- ====================================================================
CREATE OR ALTER PROCEDURE insert_constant_value_data
    @p_description        VARCHAR(50),
    @p_amount             DECIMAL(18, 2),
    @p_effective_date     DATETIME,
    @p_null_date          DATETIME,
    @p_update_date        DATETIME
AS
BEGIN
    -- Inicia una transacción para asegurar la atomicidad de la operación.
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        BEGIN TRANSACTION; -- Inicia la transacción

        -- NOTA DE DEBUG: TODO, VALIDACIONES
        -- Aquí se pueden añadir validaciones adicionales si son necesarias.

        INSERT INTO ConstantValue ( -- Cambiado de constant_value
            Description,
            Amount,
            EffectiveDate,
            NullDate,
            UpdateDate
        ) VALUES (
            @p_description,
            @p_amount,
            @p_effective_date,
            @p_null_date,
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
-- Función Escalar: get_constant_value_count
-- Descripción: Retorna el número de valores constantes que coinciden con una descripción específica.
-- ====================================================================
CREATE OR ALTER FUNCTION get_constant_value_count
(
    @p_description VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @v_count INT;

    SELECT @v_count = COUNT(*)
    FROM ConstantValue -- Cambiado de constant_value
    WHERE Description = @p_description; -- Búsqueda exacta por descripción

    RETURN @v_count;
END;
GO

-- ====================================================================
-- Procedimiento Almacenado: delete_constant_value
-- Descripción: Elimina valores constantes que coinciden con una descripción específica,
--              y retorna el número de filas eliminadas.
-- ====================================================================
CREATE OR ALTER PROCEDURE delete_constant_value
    @p_description        VARCHAR(50), -- Longitud especificada: VARCHAR(50)
    @p_rows_deleted       INT OUTPUT   -- Parámetro de salida para el número de filas eliminadas
AS
BEGIN
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM ConstantValue -- Cambiado de constant_value
        WHERE Description = @p_description; -- Búsqueda exacta por descripción

        SET @p_rows_deleted = @@ROWCOUNT;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revierte la transacción.
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Vuelve a lanzar la excepción.
        THROW;
    END CATCH;
END;
GO

-- ====================================================================
-- Procedimiento Almacenado: update_constant_value
-- Descripción: Actualiza el monto y la fecha efectiva de un valor constante
--              basándose en su descripción, y retorna el número de filas actualizadas.
-- ====================================================================
CREATE OR ALTER PROCEDURE update_constant_value
    @p_description        VARCHAR(50),
    @p_new_amount         DECIMAL(18, 2),
    @p_new_effective_date DATETIME,
    @p_updated_rows       INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON; -- Suprime los mensajes de conteo de filas afectadas.

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Actualiza el monto, la fecha de efecto y la fecha de actualización para la descripción dada.
        UPDATE ConstantValue -- Cambiado de constant_value
        SET
            Amount         = @p_new_amount,
            EffectiveDate  = @p_new_effective_date,
            UpdateDate     = GETDATE()
        WHERE
            Description = @p_description; -- Coincidencia exacta de la descripción

        SET @p_updated_rows = @@ROWCOUNT;

        COMMIT TRANSACTION; -- Confirma la transacción
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO
