# YAKI docker

# Contributing to YAKI

This file contains all the rules to follow in order to add your contribution to YAKI project.

# Public contributions

We are pleased to accept public issues from our users. Please fill an issue using one of the following templates.

## Feature requests

Wants to ask for a new feature in the app ? Choose this template.

Tell us about the context and the issue to solve with this feature.

Share any imaginated solution

Add some additional infos like screens, schemas, etc...

## Bugs

Please be precise for any bug reporting.

We need as much information as possible in order to be able to reproduce and fix the potential bug.

What was the context when the issue occured ?

How can we try to reproduce it ? What are the steps ?

What is the expected behavior ?

What happenned instead ?

Add every additional info like, phone model, OS, phone orientation (landscape, portrait), frequency, penality etc...

# XPEHO Internal contributions

## Accepted contributors

XPEHO company members are the only ones able to make code changes.

## Contribution process

1. Fill an issue to explain the change to do

2. XPEHO team will make some triage

3. Issue is accepted or rejected

4. Accepted issues will be prioritized

5. XPEHO Dev team will plan issue modifications in future dev cycle

6. Modifications will be pushed on a dedicated branch

7. Once ready, a Pull request is opened for code review and CI checks

8. Checked modification will be merged to the main branch

## Git flow

We work with `single trunk based developpment`

More information at [https://trunkbaseddevelopment.com/](https://trunkbaseddevelopment.com/)

### Branch names

All branches must reach the following convention

```
<prefix>/<change_name>
```

**Example**

```
feat/authentication
```

**Accepted prefix list**

- feat
- feature
- fix
- hotfix
- docs
- style
- refactor
- chore
- test

**Prefix list explaination**

**feat**

Branch containing small enhancement changes

**feature**

Branch containing multiple enhancement changes from multiple feat ones

**fix**

Branch containing only a bug fix

**hotfix**

Branch containing only a PROD hurry fix

**docs**

Branch containing only documentation changes

**style**

Branch containing only UI style changes

**refactor**

Branch containing breaking changes

**chore**

Branch containing tooling change like CI/CD, Issue templates, gitignore file etc...

**test**

Branch containing test

### Commit convention

We respect the `Angular Js Commit message` convention

Full documentation at [https://gist.github.com/stephenparish/9941e89d80e2bc58a153](https://gist.github.com/stephenparish/9941e89d80e2bc58a153)

The commit message must respect the following convention

```
<type>(<scope>): <subject>
```

**Example**

```
feat(authentication): Create authentication screen
```

**Accepted prefix list**

Accepted prefix list is the same as the branch prefix list

- feat
- fix
- hotfix
- docs
- style
- refactor
- chore
- test

## Pull Requests

Each change must be proposed to merge using a `Pull Request` from the current branch to the main one

For more information about `Pull Request` creation please visit [https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)

## Naming Convention

For this project, naming convention for all language use in this project should be on lower camelCase, except for Classes, enum types, typedefs, and type parameters these one should be on PascalCase.
Components references in Yaki Admin (VueJS) should be on kebab-case.
And files names and PostgreSQL, both should be name types using snake_case.

**Example**

```
For a new files : new_file_create.dart
```

```
For new class: titlePresentation
Components in the template in yaki-admin: title-presentation
```

```
For a new constant variable : const myNewConst = x
```

# env.sample

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

# application.properties.sample

The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `application.properties.sample` to `application.properties` and customize it with your own configuration settings.

## Getting started

Run as docker with server + database
`cd ../yaki_docker`
`docker compose build`
`docker compose up`
