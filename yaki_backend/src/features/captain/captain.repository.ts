import { Client } from "pg";

export class CaptainRepository {
  /**
   * Seek a captain by its user_id
   * @param user_id 
   * @returns 
   */

getByUserId = async (user_id: string) => {
  const client = new Client({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    port: Number(process.env.DB_PORT),
  });
  client.connect()
  const query = `SELECT * FROM public.captain INNER JOIN public.user ON captain_user_id = user_id WHERE captain_user_id = $1`;
  const values = [user_id];

  try {
    const result = await client.query(query, values);
    client.end()
    return result.rows;
  } catch (err) {
    console.error(err);
    return
  } finally {
    client.end();
  }
}

  /**
   * Seek all captains
   * @returns 
   */
  getAll = async () => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    client.connect()
    const query = `SELECT * FROM public.captain`;
    try {
      const result = await client.query(query);
      client.end()
      return result.rows;
    } catch (err) {
      console.error(err);
      return
    } finally {
      client.end();
    }
  }
}