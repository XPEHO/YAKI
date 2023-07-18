# YAKI_admin_backend

This project is the backend part of the YAKI admin application.

# Table of contents

- [General info](#general-info)
- [Client connection](#how-to-connect-with-the-client-side)
- [Environment variables](#properties.sample)
- [Getting started](#getting-started)

# General info

## Authentification

No GAFAM will be used for authentification
We will implement a home made authentification process
We are using JWT authorization token in the Authorization header.

## Data format

- captain: id, firstName, lastName, email, customer_name
- customer: id, name, owner_name, location_name, location_adress
- owner: id, firstName, lastName, email,
- teamMate: id, firstName, lastName, email, team_name
- team: id, captain_id, name
- user: last_name, firstname, email, login, password

## Path

- GetMapping:

  - getCaptains => get all captains
  - getCustomers => get all customers
  - findAll => get all owners

- PostMapping:

  - createCaptain => add a new captain
  - createCustomer => add a new customer
  - createOwner => add a new owner
  - createTeam => add a new team
  - createTeammate => add a new teamMate
  - createUser => add a new user

- GetMapping("{id}"):

  - getCaptainById => get a captain by id
  - getCustomer(id) => get a customer by id
  - findById => get a owner by id
  - getTeam(id) => get a team by id
  - getTeammate(id)=> get a teamMate by id

- DeleteMapping("{id}"):

  - deleteById => delete a captain/customer/owner/team/teamMate by id

- PutMapping("{id}"):

  - saveOrUpdate => update a captain/customer/team/ teamMate by id

- GetMapping({"captain/{id}"}):

  - findAllByCaptain => find all team by captain id

- GetMapping("team/{id}"):
  - findAllByTeam(id) => find all teamMate by team id.

<!-- add login path -->

# How to connect with the client side

## Authentication

When a user tries to connect to the YAKI app, the client must provide a json object in the following format:

```json
{
  "login": "user_login_value",
  "password": "user_password_value"
}
```

If the login and password values match any user in the database, the server will return the latter.
Depending on the user's role (owner, customer or captain) it will return three differents json objects:

**owner**

```ts
{
    "token"
:
    string,
        "owner_id"
:
    number,
        "user_id"
:
    number,
        "last_name"
:
    string,
        "first_name"
:
    string,
        "email"
:
    string,
}
```

**customer**

```ts
{
    "token"
:
    string,
        "customer_id"
:
    number,
        "name"
:
    string,
        "owner_id"
:
    number,
        "user_id"
:
    number,
        "last_name"
:
    string,
        "first_name"
:
    string,
        "email"
:
    string,
        "location_id"
:
    number,
        "location_name"
:
    string,
        "location_adress"
:
    string,
}
```

**captain**

```ts
{
    "token"
:
    string,
        "captain_id"
:
    number,
        "user_id"
:
    number,
        "last_name"
:
    string,
        "first_name"
:
    string,
        "email"
:
    string,
        "customer_id"
:
    number
}
```

The token is necessary on each request following the user login. If you don't provide the correct token, the server will
withdraw the request and return an error.

The token must be inside the request's headers like so :

<!-- to add -->

# Environment variables

**application.properties**

The `application.properties` file provides a template for creating an environment configuration file. It contains a list
of environment variables and their default values, which can be used as a starting point for creating
a `application.properties` file.

The `application.properties` file is used to store sensitive information and other configuration settings that should
not be hard-coded in the application code. We recommend that you copy `application.properties.sample`
to `application.properties` and customize it with your own configuration settings.

# Recommended IDE Setup

- An IDE: [IntelliJ IDEA] https://www.jetbrains.com/idea/download/#section=windows

# Used :

[Java] https://www.java.com/fr/download/: Java is a programming language and computing platform launched by Sun
Microsystems in 1995. Since its humble beginnings, Java has evolved significantly. Currently, a large portion of the
digital world relies on Java: numerous services and applications are built on this dependable platform. Likewise, new
innovative digital products and future-oriented services also depend on Java.

[Docker] https://www.docker.com/ : Docker is an open-source software platform that allows you to create, deploy, and run
applications in lightweight, self-contained containers. Docker containers are isolated execution units that encapsulate
all the elements necessary to run an application, including code, libraries, dependencies, and environment variables. In
summary, Docker is a technology that simplifies the deployment and management of applications by encapsulating them in
lightweight and portable containers, offering greater flexibility, improved resource efficiency, and ease of
cross-platform implementation.

# Getting started

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`
