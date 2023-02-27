# node-server
this is nodeJs api YAKI

## Purpose
This project is the backend part of the YAKI application.

## Table of contents
* [General info](#general-info)
* [Client connection](#how-to-connect-with-the-client-side)
* [Environment variables](#envsample)
* [Getting started](#getting-started)

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
- GET /captains/{id} => get a captain by id
- GET /teamMates/{id} => get a teamMate by id
- POST /declarations => add a new declaration to teamMate
- POST /declarations/_search => get all declarations that match the specified search criteria
- GET /teamMates?team={id} => get all team members
- GET /teams?teamMate={id} => get all teamMate teams 
- POST /login => to authenticate
- POST /logout => to disconnect

## How to connect with the client side
### Authentication
When a user tries to connect to the YAKI app, the client must provide a json object in the following format:

```json
{
    "login": "user_login_value",
    "password": "user_password_value"
}
```

If the login and password values match any user in the database, the server will return the latter.
Depending on the user's role (captain or team_mate) it will return two differents json objects:

**captain**
```ts
{
    "token": string,
    "captain_id": number,
    "user_id": number,
    "last_name": string,
    "first_name": string,
    "email": string
}
```

**team_mate**
```ts
{
    "token": string,
    "team_mate_id": number,
    "user_id": number,
    "team_id": number,
    "last_name": string,
    "first_name": string,
    "email": string
}
```

The token is necessary on each request following the user login. If you don't provide the correct token, the server will withdraw the request and return an error.

The token must be inside the request's headers like so :

```js
[x-access-token]: //the token returned by the server
```

## env.sample
The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

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
