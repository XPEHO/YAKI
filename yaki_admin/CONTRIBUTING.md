# YAKI_admin_frontend

Desktop front-end of the Admin Yaki application.

Yaki admin frontend is the desktop version so that : - the owner can manage his customer - the customer can manage his captain - the captain can manage their teams and teamMates

## env.sample

The `env.sample` file provides a template for creating an environment configuration file. It contains a list of environment variables and their default values, which can be used as a starting point for creating a `.env` file.

The `.env` file is used to store sensitive information such as API keys, database credentials, and other configuration settings that should not be hard-coded in the application code. We recommend that you copy `env.sample` to `.env` and customize it with your own configuration settings.

## Used:

[ESLint](https://eslint.org/docs/latest/): ESLint is a popular open-source static code analysis tool for JavaScript code. It is designed to identify and report potential problems or issues in JavaScript code, as well as enforce consistent coding styles and best practices.

[Vue](https://vuejs.org/guide/introduction.html) : ramework used for building user interfaces and single-page applications.

[TypeScript](https://www.typescriptlang.org/docs/): The goal of TypeScript is to improve the quality and maintainability of large-scale JavaScript applications. By adding features such as static data types, classes, interfaces, and stronger type checking, TypeScript helps catch errors earlier in the development process and improve code readability. TypeScript also facilitates interoperability between different JavaScript libraries and frameworks. Ultimately, TypeScript aims to make JavaScript programming more enjoyable and productive.

[Sass] https://sass-lang.com/: SASS, an acronym for "Syntactically Awesome Style Sheets," is a powerful and popular extension of CSS (Cascading Style Sheets). It introduces various features and enhancements to the standard CSS syntax, making it more efficient and easier to work with when creating styles for websites or applications.

## Project Setup

```
npm install
```

### Compile and Hot-Reload for Development

```
npm run dev

```

### Type-Check, Compile and Minify for Production

```
npm run build
```

### Lint with [ESLint](https://eslint.org/)

```
npm run lint
```
