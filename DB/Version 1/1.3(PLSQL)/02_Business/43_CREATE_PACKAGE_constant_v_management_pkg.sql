-- Package Header
CREATE OR REPLACE PACKAGE constant_v_management_pkg
IS
    -- Procedimiento para ingresar un nuevo registro en la tabla constant_value
    PROCEDURE insert_constant_value_data (
        p_description          IN VARCHAR2,
        p_amount               IN NUMBER,
        p_effective_date       IN DATE,
        p_null_date            IN DATE,
        p_update_date          IN DATE
    );

    -- Funcion para contar los registros en constant_value basada en descripcion
    FUNCTION get_constant_value_count (
        p_description          IN VARCHAR2
    )
    RETURN NUMBER;

    -- Funcion para eliminar los registros en constant_value basada en descripcion
    FUNCTION delete_constant_value (
        p_description          IN VARCHAR2
    )
    RETURN NUMBER;
	
	--Funcion para actualizar los campos de cantidad y fecha de efecto dada una descripcion
	FUNCTION update_constant_value (
		p_description        IN VARCHAR2,
		p_new_amount         IN NUMBER,
		p_new_effective_date IN DATE
	) 
	RETURN NUMBER;

END constant_v_management_pkg;
/