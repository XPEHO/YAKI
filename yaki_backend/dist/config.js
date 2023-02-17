"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.initConfig = void 0;
// Import the dotenv package
const dotenv_1 = __importDefault(require("dotenv"));
/**
 * This function loads environment variables from a .env file and logs their
 * values to the console.
 */
const initConfig = () => {
    dotenv_1.default.config();
    console.log(`Postgres host is ${process.env.DB_HOST}`);
    console.log(`Postgres user is ${process.env.DB_USER}`);
    console.log(`Postgres database is ${process.env.DB_DATABASE}`);
    console.log(`Postgres port is ${process.env.DB_PORT}`);
};
exports.initConfig = initConfig;
