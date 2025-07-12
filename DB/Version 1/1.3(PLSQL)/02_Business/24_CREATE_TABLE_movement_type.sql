-- Tabla: movement_type
CREATE TABLE movement_type (
    id NUMBER NOT NULL,
    description VARCHAR2(50) NOT NULL
);

ALTER TABLE movement_type
    ADD CONSTRAINT pk_movement_type_id PRIMARY KEY (id);