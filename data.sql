/* Populate database with sample data. */

INSERT INTO
    animals (
        id,
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        1,
        'Agumon',
        '2020-02-03',
        0,
        true,
        10.23
    ), (
        2,
        'Gabumon',
        '2018-11-15',
        2,
        true,
        8.00
    ), (
        3,
        'Pikachu',
        '2021-01-07',
        1,
        false,
        15.04
    ), (
        4,
        'Devimon',
        '2017-05-12',
        5,
        true,
        11.00
    );

INSERT INTO
    animals (
        id,
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        5,
        'Charmander',
        '2020-02-08',
        0,
        false,
        -11.00
    ), (
        6,
        'Plantmon',
        '2021-11-15',
        2,
        true,
        -5.70
    ), (
        7,
        'Squirtle',
        '1993-04-02',
        3,
        false,
        -12.13
    ), (
        8,
        'Angemon',
        '2005-06-12',
        1,
        true,
        -45.00
    ), (
        9,
        'Boarmon',
        '2005-06-07',
        7,
        true,
        20.40
    ), (
        10,
        'Blossom',
        '1998-10-13',
        3,
        true,
        17.00
    ), (
        11,
        'Ditto',
        '2022-05-14',
        4,
        true,
        22.00
    );

--Insert data into owners table

INSERT INTO
    owners (full_name, age)
VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- Insert data into species table

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Update the species_id based on animals name

UPDATE animals
SET
    species_id = (
        CASE
            WHEN name LIKE '%mon' THEN (
                SELECT id
                FROM species
                WHERE
                    name = 'Digimon'
            )
            ELSE (
                SELECT id
                FROM species
                WHERE
                    name = 'Pokemon'
            )
        END
    );

-- Update the owner_id based on owner's name

UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE
            full_name = 'Sam Smith'
    )
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE
            full_name = 'Jennifer Orwell'
    )
WHERE
    name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE
            full_name = 'Bob'
    )
WHERE
    name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE
            full_name = 'Melody Pond'
    )
WHERE
    name IN (
        'Charmander',
        'Squirtle',
        'Blossom'
    );

UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE
            full_name = 'Dean Winchester'
    )
WHERE
    name IN ('Angemon', 'Boarmon');