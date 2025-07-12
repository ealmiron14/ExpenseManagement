CREATE OR REPLACE PROCEDURE SP_EXECUTE_FILE_PROCESS (
    p_file_tag IN VARCHAR2
)
AS
    -- Variables para FILE_IMPORTER_PROCESS
    v_process_sp_name       FILE_IMPORTER_PROCESS.SP_NAME%TYPE;
    v_process_fixed_w       FILE_IMPORTER_PROCESS.FIXED_W%TYPE;
    v_process_char_separation FILE_IMPORTER_PROCESS.CHAR_SEPARATION%TYPE;
    v_process_is_active     FILE_IMPORTER_PROCESS.IS_ACTIVE%TYPE;
	v_dynamic_sql_stmt		VARCHAR2(200);

BEGIN
    -- Habilitar la salida de DBMS_OUTPUT para ver los resultados
    DBMS_OUTPUT.ENABLE(NULL);

    -- Leer de FILE_IMPORTER_PROCESS
    BEGIN
        SELECT SP_NAME, FIXED_W, CHAR_SEPARATION, IS_ACTIVE
        INTO v_process_sp_name, v_process_fixed_w, v_process_char_separation, v_process_is_active
        FROM FILE_IMPORTER_PROCESS
        WHERE FILE_TAG = p_file_tag;

        -- DBMS_OUTPUT.PUT_LINE('3. FILE_IMPORTER_PROCESS:');
        -- DBMS_OUTPUT.PUT_LINE('   SP Name: ' || NVL(v_process_sp_name, 'N/A'));
        -- DBMS_OUTPUT.PUT_LINE('   Fixed Width: ' || v_process_fixed_w);
        -- DBMS_OUTPUT.PUT_LINE('   Char Separation: ' || NVL(v_process_char_separation, 'N/A'));
        -- DBMS_OUTPUT.PUT_LINE('   Is Active: ' || v_process_is_active);
    EXCEPTION
        WHEN OTHERS THEN
			RAISE;
            --DBMS_OUTPUT.PUT_LINE('Error al leer FILE_IMPORTER_PROCESS: ' || SQLERRM);
    END;
    --DBMS_OUTPUT.PUT_LINE(' ');
	
	-- Llamada dinámica al SP si el SP_NAME está definido y el proceso está activo
	IF v_process_sp_name IS NOT NULL AND v_process_is_active = 'Y' THEN
		BEGIN
			-- Construye la sentencia para llamar al SP dinámico
			v_dynamic_sql_stmt := 'BEGIN ' || v_process_sp_name || '(:fixed_w_param, :char_sep_param); END;';
			--DBMS_OUTPUT.PUT_LINE('   Intentando llamar al SP dinámico: ' || v_process_sp_name);
			-- Ejecuta la sentencia dinámica, pasando los parámetros con USING
			-- NOTA DEBUG: SE PIDE PROCESAR TODOS LOS ARCHIVOS QUE SE ENCUENTRAN EN PROCESSED = 'N'
			EXECUTE IMMEDIATE v_dynamic_sql_stmt
			USING v_process_fixed_w, v_process_char_separation;
			--DBMS_OUTPUT.PUT_LINE('   SP dinámico ' || v_process_sp_name || ' llamado exitosamente.');
		EXCEPTION
			WHEN OTHERS THEN
				--DBMS_OUTPUT.PUT_LINE('   Error al llamar al SP dinámico ' || v_process_sp_name || ': ' || SQLERRM);
				RAISE;
		END;
	END IF;
EXCEPTION
    WHEN OTHERS THEN
		RAISE;
END SP_EXECUTE_FILE_PROCESS;
/