import { Pool, QueryResult } from "pg";

export class CaptainRepository {
  /**
   * Seek a captain by its user_id
   * @param user_id 
   * @returns 
   */
  getByUserId = async (user_id: string) => {
    const pool = new Pool({
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port:  Number(process.env.DB_PORT)
    }); 
    const poolResult: QueryResult = await pool.query(
      `SELECT * FROM public.captain INNER JOIN public.user ON captain_user_id = user_id WHERE captain_user_id = '${user_id}';`
    );
    await pool.end();
    return poolResult.rows[0];
  }

  /**
   * Seek all captains
   * @returns 
   */
  getAll = async () => {
    const pool = new Pool({
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port:  Number(process.env.DB_PORT)
    }); 
    const poolResult: QueryResult = await pool.query(
      `SELECT * FROM public.captain`
    )
    await pool.end();
    console.log(poolResult.rows)
    return poolResult.rows;
  }
}