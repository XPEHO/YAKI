import {Client, QueryResult} from "pg";
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
    SELECT * FROM public.team
    WHERE team_captain_id = $1;`
    client.connect()
    const poolResult: QueryResult = await client.query(query,[captainId]);
    await client.end();
    return poolResult.rows[0];
  };

  /**
   * This function returns the list of teams that a team mate is in
   * @param teamMateId the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByTeamMateId = async (teamMateId: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
    SELECT team_id, team_captain_id, team_name FROM public.team_mate
    INNER JOIN public.team 
    ON team_id = team_mate_team_id
    WHERE team_mate_user_id = $1;
    `;
    client.connect()
    try {
      const result = await client.query(query,[teamMateId]);

      const teamListToReturn: TeamDtoIn[] = [];

      for (let team of result.rows) {
        teamListToReturn.push(new TeamDtoIn(team.team_id, team.team_captain_id, team.team_name));
      }

      return teamListToReturn;
    } finally {
      client.end();
    }
  };
}
