CREATE TABLE animals( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC(5,2),
    species VARCHAR(250)
);

DROP TABLE animals;

CREATE TABLE animals( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC(5,2),
    species VARCHAR(250)
);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(190),
    age INT
);

ALTER TABLE animals DROP COLUMN species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(190)
);

