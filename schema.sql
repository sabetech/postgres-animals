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
    age INT,
    PRIMARY KEY(id)

);

ALTER TABLE animals DROP COLUMN species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(190),
    PRIMARY KEY(id)
);

ALTER TABLE animals 
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_animals_species
FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_animal_owners
FOREIGN KEY(owner_id) 
REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(190),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    species_id INT,
    vet_id INT,
    PRIMARY KEY(species_id, vet_id),
    CONSTRAINT species_id_fk FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT vet_id_fk FOREIGN KEY(vet_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    PRIMARY KEY(animal_id, vet_id, date_of_visit),
    CONSTRAINT animal_id_fk FOREIGN KEY(animal_id) REFERENCES animals(id),
    CONSTRAINT vet_id_fk FOREIGN KEY(vet_id) REFERENCES vets(id)
);






