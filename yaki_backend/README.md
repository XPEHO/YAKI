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
- GET /captains => get all captains
- GET /captains/{id} => get a captain by id
- GET /captains/{id}/teams => get all captain teams

## Getting started
Fetch dependencies
```npm install```

Run the server
```npm start ```

Run with hot reload
```npm run dev```

Build docker image

```docker build .```

Run as docker with server + database

```docker compose build```
```docker compose up```
