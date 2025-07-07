-- Package Body
-- Contiene la implementación real de los procedimientos y funciones declarados en la especificación.
CREATE OR REPLACE PACKAGE BODY movement_management_pkg
IS
    PROCEDURE insert_movement_data (
        p_description          IN VARCHAR2,
        p_amount               IN NUMBER,
        p_movement_sub_type_id IN NUMBER,
        p_completion_date      IN DATE,
        p_effective_date       IN DATE,
        p_update_date          IN DATE
    )
    IS
    BEGIN
        --NOTA DE DEBUG: TODO, VALIDACIONES
		
		INSERT INTO movement (
            description,
            amount,
            movement_sub_type_id,
            completion_date,
            effective_date,
            update_date
        ) VALUES (
            p_description,
            p_amount,
            p_movement_sub_type_id,
            p_completion_date,
            p_effective_date,
            p_update_date
        );
        COMMIT; -- Confirma la transacción
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK; -- Revierte la transacción en caso de error
            RAISE;    -- Vuelve a lanzar la excepción
    END insert_movement_data;

    FUNCTION get_movement_count (
        p_description          IN VARCHAR2,
        p_month                IN NUMBER,
        p_year                 IN NUMBER
    )
    RETURN NUMBER
    IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM movement
        WHERE description = p_description -- Búsqueda exacta por descripción
          AND EXTRACT(MONTH FROM effective_date) = p_month
          AND EXTRACT(YEAR FROM effective_date) = p_year;

        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE; 
    END get_movement_count;

    FUNCTION delete_movement (
        p_description          IN VARCHAR2,
        p_month                IN NUMBER,
        p_year                 IN NUMBER
    )
    RETURN NUMBER
    IS
        v_rows_deleted NUMBER; -- Variable que almacena el numero de filas eliminadas
    BEGIN
        DELETE FROM movement
        WHERE description = p_description -- Búsqueda exacta por descripción
          AND EXTRACT(MONTH FROM effective_date) = p_month
          AND EXTRACT(YEAR FROM effective_date) = p_year;

        -- Obtenemos el numero de filas afectadas por la sentencia DELETE
        v_rows_deleted := SQL%ROWCOUNT;

        RETURN v_rows_deleted;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE; -- Vuelve a lanzar la excepcion
    END delete_movement;

END movement_management_pkg;
/
