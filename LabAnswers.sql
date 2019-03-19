### Part 2: Simple Selects and Counts

# Directions: Write a sql query or sql queries that can answer the following questions
#
# * What are all the types of pokemon that a pokemon can have?
SELECT t.name
FROM types t
ORDER BY name ASC;

# * What is the name of the pokemon with id 45?
SELECT p.name
FROM pokemons p
WHERE id = 45;

# * How many pokemon are there?
SELECT COUNT(ALL name)
FROM pokemons;

# * How many types are there?
SELECT COUNT(DISTINCT primary_type)
FROM pokemons;

# * How many pokemon have a secondary type?
SELECT COUNT(DISTINCT secondary_type)
FROM pokemons;

#
# ### Part 3: Joins and Groups
# Directions: Write a sql query or sql queries that can answer the following questions
#
#
# * What is each pokemon's primary type?
SELECT p.name, t.name as 'Primary Type'
FROM pokemons p, types t
WHERE primary_type = t.id;

# * What is Rufflet's secondary type?
SELECT t.name
FROM pokemons p
JOIN types t
ON secondary_type = t.id
WHERE p.name = "Rufflet";

# * What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT p.name
FROM pokemon_trainer pt
JOIN pokemons p
ON pt.pokemon_id = p.id
WHERE pt.trainerID = 303;

# * How many pokemon have a secondary type `Poison`
SELECT COUNT(ALL *) as 'Number of 2nd Type Poison'
FROM pokemons p
JOIN types t
ON p.secondary_type = t.id
WHERE t.name = 'Poison';

# * What are all the primary types and how many pokemon have that type?
SELECT t.name, COUNT(ALL p.primary_type) as 'Number with this Primary type'
FROM pokemons p
JOIN types t
ON p.primary_type = t.id
GROUP BY t.name;

# * How many pokemon at level 100 does each trainer with at least one level 100 pokemone have?
  # (Hint: your query should not display a trainer
SELECT COUNT(All *) as 'number of level 100 pokemon'
FROM pokemon_trainer
WHERE pokelevel IS NOT NULL
GROUP BY trainerID;

# * How many pokemon only belong to one trainer and no other?

SELECT COUNT(ALL *)
FROM (
  SELECT COUNT(ALL *) as count
  FROM pokemon_trainer pt
  GROUP BY pt.pokemon_id
  ) list
WHERE list.count = 1;

##

#
# ### Part 4: Final Report
#
# Directions: Write a query that returns the following collumns:
#
# | Pokemon Name | Trainer Name | Level | Primary Type | Secondary Type |
# |:------------:|:------------:|:-----:|:------------:|:--------------:|
# | Pokemon's name| Trainer's name| Current Level| Primary Type Name| Secondary Type Name|
#
SELECT tr.trainername as 'Trainer Name',
       p.name as 'Pokemon Name',
       pt.pokelevel as 'Level',
       ty.name as 'Primary Type',
       sty.name as 'SecondaryType',
       pt.attack as 'Attack',
       pt.spatk as 'Special Attack',
       pt.speed as 'Speed'
FROM pokemon_trainer pt
JOIN pokemons p
ON pt.pokemon_id = p.id
JOIN trainers tr
ON pt.trainerID = tr.trainerID
JOIN types ty
ON p.primary_type = ty.id
JOIN types sty
ON p.secondary_type = sty.id
WHERE LENGTH(trainername) > 30
ORDER BY LENGTH(trainername), attack DESC, speed DESC, spatk DESC
LIMIT 10;
#
# Sort the data by finding out which trainer has the strongest pokemon so that this will act as a ranking of strongest
# to weakest trainer. You may interpret strongest in whatever way you want, but you will have to explain your decision.

# I decided to choose the trainer with the longest name, who has the the most aggressive fast pokemon.
# Based on my query this is Junior Representative Ichi-Ichi.
