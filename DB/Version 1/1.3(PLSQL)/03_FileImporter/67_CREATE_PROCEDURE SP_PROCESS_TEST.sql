CREATE OR REPLACE PROCEDURE SP_PROCESS_TEST (
/* NOTA DEBUG: ESTE SP ES UN EJEMPLO DE UN SP LLAMADO DINAMICAMENTE DESDE EL SP 
SP_READ_FILE_IMPORTER_DATA.
BASICAMENTE DEBERIA LEER Y LUEGO PROCESAR PARA EL TAG DEL PROCESO, TODOS AQUELLOS
REGISTROS DE LAS TABLAS FILE_IMPORTER_FILE y FILE_IMPORTER_FILE_DET CON PROCESSED = 'N'
MARCANDOLOS CON 'Y' AL FINALIZAR
*/
    p_fixed_w         IN FILE_IMPORTER_PROCESS.FIXED_W%TYPE,
    p_char_separation IN FILE_IMPORTER_PROCESS.CHAR_SEPARATION%TYPE
)
AS
BEGIN
    -- Habilitar la salida de DBMS_OUTPUT para ver los resultados
    DBMS_OUTPUT.ENABLE(NULL);

    -- Mensaje de confirmación para indicar que el procedimiento fue llamado
    --DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('--- SP_PROCESS_TEST: Procedimiento de prueba llamado ---');
    DBMS_OUTPUT.PUT_LINE('   Parámetro p_fixed_w recibido: ' || p_fixed_w);
    DBMS_OUTPUT.PUT_LINE('   Parámetro p_char_separation recibido: ' || NVL(p_char_separation, 'NULL'));
    DBMS_OUTPUT.PUT_LINE('--- Fin de SP_PROCESS_TEST ---');
    --DBMS_OUTPUT.PUT_LINE(' ');

EXCEPTION
    WHEN OTHERS THEN
        -- Manejo de errores en caso de que algo salga mal
        --DBMS_OUTPUT.PUT_LINE('Error en SP_PROCESS_TEST: ' || SQLERRM);
        -- Opcional: 
		RAISE; --para propagar el error
END SP_PROCESS_TEST;
/

-- Para probar este procedimiento directamente:
-- SET SERVEROUTPUT ON;
-- EXEC SP_PROCESS_TEST('Y', '|');
-- EXEC SP_PROCESS_TEST('N', NULL);
