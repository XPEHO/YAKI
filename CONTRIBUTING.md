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

## Es-lint configuration

We use es-lint to check the code quality and to make sure that the code is well written.
Please add this line to your es-lint configuration before pushing your code:

```{
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "files.eol": "\n",
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "prettier.jsxSingleQuote": true,
  "prettier.singleQuote": true,
  "files.autoSave": "afterDelay",
  "git.confirmSync": false,
  "eslint.options": {
    "parserOptions": {
      "ecmaFeatures": {
        "jsx": true
      },
      "ecmaVersion": 12,
      "sourceType": "module"
    }
  },
}
```

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

- yaki_backend_admin is based on java

  - ./src will containt server, path and config file. We sould create an application.properties.sample file if he not exist.

    -./test will containt all the test of the backend-end admin project (JUnit)

- yaki admin is based on vue.ts :

  - assets content all images we need to run the project and a translate file

# env.sample

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

# application.properties.sample

The `application.properties` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `application.properties` file.

The `application.properties` file is used to store sensitive information and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `application.properties.sample` to `application.properties` and customize it with your own configuration settings.

## Recommended

- [Flutter](https://docs.flutter.dev/get-started/install)

- For backend admin: [IntelliJ IDEA] https://www.jetbrains.com/idea/download/#section=windows

- For others : [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

  ## Used library :

- [state management library](https://pub.dev/packages/flutter_riverpod) : State management
- [translation library](https://pub.dev/packages/easy_localization) : Traduction
- [API call library](https://pub.dev/packages/retrofit) : API Call
- [Serialization](https://pub.dev/packages/json_serializable) : Data Serialization (JSON)
- [Navigation](https://pub.dev/packages/go_router) : Manage navigation
- [Flutter SVG](https://pub.dev/packages/flutter_svg) : Dart implementations of SVG parsing
- [Shared Preferences](https://pub.dev/packages/shared_preferences) : Wraps platform-specific persistent storage for simple data
- [Mockito](https://pub.dev/packages/mockito) : Mock library for Dart
- [Golden Toolkit](https://pub.dev/packages/golden_toolkit) : Lets you quickly test various states of your widgets
- [Sass] https://sass-lang.com/: SASS, an acronym for "Syntactically Awesome Style Sheets," is a powerful and popular extension of CSS (Cascading Style Sheets). It introduces various features and enhancements to the standard CSS syntax, making it more efficient and easier to work with when creating styles for websites or applications.

## Used :

[ESLint](https://eslint.org/docs/latest/): ESLint is a popular open-source static code analysis tool for JavaScript code. It is designed to identify and report potential problems or issues in JavaScript code, as well as enforce consistent coding styles and best practices.

[Vue](https://vuejs.org/guide/introduction.html) : ramework used for building user interfaces and single-page applications.

[TypeScript](https://www.typescriptlang.org/docs/): The goal of TypeScript is to improve the quality and maintainability of large-scale JavaScript applications. By adding features such as static data types, classes, interfaces, and stronger type checking, TypeScript helps catch errors earlier in the development process and improve code readability. TypeScript also facilitates interoperability between different JavaScript libraries and frameworks. Ultimately, TypeScript aims to make JavaScript programming more enjoyable and productive.

[Java] https://www.java.com/fr/download/: Java is a programming language and computing platform launched by Sun Microsystems in 1995. Since its humble beginnings, Java has evolved significantly. Currently, a large portion of the digital world relies on Java: numerous services and applications are built on this dependable platform. Likewise, new innovative digital products and future-oriented services also depend on Java.

[Docker] https://www.docker.com/ : Docker is an open-source software platform that allows you to create, deploy, and run applications in lightweight, self-contained containers. Docker containers are isolated execution units that encapsulate all the elements necessary to run an application, including code, libraries, dependencies, and environment variables. In summary, Docker is a technology that simplifies the deployment and management of applications by encapsulating them in lightweight and portable containers, offering greater flexibility, improved resource efficiency, and ease of cross-platform implementation.
```
