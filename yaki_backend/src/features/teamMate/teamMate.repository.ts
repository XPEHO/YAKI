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

  getByTeamIdWithLastDeclaration = async (team_id: number) => {
    const pool = new Pool({
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port:  Number(process.env.DB_PORT)
    }); 
    const poolResult: QueryResult = await pool.query(
      `
        SELECT 
        user_id, team_mate_id, user_last_name, user_first_name, max_decl.declaration_date, max_decl.declaration_status
        FROM public.user
        INNER JOIN public.team_mate
        ON user_id = team_mate_user_id
        LEFT JOIN
        (
          SELECT * 
          FROM (
            SELECT declaration_team_mate_id, declaration_date, declaration_status, rank()
            OVER (PARTITION BY declaration_team_mate_id ORDER BY declaration_date DESC)
            FROM public.declaration
          ) t
          WHERE rank = 1
        ) as max_decl
        ON declaration_team_mate_id = team_mate.team_mate_id
        WHERE team_mate_team_id = ${team_id};
      `
    );
    await pool.end();
    return poolResult.rows;
  }
}