-- Package Header
CREATE OR REPLACE PACKAGE movement_management_pkg
IS
    -- Procedimiento para ingresar un nuevo registro de movimiento
    PROCEDURE insert_movement_data (
        p_description          IN VARCHAR2,
        p_amount               IN NUMBER,
        p_movement_sub_type_id IN NUMBER,
        p_completion_date      IN DATE,
        p_effective_date       IN DATE,
        p_update_date          IN DATE
    );

    -- Funcion para contar los registros de movimientos basada en descripcion, mes y año
    FUNCTION get_movement_count (
        p_description          IN VARCHAR2,
        p_month                IN NUMBER,
        p_year                 IN NUMBER
    )
    RETURN NUMBER;

    -- Funcion para eliminar los registros de movimientos basada en descripcion, mes y año
    FUNCTION delete_movement (
        p_description          IN VARCHAR2,
        p_month                IN NUMBER,
        p_year                 IN NUMBER
    )
    RETURN NUMBER;
	
END movement_management_pkg;
/