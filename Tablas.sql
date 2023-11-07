CREATE TABLE "USER" (
    USER_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    FIRST_NAME VARCHAR2(50) NOT NULL,
    MIDDLE_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50) NOT NULL,
    SECOND_LAST_NAME VARCHAR2(50),
    IDENTIFICATION_TYPE_ID NUMBER NOT NULL,
    IDENTIFICATION_NUMBER VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(100) NOT NULL,
    PASSWORD VARCHAR2(100) NOT NULL,
    ROLE_ID NUMBER NOT NULL,
    IS_ACTIVE NUMBER(1) NOT NULL,
    CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LAST_MODIFICATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "IDENTIFICATION_TYPE" (
    IDENTIFICATION_TYPE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    CODE VARCHAR2(50) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    DESCRIPTION VARCHAR2(255),
    CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LAST_MODIFICATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "ROLE" (
    ROLE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME VARCHAR2(50) NOT NULL,
    DESCRIPTION VARCHAR2(255),
    CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LAST_MODIFICATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "WORK_SHIFT" (
    WORK_SHIFT_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "DATE" TIMESTAMP NOT NULL,
    SCHEDULE_ID NUMBER NOT NULL,
    USER_ID NUMBER NOT NULL,
    IS_STARTED NUMBER(1) NOT NULL,
    STARTED_AT TIMESTAMP,
    CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LAST_MODIFICATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "SCHEDULE" (
    SCHEDULE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME VARCHAR2(50) NOT NULL,
    START_TIME VARCHAR2(5) NOT NULL,
    END_TIME VARCHAR2(5) NOT NULL,
    BREAK_START_TIME VARCHAR2(5),
    BREAK_END_TIME VARCHAR2(5),
    CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LAST_MODIFICATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "SCHEDULE_EXTENSION" (
    SCHEDULE_EXTENSION_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    START_TIME VARCHAR2(5) NOT NULL,
    END_TIME VARCHAR2(5) NOT NULL,
    REASON VARCHAR2(500) NOT NULL,
    WORK_SHIFT_ID NUMBER NOT NULL,
    CREATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    LAST_MODIFICATION_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE GLOBAL TEMPORARY TABLE WORK_SHIFT_REPORT_TEMP (
    WORK_SHIFT_ID NUMBER,
    SCHEDULE_ID NUMBER,
    USER_ID NUMBER,
    ROLE_ID NUMBER,
    IDENTIFICATION_TYPE_ID NUMBER,
    FULL_NAME VARCHAR2(200),
    IDENTIFICATION_TYPE VARCHAR2(50),
    IDENTIFICATION_NUMBER VARCHAR2(50),
    EMAIL VARCHAR2(100),
    ROLE VARCHAR2(50),
    SCHEDULE VARCHAR2(50),
    START_TIME VARCHAR2(50),
    END_TIME VARCHAR2(50),
    IS_STARTED VARCHAR2(50),
    EXTENSION_START_TIME VARCHAR2(50),
    EXTENSION_END_TIME VARCHAR2(50),
    EXTENSION_REASON VARCHAR2(500)
) ON COMMIT DELETE ROWS;