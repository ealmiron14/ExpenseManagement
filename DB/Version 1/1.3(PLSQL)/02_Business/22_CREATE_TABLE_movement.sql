-- Tabla: movement
CREATE TABLE movement (
    id NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1 NOT NULL,
    description VARCHAR2(50) NOT NULL,
    amount NUMBER(19, 4) NOT NULL, -- Equivalente al tipo money de SQL Server
    movement_sub_type_id NUMBER NULL,
    completion_date DATE NOT NULL,
    effective_date DATE NULL,
    update_date DATE NULL
);

ALTER TABLE movement
    ADD CONSTRAINT pk_movement_id PRIMARY KEY (id);