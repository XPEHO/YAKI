# YAKI

Working localization declaration app

## Table of contents

- [General info](#general-info)
- [Structure](#structure)
- [Environment variables](#Environment-variables)

# General-info

## Authentification

No GAFAM will be used for authentification
We will implement a home made authentification process
We will use JWT authorization token in the Authorization header

# Structure

**yaki_admin**

Contains the Web administration UI

**yaki_backend**

Contains the backend server

**yaki_database**

Contains the database scripts

**yaki_mobile**

Contains the mobile app

**yaki_karate**

Contains API test automation

## Pull request CI

**Git checks**

Each pull request will trigger several checks like:

- branch name
- commit message
- up to date branch

> See `.github/workflows/git_checks.yaml` workflow file

**Labels**

A label will be automatically added to pull requests regarding the branch name in order to prepare the auto generated changelog

> See `.github/workflows/labels.yaml` workflow file

# Environment-variables

**application.properties**

The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `application.properties.sample` to `application.properties` and customize it with your own configuration settings.

**env.sample**

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

## Automatic release changelog

The `.github/release.yml` file contains the configuration for automatic changelog generation

For more information please visit [Automatically generated release notes](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes)
