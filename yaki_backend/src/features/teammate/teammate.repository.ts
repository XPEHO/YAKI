import {Client, QueryResult} from "pg";

export class TeammateRepository {
  getByTeamIdWithLastDeclaration = async (teamsIdList: number[]) => {
    let teamIdListString;
    if (teamsIdList.length === 1) {
      teamIdListString = teamsIdList[0];
    } else {
      teamIdListString = teamsIdList.join(",");
    }

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
      JOIN public.team ON (team_id in (${teamIdListString}) and d.declaration_team_id = team_id)
        JOIN public.user as u on (u.user_id = d.declaration_user_id)
      WHERE d.declaration_date::date = now()::date
    ) as distinctsDecl
    ORDER BY distinctsDecl.declaration_date DESC`;
    client.connect();
    const poolResult: QueryResult = await client.query(query);
    await client.end();

    return poolResult.rows;
  };
}
