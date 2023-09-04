import { Client, QueryResult } from "pg";
import "dotenv/config";
import { UserToRegisterOut } from "./toRegister.dtoOut";
import ToRegisterRes from "./toRegisterRes.dto";
import EmailAlreadyExistsError from "../../errors/EmailAlreadyExistError";
import { randomBytes } from "crypto";

export class UserRepository {
  getUserByEmail(email: string) {
    throw new Error("Method not implemented.");
  }
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
   * resgister a user that signed in with the mobile application
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

  /**
   * Reset a user's password in the database
   * @param email The email of the user whose password is being reset
   * @param newPassword The new password to set for the user
   * @returns True if the password was reset successfully, false otherwise
   */
  resetPassword = async (
    email: string,
    newPassword: string
  ): Promise<boolean> => {
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
        WHERE user_email = $2
      `;

    client.connect();
    const poolResult: QueryResult = await client.query(query, [
      newPassword,
      email,
    ]);
    await client.end();

    return poolResult.rowCount > 0;
  };

  /**
   * Generate a password reset token for a user and store it in the database
   * @param email The email of the user for whom to generate the token
   * @returns The generated token
   */
  generatePasswordResetToken = async (email: string): Promise<string> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const token = randomBytes(20).toString("hex");
    const expirationDate = new Date(Date.now() + 3600000); // Token expires in 1 hour

    const query = `
        INSERT INTO public.password_reset_token (email, token, expiration_date)
        VALUES ($1, $2, $3)
        RETURNING token
      `;

    client.connect();
    const poolResult: QueryResult = await client.query(query, [
      email,
      token,
      expirationDate,
    ]);
    await client.end();

    return poolResult.rows[0].token;
  };

  /**
   * Verify a password reset token and return the email of the associated user
   * @param token The token to verify
   * @returns The email of the user associated with the token, or null if the token is invalid or expired
   */
  verifyPasswordResetToken = async (token: string): Promise<string | null> => {
    const client = new Client({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      port: Number(process.env.DB_PORT),
    });

    const query = `
      SELECT email
      FROM public.password_reset_token
      WHERE token = $1 AND expiration_date > NOW()
    `;

    client.connect();
    const poolResult: QueryResult = await client.query(query, [token]);
    await client.end();

    return poolResult.rowCount > 0 ? poolResult.rows[0].email : null;
  };
}
