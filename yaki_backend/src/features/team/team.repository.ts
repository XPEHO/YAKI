import {Client} from "pg";

import {TeamDtoIn} from "./team.dtoIn";

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
        teamListToReturn.push(new TeamDtoIn(team.team_id, team.team_name, team.team_actif_flag));
      }
      return teamListToReturn;
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
        teamListToReturn.push(new TeamDtoIn(team.team_id, team.team_name, team.team_actif_flag));
      }
      return teamListToReturn;
    } finally {
      client.end();
    }
  };
}
