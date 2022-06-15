SELECT * FROM animals WHERE name LIKE '%mon%'
SELECT name, EXTRACT(YEAR FROM date_of_birth) as year FROM animals WHERE date_of_birth >= to_date('2016', 'YYYY') AND date_of_birth <= to_date('2019', 'YYYY');
SELECT name, neutered, escape_attempts FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name, neutered FROM animals WHERE neutered=true;
SELECT name FROM animals WHERE name <> 'Gabumon';
SELECT name, weight_kg FROM animals WHERE weight_kg >= 10.5 AND weight_kg <= 17.3;