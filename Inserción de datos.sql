-- Creación de los tipos de identificación

INSERT INTO "IDENTIFICATION_TYPE" (CODE, NAME)
VALUES 
    ('CC', 'Cédula de Ciudadanía'),
    ('CE', 'Cédula de Extranjería');

-- Creación de los role

INSERT INTO "ROLE" (NAME)
VALUES
    ('Administrador'),
    ('Contratista Supervisor'),
    ('Contratista de Campo');

-- Creación de los horarios de trabajo

INSERT INTO "SCHEDULE" (NAME, START_TIME, END_TIME, BREAK_START_TIME, BREAK_END_TIME)
VALUES
    ('Oficina', '08:00', '18:00', '12:00', '14:00'),
    ('Mañana', '06:00', '14:00', NULL, NULL),
    ('Tarde', '14:00', '22:00', NULL, NULL);

-- Creación del usuario Administrador, contraseña: 12345

INSERT INTO "USER" (
    FIRST_NAME,
    MIDDLE_NAME,
    LAST_NAME,
    SECOND_LAST_NAME,
    IDENTIFICATION_TYPE_ID,
    IDENTIFICATION_NUMBER,
    EMAIL,
    PASSWORD,
    ROLE_ID,
    IS_ACTIVE
)
VALUES (
    'Juan',
    'Ángel',
    'Ruiz',
    'Gil',
    (
        SELECT IDENTIFICATION_TYPE_ID
        FROM "IDENTIFICATION_TYPE"
        WHERE CODE = 'CC'
    ),
    '1005094822',
    'juan.ruiz.22.03.00@gmail.com',
    '$2a$10$a0xBMYSy4JVmy2FFPb0sMu77KUaKjjbogXsgfS/7J.h3KlY/xeEvy',
    (
        SELECT ROLE_ID
        FROM "ROLE"
        WHERE NAME = 'Administrador'
    ),
    1
);

-- Creación del usuario Contratista, contraseña: 12345

INSERT INTO "USER" (
    FIRST_NAME,
    MIDDLE_NAME,
    LAST_NAME,
    SECOND_LAST_NAME,
    IDENTIFICATION_TYPE_ID,
    IDENTIFICATION_NUMBER,
    EMAIL,
    PASSWORD,
    ROLE_ID,
    IS_ACTIVE
)
VALUES (
    'Jose',
    'Luis',
    'Ruiz',
    'Reyes',
    (
        SELECT IDENTIFICATION_TYPE_ID
        FROM "IDENTIFICATION_TYPE"
        WHERE CODE = 'CC'
    ),
    '1234567890',
    'jose.reyes@gmail.com',
    '$2a$10$a0xBMYSy4JVmy2FFPb0sMu77KUaKjjbogXsgfS/7J.h3KlY/xeEvy',
    (
        SELECT ROLE_ID
        FROM "ROLE"
        WHERE NAME = 'Contratista'
    ),
    1
);