# YAKI_backend

Back-end of the Yaki application.

yaki_backend is based on node.js and express :

- ./src will containt server, router and config file. To use don't forget to create your .env file
- ./test will containt all the test of the back-end project
- ./db will containt file to generate your database with fake data
- ./dev containt swagger files
- ./feature each feature containt controller, DTO, repository and service of its own folder

## env.sample

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

## Getting started

Fetch dependencies
`npm install`

Run the server
`npm start `

Run with hot reload
`npm run dev`

Update Swagger definition

`npm run swagger`

Build docker image

`docker build .`

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`
