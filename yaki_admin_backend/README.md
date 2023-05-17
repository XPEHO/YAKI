### YAKI_admin_backend

Desktop back-end of the Admin Yaki application.

## Contributing

Contributions are always welcome!

## First Utilisation:

# application.properties:

1 - The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `application.properties.sample` and customize it with your own configuration settings

## Recommended IDE Setup

- An IDE: [IntelliJ IDEA] https://www.jetbrains.com/idea/download/#section=windows

## Used :

[Java] https://www.java.com/fr/download/: Java is a programming language and computing platform launched by Sun Microsystems in 1995. Since its humble beginnings, Java has evolved significantly. Currently, a large portion of the digital world relies on Java: numerous services and applications are built on this dependable platform. Likewise, new innovative digital products and future-oriented services also depend on Java.

[Docker] https://www.docker.com/ : Docker is an open-source software platform that allows you to create, deploy, and run applications in lightweight, self-contained containers. Docker containers are isolated execution units that encapsulate all the elements necessary to run an application, including code, libraries, dependencies, and environment variables. In summary, Docker is a technology that simplifies the deployment and management of applications by encapsulating them in lightweight and portable containers, offering greater flexibility, improved resource efficiency, and ease of cross-platform implementation.

## Getting started

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`
