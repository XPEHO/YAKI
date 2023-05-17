# YAKI_admin_backend

Desktop back-end of the Admin Yaki application.

# First Utilisation:

## application.properties:

1 - The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `application.properties.sample` and customize it with your own configuration settings

## Getting started

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`


