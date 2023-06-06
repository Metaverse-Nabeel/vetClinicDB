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