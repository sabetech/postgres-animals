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


-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT animals.name, owners.full_name FROM animals JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name LIKE 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name as species_name FROM animals 
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, 
-- remember to include those that don't own any animal.

SELECT 
owners.full_name as owner_name, 
animals.name as animal_name
FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;

--How many animals are there per species?
SELECT species.name, COUNT(species.id) number_per_species FROM species
JOIN animals ON animals.species_id = species.id
GROUP BY animals.species_id, species.id;

--List all Digimon owned by Jennifer Orwell.
SELECT animals.name animal_name, 
species.name species_name, 
owners.full_name
FROM animals 
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
WHERE species.name = 'Digimon' AND
owners.full_name = 'Jennifer Orwell';

--List all animals owned by Dean Winchester 
--that haven't tried to escape.

SELECT animals.name animal_name,
owners.full_name,
animals.escape_attempts
FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND
owners.full_name LIKE 'Dean Winchester';

--Who owns the most animals?
SELECT COUNT(owners.id) animal_number, owners.full_name
FROM animals JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY animal_number DESC
LIMIT 1;


--Write queries to answer the following:
--Who was the last animal seen by William Tatcher?
SELECT animals.name  animal_name, vets.name vets_name, visits.date_of_visit date_visited
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE visits.vet_id = 1
ORDER BY visits.date_of_visit DESC
LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(visits.vet_id) AS animals_seen, vets.name AS vets_name
FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.id = 3
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name vets_name, species.name vets_specialization
FROM vets
FULL OUTER JOIN specializations ON vets.id = specializations.vet_id
FULL OUTER JOIN species ON species.id = specializations.species_id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name animals_visited_stephanie, vets.name
FROM animals
FULL OUTER JOIN visits ON animals.id = visits.animal_id
FULL OUTER JOIN vets ON vets.id = visits.vet_id
WHERE vets.id = 3 AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name animal, COUNT(visits.animal_id) max_number_of_visits
FROM animals
FULL OUTER JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name animal, vets.name vets_name, visits.date_of_visit date_visited
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vet_id = 2
ORDER BY visits.date_of_visit ASC
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name animal, 
animals.date_of_birth animal_date_of_birth,
animals.weight_kg as animal_weight,
        vets.name vet_name, 
        vets.age vets_age, 
        vets.date_of_graduation vets_date_of_graduation,
        visits.date_of_visit date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.date_of_visit DESC;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name vets_name, COUNT(vets.name) times_visited FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN visits ON visits.vet_id = specializations.vet_id
WHERE specializations.species_id IS NULL
GROUP BY vets.name, specializations.species_id;

--What specialty should Maisy Smith consider getting? 
--Look for the species she gets the most.
SELECT vets.name as vets_name, species.name as species_name, COUNT(animals.name) AS times_visited FROM animals
FULL OUTER JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
JOIN species  ON species.id = animals.species_id
WHERE vets.id = 2
GROUP BY species.name, vets.name
ORDER BY COUNT(animals.name) DESC
LIMIT 1;



