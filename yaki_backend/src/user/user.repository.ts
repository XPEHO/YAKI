import { Pool, QueryResult } from "pg";
import UserModel from "./user.model";

export class UserRepository {

    getByUsernameAndPassword = async (username: string, password: string) => {
        const pool = new Pool({
            user: `${process.env.DB_USER}`,
            host: `${process.env.DB_HOST}`,
            database: `${process.env.DB_DATABASE}`,
            password: `${process.env.DB_PASSWORD}`,
            port:  Number(process.env.DB_PORT)
        });      
        const poolResult: QueryResult = await pool.query(
            `SELECT * FROM public.user WHERE user_login = '${username}' AND user_password = '${password}';`
        );
        await pool.end();
        if(poolResult.rows.length > 0) {
            return this.getCaptainOrTeammateByUserId(poolResult.rows[0])
        } else {
            throw new Error('Bad authentification details');
        }
    }

    getCaptainOrTeammateByUserId = async (user: UserModel) => {
        const pool = new Pool({
            user: `${process.env.DB_USER}`,
            host: `${process.env.DB_HOST}`,
            database: `${process.env.DB_DATABASE}`,
            password: `${process.env.DB_PASSWORD}`,
            port:  Number(process.env.DB_PORT)
        });
        let poolResult: QueryResult = await pool.query(
            `SELECT * FROM public.user u
            LEFT JOIN public.team_mate t
            ON user_id = team_mate_user_id
            LEFT JOIN public.captain c
            ON user_id = captain_user_id
            WHERE user_id = '${user.user_id}';`
        )
        // if(poolResult.rows.length === 0) {
        //     poolResult = await pool.query(
        //         `SELECT * FROM public.captain INNER JOIN public.user ON captain_user_id = user_id WHERE user_id = '${user.user_id}';`
        //         )
        //     }
        // console.log(poolResult.rows);
        return poolResult.rows[0];
    }
}