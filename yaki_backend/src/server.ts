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

// const db = require('./repository.ts')
import * as db from './repository';

/* Importing the declaration router from the declaration.router.ts file. */
import declarationRouter from './features/declaration/declaration.router';

/* Defining the shape of the data that will be returned from the database. */
interface Captain {
  id: number;
  name: string;
}

/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
var bodyParser = require('body-parser')

// Call the initConfig function to load environment variables and log their values to the console
initConfig();

// Creating a new instance of the Express app
const app: Express = express();

// Get the value of the PORT environment variable
const port = process.env.Port;
// get the value of the HOST envirement variable
const host = process.env.Host

// Setting up the Swagger UI middleware
app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
app.use(bodyParser.json())

/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
app.use(bodyParser.urlencoded({ extends: false }))

/* A middleware that is used to route the request to the declaration router. */
app.use(declarationRouter);

// Setting up a basic "hello world" route at the root URL
app.get('/', (req: Request, res: Response) => {
  res.send('Hello, this is Express + TypeScript');
});

/* This is a route handler. It is a function that is called when a request is made to the `/captains`
endpoint. */
app.get('/captains', async (req, res) => {
  const captains: Captain[] = await db.getCaptains();
  res.send(captains)
})

/* This is a route handler. It is a function that is called when a request is made to the `/captains`
endpoint. */
app.get('/captains/:name', async (req, res) => {
  const captains: Captain[] = await db.findCaptains(req.params.name);
  res.send(captains)
})

// Starting the server and logging a message to the console
app.listen(port, () => {
  console.log(`[Server]: I am running at ${host}:${port}`);
});






