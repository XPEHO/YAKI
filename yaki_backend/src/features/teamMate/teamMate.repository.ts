import {Client, QueryResult} from "pg";

export class TeamMateRepository {
  /**
   * Seek a user in the database by its user_id
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
    const query = `SELECT * FROM public.team_mate INNER JOIN public.user ON team_mate_user_id = user_id WHERE team_mate_user_id = $1;`;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [user_id]);
    await client.end();
    return poolResult.rows[0];
  };

  getByTeamIdWithLastDeclaration = async (team_id: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
        SELECT user_id, team_mate_id, user_last_name, user_first_name,
        CASE
            WHEN declaration_date::date = now()::date 
            OR (
                declaration_date_start::date <= now()::date
                AND declaration_date_end::date > now()::date 
              )
            THEN declaration_date
            ELSE NULL
        END AS declaration_date,
        CASE
            WHEN declaration_date::date = now()::date 
            OR (
                declaration_date_start::date <= now()::date
                AND declaration_date_end::date > now()::date 
              )
            THEN declaration_status
            ELSE NULL
        END AS declaration_status
        FROM (
            SELECT u.user_id, t.team_mate_id, u.user_last_name, u.user_first_name, d.declaration_date AS declaration_date, d.declaration_date_start, d.declaration_date_end, d.declaration_status,
            ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY d.declaration_date DESC) AS rowCount
            FROM public.user AS u
            INNER JOIN public.team_mate AS t ON u.user_id = t.team_mate_user_id
            LEFT JOIN public.declaration AS d ON t.team_mate_id = d.declaration_team_mate_id
            WHERE t.team_mate_team_id = $1
        ) AS subquery
        WHERE rowCount = 1;
  `;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [team_id]);
    await client.end();
    return poolResult.rows;
  };
}
