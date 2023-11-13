import {Client, QueryResult} from "pg";
import "dotenv/config";
import {PasswordForgottenDtoIn} from "./passwordForgotten.dtoIn";
import {DatabaseError} from "../../errors/dataOrDataBaseError";

export class PasswordRepository {
  async changePassword(userId: number, newEncryptedPassword: string): Promise<boolean> {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
      UPDATE public.user
      SET user_password = $1
      WHERE user_id = $2
      returning *
    `;
    client.connect();
    try {
      const result: QueryResult = await client.query(query, [newEncryptedPassword, userId]);
      if (result.rowCount === 0) {
        throw new DatabaseError("Error during password change");
      }
      return true;
    } catch (error) {
      console.warn(error);
      throw error;
    }
  }

  async getUserEncryptedPassword(userId: number): Promise<string> {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
      SELECT user_password 
      FROM public.user
      WHERE user_id = $1
    `;
    client.connect();
    try {
      const result: QueryResult = await client.query(query, [userId]);
      if (result.rowCount === 0) {
        throw new DatabaseError("Error during user password retrieval");
      }
      return result.rows[0].user_password;
    } catch (error) {
      console.warn(error);
      throw error;
    }
  }

  async forgotPassword(passwordForgotten: PasswordForgottenDtoIn): Promise<number> {
    try {
      const response = await fetch(`${process.env.ADMIN_API}/login/forgot-password`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(passwordForgotten),
      });
      console.warn("repository res.status", response.status);
      return response.status;
    } catch (error) {
      console.warn(error);
      throw error;
    }
  }
}
