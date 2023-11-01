/* Database schema to keep the structure of entire database. */

DROP TABLE IF EXISTS animals;
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

DROP TABLE IF EXISTS vets;
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

DROP TABLE IF EXISTS specializations;
CREATE TABLE specializations (
	species_id INT,
	vet_id INT,
  PRIMARY KEY (species_id, vet_id),
  CONSTRAINT fk_species 
    FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE,
  CONSTRAINT fk_vets
	  FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
  id INT GENERATED ALWAYS AS IDENTITY,
	animal_id INT,
	vet_id INT,
  visit_date DATE,
  PRIMARY KEY (id),
	CONSTRAINT fk_animals 
    FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_vets_visits
	  FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE
);