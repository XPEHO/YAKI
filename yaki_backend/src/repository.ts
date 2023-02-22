import { Pool, QueryResult } from 'pg';
import dotenv from 'dotenv';

/* Defining the shape of the data that will be returned from the database. */
interface Captain {
  id: number;
  name: string;
}

interface Declaration {
  declaration_id: number;
  declaration_team_mate_id: number;
  declaration_date: string;
  status: string
}

interface TemeMate {
  id: number;
    name: string;
}

const createDeclaration = async (declaration: Declaration) : Promise<Declaration> =>{
  const pool = new Pool({
    user: `${process.env.DB_USER}`,
    host: `${process.env.DB_HOST}`,
    database: `${process.env.DB_DATABASE}`,
    password: `${process.env.DB_PASSWORD}`,
    port: Number(process.env.DB_PORT)
  });
  const result = await pool.query(
    'INSERT INTO teammate_declarations (declaration_date, declaration_team_mate_id, status) VALUES ($1, $2, $3) RETURNING *',
    [declaration.declaration_date, declaration.declaration_team_mate_id, declaration.status]
  );
  return result.rows[0];

}
/**
 * This function returns a promise that resolves to an array of Captain objects.
 * @returns An array of Captain objects.
 */
const getCaptains = async (): Promise<Captain[]> => {
  const pool = new Pool({
    user: `${process.env.DB_USER}`,
    host: `${process.env.DB_HOST}`,
    database: `${process.env.DB_DATABASE}`,
    password: `${process.env.DB_PASSWORD}`,
    port: Number(process.env.DB_PORT)
  });
  const poolResult: QueryResult = await pool.query('SELECT * FROM CAPTAIN');
  await pool.end();
  return poolResult.rows as Captain[];
};

/**
 * It takes a string as an argument, and returns a promise that resolves to an array of Captain objects
 * @param {string} name - string
 * @returns An array of Captain objects.
 */
const findCaptains = async (name: string): Promise<Captain[]> => {
  const pool = new Pool(
    {
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port: Number(process.env.DB_PORT)
    }
  );
  const poolResult: QueryResult = await pool.query(`SELECT * FROM CAPTAIN WHERE name like '%${name}%'`);
  await pool.end();
  return poolResult.rows as Captain[];
};

/* Exporting the functions so that they can be used in other files. */
export { getCaptains, findCaptains , createDeclaration};