-- Package Body
-- Contiene la implementación real de los procedimientos y funciones declarados en la especificación.
CREATE OR REPLACE PACKAGE BODY constant_v_management_pkg
IS
    PROCEDURE insert_constant_value_data (
        p_description          IN VARCHAR2,
        p_amount               IN NUMBER,
        p_effective_date       IN DATE,
        p_null_date            IN DATE,
        p_update_date          IN DATE
    )
    IS
    BEGIN
        --NOTA DE DEBUG: TODO, VALIDACIONES
		
		INSERT INTO constant_value (
            description,
            amount,
            effective_date,
            null_date,
            update_date
        ) VALUES (
            p_description,
            p_amount,
            p_effective_date,
            p_null_date,
            p_update_date
        );
        COMMIT; -- Confirma la transacción
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; -- Revierte la transacción en caso de error
            RAISE;    -- Vuelve a lanzar la excepción
    END insert_constant_value_data;

    FUNCTION get_constant_value_count (
        p_description          IN VARCHAR2
    )
    RETURN NUMBER
    IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM constant_value
        WHERE description = p_description; -- Búsqueda exacta por descripción
        
        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END get_constant_value_count;

    FUNCTION delete_constant_value (
        p_description          IN VARCHAR2
    )
    RETURN NUMBER
    IS
        v_rows_deleted NUMBER; -- Variable que almacena el número de filas eliminadas
    BEGIN
        DELETE FROM constant_value
        WHERE description = p_description -- Búsqueda exacta por descripción
        ;

        -- Obtenemos el número de filas afectadas por la sentencia DELETE
        v_rows_deleted := SQL%ROWCOUNT;

        RETURN v_rows_deleted;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE; -- Vuelve a lanzar la excepción
    END delete_constant_value;
	
	FUNCTION update_constant_value (
		p_description        IN VARCHAR2,
		p_new_amount         IN NUMBER,
		p_new_effective_date IN DATE
	) RETURN NUMBER
	IS
		v_updated_rows NUMBER := 0;
	BEGIN
		-- Actualiza el monto y la fecha de efecto para la descripción dada.
		-- La coincidencia de la descripción debe ser exacta.
		UPDATE constant_value
		SET
			amount         = p_new_amount,
			effective_date = p_new_effective_date,
			update_date    = SYSDATE
		WHERE
			description = p_description; -- Coincidencia exacta de la descripción

		-- Obtenemos el numero de filas afectadas por la sentencia UPDATE
		v_updated_rows := SQL%ROWCOUNT;

		COMMIT;

		RETURN v_updated_rows;

	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE; -- Vuelve a lanzar la excepcion
	END update_constant_value;

END constant_v_management_pkg;
/
