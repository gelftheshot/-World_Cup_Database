-- Connect to the postgres database as the freecodecamp user
\c postgres freecodecamp

-- Drop the worldcup database if it exists
DROP DATABASE IF EXISTS worldcup;

-- Create the worldcup database
CREATE DATABASE worldcup;

-- Connect to the worldcup database
\c worldcup freecodecamp

-- Create the teams table
CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY,
  name VARCHAR UNIQUE NOT NULL
);

-- Create the games table
CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR NOT NULL,
  winner_id INT NOT NULL REFERENCES teams(team_id),
  opponent_id INT NOT NULL REFERENCES teams(team_id),
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL
);