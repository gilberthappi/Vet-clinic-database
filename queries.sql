-- What animals belong to Melody Pond?
SELECT animals.name AS animal_name, owners.full_name AS owner_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are Pokemon (their type is Pokemon).
SELECT animals.name AS animal_name, species.name AS species_name
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animals.
SELECT owners.full_name AS owner_name, COALESCE(animals.name, 'No animals') AS animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name AS species_name, COUNT(animals.name) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS animal_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS animal_name, owners.full_name AS owner_name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name AS owner_name, COUNT(animals.name) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(animals.name) DESC;
