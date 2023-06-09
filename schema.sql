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