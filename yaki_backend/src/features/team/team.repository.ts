import {Client, QueryResult} from "pg";
import {TeamByCaptDtoIn} from "./teamByCaptainId.dtoIn";
import {TeamDtoIn} from "./team.dtoIn";

export class TeamRepository {
  getTeamByCaptainId = async (captainId: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
    SELECT t.team_id, t.team_name, ct.captains_teams_captain_id, t.team_customer_id, t.team_actif_flag 
    FROM public.team t
    INNER JOIN public.captains_teams ct
    ON ct.captains_teams_team_id = t.team_id
    WHERE ct.captains_teams_captain_id = $1
	  AND team_actif_flag = true;
    `;
    client.connect();
    const clientResult: QueryResult = await client.query(query, [captainId]);
    await client.end();

    const teamListToReturn: TeamByCaptDtoIn[] = [];
    for (let team of clientResult.rows) {
      teamListToReturn.push(
        new TeamByCaptDtoIn(
          team.team_id,
          team.team_name,
          team.captains_teams_captain_id,
          team.team_customer_id,
          team.team_actif_flag
        )
      );
    }
    return teamListToReturn;
  };

  /**
   * This function returns the list of teams that a team mate is in
   * @param teammateId the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByTeammateId = async (userId: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
    SELECT t.team_id, t.team_name, t.team_actif_flag 
	  FROM public.teammate tm
    INNER JOIN public.team t
    ON t.team_id = tm.teammate_team_id
    WHERE tm.teammate_user_id = $1
    AND t.team_actif_flag = true;
    `;
    client.connect();
    try {
      const result = await client.query(query, [userId]);

      const teamListToReturn: TeamDtoIn[] = [];
      for (let team of result.rows) {
        teamListToReturn.push(new TeamDtoIn(team.team_id, team.team_name, team.team_actif_flag));
      }
      return teamListToReturn;
    } finally {
      client.end();
    }
  };
}
