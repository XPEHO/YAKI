import express, {Express} from "express";
import "dotenv/config";
import cors from "cors";
// Import the initConfig function from the config.ts module
import {initConfig} from "./config";

// Import the Swagger UI middleware
import swaggerUi from "swagger-ui-express";
import * as swaggerDocument from "./dev/swagger.json";

import {router} from "./router";
import declarationRouter from "./declaration.router";
import teamRouter from "./team.router";
//
import {initdb} from "./db/initdb";

import client from "prom-client";

// Call the initConfig function to load environment variables and log their values to the console
initConfig();
initdb();
const corsOptions = {
  origin: "*",
  optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
};

// Creating a new instance of the Express app
const app: Express = express();
app.use(cors(corsOptions));
app.disable("x-powered-by");
/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
app.use(express.json());

/* A middleware that parses the body of the request and makes it available in the `req.body` property. */
app.use(express.urlencoded({extended: false}));

app.use(router);
/* A middleware that is used to route the request to the declaration router. */
app.use(declarationRouter);
app.use(teamRouter);


// Get the value of the PORT environment variable
const port = process.env.Port;
// Get the value of the HOST environment variable
const host = process.env.Host;

// Setting up the Swagger UI middleware
app.use("/docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));
const collectDefaultMetrics = client.collectDefaultMetrics;

collectDefaultMetrics();
app.use("/metrics",  async (_req, res) =>{
  res.set("Content-Type", client.register.contentType);
  res.end(await client.register.metrics());
});

// Starting the server and logging a message to the console
app.listen(`${port}`, () => {
  console.log(`[Server]: I am running at ${host}:${port}`);
});


