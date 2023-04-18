import { Pool, QueryResult } from "pg";

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

    getByCaptainId = async (captain_id: number) => {
        const pool = new Pool({
          user: `${process.env.DB_USER}`,
          host: `${process.env.DB_HOST}`,
          database: `${process.env.DB_DATABASE}`,
          password: `${process.env.DB_PASSWORD}`,
          port:  Number(process.env.DB_PORT)
        }); 
        const poolResult: QueryResult = await pool.query(
          `
            SELECT * FROM public.team
            WHERE team_captain_id = ${captain_id};
          `
        );
        await pool.end();
        return poolResult.rows[0];
    }

    /**
     * This function returns the list of teams that a team mate is in
     * @param team_mate_id the id of the team mate
     * @returns a list of teams that the team mate is in
     */
    getTeamByTeamMateId = async (team_mate_id: number) => {
        const client = await this.pool.connect();
        try {
          const result = await client.query(
            `
              SELECT team_name FROM public.team_mate
              INNER JOIN public.team ON team_id = team_mate_team_id
              WHERE team_mate_id = $1;
            `,
            [team_mate_id]
          );
          return result.rows;
        }
        finally {
          client.release();
        }
    }
}

