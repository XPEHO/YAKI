import {Pool, QueryResult} from "pg";
import {TeamDtoIn} from "./team.dtoIn";

export class TeamRepository {
  private pool: Pool;

  constructor() {
    this.pool = new Pool({
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port: Number(process.env.DB_PORT),
    });
  }

  getTeamByCaptainId = async (captainId: number) => {
    const pool = new Pool({
      user: `${process.env.DB_USER}`,
      host: `${process.env.DB_HOST}`,
      database: `${process.env.DB_DATABASE}`,
      password: `${process.env.DB_PASSWORD}`,
      port: Number(process.env.DB_PORT),
    });
    const poolResult: QueryResult = await pool.query(
      `
        SELECT * FROM public.team
        WHERE team_captain_id = ${captainId};
      `
    );
    await pool.end();
    return poolResult.rows[0];
  };

  /**
   * This function returns the list of teams that a team mate is in
   * @param teamMateId the id of the team mate
   * @returns a list of teams that the team mate is in
   */
  getTeamByTeamMateId = async (teamMateId: number) => {
    const client = await this.pool.connect();
    try {
      const result = await client.query(
        `
          SELECT * FROM public.team_mate
          INNER JOIN public.team ON team_id = team_mate_team_id
          WHERE team_mate_id = $1;
        `,
        [teamMateId]
      );

      const teamListToReturn: TeamDtoIn[] = [];

      for (let team of result.rows) {
        teamListToReturn.push(
          new TeamDtoIn(
            team.team_mate_id,
            team.team_mate_team_id,
            team.team_mate_user_id,
            team.team_id,
            team.team_captain_id,
            team.team_name
          )
        );
      }

      return teamListToReturn;
    } finally {
      client.release();
    }
  };
}
