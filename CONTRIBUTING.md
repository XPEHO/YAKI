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

For this project, naming convention for all language use in this project should be on lower camelCase,
except for Classes, enum types, typedefs, and type parameters these one should be on kebab-case.
And files names and PostgreSQL, both should be name types using snake_case

**Example**

```
For a new files : new_file_create.dart
```

```
For new class: title-presentation
```

```
For a new constant variable : const myNewConst = x
```

## Project architecture

The project is a monorepo project

divided into 2 main parts :

- yaki_mobile who content the flutter project :

  - assets content all images we need to run the project and a translate file
  - In the lib file you will discovers three files, main, app and app_router and three folder, data, domain and presentation:

  - All the view is display in ./lib/presentation/ui

  - A style folder is available to use the graphic chart of this project. ./lib/styles

  - In this project we use riverpod for the state-management :
    we use two differents forlder to manage state:
    notifiers folder (./lib/presentation/state/notifier) and providers folder (./lib/presentation/state/provider)

  - We also use dio and retrofit for http request, interceptors...
    you can find the dio file in ./lib/presentation/state/dio

  - For all the data you can find a folder in ./lib/data then you have three files :

  - models : you will find all the model class
  - source : you will find all the http request do with retrofit
  - repositories : you will find all the repositories

  - Test folder like the name said will containt all the test of our application

- yaki_backend is based on node.js and express :

  - ./src will containt server, router and config file. To use don't forget to create your .env file
  - ./test will containt all the test of the back-end project
  - ./db will containt file to generate your database with fake data
  - ./dev containt swagger files
  - ./feature each feature containt controller, DTO, repository and service of its own folder

- database is based on PostgreSQL

- yaki_backend_admin is based on java:

  - assets content all images we need to run the project and a translate file

- yaki admin is based on vue.ts.
