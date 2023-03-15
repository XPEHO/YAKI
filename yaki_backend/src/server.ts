// Importing the Express library and related types
import express, { Express } from 'express';
// Load environment variables from a .env file
import "dotenv/config"
// Import the initConfig function from the config.ts module
import { initConfig } from './config';

// Import the Swagger UI middleware 
import swaggerUi from "swagger-ui-express";
// Import swagger JSON file
import * as swaggerDocument from "./dev/swagger.json";

import { router } from './router';
import { initdb } from './db/initdb';
/* Importing the declaration router from the declaration.router.ts file. */
import declarationRouter from './features/declaration/declaration.router';

import cors from 'cors';

// get body-parser to handle request's body
var bodyParser = require('body-parser');

// Call the initConfig function to load environment variables and log their values to the console
initConfig();
initdb();

var corsOptions = {
  origin: '*',
  optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
}


// Creating a new instance of the Express app
const app: Express = express();
app.use(cors(corsOptions))
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extends : false}));
app.use(router);

// Get the value of the PORT environment variable
const port = process.env.Port;
// Get the value of the HOST environment variable
const host = process.env.Host

// Setting up the Swagger UI middleware
app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
app.use(bodyParser.json())

/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
app.use(bodyParser.urlencoded({ extends: false }))

/* A middleware that is used to route the request to the declaration router. */
app.use(declarationRouter);

// Starting the server and logging a message to the console
app.listen( `${port}`, () => {
  console.log(`[Server]: I am running at ${host}:${port}` );
});