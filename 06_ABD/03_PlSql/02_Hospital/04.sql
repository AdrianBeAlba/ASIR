CREATE OR REPLACE PROCEDURE Insertar_Enfermo(
    p_nombre IN VARCHAR2,
    p_apellidos IN VARCHAR2,
    p_direccion IN VARCHAR2
)
AS
    v_num_filas NUMBER;
BEGIN
    -- Contar las filas antes de la inserción
    SELECT COUNT(*) INTO v_num_filas FROM ENFERMO;
    DBMS_OUTPUT.PUT_LINE('Nº de filas en tabla ENFERMO antes de insertar= ' || v_num_filas);

    -- Insertar en la tabla ENFERMO
    INSERT INTO ENFERMO (NUMSEGSOCIAL, FECHA_NACIMIENTO, NOMBRE, APELLIDOS, DIRECCION, SEXO)
    VALUES (280862486, TO_DATE('01/01/2000', 'DD/MM/YYYY'), p_nombre, p_apellidos, p_direccion, 'M');

    -- Insertar 10 registros en la tabla HOSPITAL_ENFERMO
    FOR i IN 1..10 LOOP
        INSERT INTO HOSPITAL_ENFERMO (HOSP_CODIGO, INSCRIPCION, ENF_NUMSEGSOCIAL, FINSCRIPCION)
        VALUES (6, seq_inscripcion.NEXTVAL, 280862486, TO_DATE('01/01/2000', 'DD/MM/YYYY') + seq_inscripcion.NEXTVAL);
    END LOOP;

    -- Confirmar la transacción
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Inserción completada con éxito.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END Insertar_Enfermo;
/
