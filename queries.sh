#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "Total number of goals in all games from winning teams:\n$($PSQL "SELECT SUM(winner_goals) FROM games")"
echo -e "\nTotal number of goals in all games from both teams combined:\n$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"
echo -e "\nAverage number of goals in all games from the winning teams:\n$($PSQL "SELECT AVG(winner_goals) FROM games")"
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:\n$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"
echo -e "\nAverage number of goals in all games from both teams:\n$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"
echo -e "\nMost goals scored in a single game by one team:\n$($PSQL "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM games")"
echo -e "\nNumber of games where the winning team scored more than two goals:\n$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"
echo -e "\nWinner of the 2018 tournament team name:\n$($PSQL "SELECT name FROM teams WHERE team_id = (SELECT winner_id FROM games WHERE year = 2018 AND round = 'Final')")"
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
$PSQL "SELECT name FROM teams WHERE team_id IN (SELECT winner_id FROM games WHERE year = 2014 AND round = 'Eighth-Final') UNION SELECT name FROM teams WHERE team_id IN (SELECT opponent_id FROM games WHERE year = 2014 AND round = 'Eighth-Final')" | while read -r line ; do
  echo "$line"
done
echo -e "\nList of unique winning team names in the whole data set:"
$PSQL "SELECT DISTINCT name FROM teams WHERE team_id IN (SELECT winner_id FROM games) ORDER BY name" | while read -r line ; do
  echo "$line"
done
echo -e "\nYear and team name of all the champions:"
$PSQL "SELECT year || '|' || name FROM games JOIN teams ON games.winner_id = teams.team_id WHERE round = 'Final' ORDER BY year ASC" | while read -r line ; do
  echo "$line"
done
echo -e "\nList of teams that start with 'Co':"
$PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'" | while read -r line ; do
  echo "$line"
done
echo