
# World Cup Database


## Project goal

This project aims to create a Bash script that enters data from a games.csv file into a PostgreSQL database, and then queries the database to obtain useful statistics. The project was completed as part of the **FreeCodeCamp Relational Databases Beta Certificate course**.

## Creating the Database

The database contains two tables: teams and games. The teams table lists all of the teams that played in the matches, and the games table tracks the scores and results of each match, using the team_id as the identifier for each team. Primary and foreign keys are used to establish relationships between the tables.

## Automating Data Insertion and Querying with SQL

A Bash script has been created to read the data from the games.csv file and use SQL query commands to automatically insert the data into the teams and games tables. The script takes the constraints of the database into consideration when inserting the data, ensuring that all winner and opponent teams are individually added to the teams table before being inserted into the games table based on their team_id.

The project is completed with the creation of a Bash script that utilizes SQL to query the database and obtain useful values.
