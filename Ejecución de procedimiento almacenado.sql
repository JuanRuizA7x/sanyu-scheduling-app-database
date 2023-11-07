DECLARE
    p_date DATE := TO_DATE('2023-12-11', 'yyyy-mm-dd'); -- Reemplaza con la fecha que desees
    p_report WORK_SHIFT_REPORT_LIST;
    p_error_message VARCHAR2(100);
BEGIN
    GET_ASSIGNED_WORK_SHIFTS_BY_DATE(TO_DATE('2023-12-11', 'yyyy-mm-dd'), p_report, p_error_message);

    -- Imprimir el contenido de las variables de salida
    DBMS_OUTPUT.PUT_LINE('Error Message: ' || p_error_message);

    FOR i IN 1..p_report.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Record ' || i || ':');
        DBMS_OUTPUT.PUT_LINE('Identification Type: ' || p_report(i).IDENTIFICATION_TYPE);
        DBMS_OUTPUT.PUT_LINE('Identification Number: ' || p_report(i).IDENTIFICATION_NUMBER);
        DBMS_OUTPUT.PUT_LINE('Full Name: ' || p_report(i).FULL_NAME);
        DBMS_OUTPUT.PUT_LINE('Email: ' || p_report(i).EMAIL);
        DBMS_OUTPUT.PUT_LINE('Role: ' || p_report(i).ROLE);
        DBMS_OUTPUT.PUT_LINE('Schedule: ' || p_report(i).SCHEDULE);
        DBMS_OUTPUT.PUT_LINE('Start Time: ' || p_report(i).START_TIME);
        DBMS_OUTPUT.PUT_LINE('End Time: ' || p_report(i).END_TIME);
        DBMS_OUTPUT.PUT_LINE('Is Started: ' || p_report(i).IS_STARTED);
        DBMS_OUTPUT.PUT_LINE('Extension Start Time: ' || p_report(i).EXTENSION_START_TIME);
        DBMS_OUTPUT.PUT_LINE('Extension End Time: ' || p_report(i).EXTENSION_END_TIME);
        DBMS_OUTPUT.PUT_LINE('Extension Reason: ' || p_report(i).EXTENSION_REASON);
        DBMS_OUTPUT.NEW_LINE();
    END LOOP;
    
END;