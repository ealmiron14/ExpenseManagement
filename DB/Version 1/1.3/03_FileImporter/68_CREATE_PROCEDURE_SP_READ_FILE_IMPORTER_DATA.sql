CREATE OR REPLACE PROCEDURE SP_READ_FILE_IMPORTER_DATA --(
    --p_file_tag IN VARCHAR2
--)
AS
	-- Cursor para FILE_IMPORTER_GROUP
    CURSOR c_group IS
        SELECT FILE_TAG, INPUT_PATH
        FROM FILE_IMPORTER_GROUP
        WHERE IS_ACTIVE = 'Y';
    v_group_rec         c_group%ROWTYPE;


    -- Cursor para FILE_IMPORTER_GROUP_EXT
    CURSOR c_group_ext(p_file_tag VARCHAR2) IS
        SELECT EXTENSION, IS_ACTIVE
        FROM FILE_IMPORTER_GROUP_EXT
        WHERE FILE_TAG = p_file_tag
			AND IS_ACTIVE = 'Y';
    v_group_ext_rec         c_group_ext%ROWTYPE;
BEGIN
    -- Habilitar la salida de DBMS_OUTPUT para ver los resultados
    DBMS_OUTPUT.ENABLE(NULL);
	
	--DBMS_OUTPUT.PUT_LINE('--- Información para FILE_TAG: ' || p_file_tag || ' ---');
    --DBMS_OUTPUT.PUT_LINE(' ');
	
	--1. 2. NOTA DEBUG: SE USAN PARA LEER LOS ARCHIVOS DESDE LAS UBICACIONES ESTABLECIDAS EN LAS TABLAS FILE_IMPORTER_GROUP, FILE_IMPORTER_GROUP_EXT,
	--ASIMISMO EN ESTAS ETAPAS SE DEBERIAN CARGAR LAS TABLAS FILE_IMPORTER_FILE y FILE_IMPORTER_FILE_DET

    -- 1. NOTA DEBUG: TODO Leer de FILE_IMPORTER_GROUP
	DBMS_OUTPUT.PUT_LINE('1. FILE_IMPORTER_GROUP:');
    OPEN c_group;
    FETCH c_group INTO v_group_rec;
    IF c_group%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron procesos activos');
    ELSE
        LOOP
            DBMS_OUTPUT.PUT_LINE('   - Etiqueta: ' || v_group_rec.FILE_TAG || ', Ubicacion: ' || v_group_rec.INPUT_PATH);
			--
			DBMS_OUTPUT.PUT_LINE('2. FILE_IMPORTER_GROUP_EXT (Extensiones), para la etiqueta: ' || v_group_rec.FILE_TAG);
			OPEN c_group_ext(v_group_rec.FILE_TAG);
			FETCH c_group_ext INTO v_group_ext_rec;
			IF c_group_ext%NOTFOUND THEN
				DBMS_OUTPUT.PUT_LINE('No se encontraron extensiones para el FILE_TAG.');
			ELSE
				LOOP
					DBMS_OUTPUT.PUT_LINE('   - Extension: ' || v_group_ext_rec.EXTENSION);
					--NOTA DEBUG: TODO CARGAR LAS TABLAS FILE_IMPORTER_FILE y FILE_IMPORTER_FILE_DET
					FETCH c_group_ext INTO v_group_ext_rec;
					EXIT WHEN c_group_ext%NOTFOUND;
				END LOOP;
			END IF;
			CLOSE c_group_ext;
			--DBMS_OUTPUT.PUT_LINE(' ');
			--
			--NOTA DEBUG: AL FINALIZAR LA CARGA DE UN DETERMINADO TAG, SE PIDE PROCESAR TODOS LOS ARCHIVOS QUE SE ENCUENTRAN EN PROCESSED = 'N'
			SP_EXECUTE_FILE_PROCESS(v_group_rec.FILE_TAG);
            FETCH c_group INTO v_group_rec;
            EXIT WHEN c_group%NOTFOUND;
        END LOOP;
    END IF;
    CLOSE c_group;
    --DBMS_OUTPUT.PUT_LINE(' ');

EXCEPTION
    WHEN OTHERS THEN
		RAISE;
END SP_READ_FILE_IMPORTER_DATA;
/