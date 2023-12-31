-- Habilitar la creación de usuarios

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- Creación de tablespace (Ajustar la ruta de almacenamiento del datafile)

CREATE TABLESPACE APP_AGEND_UT_TS
DATAFILE '/opt/oracle/oradata/FREE/app_agend_ut_datafile.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 250K
MAXSIZE 200M;

COMMIT;

-- Creación de usuario (esquema)

CREATE USER APP_AGEND_UT
IDENTIFIED BY "oracle"
DEFAULT TABLESPACE APP_AGEND_UT_TS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON APP_AGEND_UT_TS;

-- Asignar provilegios al usuario

GRANT CONNECT TO APP_AGEND_UT;
GRANT RESOURCE TO APP_AGEND_UT;

COMMIT;