-- Active: 1747426910940@@localhost@5432@conservation_db
CREATE DATABASE conservation_db;

-- Rangers Table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

-- Rangers Data
INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');

-- Register a new ranger
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');


-- Species Table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic'))
);

-- Species Data
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;


-- Sightings Table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL REFERENCES species(species_id),
    ranger_id INT NOT NULL REFERENCES rangers(ranger_id),
    sighting_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(100) NOT NULL,
    notes TEXT
);

-- Sightings Data
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

-- Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- List each ranger's name and their total number of sightings.
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

-- List species that have never been sighted.
SELECT common_name
FROM species
WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);

--  Show the most recent 2 sightings.
SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id,
    CASE
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);



SELECT * FROM rangers;
