-- Tabla: movement_sub_type
CREATE TABLE movement_sub_type (
    id NUMBER NOT NULL,
    description VARCHAR2(50) NOT NULL,
    movement_type_id NUMBER NOT NULL
);

ALTER TABLE movement_sub_type
    ADD CONSTRAINT pk_movement_sub_type_id PRIMARY KEY (id, movement_type_id);