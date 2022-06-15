CREATE TABLE animals( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC(5,2)
);

