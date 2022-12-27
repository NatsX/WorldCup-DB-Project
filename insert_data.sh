#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Emptying the rows in the tables of the database to rerun the file
echo $($PSQL "TRUNCATE TABLE games, teams")


# Read the games.csv file using cat and apply a while loop to read row by row
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
  # If the value in the "WINNER" column is not "winner"
  if [[ $WINNER != 'winner' ]]
    then
      # Check if the team in the "WINNER" column exists in the "teams" table
      TEAM1_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
      # If the team does not exist in the "teams" table
      if [[ -z $TEAM1_NAME ]]
        then
          # Insert the team into the "teams" table
          INSERT_TEAM1_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
          # If the insertion was successful
          if [[ $INSERT_TEAM1_NAME == "INSERT 0 1" ]]
            then
              # Print a message indicating the team was inserted
              echo "Inserted team $WINNER"
          fi
      fi
  fi

    # GET OPPONENT TEAM NAME

      # If the value in the "OPPONENT" column is not "opponent"
      if [[ $OPPONENT != "opponent" ]]
        then
          # Check if the team in the "WINNER" column exists in the "teams" table
          TEAM2_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
            # If the team does not exist in the "teams" table
            if [[ -z $TEAM2_NAME ]]
              then
              # Insert the team into the "teams" table
              INSERT_TEAM2_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
                # If the insertion was successful
                if [[ $INSERT_TEAM2_NAME == "INSERT 0 1" ]]
                  then
                    # Print a message indicating the team was inserted
                    echo Inserted team $OPPONENT
                fi
            fi
      fi

  # INSERT GAMES TABLE DATA

    # If the value in the "YEAR" column is not "year"
    if [[ YEAR != "year" ]]
      then
        #GET WINNER_ID
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        #GET OPPONENT_ID
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        #INSERT NEW GAMES ROW
        INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
          # Print a message indicating what was added
          if [[ $INSERT_GAME == "INSERT 0 1" ]]
            then
              echo New game added: $YEAR, $ROUND, $WINNER_ID VS $OPPONENT_ID, score $WINNER_GOALS : $OPPONENT_GOALS
          fi
    fi
    
done