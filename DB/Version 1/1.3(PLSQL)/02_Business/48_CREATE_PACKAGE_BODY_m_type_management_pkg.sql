-- Package Body
CREATE OR REPLACE PACKAGE BODY m_type_management_pkg
IS
    PROCEDURE insert_movement_type_data (
        p_id                IN NUMBER,
        p_description       IN VARCHAR2
    )
    IS
    BEGIN
        --NOTA DE DEBUG: TODO, VALIDACIONES
		
		INSERT INTO movement_type (
            id,
            description
        ) VALUES (
            p_id,
            p_description
        );
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END insert_movement_type_data;

    FUNCTION get_movement_type_count (
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
            movement_type
        WHERE
            description = p_description;

        RETURN v_count;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END get_movement_type_count;

    FUNCTION delete_movement_type (
        p_description       IN VARCHAR2
    )
    RETURN NUMBER
    IS
        v_rows_deleted NUMBER := 0;
    BEGIN
        DELETE FROM movement_type
        WHERE
            description = p_description;
			
		-- Obtenemos el número de filas afectadas por la sentencia DELETE
        v_rows_deleted := SQL%ROWCOUNT;
        COMMIT;

        RETURN v_rows_deleted;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END delete_movement_type;

END m_type_management_pkg;
/
