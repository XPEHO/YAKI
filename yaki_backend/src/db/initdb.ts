import fs from "fs";
import {Pool} from "pg";
import {createUser} from "./create_user";

const readSqlFile = (file: string) => {
  return fs.readFileSync(file, "utf8");
};

export const initdb = async () => {
  let createTable = createUser + readSqlFile("./src/db/create_tables.sql");
  let insertContent = createTable + readSqlFile("./src/db/starting_data.sql");

  const pool = new Pool({
    user: `${process.env.DB_USER}`,
    host: `${process.env.DB_HOST}`,
    database: `${process.env.DB_DATABASE}`,
    password: `${process.env.DB_PASSWORD}`,
    port: Number(process.env.DB_PORT),
  });

  await pool.query(insertContent);

  await pool.end();
};
