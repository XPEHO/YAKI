// Import the dotenv package
import dotenv from 'dotenv';

/**
 * This function loads environment variables from a .env file and logs their 
 * values to the console.
 */
const initConfig = (): void => {
    dotenv.config();
    console.log(`Postgres host is ${process.env.DB_HOST}`);
    console.log(`Postgres user is ${process.env.DB_USER}`);
    console.log(`Postgres database is ${process.env.DB_DATABASE}`);
    console.log(`Postgres port is ${process.env.DB_PORT}`);
}

// Export the initConfig function so that it can be used in other modules
export { initConfig };