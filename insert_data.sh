#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Read the CSV file and insert unique teams into the teams table
awk -F ',' 'NR > 1 {print $3 "\n" $4}' games.csv | sort | uniq | while read team; do
    $PSQL "INSERT INTO teams (name) VALUES ('$team') ON CONFLICT DO NOTHING;"
done

# Read the CSV file and insert games into the games table
awk -F ',' 'NR > 1 {print $1 "," $2 "," $3 "," $4 "," $5 "," $6}' games.csv | while IFS=',' read -r year round winner opponent winner_goals opponent_goals; do
    winner_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$winner';" | xargs)
    opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$opponent';" | xargs)
    $PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals);"
done
