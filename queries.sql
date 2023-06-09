/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".

SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.

SELECT name
FROM animals
WHERE EXTRACT(
        year
        FROM
            date_of_birth
    ) BETWEEN 2016 AND 2019;

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name FROM animals WHERE neutered AND (escape_attempts < 3);

-- List the date of birth of all animals named either "Agumon"  or "Pikachu".

SELECT date_of_birth
FROM animals
WHERE
    name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5 kg

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT * FROM animals WHERE neutered IS true;

-- Find all animals not named Gabumon.

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

-- Find all animals with a weight between 10.4 kg and 17.3 kg (including the animals with the weights that equals precisely 10.4 kg or 17.3 kg)

SELECT *
FROM animals
WHERE
    weight_kg >= 10.40
    AND weight_kg <= 17.30;

--Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction

BEGIN TRANSACTION;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK TRANSACTION;

SELECT * FROM animals;

-- Transaction for first screenshot

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE "name" LIKE '%mon';

SELECT * FROM animals;

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

COMMIT TRANSACTION;

SELECT * FROM animals;

-- Transaction for Second screenshot

BEGIN TRANSACTION;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK TRANSACTION;

SELECT * FROM animals;

-- Transaction for Third screenshot

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;

SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1;

SELECT * FROM animals;

ROLLBACK TO SAVEPOINT SP1;

SELECT * FROM animals;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT TRANSACTION;

-- Queries to answer the questions

SELECT COUNT(name) FROM animals;

SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

SELECT avg(weight_kg) from animals;

select neutered, max(escape_attempts) from animals group by neutered;

select
    species,
    max(weight_kg),
    min(weight_kg)
from animals
group by species;

SELECT
    species,
    AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE
    date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Write queries (using JOIN) to answer the questions:

-- What animals belong to Melody Pond?

SELECT name
FROM animals
    INNER JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name
FROM animals
    JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT full_name, name
FROM owners
    LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?

SELECT
    species.name,
    COUNT(*) AS animal_count
FROM animals
    LEFT JOIN species ON animals.species_id = species.id
GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.

SELECT animals.name
FROM animals
    JOIN species ON animals.species_id = species.id
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Jennifer Orwell'
    AND species.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name
FROM animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0;

--who owns the most animals

SELECT
    owners.full_name,
    COUNT(animals.id) AS animal_count
FROM owners
    JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- What animals belong to Melody Pond?

SELECT name
FROM animals
    INNER JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name
FROM animals
    JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT full_name, name
FROM owners
    LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?

SELECT
    species.name,
    COUNT(*) AS animal_count
FROM animals
    LEFT JOIN species ON animals.species_id = species.id
GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.

SELECT animals.name
FROM animals
    JOIN species ON animals.species_id = species.id
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Jennifer Orwell'
    AND species.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name
FROM animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0;

--who owns the most animals

SELECT
    owners.full_name,
    COUNT(animals.id) AS animal_count
FROM owners
    JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?

SELECT animals.name
FROM animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vet_id = vets.id
WHERE
    vets.name = 'William Tatcher'
ORDER BY
    visits.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT
    COUNT(DISTINCT animals.name) AS animal_count
FROM animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vet_id = vets.id
WHERE
    vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT
    vets.name as Vet_Name,
    species.name as specialized_in
FROM vets
    LEFT JOIN specializations ON vets.id = specializations.vet_id
    LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name
FROM animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vet_id = vets.id
WHERE
    vets.name = 'Stephanie Mendez'
    AND visits.visit_date >= '2020-04-01'
    AND visits.visit_date <= '2020-08-30';

-- What animal has the most visits to vets?

SELECT
    animals.name AS Animal_Name,
    COUNT(visits.animal_id) AS Visit_Count
FROM animals
    JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;

--Who was Maisy Smith's first visit?

SELECT
    animals.name AS Animal_Name
FROM animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vet_id = vets.id
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.

SELECT
    animals.name AS Animal_Name,
    vets.name AS Checked_by,
    visits.visit_date
FROM animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vet_id = vets.id
ORDER BY
    visits.visit_date DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) AS num_of_visits
FROM visits
    JOIN animals ON visits.animal_id = animals.id
    JOIN vets ON visits.vet_id = vets.id
    JOIN specializations ON vets.id = specializations.vet_id
    JOIN species ON animals.species_id = species.id
WHERE
    species.id != specializations.species_id;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name AS Specialty
FROM visits
    JOIN animals ON visits.animal_id = animals.id
    JOIN vets ON visits.vet_id = vets.id
    JOIN specializations ON vets.id = specializations.vet_id
    JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;