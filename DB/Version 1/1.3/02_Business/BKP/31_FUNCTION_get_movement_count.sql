CREATE OR REPLACE FUNCTION get_movement_count (
    p_description     IN VARCHAR2,
    p_month           IN NUMBER,
    p_year            IN NUMBER
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
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- En caso de no encontrar datos, retorna 0
    WHEN OTHERS THEN
        RAISE; -- Vuelve a lanzar cualquier otra excepción
END;
/