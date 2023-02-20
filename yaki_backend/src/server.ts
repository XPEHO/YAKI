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

interface Captain {
    id: number;
    name: string;
  }

// Call the initConfig function to load environment variables and log their values to the console
initConfig();

// Creating a new instance of the Express app
const app: Express = express();

// Get the value of the PORT environment variable
const port = process.env.Port;
const adress = process.env.Adress

// Setting up the Swagger UI middleware
app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));


// Setting up a basic "hello world" route at the root URL
app.get('/', (req: Request, res: Response) => {
    res.send('Hello, this is Express + TypeScript');
});

app.get('/captains',  async (req, res) => {
    const captains: Captain[] = await db.getCaptains();
    res.send(captains)
  })
  
  app.get('/captains/:name',  async (req, res) => {
    const captains: Captain[] = await db.findCaptains(req.params.name);
    res.send(captains)
  })

// Starting the server and logging a message to the console
app.listen(port, () => {
    console.log(`[Server]: I am running at ${adress}:${port}` );
});






