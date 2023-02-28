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
- GET /captains/{id} => get a captain by id
- GET /teamMates/{id} => get a teamMate by id
- POST /declarations => add a new declaration to teamMate
- POST /declarations/_search => get all declarations that match the specified search criteria
- GET /teamMates?team={id} => get all team members
- GET /teams?teamMate={id} => get all teamMate teams 
- POST /login => to authenticate
- POST /logout => to disconnect

## How to connect with the client side
### Declaration
The declaration feature is built using the following technologies: Express, TypeScript, and PostgreSQL.

- The declaration repository class (DeclarationRepository) is responsible for managing the database interaction.
- The declaration service class (DeclarationService) provides the business logic for creating a declaration.
- The declaration controller class (DeclarationController) handles the HTTP requests and responses for creating a declaration.
- The declaration router class (declarationRouter) sets up the routes for the declaration feature.
Creating a declaration:
- To create a new declaration, send a POST request to the ```/declarations``` endpoint with the following JSON payload:
```bash
{
"declaration_date": "2023-02-24T00:00:00.000Z",
"declaration_team_mate_id": 123,
"declaration_status": "Remote"
}
``` 
- declaration_date: The date and time of the declaration in Date format (ISO 8601 format).

- declaration_team_mate_id: The ID of the teammate making the declaration.

 - declaration_status: The status of the declaration (Remote, On site, Vacation, Other).
#### Response:
If the declaration is successfully created, the API will send an HTTP response with a status code of 201 (Created) and return a JSON object with the created declaration.
```bash
{
"declaration_id": 456,
"declaration_date": "2023-02-24T10:30:00Z",
"declaration_team_mate_id": 123,
"declaration_status": "Remote"
}
``` 
If there is an error, the API will send an HTTP response with a status code of 500 (server errors) and return a JSON object with an error message.
```bash
{
"message": "Error message"
}
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
