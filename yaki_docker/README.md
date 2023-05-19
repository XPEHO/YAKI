## YAKI docker

The docker-compose.yml file is used to define and manage services for an application using Docker Compose

## Used

[Docker] https://www.docker.com/ : Docker is an open-source software platform that allows you to create, deploy, and run applications in lightweight, self-contained containers. Docker containers are isolated execution units that encapsulate all the elements necessary to run an application, including code, libraries, dependencies, and environment variables. In summary, Docker is a technology that simplifies the deployment and management of applications by encapsulating them in lightweight and portable containers, offering greater flexibility, improved resource efficiency, and ease of cross-platform implementation.

## env.sample

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.


# application.properties.sample

The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `application.properties.sample` to `application.properties` and customize it with your own configuration settings.

## Getting started

Build docker image

`docker build .`

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`