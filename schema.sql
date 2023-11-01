/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(30);

DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(100),
  age INT,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS species;
CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals
  ADD COLUMN species_id INT,
  ADD CONSTRAINT fk_species_id
    FOREIGN KEY (species_id)
    REFERENCES species(id)
    ON DELETE CASCADE;

ALTER TABLE animals
  ADD COLUMN owner_id INT,
  ADD CONSTRAINT fk_owner_id
    FOREIGN KEY (owner_id)
    REFERENCES owners(id)
    ON DELETE CASCADE;