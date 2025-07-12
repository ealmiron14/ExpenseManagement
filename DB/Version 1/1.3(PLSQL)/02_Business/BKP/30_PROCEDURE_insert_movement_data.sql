CREATE OR REPLACE PROCEDURE insert_movement_data (
    p_description         IN VARCHAR2,
    p_amount              IN NUMBER,
    p_movement_sub_type_id IN NUMBER,
    p_completion_date     IN DATE,
    p_effective_date      IN DATE,
    p_update_date         IN DATE
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
        RAISE; -- Vuelve a lanzar la excepción
END;
/
