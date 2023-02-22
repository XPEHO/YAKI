import { Pool, QueryResult } from "pg";
import UserModel from "./user.dtoIn";

export class UserRepository {
    /**
     * Seek a user in the database by its login value
     * @param username 
     * @param password 
     * @returns 
     */
    getByLogin = async (username: string, password: string) => {
        const pool = new Pool({
            user: `${process.env.DB_USER}`,
            host: `${process.env.DB_HOST}`,
            database: `${process.env.DB_DATABASE}`,
            password: `${process.env.DB_PASSWORD}`,
            port:  Number(process.env.DB_PORT)
        });      
        const poolResult: QueryResult = await pool.query(
            `SELECT * FROM public.user WHERE user_login = '${username}';`
        );
        await pool.end();
        // If the user was found in the database
        if(poolResult.rowCount > 0) {
            return poolResult.rows[0];
        } else {
            throw new Error('Bad authentification details');
        }
    }
}