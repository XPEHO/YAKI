import { Pool, QueryResult } from "pg";

export class TeamMateRepository {
  /**
   * Seek a user in the database by its user_id
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
      `SELECT * FROM public.team_mate INNER JOIN public.user ON team_mate_user_id = user_id WHERE team_mate_user_id = '${user_id}';`
    );
    await pool.end();
    return poolResult.rows[0];
  }
}