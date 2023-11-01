SELECT * from animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Angemon' OR name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
-- SELECT * from animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Squirtle';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;	

-- TRANSACTION
BEGIN;

UPDATE animals SET species = 'unspecified';

ROLLBACK;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';

COMMIT;

BEGIN;

DELETE FROM animals;

ROLLBACK;

BEGIN;

SAVEPOINT SP1;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

ROLLBACK TO SP1;

SAVEPOINT SP2;
UPDATE animals SET weight_kg=weight_kg * -1;

ROLLBACK TO SP2;

UPDATE animals SET weight_kg=weight_kg * -1;

COMMIT;

-- SOME OTHER QUERIES
-- How many animals are there?
SELECT count(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT count(*) AS never_tried_to_escape FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT CAST(AVG(weight_kg) AS DECIMAL(5,2)) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name, MAX(escape_attempts) AS most_escape FROM animals WHERE neutered = true OR neutered = false GROUP BY name ORDER BY MAX(escape_attempts) DESC;

-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT CAST(AVG(escape_attempts) AS DECIMAL(5,2)) AS average_escape_attempts FROM animals WHERE extract(YEAR FROM date_of_birth) BETWEEN '1990' AND '2000';

-- JOIN QUERIES
-- What animals belong to Melody Pond?
SELECT 
an.name AS animal_name,
ow.full_name AS owner_name 
FROM animals an 
INNER JOIN owners ow
ON ow.id = an.owners_id 
WHERE ow.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT 
an.name AS animal_name, 
sp.name AS species 
FROM animals an 
INNER JOIN species sp
ON sp.id = an.species_id
WHERE sp.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
ow.full_name as owner_name,
an.name as animal_name
FROM owners ow
LEFT JOIN animals an
ON ow.id = an.owners_id

-- How many animals are there per species?
SELECT 
sp.name AS species_name,
COUNT(an.name) AS animal_count
FROM animals an 
INNER JOIN species sp
ON sp.id = an.species_id
GROUP BY sp.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT 
ow.full_name as owner_name,
sp.name as species_name,
an.name as animal_name
FROM animals an 
INNER JOIN owners ow
ON ow.id = an.owners_id
INNER JOIN species sp
ON sp.id = an.owners_id
WHERE ow.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT 
ow.full_name as owner_name,
an.name as animal_name,
an.escape_attempts as check_attempts
FROM animals an 
INNER JOIN owners ow
ON ow.id = an.owners_id
WHERE an.escape_attempts = 0 
AND ow.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT 
COUNT(an.name) AS animal_count,
ow.full_name AS owner_name 
FROM animals an 
INNER JOIN owners ow
ON ow.id = an.owners_id 
GROUP BY ow.full_name 
ORDER BY MAX(an.name) DESC;