import {Client} from "pg";

import {TeamDtoIn} from "./team.dtoIn";
import {TeamLogoDto} from "./teamLogo.dto";
import {DataError} from "../../errors/dataOrDataBaseError";

export class TeamRepository {
  /**
   * This function returns the list of teams that a user is part of
   * @param userId the id of the team mate
   * @returns a list of teams that the user is part of
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
        teamListToReturn.push(
          new TeamDtoIn(team.team_id, team.team_name, team.team_actif_flag)
        );
      }
      return teamListToReturn;
    } finally {
      client.end();
    }
  };

  /**
   * Retrive a list of team logo given a list of team id.
   * If a team id does not have a logo, it will not be returned.

   * @param teamIds list of team id
   * @returns promise of list of TeamLogoDto
   */
  getTeamLogoByTeamsId = async (teamIds: number[]): Promise<TeamLogoDto[]> => {
    let teamIdListString = teamIds.join(",");

    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
      SELECT 
      tl.team_logo_team_id, 
      tl.team_logo_blob 
      FROM public.team_logo tl
      WHERE tl.team_logo_team_id in (${teamIdListString})
    `;

    await client.connect();
    try {
      const result = await client.query(query);

      if (result.rows.length === 0) {
        return [];
      }
      const teamLogoList: TeamLogoDto[] = result.rows.map(
        (teamImageRow) =>
          new TeamLogoDto(teamImageRow.team_logo_team_id, teamImageRow.team_logo_blob)
      );
      return teamLogoList;
    } catch (error: any) {
      throw new DataError("Error during users avatar fetching: " + error.message);
    } finally {
      client.end();
    }
  };

  // DEPRECIATED - TO BE REMOVED WHEN 1.10 isnt used anymore
  //========================================================
  /**
   * This function returns the list of teams that a team mate is in
   * @param user_id the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByUserId = async (userId: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `

  -- Get user teams
  SELECT distinct team_id
  FROM team
  JOIN teammate on (teammate_team_id = team_id)
  JOIN public.user on (teammate_user_id = user_id AND user_id= $1) `;
    client.connect();
    try {
      const result = await client.query(query, [userId]);

      const teamListToReturn: TeamDtoIn[] = [];
      for (let team of result.rows) {
        teamListToReturn.push(
          new TeamDtoIn(team.team_id, team.team_name, team.team_actif_flag)
        );
      }
      return teamListToReturn;
    } finally {
      client.end();
    }
  };
}
