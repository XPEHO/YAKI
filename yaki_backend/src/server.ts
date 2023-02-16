// Importing the Express library and related types
import express, { Express, Request, Response } from 'express';

// Creating a new instance of the Express app
const app: Express = express();

// Setting the server port to 3000
const port = 3000;

// Setting up a basic "hello world" route at the root URL
app.get('/', (req: Request, res: Response) => {
    res.send('Hello, this is Express + TypeScript');
});

// Starting the server and logging a message to the console
app.listen(port, () => {
    console.log(`[Server]: I am running at https://localhost:${port}`);
});






