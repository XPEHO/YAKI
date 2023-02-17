"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// Importing the Express library and related types
const express_1 = __importDefault(require("express"));
// Load environment variables from a .env file
require("dotenv/config");
// Import the initConfig function from the config.ts module
const config_1 = require("./config");
const swaggerUi = require('swagger-ui-express');
// const swaggerDocument = require('dev/swagger.json');
// Call the initConfig function to load environment variables and log their values to the console
(0, config_1.initConfig)();
// Creating a new instance of the Express app
const app = (0, express_1.default)();
// Get the value of the PORT environment variable
const port = process.env.Port;
// app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));
app.use("/docs", swaggerUi.serve, swaggerUi.setup(undefined, {
    swaggerOptions: {
        url: "./dev/swagger.json",
    },
}));
// Setting up a basic "hello world" route at the root URL
app.get('/', (req, res) => {
    res.send('Hello, this is Express + TypeScript');
});
// Starting the server and logging a message to the console
app.listen(port, () => {
    console.log(`[Server]: I am running at https://localhost:${port}`);
});
