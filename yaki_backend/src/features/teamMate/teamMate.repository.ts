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
    WHERE team_mate_team_id = $1
    AND declaration_date::date = now()::date;
  `;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [team_id]);
    await client.end();
    return poolResult.rows;
  };
}
