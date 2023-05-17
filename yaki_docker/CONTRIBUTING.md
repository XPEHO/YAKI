### YAKI docker

## Contributing

Contributions are always welcome!

## Recommended IDE Setup

- An IDE: [IntelliJ IDEA] https://www.jetbrains.com/idea/download/#section=windows

## First Utilisation:

# env.sample

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

# application.properties:

1 - The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `application.properties.sample` and customize it with your own configuration settings

## Getting started

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`

