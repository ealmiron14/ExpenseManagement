-- Package Header
CREATE OR REPLACE PACKAGE m_sub_type_management_pkg
IS
    -- Procedimiento para ingresar un nuevo registro en la tabla movement_sub_type
    PROCEDURE insert_movement_sub_type_data (
        p_id                IN NUMBER,
        p_description       IN VARCHAR2,
        p_movement_type_id  IN NUMBER
    );

    -- Funcion para contar los registros en movement_sub_type basada en descripcion
    FUNCTION get_movement_sub_type_count (
        p_description       IN VARCHAR2
    )
    RETURN NUMBER;

    -- Funcion para eliminar los registros en movement_sub_type basada en descripcion
    FUNCTION delete_movement_sub_type (
        p_description       IN VARCHAR2
    )
    RETURN NUMBER;

END m_sub_type_management_pkg;
/