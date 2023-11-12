CREATE OR REPLACE PROCEDURE APP_AGEND_UT.GET_ASSIGNED_WORK_SHIFTS_BY_DATE(
    P_DATE IN DATE,
    P_REPORT OUT WORK_SHIFT_REPORT_LIST,
    P_ERROR_MESSAGE OUT VARCHAR2
) AS

BEGIN

    INSERT INTO APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP (WORK_SHIFT_ID, SCHEDULE_ID, USER_ID, IS_STARTED)
    SELECT WORK_SHIFT_ID, SCHEDULE_ID, USER_ID, CASE WHEN IS_STARTED = 1 THEN 'Sí' ELSE 'No' END
    FROM APP_AGEND_UT.WORK_SHIFT
    WHERE "DATE" = P_DATE;

    UPDATE APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP T
    SET (
        ROLE_ID,
        IDENTIFICATION_TYPE_ID,
        FULL_NAME,
        IDENTIFICATION_NUMBER,
        EMAIL
    ) = (
        SELECT
            ROLE_ID,
            IDENTIFICATION_TYPE_ID,
            (
                CONCAT(FIRST_NAME, ' ') ||
                CASE
                    WHEN MIDDLE_NAME IS NOT NULL
                    THEN CONCAT(MIDDLE_NAME, ' ')
                    ELSE '' 
                END ||
                CASE
                    WHEN SECOND_LAST_NAME IS NOT NULL
                    THEN CONCAT(LAST_NAME, ' ')
                    ELSE LAST_NAME
                END ||
                SECOND_LAST_NAME
            ),
            IDENTIFICATION_NUMBER,
            EMAIL
        FROM APP_AGEND_UT."USER" U
        WHERE U.USER_ID = T.USER_ID
    );

    UPDATE APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP T
    SET ROLE = (
        SELECT NAME FROM APP_AGEND_UT.ROLE R
        WHERE R.ROLE_ID = T.ROLE_ID
    );

    UPDATE APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP T
    SET IDENTIFICATION_TYPE = (
        SELECT NAME FROM APP_AGEND_UT.IDENTIFICATION_TYPE I
        WHERE I.IDENTIFICATION_TYPE_ID = T.IDENTIFICATION_TYPE_ID
    );

    UPDATE APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP T
    SET (SCHEDULE, START_TIME, END_TIME) = (
        SELECT NAME, START_TIME, END_TIME
        FROM APP_AGEND_UT.SCHEDULE S
        WHERE S.SCHEDULE_ID = T.SCHEDULE_ID
    );

    UPDATE APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP T
    SET (EXTENSION_START_TIME, EXTENSION_END_TIME, EXTENSION_REASON) = (
        SELECT START_TIME, END_TIME, REASON
        FROM APP_AGEND_UT.SCHEDULE_EXTENSION S
        WHERE S.WORK_SHIFT_ID = T.WORK_SHIFT_ID
        FETCH FIRST 1 ROW ONLY
    );

    SELECT APP_AGEND_UT.WORK_SHIFT_REPORT_TYPE(
        IDENTIFICATION_TYPE,
        IDENTIFICATION_NUMBER,
        FULL_NAME,
        EMAIL,
        ROLE,
        SCHEDULE,
        START_TIME,
        END_TIME,
        IS_STARTED,
        EXTENSION_START_TIME,
        EXTENSION_END_TIME,
        EXTENSION_REASON
    ) BULK COLLECT INTO P_REPORT
    FROM APP_AGEND_UT.WORK_SHIFT_REPORT_TEMP
    ORDER BY ROLE, SCHEDULE, FULL_NAME;

    EXCEPTION
        WHEN OTHERS THEN
            P_ERROR_MESSAGE := SQLERRM;
            ROLLBACK;

END APP_AGEND_UT.GET_ASSIGNED_WORK_SHIFTS_BY_DATE;

COMMIT;