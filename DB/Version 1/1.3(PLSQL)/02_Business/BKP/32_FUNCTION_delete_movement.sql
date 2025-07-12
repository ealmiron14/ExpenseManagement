CREATE OR REPLACE FUNCTION delete_movement (
    p_description   IN VARCHAR2,
    p_month         IN NUMBER,
    p_year          IN NUMBER
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
        RAISE;-- Vuelve a lanza la excepcion
END;
/
