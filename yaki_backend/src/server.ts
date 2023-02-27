// Importing the Express library and related types
import express, { Express, Request, Response } from 'express';
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

interface Captain {
    id: number;
    name: string;
  }

// get body-parser to handle request's body
var bodyParser = require('body-parser');

// Call the initConfig function to load environment variables and log their values to the console
initConfig();
initdb();

// Creating a new instance of the Express app
const app: Express = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extends : false}));
app.use(router);

// Get the value of the PORT environment variable
const port = process.env.Port;

// Setting up the Swagger UI middleware
app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

// Starting the server and logging a message to the console
app.listen(port, () => {
  console.log(`[Server]: I am running at https://localhost:${port}` );
});