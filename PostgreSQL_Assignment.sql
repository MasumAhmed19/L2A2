-- Active: 1747670864018@@127.0.0.1@5432@conservation_db
create table rangers(
    ranger_id SERIAL PRIMARY key,
    name VARCHAR(50),
    region VARCHAR(50)
);
drop table rangers;


create table species(
    species_id SERIAL PRIMARY key,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

drop table species;


create table sightings(
    sighting_id SERIAL PRIMARY key,
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    species_id INTEGER REFERENCES species(species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes VARCHAR(50)
);
drop table sightings;


INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('David Black', 'Coastal Forest'),
('Eva Stone', 'Desert Plains'),
('Frank Moore', 'Wetland Reserve'),
('Grace Lee', 'Rainforest Zone'),
('Henry Ford', 'Savannah Outpost'),
('Isla Turner', 'Highland Range'),
('Jack Norris', 'Volcanic Ridge');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Giant Panda', 'Ailuropoda melanoleuca', '1869-03-11', 'Vulnerable'),
('Black Rhino', 'Diceros bicornis', '1758-01-01', 'Critically Endangered'),
('Green Sea Turtle', 'Chelonia mydas', '1758-01-01', 'Endangered'),
('Mountain Gorilla', 'Gorilla beringei beringei', '1903-01-01', 'Endangered'),
('Snowy Owl', 'Bubo scandiacus', '1758-01-01', 'Least Concern'),
('Orangutan', 'Pongo pygmaeus', '1760-01-01', 'Critically Endangered'),
('Blue Whale', 'Balaenoptera musculus', '1758-01-01', 'Endangered'),
('Saola', 'Pseudoryx nghetinhensis', '1992-01-01', 'Critically Endangered'),
('Amur Leopard', 'Panthera pardus orientalis', '1857-01-01', 'Critically Endangered'),
('Komodo Dragon', 'Varanus komodoensis', '1912-01-01', 'Endangered'),
('African Grey Parrot', 'Psittacus erithacus', '1758-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45 AM', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 04:20 PM', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10 AM', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 06:30 PM', NULL),
(5, 4, 'Pine Valley', '2024-05-20 06:50 AM', 'Solo panda near river'),
(6, 5, 'Dusty Flats', '2024-05-22 11:15 AM', 'Rhino crossing recorded'),
(7, 6, 'Lagoon Trail', '2024-05-24 02:00 PM', 'Nest near water observed'),
(8, 7, 'Foggy Hillside', '2024-05-26 08:40 AM', 'Group of gorillas spotted'),
(9, 8, 'Arctic Watchpost', '2024-05-28 05:30 AM', 'One owl flew overhead'),
(10, 9, 'Canopy Road', '2024-05-29 05:20 PM', 'Swinging between trees');


SELECT * from rangers;
SELECT * from species;
SELECT * from sightings;

-- PROBLEM 01 : Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
insert into rangers(name, region) values
('Derek Fox', 'Coastal Plains');

-- PROBLEM 02 : Count unique species ever sighted.
select count(DISTINCT scientific_name) as unique_species_count from species;

-- PROBLEM 03 : Find all sightings where the location includes "Pass"
select * from sightings where location  like '%Pass%';


-- PROBLEM 04 : List each ranger's name and their total number of sightings.
select name, count(sighting_id) as total_sightings from rangers
join sightings on rangers.ranger_id = sightings.ranger_id
GROUP BY name;

-- PROBLEM 05 : List species that have never been sighted.
select common_name from species
left join sightings on species.species_id = sightings.species_id
where sightings.sighting_id is NULL;



-- PROBLEM 06 : Show the most recent 2 sightings.
select common_name, sighting_time, name from species
join sightings on species.species_id = sightings.species_id 
join rangers on sightings.ranger_id = rangers.ranger_id
ORDER BY sighting_time DESC
LIMIT 2;


-- PROBLEM 07 : Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
set conservation_status = 'Historic'
where EXTRACT(YEAR FROM discovery_date) < 1800;


-- PROBLEM 08 : Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

-- PROBLEM 09 : Delete rangers who have never sighted any specie
select  ranger_id from sightings;



