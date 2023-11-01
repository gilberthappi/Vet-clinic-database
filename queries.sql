/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT * from animals WHERE escape_attempts < 3;
SELECT * from animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species from animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS null;
COMMIT;
SELECT name, species from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;

SELECT * from animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_after_2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK to delete_after_2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) AS "No. of animals" FROM animals;
SELECT COUNT(*) AS "No. of animals never scaped" FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS "Animals average weight" FROM animals;
SELECT name, escape_attempts FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE  date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;

SELECT animals.name
FROM animals 
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals 
JOIN species ON species.id = animals.species_id
WHERE species.name = 'Pokemon';

SELECT animals.name, owners.full_name
FROM animals 
RIGHT JOIN owners ON owners.id = animals.owner_id;

SELECT count(animals), species.name
FROM animals 
JOIN species ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name, species.name, owners.full_name
FROM animals 
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name, owners.full_name
FROM animals 
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals)
FROM animals
JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.full_name

ORDER BY COUNT(animals) DESC LIMIT 1;

SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT COUNT(animals)
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name
FROM vets
FULL JOIN specializations ON specializations.vet_id = vets.id
FULL JOIN species ON species.id = specializations.species_id;

SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits)
FROM animals
join visits on visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(visits) DESC LIMIT 1;

SELECT animals.name, visits.visit_date
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date LIMIT 1;

SELECT animals.name, vets.name, visits.visit_date
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT vets.name, COUNT (visits)
from vets
FULL JOIN Specializations ON Specializations.vet_id = vets.id
FULL JOIN species ON species.id = specializations.species_id
JOIN visits ON visits.vet_id = vets.id
WHERE species.name IS NULL
GROUP BY vets.name;

SELECT vets.name, species.name, COUNT(species)
from vets
JOIN visits ON visits.vet_id = vets.id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, species.name
ORDER BY COUNT(species) DESC LIMIT 1;