import { Client, QueryResult } from "pg";
import "dotenv/config";
import { UserToRegisterOut } from "./toRegister.dtoOut";
import ToRegisterRes from "./toRegisterRes.dto";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";

export class UserRepository {
  /**
   * Seek a user in the database by its login value
   * @param username
   * @param password
   * @returns
   */
  getByLogin = async (username: string) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    // selected attribut do not work ?
    // user_id, user_last_name, user_first_name, user_email, teammate_id, captain_id, user_enabled

    const query = `
        SELECT *
        FROM public.user u
        LEFT JOIN public.teammate tm
        ON u.user_id = tm.teammate_user_id
        LEFT JOIN public.captain c
        ON u.user_id = c.captain_user_id
        WHERE user_login = $1
      `;
    client.connect();
    const poolResult: QueryResult = await client.query(query, [username]);
    await client.end();
    // If the user wasn't found in the DB
    if (poolResult.rowCount === 0) {
      throw new Error("Bad authentification details");
    }
    // If the user still hasn't confirmed his account
    if (poolResult.rows[0].user_enabled === false) {
      console.log("this user isn't activated");
      throw new Error("This account isn't activated");
    }
    // "else" return the user
    return poolResult.rows[0];
  };

  /**
   * register a user that signed in with the mobile application
   * @param user user data coming from registration process
   * @returns response from admin api after email confirmation & successfull registration
   */
  registerUser = async (user: UserToRegisterOut): Promise<ToRegisterRes> => {
    try {
      const registerResponse = await fetch(
        `${process.env.ADMIN_API}/login/register`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(user),
        }
      );
      if (!registerResponse.ok) {
        if (registerResponse.status === 417)
          //handle the email already used error
          throw new EmailAlreadyExistsError("email already used");
      }
      let jsonResponse = await registerResponse.json();
      return jsonResponse;
    } catch (err) {
      console.warn(err);
      throw err;
    }
  };

  getUserById = async (userId: number) => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });
    const query = `
        SELECT user_last_name, user_first_name, user_email
        FROM public.user u
        WHERE user_id = $1
      `;

    try {
      await client.connect();
      const poolResult: QueryResult = await client.query(query, [userId]);
      await client.end();

      return poolResult.rows;
    } catch (error: any) {
      console.log(error);
      throw error;
    }
  };
}
