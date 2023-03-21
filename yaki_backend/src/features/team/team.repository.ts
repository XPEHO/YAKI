import { Pool, QueryResult } from "pg";

export class TeamRepository {
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
}