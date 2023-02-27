import { Pool, QueryResult } from "pg";
import UserModel from "./user.dtoIn";

export class UserRepository {
    /**
     * Seek a user in the database by its login value
     * @param username 
     * @param password 
     * @returns 
     */
    getByLogin = async (username: string) => {
        const pool = new Pool({
            user: `${process.env.DB_ROLE}`,
            host: `${process.env.DB_HOST}`,
            database: `${process.env.DB_DATABASE}`,
            password: `${process.env.DB_ROLE_PWD}`,
            port:  Number(process.env.DB_PORT)
        });
        const poolResult: QueryResult = await pool.query(
            `SELECT * FROM public.user u
            LEFT JOIN public.team_mate tm
            ON u.user_id = tm.team_mate_user_id
            LEFT JOIN public.captain c
            ON u.user_id = c.captain_user_id
			WHERE user_login = '${username}';`
        );
        await pool.end();
        console.log('query passée');
        // If the user was found in the database
        if(poolResult.rowCount > 0) {
            return poolResult.rows[0];
        } else {
            throw new Error('Bad authentification details');
        }
    }
}