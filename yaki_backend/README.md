# node-server
this is nodeJs api YAKI

## Purpose
This project is the backend part of the YAKI application.

## General info
### Authentification
No GAFAM will be used for authentification
We will implement a home made authentification process
We will use JWT authorization token in the Authorization header

### Data format
- teamMate : id, firstName, lastName, email
- captain: id, firstName, lastName, email
- team: id, idCapitain, name
- declaration: id, idTeamMate, status, date

### Path
- GET /teamMates => get all team-mates
- GET /teamMates/{id} => get a team-mate by id
- GET /teamMates/{id}/declarations => get all team-mate declarations 
- GET /teams/{id}/captain => get team captain
- GET /captains => get all captains
- GET /captains/{id} => get a captain by id
- GET /captains/{id}/teams => get all captain teams
- POST /teamMates/{id}/declaration => add a new declaration to teamMate
- Get /teamMates/{id}/declarations/date?period="mornig or afternoon" => get teamMate today's, morning, afternoon declarations
- GET /teams/{id}/teamMates => get all team members
- GET /teamMates/{id}/teams => get all teamMate teams 
- POST /login => to authenticate
- POST /logout => to disconnect

## Getting started
Fetch dependencies
```npm install```

Run the server
```npm start ```

Run with hot reload
```npm run dev```

Update Swagger definition

```npm run swagger```

Build docker image

```docker build .```

Run as docker with server + database

```docker compose build```
```docker compose up```
