/* Create Database named vet_clinic */

CREATE DATABASE vet_clinic;

/* Database schema to keep the structure of entire database. */

CREATE TABLE
    animals(
        id INT PRIMARY KEY,
        name VARCHAR(250),
        date_of_birth DATE,
        escape_attempts INT,
        neutered BOOLEAN,
        weight_kg DECIMAL
    );

/* Update Database schema with species column. */

ALTER TABLE animals ADD species VARCHAR(255);

-- create owners table

CREATE TABLE
    owners(
        id int generated always as identity,
        full_name VARCHAR(250),
        age INT,
        PRIMARY Key (id)
    );

-- Create species table

CREATE TABLE
    species(
        id int generated always as identity,
        name VARCHAR(250),
        PRIMARY Key (id)
    );

ALTER TABLE animals DROP COLUMN id;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD id INT GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals ADD PRIMARY KEY (id);

ALTER TABLE animals
ADD
    COLUMN species_id INTEGER REFERENCES species(id),
ADD
    COLUMN owner_id INTEGER REFERENCES owners(id);

-- Create a table named vets as per the requirements:

CREATE TABLE
    vets(
        id INT GENERATED ALWAYS AS IDENTITY,
        name VARCHAR(250),
        age INT,
        date_of_graduation DATE,
        PRIMARY KEY (id)
    );

-- Create a "join table" called specializations to handle this relationship.

CREATE TABLE
    specializations(
        vet_id INT REFERENCES vets (id),
        species_id INT REFERENCES species (id),
        PRIMARY KEY (vet_id, species_id)
    );

-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.

CREATE TABLE
    visits(
        animal_id INT REFERENCES animals(id),
        vet_id INT REFERENCES vets(id),
        visit_date DATE,
        PRIMARY KEY (animal_id, vet_id, visit_date)
    );