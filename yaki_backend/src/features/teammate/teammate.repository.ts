import {Client, QueryResult} from "pg";

export class TeammateRepository {
  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  getByTeamIdWithLastDeclaration = async (teamsIdList: number[]) => {
    let teamIdListString = teamsIdList.join(",");

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

  /**
   * Retrive all uers's declaration for the current day.
   * If there is no declaration, all declaration related values will be null.
   * Meaning the user still dont have a declaration for the current day.
   * @param usersId users id list used to get their declarations
   * @returns
   */
  getTeammatesDeclarationsFromUserTeams = async (usersId: number[]) => {
    const valuesList = usersId.map((_, index) => `$${index + 1}`).join(",");

    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
    SELECT 
      u.user_id, 
      u.user_last_name, 
      u.user_first_name,
      d.declaration_date, 
      d.declaration_date_start, 
      d.declaration_date_end, 
      d.declaration_status, 
      d.team_id,
      d.team_name,
      d.team_customer_id,
      d.customer_name
    FROM public.user u
    LEFT JOIN (
      SELECT * FROM public.declaration subd 
      INNER JOIN public.team t on t.team_id = subd.declaration_team_id
      INNER JOIN public.customer c on t.team_customer_id = c.customer_id
      ) as d on ( 
        d.declaration_user_id = u.user_id 
        AND d.declaration_is_latest = true 
        AND d.declaration_date::date = now()::date
        )
    WHERE u.user_id IN (${valuesList}) 
    ORDER BY d.declaration_date DESC`;
    client.connect();
    const poolResult: QueryResult = await client.query(query, usersId);
    await client.end();

    return poolResult.rows;
  };

  /**
   * Get all users id from the teams where the selected user is into.
   * @param userId
   * @returns usersId list number[]
   */
  getUsersIdFromTeamsWhereUserIsInto = async (userId: number): Promise<number[]> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
    SELECT DISTINCT tm.teammate_user_id
    FROM public.teammate tm
    INNER JOIN public.team t ON tm.teammate_team_id = t.team_id
    WHERE t.team_id IN (
        SELECT subtm.teammate_team_id 
        FROM public.teammate subtm
        WHERE subtm.teammate_user_id = $1 
    )
    AND t.team_actif_flag = true`;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [userId]);
    await client.end();

    return poolResult.rows.map((row) => row.teammate_user_id);
  };

  /**
   * Determine if one if the user from the selected user list (usersId) has an absence.
   * @param usersId number[]
   * @returns AbsenceDeclarationDto[]
   */
  getUsersAbsence = async (usersId: number[]) => {
    const valuesList = usersId.map((_, index) => `$${index + 1}`).join(",");

    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
    SELECT 
    d.declaration_user_id,
    d.declaration_date,
    d.declaration_date_start,
    d.declaration_date_end,
    d.declaration_status
    FROM public.declaration d
    WHERE (
    	d.declaration_user_id IN (${valuesList})
    	AND d.declaration_status = 'absence' 
    	AND d.declaration_date_start::date <= now()::date 
    	AND d.declaration_date_end::date > now()::date
    	)
    ORDER BY d.declaration_date DESC, ABS(DATE_PART('day', d.declaration_date_start - NOW()))
    LIMIT 1;
    `;
    client.connect();
    const poolResult: QueryResult = await client.query(query, usersId);
    await client.end();

    return poolResult.rows;
  };
}
