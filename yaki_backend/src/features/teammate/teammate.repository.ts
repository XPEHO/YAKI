import { Client, QueryResult } from 'pg';

export class TeammateRepository {
  getByTeamIdWithLastDeclaration = async (team_id: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
SELECT DISTINCT * FROM (
	SELECT 
		d.declaration_id,
		d.declaration_user_id,
		d.declaration_date,
		d.declaration_date_start,
		d.declaration_date_end,
		d.declaration_status,
		team_name,
    team_id,
    user_last_name,
    user_first_name,
    user_id
	FROM declaration as d
	JOIN public.team ON (team_id in ($1) and d.declaration_team_id = team_id)
    JOIN public.user as u on (u.user_id = d.declaration_user_id)
	WHERE d.declaration_date::date = now()::date
) as disticnts`;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [team_id]);
    await client.end();
    return poolResult.rows;
  };
}
