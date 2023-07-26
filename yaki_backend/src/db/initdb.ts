import {Pool} from "pg";
import {createUser} from "./create_user";

export const initdb = async () => {
  let createUserInDB = createUser;

  const pool = new Pool({
    user: `${process.env.DB_USER}`,
    host: `${process.env.DB_HOST}`,
    database: `${process.env.DB_DATABASE}`,
    password: `${process.env.DB_PASSWORD}`,
    port: Number(process.env.DB_PORT),
  });

  await pool.query(createUserInDB);

  await pool.end();
};
