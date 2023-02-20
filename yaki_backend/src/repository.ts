import { Pool, QueryResult } from 'pg';
import dotenv from 'dotenv';

interface Captain {
  id: number;
  name: string;
}

const getCaptains = async (): Promise<Captain[]> => {
  const pool = new Pool({
    user: `${process.env.DB_USER}`,
    host: `${process.env.DB_HOST}`,
    database: `${process.env.DB_DATABASE}`,
    password: `${process.env.DB_PASSWORD}`,
    port:  Number(process.env.DB_PORT)
  });
  const poolResult: QueryResult = await pool.query('SELECT * FROM CAPTAIN');
  await pool.end();
  return poolResult.rows as Captain[];
};

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

export { getCaptains , findCaptains};