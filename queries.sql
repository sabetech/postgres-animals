SELECT * FROM animals WHERE name LIKE '%mon%'
SELECT name, EXTRACT(YEAR FROM date_of_birth) as year FROM animals WHERE date_of_birth >= to_date('2016', 'YYYY') AND date_of_birth <= to_date('2019', 'YYYY');
SELECT name, neutered, escape_attempts FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name, neutered FROM animals WHERE neutered=true;
SELECT name FROM animals WHERE name <> 'Gabumon';
SELECT name, weight_kg FROM animals WHERE weight_kg >= 10.5 AND weight_kg <= 17.3;

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

SELECT * FROM animals;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

SELECT * FROM animals;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(id) number_of_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) number_of_animals_tried_to_escape FROM animals WHERE escape_attempts > 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) average_weight_of_animals FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) maximum_weight, MIN(weight_kg) minimum_weight FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth
BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;



