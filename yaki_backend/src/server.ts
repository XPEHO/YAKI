// Importing the Express library and related types
import express, { Express, Request, Response } from 'express';
// Load environment variables from a .env file
import "dotenv/config"
// Import the initConfig function from the config.ts module
import { initConfig } from './config';

import swaggerUi from "swagger-ui-express";


// Call the initConfig function to load environment variables and log their values to the console
initConfig();

// Creating a new instance of the Express app
const app: Express = express();

// Get the value of the PORT environment variable
const port = process.env.Port;


app.use(
    "/docs",
    swaggerUi.serve,
    swaggerUi.setup(undefined, {
      swaggerOptions: {
        url: "./swagger.json",
      },
    })
  );

// Setting up a basic "hello world" route at the root URL
app.get('/', (req: Request, res: Response) => {
    res.send('Hello, this is Express + TypeScript');
});

// Starting the server and logging a message to the console
app.listen(port, () => {
    console.log(`[Server]: I am running at https://localhost:${port}`);
});






