-- Package Body
CREATE OR REPLACE PACKAGE BODY m_sub_type_management_pkg
IS
    PROCEDURE insert_movement_sub_type_data (
        p_id                IN NUMBER,
        p_description       IN VARCHAR2,
        p_movement_type_id  IN NUMBER
    )
    IS
    BEGIN
        --NOTA DE DEBUG: TODO, VALIDACIONES
		
		INSERT INTO movement_sub_type (
            id,
            description,
            movement_type_id
        ) VALUES (
            p_id,
            p_description,
            p_movement_type_id
        );
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END insert_movement_sub_type_data;

    FUNCTION get_movement_sub_type_count (
        p_description       IN VARCHAR2
    )
    RETURN NUMBER
    IS
        v_count NUMBER;
    BEGIN
        SELECT
            COUNT(*)
        INTO v_count
        FROM
            movement_sub_type
        WHERE
            description = p_description;

        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END get_movement_sub_type_count;

    FUNCTION delete_movement_sub_type (
        p_description       IN VARCHAR2
    )
    RETURN NUMBER
    IS
        v_rows_deleted NUMBER := 0;
    BEGIN
        DELETE FROM movement_sub_type
        WHERE
            description = p_description; -- Búsqueda exacta por descripción
		
		-- Obtenemos el número de filas afectadas por la sentencia DELETE
        v_rows_deleted := SQL%ROWCOUNT;
        COMMIT;

        RETURN v_rows_deleted;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END delete_movement_sub_type;

END m_sub_type_management_pkg;
/