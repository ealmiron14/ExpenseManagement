CREATE TABLE constant_value (
    id NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1 NOT NULL,
    description VARCHAR2(50) NOT NULL,
    amount NUMBER(19, 4) NOT NULL, -- Equivalent to SQL Server's money type
    effective_date DATE NOT NULL,
    null_date DATE NULL,
    update_date DATE NOT NULL
);

ALTER TABLE constant_value
    ADD CONSTRAINT pk_constant_value_id PRIMARY KEY (id);
